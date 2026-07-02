#!/usr/bin/env bash
SCENARIO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Success: the connection sidekiq is configured with actually reaches Redis.
# (RestartCount is useless here - it never resets, so any threshold on it
# becomes unwinnable once the crash loop has run a few times.)
docker compose -f "$SCENARIO_DIR/docker-compose.yml" exec -T sidekiq \
  bundle exec ruby -r sidekiq -e 'Sidekiq.redis { |c| c.ping }' > /dev/null 2>&1
