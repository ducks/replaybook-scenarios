#!/usr/bin/env bash
# The intended player fix: discover the stale /etc/hosts pin inside the
# app container and remove it - name resolution falls back to DNS.
# /etc/hosts is a docker bind mount, so sed -i (rename-based) fails with
# 'device busy'; rewrite the file in place via a truncating redirect.
set -e

SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T app \
  sh -c 'grep -v " backend " /etc/hosts > /tmp/hosts.clean && cat /tmp/hosts.clean > /etc/hosts && rm /tmp/hosts.clean'
