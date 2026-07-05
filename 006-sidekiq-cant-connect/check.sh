#!/usr/bin/env bash
SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Success: sidekiq's configured connection can actually WRITE to redis.
# A read-only ping would miss the maxmemory fault (reads still work when
# redis is full), so this must be a write.
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T sidekiq \
  bundle exec ruby -r sidekiq -e 'Sidekiq.redis { |c| c.call("SET", "replaybook:check", "1") }' \
  > /dev/null 2>&1
