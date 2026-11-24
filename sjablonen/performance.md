# docs/architecture/performance.md

> **Rol:** Budgets en anti-patronen; performance vanaf dag 1.
> **Niet hier:** dashboards ([observability](observability.md)).

**Kitbestand:** [kit/kern/docs/architecture/performance.md](../kit/kern/docs/architecture/performance.md) · laag kern · P13

## Wanneer

Dag 0 met de voorbeeld-budgets. Pas cijfers aan zodra je een eerste meting hebt (`make bench-*` of obs). Bij elke nieuwe hot path: rij in de tabel of ADR. AGENTS: alleen via INDEX als de opdracht het noemt, niet always-on.

## Invullen

1. **Budgets:** vervang voorbeelden door projectcijfers (API eerst, dan web, dan analytics). Lagen aanpassen aan de stacks van het project.
2. **Productie:** limieten/CDN/scaling kort of via ADR.
3. **Bench-scripts:** `apps/<app>/scripts/bench.sh` — zie [how-to in de kit](../kit/kern/docs/how-to/perf-bench.md).
4. **`## Bewust later`:** kitrijen laten staan of aanvullen (P28); geen stille weglatingen. Geen paden naar Agent Engineering `bron/` in het projectbestand.

## Snelle toets

- [ ] `make perf-check` is groen.
- [ ] `make bench` / `bench-api` staan in `make help`; niet in `make check`.
- [ ] `## Bewust later` heeft minstens één uitbreidingsrij (P28).
- [ ] Budgets-tabel heeft projectcijfers, geen verouderde voorbeelden zonder BACKLOG.
