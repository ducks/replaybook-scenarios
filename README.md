# replaybook-scenarios

Official scenario pack for [replaybook](https://github.com/ducks/replaybook).

## Install

```bash
replaybook add ducks/replaybook-scenarios
```

## Scenarios

| ID | Title | Difficulty |
|----|-------|------------|
| 001-nginx-502 | 502 Bad Gateway | 1 |
| 002-postgres-rejecting-connections | Postgres Rejecting Connections | 2 |
| 003-missing-env-var | App Crashing on Boot | 1 |
| 004-disk-full | Health Checks Failing | 2 |
| 005-oom-kill | App Keeps Dying | 2 |
| 006-sidekiq-cant-connect | Jobs Not Processing | 2 |
| 007-packet-loss | Intermittent Request Failures | 3 |

## Contributing

Each scenario is a directory with:

```
my-scenario/
  meta.json            # id, title, page text, difficulty, hints, success condition
  docker-compose.yml   # the environment
  break.sh             # injects the fault after compose up (or a break: [...] list in meta.json)
  check.sh             # polled to detect resolution (or use http_200 in meta.json)
  solve.sh             # scripted fix, used by `replaybook test` and CI - never shown to players
```

Every scenario must pass `replaybook test <id>`: it brings the environment up,
injects the fault, asserts the check fails, applies `solve.sh`, and asserts
the check recovers. CI runs this for every scenario on every push.

### Design rules

- **Faults live in apps and services, not in Docker.** The player should be
  reading nginx configs, postgres logs, and redis auth errors - not fixing
  the compose file. If the fix is a docker command, rethink the fault.
- **Keep the target container alive.** Players can't get into a container
  that's crash-looping. If the faulty process dies on boot, wrap it in a
  small supervisor loop (see 003/005/006's `run.sh`) so the *process*
  crash-loops while the container stays up.
- **Fault injection must be deterministic.** Prefer the declarative
  `break: [...]` steps in meta.json (cp/exec/restart) over `break.sh`;
  reserve the script for logic that genuinely needs it, and make it
  location-independent (resolve paths from the script's own directory).
- `solve.sh` should mirror the fix a player is expected to find - it doubles
  as documentation of the intended solution path.
- **Prefer fault variants over new lookalike scenarios.** A `faults: [...]`
  list in meta.json gives one symptom several root causes; `replaybook run`
  draws one blind, so repeat plays stay diagnostic. See
  `006-sidekiq-cant-connect` (auth drift vs redis OOM vs stopped redis) and
  the [engine README](https://github.com/ducks/replaybook#fault-variants-one-symptom-several-root-causes)
  for the format. Keep a compat `break.sh`/`solve.sh` for one fault so
  older engines still play the scenario.

See any existing scenario for a working example.
