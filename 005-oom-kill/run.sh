#!/bin/sh
# Keep the container alive while the app process gets OOM-killed, so the
# player can get inside. The supervisor is part of the scenario, not the fault.
while true; do
  python /app/app.py
  echo "[supervisor] app exited ($?), restarting in 2s..." >&2
  sleep 2
done
