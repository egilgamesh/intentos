#!/usr/bin/env python3
"""Boot IntentOS in QEMU and verify PID1 and interactive commands via serial."""
import os
import pathlib
import selectors
import subprocess
import sys
import time

root = pathlib.Path(__file__).resolve().parents[1]
out = root / "build" / "bootable"
log_path = root / "boot.log"
kernel = out / "vmlinuz"
initrd = out / "initramfs.cpio.gz"
for path in (kernel, initrd):
    if not path.is_file():
        raise SystemExit(f"Missing image: {path}")

cmd = [
    "qemu-system-x86_64", "-machine", "q35,accel=tcg",
    "-m", "512M", "-nographic", "-no-reboot",
    "-kernel", str(kernel), "-initrd", str(initrd),
    "-append", "console=ttyS0 rdinit=/init panic=1",
]
deadline = time.monotonic() + int(os.environ.get("BOOT_TIMEOUT", "120"))
proc = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT, bufsize=0)
selector = selectors.DefaultSelector()
selector.register(proc.stdout, selectors.EVENT_READ)
log = bytearray()
phase = 0
try:
    while time.monotonic() < deadline:
        for key, _ in selector.select(timeout=0.5):
            data = os.read(key.fileobj.fileno(), 65536)
            if not data:
                break
            log.extend(data)
            recent = bytes(log)
            if phase == 0 and b"intentos> " in recent:
                assert b"INTENTOS_BOOT_OK" in recent, "Kernel reached prompt without boot marker"
                proc.stdin.write(b"status\n")
                proc.stdin.flush()
                phase = 1
            elif phase == 1 and b"IntentOS kernel running; IntentMind not installed" in recent:
                proc.stdin.write(b"help\n")
                proc.stdin.flush()
                phase = 2
            elif phase == 2 and b"help status uname reboot poweroff" in recent:
                proc.stdin.write(b"poweroff\n")
                proc.stdin.flush()
                phase = 3
        if phase == 3 and proc.poll() is not None:
            print("PASS: QEMU boot, PID1, status, help, poweroff")
            break
    else:
        raise RuntimeError(f"QEMU boot timed out (phase {phase})")
    if phase != 3:
        raise RuntimeError(f"QEMU exited before completing interactive checks (phase {phase})")
finally:
    if proc.poll() is None:
        proc.terminate()
        try:
            proc.wait(timeout=3)
        except subprocess.TimeoutExpired:
            proc.kill()
            proc.wait()
    log_path.write_bytes(log)
    sys.stdout.buffer.write(log[-12000:])
