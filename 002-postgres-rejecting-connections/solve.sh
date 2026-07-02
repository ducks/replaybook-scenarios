#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"
COMPOSE=(docker compose -f "$SCENARIO_DIR/docker-compose.yml")

"${COMPOSE[@]}" exec -T db \
  sed -i '/^host all all all reject$/d' /var/lib/postgresql/data/pg_hba.conf
"${COMPOSE[@]}" exec -T db psql -U postgres -c 'SELECT pg_reload_conf()' > /dev/null
