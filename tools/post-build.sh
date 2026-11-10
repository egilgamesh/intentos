#!/bin/sh
set -eu
TARGET_DIR="$1"
chmod 0755 "$TARGET_DIR/etc/init.d/S99intentos"
