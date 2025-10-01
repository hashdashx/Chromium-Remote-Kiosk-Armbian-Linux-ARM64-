# Chromium Remote Kiosk (Armbian / Linux ARM64)

Proyek ini menunjukkan cara menjalankan **Chromium dalam mode kiosk** pada **Armbian headless (tanpa monitor, tanpa desktop environment)** dengan menampilkan output melalui **VNC** atau **noVNC (akses via browser)**.

## 🚀 Fitur
- Menjalankan Chromium langsung dalam mode kiosk (fullscreen) di display virtual (Xvfb)
- Tidak memerlukan desktop environment (LXDE/XFCE/GNOME)
- Akses tampilan Chromium melalui:
  - **VNC Viewer** (port 5900)
  - **noVNC di browser** (port 6080)
- Skrip otomatis start & stop

---

## 📂 Struktur
```
.
├── chromium-vnc.sh      # Skrip untuk menjalankan Chromium + VNC + noVNC
├── kill-chromium.sh     # Skrip untuk menghentikan semua proses terkait
└── README.md            # Dokumentasi (ini file)
```

---

## ⚙️ Instalasi

### 1. Install dependency
```bash
sudo apt update
sudo apt install -y chromium xvfb x11vnc novnc websockify x11-xserver-utils openbox alsa-utils

```

### 2. Simpan skrip
**chromium-vnc.sh**
```bash
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
```

**kill-chromium.sh**
```bash
#!/bin/bash
# Hentikan semua proses
pkill chromium
pkill x11vnc
killall Xvfb
pkill -f "websockify --web=/usr/share/novnc/ 6080 localhost:5900"
```

Beri izin eksekusi:
```bash
chmod +x chromium-vnc.sh kill-chromium.sh
```

---

## ▶️ Menjalankan

### Start Chromium Kiosk Remote
```bash
./chromium-vnc.sh
```

### Stop semua proses
```bash
./kill-chromium.sh
```

---

## 🔗 Akses
- Dari PC/Laptop (Windows/Linux/macOS):
  - **VNC Viewer** → `192.168.60.2:5900`
  - **Browser** → `http://192.168.60.2:6080`

> Ganti `192.168.60.2` dengan IP dari board Armbian kamu.

---

# 🌍 English Version

## Chromium Remote Kiosk (Armbian / Linux ARM64)

This project demonstrates how to run **Chromium in kiosk mode** on **Armbian headless (no monitor, no desktop environment)** and expose the display through **VNC** or **noVNC (browser access)**.

## 🚀 Features
- Run Chromium directly in kiosk mode (fullscreen) in a virtual display (Xvfb)
- No need for desktop environments (LXDE/XFCE/GNOME)
- Access Chromium display via:
  - **VNC Viewer** (port 5900)
  - **noVNC in browser** (port 6080)
- Easy start & stop scripts

---

## 📂 Structure
```
.
├── chromium-vnc.sh      # Script to start Chromium + VNC + noVNC
├── kill-chromium.sh     # Script to kill all related processes
└── README.md            # Documentation (this file)
```

---

## ⚙️ Installation

### 1. Install dependencies
```bash
sudo apt update
sudo apt install -y chromium xvfb x11vnc novnc websockify x11-xserver-utils openbox alsa-utils
```

### 2. Save scripts
**chromium-vnc.sh**
```bash
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
```

**kill-chromium.sh**
```bash
#!/bin/bash
# Kill all processes
pkill chromium
pkill x11vnc
killall Xvfb
pkill -f "websockify --web=/usr/share/novnc/ 6080 localhost:5900"
```

Make them executable:
```bash
chmod +x chromium-vnc.sh kill-chromium.sh
```

---

## ▶️ Run

### Start Chromium Kiosk Remote
```bash
./chromium-vnc.sh
```

### Stop all processes
```bash
./kill-chromium.sh
```

---

## 🔗 Access
- From PC/Laptop (Windows/Linux/macOS):
  - **VNC Viewer** → `192.168.60.2:5900`
  - **Browser** → `http://192.168.60.2:6080`

> Replace `192.168.60.2` with your Armbian board IP.

