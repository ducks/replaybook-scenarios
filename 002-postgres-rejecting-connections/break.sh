#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"
COMPOSE=(docker compose -f "$SCENARIO_DIR/docker-compose.yml")

# Wait for postgres to finish first-boot init before touching it
for _ in $(seq 1 30); do
  "${COMPOSE[@]}" exec -T db pg_isready -h 127.0.0.1 -U postgres > /dev/null 2>&1 && break
  sleep 1
done

# A pg_hba rule someone added "temporarily" - first match wins, so this
# rejects every TCP connection. Survives restarts, unlike ownership faults
# (the official entrypoint chowns the data dir back on every start).
"${COMPOSE[@]}" exec -T db \
  sed -i '1i host all all all reject' /var/lib/postgresql/data/pg_hba.conf
"${COMPOSE[@]}" exec -T db psql -U postgres -c 'SELECT pg_reload_conf()' > /dev/null
