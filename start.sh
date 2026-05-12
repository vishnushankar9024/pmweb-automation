#!/bin/bash
set -e

Xvfb :99 -screen 0 1400x900x24 -ac &
sleep 2
fluxbox -display :99 &
sleep 1
x11vnc -display :99 -forever -nopw -shared -rfbport 5900 -bg -o /tmp/x11vnc.log
/opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6081 &
sleep 1

exec gunicorn \
    --bind 0.0.0.0:${PORT:-8080} \
    --workers 1 \
    --timeout 600 \
    --graceful-timeout 600 \
    --worker-class uvicorn.workers.UvicornWorker \
    app.main:app
