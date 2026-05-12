#!/bin/bash
set -e

# Virtual display for Chrome
Xvfb :99 -screen 0 1400x900x24 -ac &
sleep 2

# Window manager
fluxbox -display :99 &
sleep 1

# VNC server
x11vnc -display :99 -forever -nopw -shared -rfbport 5900 -bg -o /tmp/x11vnc.log

# noVNC (browser access to VNC on port 6081)
/opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6081 &
sleep 1

echo "Starting PMWeb Agent on port ${PORT:-8080}..."
exec gunicorn \
    --bind 0.0.0.0:${PORT:-8080} \
    --workers 1 \
    --timeout 600 \
    --graceful-timeout 600 \
    --keep-alive 120 \
    --worker-class uvicorn.workers.UvicornWorker \
    app.main:app
