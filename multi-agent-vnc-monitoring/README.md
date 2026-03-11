# Multi‑Agent Browser Monitoring with Automatic Display Allocation

This guide explains how to run multiple OpenClaw agents simultaneously while providing each agent with its own:

X display  
VNC port  
noVNC monitoring interface  

This allows operators to visually monitor agent activity independently.

--------------------------------------------------

ARCHITECTURE

Agent
↓
Xvfb display
↓
x11vnc
↓
websockify
↓
noVNC browser viewer

Each agent runs in its own isolated display.

--------------------------------------------------

EXAMPLE DISPLAY ALLOCATION

Agent              DISPLAY     VNC Port     noVNC URL
---------------------------------------------------------
research-agent     :99         5900         http://localhost:6080
email-agent        :100        5901         http://localhost:6081
crawler-agent      :101        5902         http://localhost:6082

This mapping allows operators to quickly identify which browser belongs to which agent.

--------------------------------------------------

RECOMMENDED OPERATOR MAP FILE

Maintain a simple file such as:

agent-monitoring-map.md

Example contents:

Agent Name        DISPLAY     VNC Port     noVNC URL
---------------------------------------------------------
research-agent    :99         5900         http://host:6080
email-agent       :100        5901         http://host:6081
crawler-agent     :101        5902         http://host:6082

--------------------------------------------------

EXAMPLE MULTI‑AGENT LAUNCH SCRIPT

#!/usr/bin/env bash

AGENT_NAME=$1
DISPLAY_NUM=$2
VNC_PORT=$3
WEB_PORT=$4

echo "Starting agent: $AGENT_NAME"

Xvfb :$DISPLAY_NUM -screen 0 1920x1080x24 &
sleep 2

export DISPLAY=:$DISPLAY_NUM

openbox &

x11vnc \
-display :$DISPLAY_NUM \
-rfbport $VNC_PORT \
-forever \
-shared &

websockify \
--web /usr/share/novnc \
$WEB_PORT localhost:$VNC_PORT &

openclaw --agent "$AGENT_NAME"

--------------------------------------------------

EXAMPLE USAGE

./launch-agent.sh research-agent 99 5900 6080

./launch-agent.sh email-agent 100 5901 6081

./launch-agent.sh crawler-agent 101 5902 6082

--------------------------------------------------

OPERATOR ACCESS

Agent 1
http://localhost:6080/vnc.html

Agent 2
http://localhost:6081/vnc.html

Agent 3
http://localhost:6082/vnc.html

--------------------------------------------------

BEST PRACTICES

Assign stable ports per agent

Store mappings in version control

Use reverse proxy + authentication in production

Combine with browser session recording for debugging
