#!/usr/bin/env bash

echo "Checking OpenClaw VNC environment..."

pgrep Xvfb >/dev/null && echo "Xvfb running" || echo "Xvfb not running"

pgrep x11vnc >/dev/null && echo "x11vnc running" || echo "x11vnc not running"

ss -ltn | grep 6080 >/dev/null && echo "noVNC active" || echo "noVNC not active"

DISPLAY=localhost:99.0 xdpyinfo >/dev/null 2>&1 && echo "Display OK" || echo "Display failed"
