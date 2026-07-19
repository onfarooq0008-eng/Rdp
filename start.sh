#!/bin/bash
set -e

export DISPLAY=:1

Xvfb :1 -screen 0 1280x720x24 -ac -nolisten tcp &
sleep 3

firefox-esr \
  --display :1 \
  --no-remote \
  --new-instance \
  --kiosk \
  --private-window \
  https://www.google.com &

sleep 5

x11vnc \
  -display :1 \
  -forever \
  -shared \
  -nopw \
  -repeat \
  -rfbport 5900 &

sleep 2

websockify \
  --web=/usr/share/novnc \
  --heartbeat=30 \
  8080 \
  localhost:5900
