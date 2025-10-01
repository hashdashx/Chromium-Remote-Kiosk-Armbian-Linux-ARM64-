#!/bin/bash

# 1. Start Xvfb tanpa DPMS/screensaver
Xvfb :99 -screen 0 1920x1080x24 &
export DISPLAY=:99
sleep 2

# 2. Disable screensaver (backup)
#xset s off
#xset s noblank
#xset -dpms

# 3. Window manager
openbox --display :99 &

# 4. Jalankan Chromium kiosk
DISPLAY=:99 chromium \
  --kiosk \
  --no-first-run \
  --disable-translate \
  --no-sandbox \
  --disable-gpu \
  --disable-software-rasterizer \
  --disable-dev-shm-usage \
  --window-position=0,0 \
  --window-size=1920,1080 \
  --force-device-scale-factor=1 \
  --alsa-output-device=default \
  --autoplay-policy=no-user-gesture-required \
  http://192.168.60.6:8090 &

# 5. Start VNC
x11vnc -display :99 -nopw -forever -noxdamage -rfbport 5900
