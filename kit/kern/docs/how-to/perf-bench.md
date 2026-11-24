# How-to — performance bench

> **Rol:** `make bench` / `make perf-check` gebruiken en een app-bench toevoegen.
> **Niet hier:** budgets en anti-patronen ([performance.md](../architecture/performance.md)).

## perf-check

```bash
make perf-check
```

Controleert of `docs/architecture/performance.md` de vaste secties heeft (Budgets, Anti-patronen, …). Vult geen cijfers voor je in. **Niet** onderdeel van `make check`.

Uitbreidingen (heuristische scan, load-tests, …): zie `## Bewust later` in [performance.md](../architecture/performance.md) (P28).

## bench per app

1. Zet `apps/<app>/scripts/bench.sh` (uitvoerbaar) dat een meting print en non-zero exit bij budget-breuk.
2. Het kit-target `bench-<app>` roept dat script aan; ontbreekt het script → duidelijke fout.

Voorbeelden van minimale meting:

| App | Idee |
|-----|------|
| api | `curl` timing op `/health` en één read-route (API moet draaien of script start hem) |
| web | bundle-size na `build`, of Playwright timing op één URL |
| analytics | wall-clock van één CLI-commando op `tests/fixtures/` |

```bash
make bench-api
make bench          # alle apps in BENCH
```
