#!/bin/bash
set -e

export DISPLAY=:1

Xvfb :1 -screen 0 1280x720x16 &

sleep 2

firefox-esr \
  --no-remote \
  --new-instance \
  --kiosk \
  --private-window about:blank \
  --safe-mode &

x11vnc \
  -display :1 \
  -forever \
  -shared \
  -nopw \
  -rfbport 5900 &

websockify \
  --web=/usr/share/novnc \
  8080 \
  localhost:5900
