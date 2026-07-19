#!/bin/bash
set -e

export DISPLAY=:1

Xvfb :1 -screen 0 1280x720x16 -ac &

sleep 2

firefox-esr \
  --no-remote \
  --new-instance \
  --kiosk \
  --private-window \
  --safe-mode about:blank &

x11vnc \
  -display :1 \
  -forever \
  -shared \
  -nopw \
  -noxrecord \
  -noxfixes \
  -noxdamage \
  -rfbport 5900 &

websockify \
  --web=/usr/share/novnc \
  8080 \
  localhost:5900

echo "Firefox RDP ready"
