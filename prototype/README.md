# IntentOS bootable prototype

This is a real Linux-kernel-based boot target, not a new kernel implementation. The kernel is supplied by the build host; our static PID 1 (`prototype/init.c`) runs directly from an initramfs.

## Local build (Debian/Ubuntu)
Install `gcc libc6-dev cpio qemu-system-x86 linux-image-amd64` (package names vary by distribution), then:

```sh
bash tools/build-bootable-prototype.sh
qemu-system-x86_64 -m 512M -nographic -kernel build/bootable/vmlinuz -initrd build/bootable/initramfs.cpio.gz -append 'console=ttyS0 rdinit=/init panic=1'
```

Expected serial output includes `INTENTOS_BOOT_OK` and an `intentos>` prompt. Try `help` and `status`. CI smoke test verifies the boot marker and uploads the kernel/initramfs.

This is a developer-only prototype. It lacks a package manager, persistent filesystem, network configuration, graphics, security hardening, and mobile support. It should not be used as a daily OS.
