#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/build/bootable"
for file in "$OUT/vmlinuz" "$OUT/initramfs.cpio.gz"; do
  [[ -s "$file" ]] || { echo "Missing $file. Run: bash tools/build-bootable-prototype.sh" >&2; exit 1; }
done
command -v qemu-system-x86_64 >/dev/null || { echo "Install qemu-system-x86" >&2; exit 1; }
exec qemu-system-x86_64 \
  -machine q35,accel=tcg \
  -cpu max \
  -m 512M \
  -nographic \
  -no-reboot \
  -kernel "$OUT/vmlinuz" \
  -initrd "$OUT/initramfs.cpio.gz" \
  -append "console=ttyS0 rdinit=/init panic=1"
