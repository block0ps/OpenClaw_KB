#!/usr/bin/env bash
set -e

pkill -f x11vnc || true
pkill -f websockify || true
pkill -f "Xvfb :99" || true
pkill -f openbox || true

Xvfb :99 -screen 0 1920x1080x24 -listen tcp -ac &
sleep 2

export DISPLAY=localhost:99.0

unset WAYLAND_DISPLAY
unset XDG_SESSION_TYPE

openbox &

x11vnc \
 -display localhost:99.0 \
 -forever \
 -shared \
 -rfbport 5900 \
 -usepw \
 -noshm \
 -noxdamage &

websockify --web /usr/share/novnc/ 6080 localhost:5900 &

echo "noVNC available at http://localhost:6080/vnc.html"
