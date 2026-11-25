# Observability

> **Role:** which signals this project is required to emit, which stack is used locally/in production, and how to start it.
> **Not here:** security threats ([security.md](security.md)); latency **budgets** and anti-patterns ([performance.md](performance.md)); container diagram ([ARCHITECTURE.md](ARCHITECTURE.md)).

## Kit default (LGTM)

Self-host **LGTM** through OpenTelemetry. This is the kit's default choice, not "already live in every app":

```
  apps (OTel SDK)
       │
       ▼
  Grafana Alloy          ← receiver / processor / exporter
       │
       ├──► Prometheus   metrics
       ├──► Loki         logs
       └──► Tempo        traces
              │
              ▼
           Grafana       UI (correlate via trace_id)
```

| Layer | Choice |
|-------|--------|
| Instrumentation | OpenTelemetry (SDK per stack: Node/Nest, Next, Python, …) |
| Collector | Grafana Alloy |
| Metrics | Prometheus |
| Logs | Loki (structured JSON + `trace_id`) |
| Traces | Tempo |
| UI | Grafana |

Deviating is allowed per project — record it in an ADR and adjust this file.

## Required signals

| Signal | Minimum | Watch out for |
|--------|---------|---------------|
| Logs | Structured JSON; errors with a stack | No secrets; keep `trace_id` |
| Metrics | RED or USE per service (rate, errors, duration) | Labels **bounded** — no `user_id` / raw URL |
| Traces | Inbound HTTP + DB/outbound calls | Context propagation |
| Events | Deploys / migrations as markers where possible | |
| Alerts | Symptoms first (availability/latency), SLO burn later | Not CPU alone |
| SLOs | At least one user-facing objective (availability or latency) | Error budget |
| Security telemetry | Auth failures, 4xx/5xx on authz | Complement with `make security-scan` |

**Cardinality:** high-cardinality IDs belong in logs/traces, not in metric labels.

## Running locally

The `observability` module provides `docker-compose.observability.yml` + configs under `infra/observability/`. Without that module the compose files do not exist — see [Deliberately later](#deliberately-later).

```bash
make obs-up       # start the LGTM stack
make obs-status   # containers
make obs-down     # stop
```

Grafana: usually http://localhost:3001 (port in compose; avoid clashing with Next on 3000).

Without the module: the Make targets explain how to add `--modules observability`. Without OTel in the apps: the stack runs empty — see [Deliberately later](#deliberately-later) (P28).

## Production

<Hosting: the same stack self-hosted, or a managed equivalent with OTel ingest. What is local Grafana here is … there.>

## Correlation

Minimum fields on all signals: `service.name`, `service.version`, `deployment.environment`, `trace_id` / `span_id`, `request_id`.

## Deliberately later

Fixed heading (P28): ask about it or file a BACKLOG item when this becomes needed.

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| OTel instrumentation in apps (Nest/Next/Python) | Docs + compose first; code per app | First real metrics/traces in Grafana |
| Ready-made Grafana dashboards in the module | Avoids vendor lock on one layout | The team wants day-1 RED/USE panels |
| Alertmanager / fixed alert rules in the kit | Alerts are project-specific | Production on-call without ad-hoc alerts |
| Managed cloud obs instead of LGTM | Default = self-hosted LGTM | Hosting forces another stack → ADR + this file |
