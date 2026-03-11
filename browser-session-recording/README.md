# **Automatic Browser Session Recording and Playback**

Record and replay OpenClaw browser sessions for debugging, auditing, and operational review.

## 🎯 **Why Record Sessions**

Session recordings make it easier to:

- Replay agent behavior after failures.
- Validate agent actions for audits.
- Share exact browser timelines during debugging.

## 🎥 **Option 1: Playwright Video Recording**

If your OpenClaw automation uses Playwright, enable built-in context recording.

```javascript
const context = await browser.newContext({
  recordVideo: { dir: "./recordings/" },
});
```

Example output:

```text
recordings/
  agent1-session.webm
  agent2-session.webm
```

Advantages:

- Low overhead.
- Automatic segmentation.
- Easy playback.

## 🎞️ **Option 2: FFmpeg Display Recording**

Capture an X display directly:

```bash
ffmpeg \
  -video_size 1920x1080 \
  -framerate 30 \
  -f x11grab \
  -i :99.0 \
  -c:v libx264 \
  -preset veryfast \
  -crf 23 \
  "recordings/agent1/session-$(date +%F-%H%M%S).mp4"
```

Example display mapping:

```text
:99  -> agent1
:100 -> agent2
:101 -> agent3
```

## 🧰 **Example Recording Script**

```bash
#!/usr/bin/env bash

set -euo pipefail

DISPLAY_NUM="$1"
AGENT_NAME="$2"
OUTPUT_DIR="recordings/$AGENT_NAME"
TIMESTAMP="$(date +%F-%H%M%S)"

mkdir -p "$OUTPUT_DIR"

ffmpeg \
  -video_size 1920x1080 \
  -framerate 30 \
  -f x11grab \
  -i ":${DISPLAY_NUM}.0" \
  -c:v libx264 \
  -preset veryfast \
  -crf 23 \
  "$OUTPUT_DIR/session-$TIMESTAMP.mp4"
```

## 📁 **Recommended Recording Directory Layout**

```text
recordings/
  agent1/
    session-2026-03-10-101500.mp4
  agent2/
    session-2026-03-10-104200.mp4
```

## ♻️ **Retention Policy**

Example: keep recordings for 7 days.

```bash
find recordings -type f -mtime +7 -delete
```

## ▶️ **Session Playback**

Common playback options:

- VLC
- Browser playback for `.webm`
- Internal debugging tooling

Example local playback:

```bash
vlc recordings/agent1/session-2026-03-10-101500.mp4
```

Typical debugging flow:

1. Agent error occurs.
2. Locate the matching timestamp.
3. Load the recording.
4. Review browser activity step-by-step.
