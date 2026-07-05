#!/usr/bin/env bash
# Compat shim for engines without fault-variant support: plays the
# auth-drift fault. Engines with faults support use meta.json's list.
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T redis \
  sh -c "redis-cli -a correctpassword config set requirepass hunter2 > /dev/null 2>&1"
docker compose -f "$SCENARIO_DIR/docker-compose.yml" restart sidekiq
