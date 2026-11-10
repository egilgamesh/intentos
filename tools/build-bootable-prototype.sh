#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/build/bootable"
KERNEL="${KERNEL_IMAGE:-/boot/vmlinuz-$(uname -r)}"
command -v gcc >/dev/null
command -v cpio >/dev/null
test -f "$KERNEL" || { echo "Kernel missing: $KERNEL (set KERNEL_IMAGE)" >&2; exit 1; }
mkdir -p "$OUT/rootfs"/{bin,dev,proc,sys}
gcc -static -Os -Wall -Wextra -o "$OUT/rootfs/init" "$ROOT/prototype/init.c"
cp /usr/bin/busybox "$OUT/rootfs/bin/busybox" 2>/dev/null || true
if [[ -e "$OUT/rootfs/bin/busybox" ]]; then
  ln -sf busybox "$OUT/rootfs/bin/uname"
fi
cp "$KERNEL" "$OUT/vmlinuz"
(cd "$OUT/rootfs" && find . -print0 | cpio --null -ov --format=newc 2>/dev/null | gzip -9 > "$OUT/initramfs.cpio.gz")
echo "Created $OUT/vmlinuz and $OUT/initramfs.cpio.gz"
echo "Run: qemu-system-x86_64 -m 512M -nographic -kernel $OUT/vmlinuz -initrd $OUT/initramfs.cpio.gz -append 'console=ttyS0 rdinit=/init panic=1'"
