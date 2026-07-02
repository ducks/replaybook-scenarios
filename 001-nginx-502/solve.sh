#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" cp \
  "$SCENARIO_DIR/nginx.conf" nginx:/etc/nginx/nginx.conf
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T nginx nginx -s reload
