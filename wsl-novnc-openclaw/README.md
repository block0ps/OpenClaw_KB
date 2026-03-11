# OpenClaw noVNC Setup (WSL)

This guide explains how to run OpenClaw browser sessions inside a virtual display in WSL and monitor them through a browser using noVNC.

Open the viewer:

http://localhost:6080/vnc.html

---

# Architecture

OpenClaw  
↓  
Xvfb virtual display  
↓  
x11vnc  
↓  
websockify  
↓  
noVNC viewer  

---

# Install Dependencies

Run:

./install.sh

---

# Start the Environment

Run:

./start.sh

Then open:

http://localhost:6080/vnc.html

---

# Stop the Environment

Run:

./stop.sh

---

# Health Check

Run:

./healthcheck.sh

---

# Running OpenClaw

Ensure OpenClaw inherits the display variable:

export DISPLAY=localhost:99.0

Then start OpenClaw:

openclaw

or

DISPLAY=localhost:99.0 node openclaw

Any browser sessions launched by OpenClaw will appear in the noVNC viewer.

---

# Docker Deployment

Run:

cd docker

docker compose up --build

Then access:

http://localhost:6080/vnc.html

---

# systemd Service

Install the service:

sudo cp systemd/openclaw-vnc.service /etc/systemd/system/

sudo systemctl daemon-reload

Enable the service:

sudo systemctl enable openclaw-vnc

Start it:

sudo systemctl start openclaw-vnc

---

# Troubleshooting

Verify the display:

DISPLAY=localhost:99.0 xdpyinfo

Test the display:

DISPLAY=localhost:99.0 xclock &

If the clock appears in noVNC, the display is working correctly.

---

# WSL Notes

WSL has two X11 quirks:

### `/tmp/.X11-unix` is read‑only

Use TCP display instead:

DISPLAY=localhost:99.0

### MIT‑SHM crashes with virtual displays

Use:

x11vnc -noshm
