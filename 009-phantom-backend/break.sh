#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Someone pinned 'backend' to an IP in /etc/hosts during last month's
# incident - and that IP belongs to the decommissioned canary.
# /etc/hosts beats DNS, so every app request silently goes to the wrong
# service. Needs script logic (the canary's IP is only known at runtime),
# so this is a break.sh rather than declarative steps.
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T app \
  sh -c 'IP=$(python -c "import socket,sys; print(socket.gethostbyname(sys.argv[1]))" backend-canary); echo "$IP backend # pinned during 2026-06 incident, remove after fix" >> /etc/hosts'
