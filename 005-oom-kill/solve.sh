#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" cp \
  "$SCENARIO_DIR/cache.conf" app:/app/cache.conf
# The in-container supervisor restarts the app within a couple of seconds.
