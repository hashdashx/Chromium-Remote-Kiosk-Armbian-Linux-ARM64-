#!/bin/bash

# start virtual display
Xvfb :99 -screen 0 1920x1080x24 &
sleep 2

# set display variable
export DISPLAY=:99

# start chromium kiosk mode
chromium --no-sandbox --disable-gpu --kiosk --no-first-run --disable-translate \
  --window-position=0,0 --window-size=1920,1080 --force-device-scale-factor=1 \
  --alsa-output-device=default --autoplay-policy=no-user-gesture-required \
  http://192.168.60.6:8090 &
sleep 3

# start vnc server
x11vnc -display :99 -nopw -listen 0.0.0.0 -forever -noxdamage -rfbport 5900 &
sleep 2

# start novnc
websockify --web=/usr/share/novnc/ 6080 localhost:5900
