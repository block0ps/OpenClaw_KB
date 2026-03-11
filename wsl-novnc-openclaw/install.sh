#!/usr/bin/env bash
set -e

echo "Installing dependencies..."

sudo apt update

sudo apt install -y \
  xvfb \
  x11vnc \
  novnc \
  websockify \
  openbox \
  dbus-x11 \
  x11-utils \
  x11-apps

mkdir -p ~/.vnc

if [ ! -f ~/.vnc/passwd ]; then
  echo "Setting VNC password..."
  x11vnc -storepasswd
fi

echo "Install complete."
