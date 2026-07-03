#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Add 80% packet loss on the app container's eth0 - heavy enough that TCP
# retransmission can't paper over it within the check's 1s budget
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T app \
  tc qdisc add dev eth0 root netem loss 80%
