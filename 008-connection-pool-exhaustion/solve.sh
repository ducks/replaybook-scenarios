#!/usr/bin/env bash
# The intended player fix: find the connection hog via pg_stat_activity
# (application_name=nightly-batch), trace it to the batch container, and
# kill the leaking process.
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T batch \
  pkill -f leak.py
