#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T app \
  rm -f /tmp/app-debug.core
