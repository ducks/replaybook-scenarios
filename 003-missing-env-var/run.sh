#!/bin/sh
# Keep the container alive while the app crash-loops, so the player can get
# inside and fix it. The supervisor is part of the scenario, not the fault.
while true; do
  sh -c '. /app/.env 2>/dev/null; exec python /app/app.py'
  echo "[supervisor] app exited ($?), restarting in 2s..." >&2
  sleep 2
done
