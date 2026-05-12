#!/bin/bash
set -e

# Start virtual display
Xvfb :99 -screen 0 1400x900x24 -ac &
sleep 2

# Start window manager
fluxbox -display :99 &
sleep 1

# Start VNC server
x11vnc -display :99 -forever -nopw -shared -rfbport 5900 -bg -o /tmp/x11vnc.log

# Start noVNC WebSocket proxy
/opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6081 &
sleep 1

# Start the app
exec gunicorn \
    --bind 0.0.0.0:${PORT:-8080} \
    --workers 2 \
    --timeout 300 \
    --worker-class uvicorn.workers.UvicornWorker \
    app.main:app
