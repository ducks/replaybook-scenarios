#!/usr/bin/env bash
# The intended player fix: discover the stale /etc/hosts pin inside the
# app container and remove it - name resolution falls back to DNS.
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T app \
  sh -c "sed -i '/ backend /d;/ backend\$/d' /etc/hosts"
