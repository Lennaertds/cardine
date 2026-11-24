# docs/research/radar.md

> **Rol:** Tech-radar (Adopt/Trial/Assess/Hold); maandelijks herijken.
> **Niet hier:** wantlist ([research](research.md)), CVE-audits ([dependencies](dependencies.md)).

**Kitbestand:** [kit/modules/research/docs/research/radar.md](../kit/modules/research/docs/research/radar.md) · module `research` · P5, P8, P25, P28  
**How-to:** [kit/modules/research/docs/how-to/radar.md](../kit/modules/research/docs/how-to/radar.md)

## Wanneer

Met module `research`. Dag 0: voorbeeldrijen vervangen of markeren. Daarna maandelijks (`make radar-reminder`).

## Invullen

1. **Laatst herzien:** echte `YYYY-MM-DD` na elke inhoudelijke pass.
2. **Rijen:** projectkeuzes; voorbeeldrijen weg of herschreven (geen illustratie als feit laten staan).
3. **Adopt/Hold met impact:** ADR.
4. **`## Bewust later`:** kitrijen laten of aanvullen (P28). Geen scrapers in v1.

## Snelle toets

- [ ] `make radar-check` is groen.
- [ ] `radar-check` / `radar-reminder` in `make help`; niet in `CHECK` / `check-full`.
- [ ] `## Bewust later` heeft minstens één uitbreidingsrij (P28).
- [ ] Geen feed-dump in dit bestand (P5).
