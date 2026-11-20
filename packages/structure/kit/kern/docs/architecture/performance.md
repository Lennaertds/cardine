# Performance

> **Rol:** Budgets en anti-patronen zodat performance vanaf dag 1 meespeelt bij ontwerp en code — niet pas na een incident.
> **Niet hier:** hoe je metrics/traces ziet ([observability.md](observability.md)); security ([security.md](security.md)).

Meten (latency, saturatie, profiles) gebeurt via de LGTM-stack in [observability.md](observability.md) (als die module aanstaat). **Beslissen wat “goed genoeg” is** staat hier.

## Relatie tot observability

| Hier | Elders |
|------|--------|
| Budgets, verboden patronen | `observability.md` — signalen, OTel, Grafana, alerts/SLO’s |
| Wanneer native (Rust/C) na budget-breuk | [polyglot.md](polyglot.md) |
| `make bench` / `make perf-check` | `make obs-up`, dashboards |

## Lagen (prioriteit)

Budgetteer en bench in deze volgorde (grootste impact / makkelijkst te meten eerst):

1. **API** — request p95, N+1, blocking I/O op het request-pad  
2. **Web** — TTFB / LCP of bundle-grootte (smoke)  
3. **Batch / analytics** — job-duur of rijen/s op een vaste fixture  

SQL-pipeline: datakwaliteit blijft `checks-pipeline`; perf alleen als een mart aantoonbaar traag is (ADR). Pas de lagen aan op de stacks van dit project.

## Budgets

Vervang de voorbeelden door projectcijfers. Lege of verouderde budgets → BACKLOG, niet stilzwijgend negeren.

| Laag | Metric | Budget (voorbeeld — pas aan) | Meet met |
|------|--------|------------------------------|----------|
| API | p95 latency `GET /health` (lokaal, warm) | &lt; 50 ms | `make bench-api` |
| API | p95 latency typische read-endpoint | &lt; 200 ms | `make bench-api` + obs |
| Web | JS bundle main (gzip), of LCP op landing | &lt; 250 KiB / &lt; 2.5 s | `make bench-web` |
| Analytics | Duur `make data-analytics` op demo-fixture | &lt; 60 s | `make bench-analytics` |

SLO’s die users raken horen ook in observability (error budget); dit bestand houdt de **engineering-budgets** scherp.

## Anti-patronen (dag 1)

| Niet | Wel |
|------|-----|
| N+1 queries / `await` in een lus naar de DB | Batch, join, of DataLoader-patroon |
| Zwaar CPU/sync werk op het HTTP-request-pad | Queue, worker, of native module (Rust/C) na meting |
| Onbegrensde `SELECT *` / full table scan in hot path | Index + begrensde query; uitleg in ADR als uitzondering |
| Nieuwe dependency “voor snelheid” zonder bench | Eerst meten (`bench` of obs), dan ADR |
| Agent neemt aan dat Rust/C “niet mag” | Mag wél na budget-breuk + ADR; zie [polyglot.md](polyglot.md) |

## Commando's

```bash
make perf-check    # structuur budgets/anti-patronen; niet in make check
make bench         # alle bench-<app>
make bench-api     # één laag
```

Ontbreekt `apps/<app>/scripts/bench.sh`: het Make-target faalt met uitleg — zie [how-to/perf-bench.md](../how-to/perf-bench.md). Bewuste weglatingen: [Bewust later](#bewust-later) (P28).

## Productie

<Hosting-limieten, autoscaling, CDN, read-replica’s — kort, of ADR.>

## Bewust later

Vaste kop (P28): vraag ernaar of BACKLOG als dit nodig wordt.

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Heuristische code-scan op anti-patronen | v1 = docs + bench-stubs | Agent/CI moet N+1 e.d. automatisch vlaggen |
| Echte `apps/<app>/scripts/bench.sh` per stack | Project vult in na eerste meting | Budgets zonder meetpad |
| Load / stress / chaos (`k6`, Locust, …) | Geen vaste tool in kern | Release-gate of capaciteitsvraag |
| Heuristische latency-regressie op CI-artifact | Soft bench stubs; STRICT native is apart (`native-ci.md`) | PR faalt bij p95-regressie zonder handmatige bench |
