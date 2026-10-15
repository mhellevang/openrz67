#!/usr/bin/env bash
# Regenerate img/case-pcb.png (ESP32) or img/nrf-case-pcb.png (nRF) from the
# current trigger geometry.
#
#   ./render.sh                  # STLs + board GLB + render
#   ./render.sh --no-inputs      # render only, reuse the existing STLs/GLB
#   ./render.sh nrf [--no-inputs]
#
# Overrides: TRIGGER_REPO, BLENDER, KICAD_CLI, RENDER_RES, RENDER_SAMPLES,
# CAM_AZ, CAM_EL, CAM_DIST, CAM_LENS, RENDER_OUT, SAVE_BLEND=1.
set -euo pipefail
cd "$(dirname "$0")"

TRIGGER_REPO="${TRIGGER_REPO:-$(cd ../../openrz67-trigger && pwd)}"
BLENDER="${BLENDER:-/Applications/Blender.app/Contents/MacOS/Blender}"
KICAD_CLI="${KICAD_CLI:-$(command -v kicad-cli || echo /Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli)}"
export TRIGGER_REPO

[ -x "$BLENDER" ] || { echo "Blender not found at $BLENDER (set BLENDER)" >&2; exit 1; }

VARIANT=esp32
if [ "${1:-}" = nrf ]; then VARIANT=nrf; shift; fi

if [ "${1:-}" != "--no-inputs" ] && [ "$VARIANT" = nrf ]; then
  [ -x "$KICAD_CLI" ] || { echo "kicad-cli not found (set KICAD_CLI)" >&2; exit 1; }

  # Not export.sh: that also rewrites the tracked slicer project.
  echo "==> case STLs"
  ( cd "$TRIGGER_REPO/nrf52/case" && OUTDIR=stl uv run openrz67_nrf_case.py )

  echo "==> board GLB"
  ( cd "$TRIGGER_REPO/nrf52/kicad" && "$KICAD_CLI" pcb export glb \
      --subst-models --no-dnp \
      --include-silkscreen --include-soldermask --include-tracks --include-pads \
      --user-origin 0x0mm -f -o out/openrz67-nrf.glb openrz67-nrf.kicad_pcb )
elif [ "${1:-}" != "--no-inputs" ]; then
  [ -x "$KICAD_CLI" ] || { echo "kicad-cli not found (set KICAD_CLI)" >&2; exit 1; }

  echo "==> case STLs"
  ( cd "$TRIGGER_REPO/case" && MAKE_3MF=false ./export.sh )

  # --user-origin puts the GLB origin on the board's front-left corner, which is
  # what render_case.py places at PCB_ORIGIN. Keep it matched to Edge.Cuts.
  echo "==> board GLB"
  ( cd "$TRIGGER_REPO/pcb/kicad" && "$KICAD_CLI" pcb export glb \
      --subst-models --no-dnp \
      --include-silkscreen --include-soldermask --include-tracks --include-pads \
      --user-origin 120x90mm -f -o out/openrz67.glb openrz67.kicad_pcb )
fi

echo "==> render"
SCRIPT=render_case.py
[ "$VARIANT" = nrf ] && SCRIPT=render_nrf.py
"$BLENDER" --background --factory-startup --python "$SCRIPT"
