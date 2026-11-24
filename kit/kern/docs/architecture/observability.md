# Observability

> **Rol:** Welke signalen dit project verplicht emitteert, welke stack lokaal/productie gebruikt, en hoe je ze start.
> **Niet hier:** security-dreigingen ([security.md](security.md)); latency-**budgets** en anti-patronen ([performance.md](performance.md)); containerdiagram ([ARCHITECTURE.md](ARCHITECTURE.md)).

## Kit-default (LGTM)

Self-host **LGTM** via OpenTelemetry. Dit is de standaardkeuze van de kit, niet “al live in elke app”:

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

| Laag | Keuze |
|------|--------|
| Instrumentatie | OpenTelemetry (SDK per stack: Node/Nest, Next, Python, …) |
| Collector | Grafana Alloy |
| Metrics | Prometheus |
| Logs | Loki (structured JSON + `trace_id`) |
| Traces | Tempo |
| UI | Grafana |

Afwijken mag per project — leg het vast in een ADR en pas dit bestand aan.

## Verplichte signalen

| Signaal | Minimaal | Let op |
|---------|----------|--------|
| Logs | Structured JSON; errors met stack | Geen secrets; wel `trace_id` |
| Metrics | RED of USE per service (rate, errors, duration) | Labels **bounded** — geen `user_id` / raw URL |
| Traces | Inbound HTTP + DB/outbound calls | Context propagation |
| Events | Deploys / migraties als markers waar mogelijk | |
| Alerts | Eerst symptomen (availability/latency), later SLO-burn | Niet alleen CPU |
| SLOs | Minstens één user-facing doel (beschikbaarheid of latentie) | Error budget |
| Security telemetry | Auth-failures, 4xx/5xx op authz | Aanvullen met `make security-scan` |

**Cardinality:** hoog-kardinaliteit-IDs horen in logs/traces, niet in metric-labels.

## Lokaal draaien

Module `observability` zet `docker-compose.observability.yml` + configs onder `infra/observability/`. Zonder die module bestaan de compose-files niet — zie [Bewust later](#bewust-later).

```bash
make obs-up       # LGTM-stack starten
make obs-status   # containers
make obs-down     # stoppen
```

Grafana: meestal http://localhost:3001 (poort in compose; vermijd clash met Next op 3000).

Zonder module: Make-targets zeggen hoe je `--modules observability` toevoegt. Zonder OTel in de apps: stack draait leeg — zie [Bewust later](#bewust-later) (P28).

## Productie

<Hosting: zelfde stack self-host, of managed equivalent met OTel-ingest. Wat hier lokaal Grafana is, is daar …>

## Correlatie

Minimale velden op alle signalen: `service.name`, `service.version`, `deployment.environment`, `trace_id` / `span_id`, `request_id`.

## Bewust later

Vaste kop (P28): vraag ernaar of BACKLOG als dit nodig wordt.

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| OTel-instrumentatie in apps (Nest/Next/Python) | Docs + compose eerst; code per app | Eerste echte metrics/traces in Grafana |
| Kant-en-klare Grafana-dashboards in de module | Voorkomt vendor-lock op één layout | Team wil day-1 RED/USE panels |
| Alertmanager / vaste alert-rules in kit | Alerts zijn project-specifiek | Productie-on-call zonder ad-hoc alerts |
| Managed cloud-obs i.p.v. LGTM | Default = self-host LGTM | Hosting dwingt andere stack → ADR + dit bestand |
