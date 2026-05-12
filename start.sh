#!/usr/bin/env bash
set -euo pipefail

# Start Xvfb for headless Chrome (only if no DISPLAY is set)
if [ -z "${DISPLAY:-}" ]; then
  export DISPLAY=:99
  Xvfb :99 -screen 0 1400x900x24 &
  sleep 1
fi

exec uvicorn app.main:app \
  --host 0.0.0.0 \
  --port "${PORT:-8000}" \
  --workers 1 \
  --app-dir backend
