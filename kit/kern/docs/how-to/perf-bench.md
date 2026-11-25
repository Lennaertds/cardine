# How-to — performance bench

> **Role:** Use `make bench` / `make perf-check` and add a per-app bench.
> **Not here:** budgets and anti-patterns ([performance.md](../architecture/performance.md)).

## perf-check

```bash
make perf-check
```

Checks that `docs/architecture/performance.md` has the fixed sections (Budgets, Anti-patterns, …). It does not fill in numbers for you. **Not** part of `make check`.

Extensions (heuristic scan, load tests, …): see `## Deliberately later` (P28) in [performance.md](../architecture/performance.md).

## bench per app

1. Add `apps/<app>/scripts/bench.sh` (executable) that prints a measurement and exits non-zero on a budget breach.
2. The kit target `bench-<app>` calls that script; without the script → a clear error.

Examples of a minimal measurement:

| App | Idea |
|-----|------|
| api | `curl` timing on `/health` and one read route (the API must be running, or the script starts it) |
| web | bundle size after `build`, or Playwright timing on one URL |
| analytics | wall-clock of one CLI command on `tests/fixtures/` |

```bash
make bench-api
make bench          # all apps in BENCH
```
