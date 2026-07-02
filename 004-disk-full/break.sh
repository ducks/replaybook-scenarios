#!/usr/bin/env bash
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Fill /tmp (a small tmpfs) completely with a leftover debug dump.
# storage_opt was not used here: it only works on overlay2-over-xfs hosts.
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T app \
  sh -c 'rm -f /tmp/healthcheck; dd if=/dev/zero of=/tmp/app-debug.core bs=1M count=16 2>/dev/null || true'
