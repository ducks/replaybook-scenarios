#!/usr/bin/env bash
SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# The db must accept a real TCP connection, not just be running -
# pg_hba rejections only apply to the TCP path, so force -h.
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T -e PGPASSWORD=password db \
  psql -h 127.0.0.1 -U postgres -d appdb -c 'SELECT 1' > /dev/null 2>&1
