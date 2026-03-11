# **Multi-Agent Browser Monitoring (Automatic Display Allocation)**

Run multiple OpenClaw agents simultaneously while giving each agent an isolated display, VNC port, and noVNC web viewer.

## 🏗️ **Architecture**

```text
Agent
  -> Xvfb display
  -> x11vnc
  -> websockify
  -> noVNC browser viewer
```

Each agent runs in an isolated display namespace.

## 📊 **Example Display Allocation**

| Agent | DISPLAY | VNC Port | noVNC URL |
| --- | --- | --- | --- |
| research-agent | :99 | 5900 | http://localhost:6080/vnc.html |
| email-agent | :100 | 5901 | http://localhost:6081/vnc.html |
| crawler-agent | :101 | 5902 | http://localhost:6082/vnc.html |

## 🗂️ **Recommended Operator Map File**

Use a simple mapping file like `agent-monitoring-map.md`:

```text
| Agent Name     | DISPLAY | VNC Port | noVNC URL                      |
|----------------|---------|----------|--------------------------------|
| research-agent | :99     | 5900     | http://host:6080/vnc.html      |
| email-agent    | :100    | 5901     | http://host:6081/vnc.html      |
| crawler-agent  | :101    | 5902     | http://host:6082/vnc.html      |
```

## 🚀 **Example Multi-Agent Launch Script**

```bash
#!/usr/bin/env bash

set -euo pipefail

AGENT_NAME="$1"
DISPLAY_NUM="$2"
VNC_PORT="$3"
WEB_PORT="$4"

echo "Starting agent: $AGENT_NAME"

Xvfb ":$DISPLAY_NUM" -screen 0 1920x1080x24 &
sleep 2

export DISPLAY=":$DISPLAY_NUM"

openbox &

x11vnc \
  -display ":$DISPLAY_NUM" \
  -rfbport "$VNC_PORT" \
  -forever \
  -shared &

websockify \
  --web /usr/share/novnc \
  "$WEB_PORT" "localhost:$VNC_PORT" &

openclaw --agent "$AGENT_NAME"
```

## 🧪 **Example Usage**

```bash
./launch-agent.sh research-agent 99 5900 6080
./launch-agent.sh email-agent 100 5901 6081
./launch-agent.sh crawler-agent 101 5902 6082
```

## 👀 **Operator Access**

- Agent 1: [http://localhost:6080/vnc.html](http://localhost:6080/vnc.html)
- Agent 2: [http://localhost:6081/vnc.html](http://localhost:6081/vnc.html)
- Agent 3: [http://localhost:6082/vnc.html](http://localhost:6082/vnc.html)

## ✅ **Best Practices**

- Keep stable display and port assignments per agent.
- Store mapping files in version control.
- Use reverse proxy + authentication in production.
- Pair this setup with session recording for debugging and audits.
