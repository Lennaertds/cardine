# Performance

> **Role:** budgets and anti-patterns so that performance counts from day one in design and code — not only after an incident.
> **Not here:** how to see metrics/traces ([observability.md](observability.md)); security ([security.md](security.md)).

Measuring (latency, saturation, profiles) happens through the LGTM stack in [observability.md](observability.md) (if that module is on). **Deciding what "good enough" is** happens here.

## Relation to observability

| Here | Elsewhere |
|------|-----------|
| Budgets, forbidden patterns | `observability.md` — signals, OTel, Grafana, alerts/SLOs |
| When native (Rust/C) after a budget breach | [polyglot.md](polyglot.md) |
| `make bench` / `make perf-check` | `make obs-up`, dashboards |

## Layers (priority)

Budget and bench in this order (largest impact / easiest to measure first):

1. **API** — request p95, N+1, blocking I/O on the request path
2. **Web** — TTFB / LCP or bundle size (smoke)
3. **Batch / analytics** — job duration or rows/s on a fixed fixture

SQL pipeline: data quality stays with `checks-pipeline`; perf only when a mart is demonstrably slow (ADR). Adapt the layers to this project's stacks.

## Budgets

Replace the examples with project numbers. Empty or outdated budgets → BACKLOG, never silently ignored.

| Layer | Metric | Budget (example — change this) | Measure with |
|-------|--------|--------------------------------|--------------|
| API | p95 latency `GET /health` (local, warm) | &lt; 50 ms | `make bench-api` |
| API | p95 latency typical read endpoint | &lt; 200 ms | `make bench-api` + obs |
| Web | JS bundle main (gzip), or LCP on landing | &lt; 250 KiB / &lt; 2.5 s | `make bench-web` |
| Analytics | Duration `make data-analytics` on demo fixture | &lt; 60 s | `make bench-analytics` |

SLOs that affect users also belong in observability (error budget); this file keeps the **engineering budgets** sharp.

## Anti-patterns (day one)

| Not this | But this |
|----------|----------|
| N+1 queries / `await` in a loop to the DB | Batch, join, or the DataLoader pattern |
| Heavy CPU/sync work on the HTTP request path | Queue, worker, or a native module (Rust/C) after measuring |
| Unbounded `SELECT *` / full table scan in a hot path | Index + bounded query; explanation in an ADR if it is an exception |
| A new dependency "for speed" without a bench | Measure first (`bench` or obs), then an ADR |
| The agent assuming Rust/C "is not allowed" | It is allowed after a budget breach + ADR; see [polyglot.md](polyglot.md) |

## Commands

```bash
make perf-check    # structure of budgets/anti-patterns; not in make check
make bench         # every bench-<app>
make bench-api     # a single layer
```

Missing `apps/<app>/scripts/bench.sh`: the Make target fails with an explanation — see [how-to/perf-bench.md](../how-to/perf-bench.md). Deliberate omissions: [Deliberately later](#deliberately-later) (P28).

## Production

<Hosting limits, autoscaling, CDN, read replicas — brief, or an ADR.>

## Deliberately later

Fixed heading (P28): ask about it or file a BACKLOG item when this becomes needed.

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Heuristic code scan for anti-patterns | v1 = docs + bench stubs | Agent/CI must flag N+1 etc. automatically |
| A real `apps/<app>/scripts/bench.sh` per stack | The project fills it in after the first measurement | Budgets without a measurement path |
| Load / stress / chaos (`k6`, Locust, …) | No fixed tool in the core | Release gate or capacity question |
| Heuristic latency regression on CI artefacts | Soft bench stubs; native STRICT is separate (`native-ci.md`) | A PR fails on a p95 regression without a manual bench |
