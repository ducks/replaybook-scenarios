#!/usr/bin/env bash
set -euo pipefail

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONTAINER=$(docker compose -f "$SCENARIO_DIR/docker-compose.yml" ps -q app)

docker cp "$SCENARIO_DIR/pool.conf" "$CONTAINER:/app/pool.conf"
docker compose -f "$SCENARIO_DIR/docker-compose.yml" restart app
