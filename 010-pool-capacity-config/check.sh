#!/usr/bin/env bash
set -euo pipefail

docker compose exec -T app wget -qO- http://127.0.0.1:8080/health | grep -q 'ok'
