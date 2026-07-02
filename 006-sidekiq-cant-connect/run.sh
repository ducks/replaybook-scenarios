#!/bin/sh
# Keep the container alive while sidekiq crash-loops, so the player can get
# inside. The supervisor is part of the scenario, not the fault.
while true; do
  bundle exec sidekiq -r /app/worker.rb
  echo "[supervisor] sidekiq exited ($?), restarting in 5s..." >&2
  sleep 5
done
