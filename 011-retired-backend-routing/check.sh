#!/usr/bin/env bash
set -euo pipefail

body=$(docker compose exec -T nginx wget -T 2 -qO- http://127.0.0.1/checkout)
case "$body" in
  "checkout backend handled checkout"*) exit 0 ;;
  *) exit 1 ;;
esac
