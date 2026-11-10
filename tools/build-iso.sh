#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/build/bootable"
ISO_ROOT="$OUT/iso-root"
for cmd in grub-mkrescue xorriso; do
  command -v "$cmd" >/dev/null || { echo "Missing dependency: $cmd" >&2; exit 1; }
done
for file in "$OUT/vmlinuz" "$OUT/initramfs.cpio.gz"; do
  [[ -s "$file" ]] || { echo "Missing $file; build initramfs first" >&2; exit 1; }
done
mkdir -p "$ISO_ROOT/boot/grub"
cp "$OUT/vmlinuz" "$ISO_ROOT/boot/vmlinuz"
cp "$OUT/initramfs.cpio.gz" "$ISO_ROOT/boot/initramfs.cpio.gz"
cat > "$ISO_ROOT/boot/grub/grub.cfg" <<'EOF'
serial --unit=0 --speed=115200
terminal_input serial
terminal_output serial
set timeout=2
set default=0
menuentry "IntentOS 0.1 Developer Preview" {
  linux /boot/vmlinuz console=tty0 console=ttyS0 rdinit=/init panic=1
  initrd /boot/initramfs.cpio.gz
}
EOF
grub-mkrescue -o "$OUT/intentos-0.1-x86_64.iso" "$ISO_ROOT"
echo "Created $OUT/intentos-0.1-x86_64.iso"
