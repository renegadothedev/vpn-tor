#!/usr/bin/env bash
# Regression tests run without root privileges or any real VPN connections.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT/vpn-manager"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
export VPN_MANAGER_CONFIG_DIR="$TMP/private settings"
fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
equal() { [[ "$1" == "$2" ]] || fail "Expected [$2], got [$1]"; }
ok() { "$@" || fail "Expected success: $*"; }
no() { if "$@"; then fail "Expected failure: $*"; fi; }
bash -n "$SCRIPT"
bash "$SCRIPT" --version | grep -q '2.1.0'
bash "$SCRIPT" --help | grep -q 'OpenVPN'
source "$SCRIPT"
ok setup_config
equal "$MAX_RETRIES" 3
equal "$CONNECT_TIMEOUT" 20
equal "$(stat -c '%a' "$CONFIG_DIR")" 700
equal "$(stat -c '%a' "$CONFIG_FILE")" 600
CONFIG_PATH="$TMP/profile with = and spaces.ovpn"
CONNECTION_NAME='VPN "Work"'
MAX_RETRIES=5
CONNECT_TIMEOUT=30
ok save_settings
CONFIG_PATH=''
CONNECTION_NAME=''
ok load_settings
equal "$CONFIG_PATH" "$TMP/profile with = and spaces.ovpn"
equal "$CONNECTION_NAME" 'VPN "Work"'
equal "$MAX_RETRIES" 5
equal "$CONNECT_TIMEOUT" 30
# Settings values are data, never executed.
printf 'CONFIG_PATH="$(touch %s)"\nMAX_RETRIES="9999"\nCONNECT_TIMEOUT="9999"\n' "$TMP/malicious" > "$CONFIG_FILE"
ok load_settings
[[ ! -e "$TMP/malicious" ]] || fail "Command substitution was executed"
equal "$MAX_RETRIES" 3
equal "$CONNECT_TIMEOUT" 20
mv "$CONFIG_FILE" "$CONFIG_FILE.saved"
printf 'untouched\n' > "$TMP/target"
ln -s "$TMP/target" "$CONFIG_FILE"
no repair_config_permissions
equal "$(cat "$TMP/target")" untouched
rm -f "$CONFIG_FILE"
mv "$CONFIG_FILE.saved" "$CONFIG_FILE"
VPN_METHOD=openvpn
CONFIG_PATH="$TMP/test.ovpn"
printf 'client\n' > "$CONFIG_PATH"
sleep 15 &
other_pid=$!
printf '%s\n' "$other_pid" > "$OPENVPN_PID_FILE"
no managed_openvpn_pid
ok cleanup_failed_openvpn
kill -0 "$other_pid" || fail "Unrelated process was killed"
kill "$other_pid"
wait "$other_pid" 2>/dev/null || true
# EOF should close the menu without a busy loop.
printf '' | bash "$SCRIPT" > "$TMP/eof.log"
grep -q 'Input closed; exiting.' "$TMP/eof.log"
printf 'PASS: offline regression suite\n'
