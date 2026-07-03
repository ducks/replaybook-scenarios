#!/usr/bin/env bash
# Must succeed 5 times in a row, fast - a single lenient curl lets TCP
# retransmission absorb the packet loss and passes while still broken.
set -e
for _ in $(seq 1 5); do
  curl -sf --max-time 1 http://localhost:8080/health > /dev/null || exit 1
done
