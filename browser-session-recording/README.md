# Automatic Browser Recording and Session Playback

This guide explains how to record OpenClaw browser sessions for debugging, auditing, and operational review.

Session recording allows operators to replay agent actions and diagnose failures.

--------------------------------------------------

RECORDING OPTIONS

--------------------------------------------------

OPTION 1 — PLAYWRIGHT VIDEO RECORDING

If OpenClaw uses Playwright automation, enable built‑in recording.

Example configuration concept:

recordVideo directory set to ./recordings/

Example output files:

recordings/
agent1-session.webm
agent2-session.webm

Advantages:

low overhead

automatic segmentation

easy playback

--------------------------------------------------

OPTION 2 — FFMPEG DISPLAY RECORDING

Capture the X display directly.

Example command concept:

ffmpeg capturing display :99 at 1920x1080 resolution and 30fps

Example display mapping:

:99  -> agent1

:100 -> agent2

:101 -> agent3

--------------------------------------------------

EXAMPLE RECORDING SCRIPT

#!/usr/bin/env bash

DISPLAY_NUM=$1
AGENT_NAME=$2

ffmpeg capture display :DISPLAY_NUM

output file format:

AGENT_NAME-timestamp.mp4

--------------------------------------------------

RECOMMENDED RECORDING DIRECTORY

recordings/

agent1/
session-2026-03-10.mp4

agent2/
session-2026-03-10.mp4

--------------------------------------------------

RETENTION POLICY

Recommended retention:

Keep recordings for 7 days

Rotate automatically using cron

Example cleanup concept:

delete recordings older than 7 days

--------------------------------------------------

SESSION PLAYBACK

Recordings can be reviewed using:

VLC

browser playback

internal debugging tools

Typical debugging workflow:

Agent error occurs

Locate timestamp

Load recording

Review browser activity
