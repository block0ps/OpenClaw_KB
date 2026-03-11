# OpenClaw noVNC Setup for WSL

Run OpenClaw browser sessions inside a virtual X display in WSL and view them in your browser using noVNC.

## Architecture

OpenClaw Browser  
↓  
Xvfb virtual display  
↓  
x11vnc  
↓  
websockify  
↓  
noVNC  
↓  
http://localhost:6080/vnc.html

## Install Dependencies

Inside WSL:

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

## First Run (set password)

x11vnc -storepasswd

## Start noVNC environment

./start-openclaw-vnc.sh

Then open:

http://localhost:6080/vnc.html

## Running OpenClaw

OpenClaw must inherit the DISPLAY variable:

export DISPLAY=localhost:99.0
openclaw

Any browser window created by OpenClaw will appear in the noVNC viewer.

## Testing the display

export DISPLAY=localhost:99.0
xclock &

If the clock appears in noVNC, the display is working.

## Notes for WSL

WSL has two quirks:

1. `/tmp/.X11-unix` is read-only  
   → use `DISPLAY=localhost:99.0`

2. MIT-SHM crashes with virtual displays  
   → use `x11vnc -noshm`

