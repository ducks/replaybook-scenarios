#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T redis \
  sh -c "redis-cli -a correctpassword config set maxmemory 0 > /dev/null 2>&1"
