#!/bin/bash
set -e

export DISPLAY=:1

# Start virtual display
Xvfb :1 -screen 0 1280x720x24 -ac +extension GLX +render -noreset &

sleep 3

# Start Firefox
firefox-esr \
  --display :1 \
  --no-remote \
  --new-instance \
  --kiosk \
  --private-window \
  https://www.google.com &

sleep 5

# Start VNC
x11vnc \
  -display :1 \
  -forever \
  -shared \
  -nopw \
  -rfbport 5900 &

# Start noVNC
websockify \
  --web=/usr/share/novnc \
  8080 \
  localhost:5900
