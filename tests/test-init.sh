#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
gcc -static -Os -Wall -Wextra -Werror -o "$TMP/init" "$ROOT/prototype/init.c"
file "$TMP/init"
file "$TMP/init" | grep -q 'statically linked'
# Running PID1 outside a VM is not a boot test. Only validate CLI parser output.
set +e
printf 'help\nstatus\nuname\n' | timeout 2s "$TMP/init" > "$TMP/cli.log" 2>&1
set -e
grep -q 'INTENTOS_BOOT_OK' "$TMP/cli.log"
grep -q 'IntentOS kernel running' "$TMP/cli.log"
grep -q 'help status uname reboot poweroff' "$TMP/cli.log"
echo "PASS: init compilation and basic command parser"
