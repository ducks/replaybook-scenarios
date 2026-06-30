# on-call-scenarios

Official scenario pack for [on-call](https://github.com/ducks/on-call).

## Install

```bash
on-call add ducks/on-call-scenarios
```

## Scenarios

| ID | Title | Difficulty |
|----|-------|------------|
| 001-nginx-502 | 502 Bad Gateway | 1 |
| 002-postgres-wont-start | Postgres Won't Start | 1 |
| 003-missing-env-var | App Crashing on Boot | 1 |
| 004-disk-full | Health Checks Failing | 2 |
| 005-oom-kill | Container Keeps Restarting | 2 |
| 006-sidekiq-cant-connect | Jobs Not Processing | 2 |
| 007-packet-loss | Intermittent Request Failures | 3 |

## Contributing

Each scenario is a directory with:

```
my-scenario/
  meta.json            # id, title, page text, difficulty, hints, success condition
  docker-compose.yml   # the environment
  break.sh             # injects the fault after compose up
  check.sh             # polled to detect resolution (or use http_200 in meta.json)
```

See any existing scenario for a working example.
