# **OpenClaw noVNC Setup (WSL)**

Run OpenClaw browser sessions inside a virtual display in WSL and monitor them in your browser with noVNC.

## 🧭 **Overview**

Open the noVNC viewer:

[http://localhost:6080/vnc.html](http://localhost:6080/vnc.html)

## 🏗️ **Architecture**

```text
OpenClaw
  -> Xvfb (virtual display)
  -> x11vnc
  -> websockify
  -> noVNC viewer
```

## ⚙️ **Install Dependencies**

```bash
./install.sh
```

## ▶️ **Start the Environment**

```bash
./start.sh
```

Then open:

[http://localhost:6080/vnc.html](http://localhost:6080/vnc.html)

## ⏹️ **Stop the Environment**

```bash
./stop.sh
```

## ✅ **Health Check**

```bash
./healthcheck.sh
```

## 🤖 **Run OpenClaw**

Set the display for OpenClaw browser sessions:

```bash
export DISPLAY=localhost:99.0
```

Start OpenClaw:

```bash
openclaw
# or
DISPLAY=localhost:99.0 node openclaw
```

Any browser sessions launched by OpenClaw should appear in noVNC.

## 🐳 **Docker Deployment**

```bash
cd docker
docker compose up --build
```

Then open:

[http://localhost:6080/vnc.html](http://localhost:6080/vnc.html)

## 🛠️ **systemd Service**

```bash
sudo cp systemd/openclaw-vnc.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable openclaw-vnc
sudo systemctl start openclaw-vnc
```

## 🧪 **Troubleshooting**

Verify the display:

```bash
DISPLAY=localhost:99.0 xdpyinfo
```

Test the display:

```bash
DISPLAY=localhost:99.0 xclock &
```

If the clock appears in noVNC, the display is working.

## 📌 **WSL Notes**

### `/tmp/.X11-unix` is read-only

Use TCP display instead:

```bash
export DISPLAY=localhost:99.0
```

### MIT-SHM can crash with virtual displays

Use:

```bash
x11vnc -noshm
```
