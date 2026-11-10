#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILDROOT_DIR="$ROOT/build/buildroot"
BUILDROOT_TAG="2025.02.8"

command -v git >/dev/null || { echo "git required" >&2; exit 1; }
command -v make >/dev/null || { echo "make required" >&2; exit 1; }

mkdir -p "$ROOT/build"
if [[ ! -d "$BUILDROOT_DIR/.git" ]]; then
  git clone --depth 1 --branch "$BUILDROOT_TAG" https://github.com/buildroot/buildroot.git "$BUILDROOT_DIR"
fi

cd "$BUILDROOT_DIR"
make qemu_x86_64_defconfig
./utils/config --set-str BR2_ROOTFS_OVERLAY "$ROOT/images/pc-x86_64/rootfs-overlay"
make olddefconfig
make

echo "Build complete. Inspect: $BUILDROOT_DIR/output/images/"
