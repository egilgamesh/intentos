#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/build/bootable"
KERNEL="${KERNEL_IMAGE:-/boot/vmlinuz-$(uname -r)}"

for tool in gcc cpio gzip; do
  command -v "$tool" >/dev/null || { echo "Missing tool: $tool" >&2; exit 1; }
done
test -f "$KERNEL" || { echo "Kernel missing: $KERNEL (set KERNEL_IMAGE)" >&2; exit 1; }

rm -rf "$OUT/rootfs"
mkdir -p "$OUT/rootfs"/{dev,proc,sys}
gcc -static -Os -Wall -Wextra -Werror -o "$OUT/rootfs/init" "$ROOT/prototype/init.c"
cp "$KERNEL" "$OUT/vmlinuz"

# The Linux kernel mounts devtmpfs after /init starts; provide early console.
# cpio's -R requires root for device nodes, so create them if permitted.
if [[ "$(id -u)" -eq 0 ]]; then
  mknod -m 600 "$OUT/rootfs/dev/console" c 5 1
  mknod -m 666 "$OUT/rootfs/dev/null" c 1 3
fi

(cd "$OUT/rootfs" && find . -print0 | cpio --null -o --format=newc 2>/dev/null | gzip -9 > "$OUT/initramfs.cpio.gz")
echo "Created: $OUT/vmlinuz and $OUT/initramfs.cpio.gz"
echo "Boot: qemu-system-x86_64 -m 512M -nographic -no-reboot -kernel '$OUT/vmlinuz' -initrd '$OUT/initramfs.cpio.gz' -append 'console=ttyS0 rdinit=/init panic=1'"
