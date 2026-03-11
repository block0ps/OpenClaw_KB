#!/usr/bin/env bash

pkill -f x11vnc || true
pkill -f websockify || true
pkill -f "Xvfb :99" || true
pkill -f openbox || true

echo "Environment stopped"
