#!/bin/sh
# SPDX-License-Identifier: MPL-2.0
# Build MCUboot + the signed app into build/.
#
#   ./build.sh [debug]      debug adds RTT logging (debug.conf)
#
# NCS is the nRF Connect SDK workspace, KEY the MCUboot signing key; override if they live elsewhere:
#   NCS=/path/to/ncs KEY=/path/to/mcuboot-ed25519.pem ./build.sh
set -eu
FW=$(cd "$(dirname "$0")" && pwd)
NCS=${NCS:-$HOME/ncs}
KEY=${KEY:-$HOME/.openrz67/mcuboot-ed25519.pem}
[ -d "$NCS" ] || { echo "SDK workspace not found: $NCS; set NCS" >&2; exit 1; }
[ -f "$KEY" ] || { echo "signing key not found: $KEY; set KEY" >&2; exit 1; }

case "${1:-}" in
  "") extra= ;;
  debug) extra=-DEXTRA_CONF_FILE=debug.conf ;;
  *) echo "usage: ./build.sh [debug]" >&2; exit 1 ;;
esac

cd "$NCS"
if [ -f .venv/bin/activate ]; then . .venv/bin/activate; fi
west build -b openrz67_nrf/nrf54l15/cpuapp -s "$FW" -d "$FW/build" -- \
  -DBOARD_ROOT="$FW" -DSB_CONFIG_BOOT_SIGNATURE_KEY_FILE="\"$KEY\"" $extra
