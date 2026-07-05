#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Someone "temporarily" stopped redis and forgot about it.
docker compose -f "$SCENARIO_DIR/docker-compose.yml" stop redis
