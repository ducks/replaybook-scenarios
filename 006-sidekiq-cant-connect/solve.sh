#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Align the Redis password with the one sidekiq is configured to use
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T redis \
  redis-cli -a correctpassword config set requirepass wrongpassword > /dev/null 2>&1
