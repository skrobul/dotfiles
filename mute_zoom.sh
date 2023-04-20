#!/bin/sh
CURRENT=$(xdotool getwindowfocus)
ZOOM=$(xdotool search --limit 1 --name "Zoom Meeting")
if ! [ "$CURRENT" = "$ZOOM" ]; then
  xdotool windowactivate --sync "${ZOOM}"
fi
xdotool key --clearmodifiers "alt+a"
if ! [ "$CURRENT" = "$ZOOM" ]; then
  xdotool windowactivate --sync "${CURRENT}"
fi
