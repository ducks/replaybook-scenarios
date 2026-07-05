#!/usr/bin/env bash
# Solve for the auth-drift fault (and the compat break.sh): restarting
# redis discards the un-persisted CONFIG SET and restores the password
# from its command line.
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" restart redis
