# docs/architecture/performance.md

> **Role:** Budgets and anti-patterns; performance from day 1.
> **Not here:** dashboards ([observability](observability.md)).

**Kit file:** [kit/kern/docs/architecture/performance.md](../kit/kern/docs/architecture/performance.md) · layer kern · P13

## When

Day 0 with the example budgets. Update the numbers once you have a first measurement (`make bench-*` or obs). With every new hot path: a row in the table or an ADR. AGENTS: only via INDEX when the task names it, not always-on.

## Filling in

1. **Budgets:** replace the examples with project numbers (API first, then web, then analytics). Adapt the layers to the project's stacks.
2. **Production:** limits/CDN/scaling briefly or via an ADR.
3. **Bench scripts:** `apps/<app>/scripts/bench.sh` — see the [how-to in the kit](../kit/kern/docs/how-to/perf-bench.md).
4. **`## Deliberately incomplete` (P28):** keep the kit rows or extend them (P28); no silent omissions. No paths into Agent Engineering `bron/` in the project file.

## Quick check

- [ ] `make perf-check` is green.
- [ ] `make bench` / `bench-api` are listed in `make help`; not in `make check`.
- [ ] `## Deliberately incomplete` has at least one extension row (P28).
- [ ] The budgets table has project numbers, no stale examples without a BACKLOG entry.
