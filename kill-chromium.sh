#!/bin/bash
# Hentikan semua proses
pkill chromium
pkill x11vnc
killall Xvfb
pkill -f "websockify --web=/usr/share/novnc/ 6080 localhost:5900"
