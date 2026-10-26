# Onderzoek

> **Rol:** Wat we over het domein weten, op welke bronnen dat steunt, en welke productregel erop rust.
> **Niet hier:** de productregels zelf (`product/`), code van experimenten (`apps/<app>/experiments/`).

## Programma (agents: start hier)

Volledig: [onderzoek-programma.md](onderzoek-programma.md) — volgorde A1→A2→A5→A4→A3→B, waar § vs wantlist vs ADR.

## Onderzoeksvragen

1. Welke minimale harness-oppervlakte volstaat om een agent de projectstandaard te laten respecteren (meetbaar)?
2. Hoe moet structure-integratie (docs/rules/seams) in de loop landen zonder de standaard te dupliceren?
3. Welke indexing-aanpak geeft bruikbare context zonder secrets of vreemde projectdata te lekken?
4. (A1–A5) Wat kunnen we van Cursor / Pi / DeepSeek Harness / peers leren — technisch en met benchmarks — vóór stack/fork-ADR?

## Hoe we bronnen beoordelen

| Niveau | Wat telt | Gebruik |
|--------|----------|---------|
| A | Meta-analyse of systematische review | Mag een productregel dragen |
| B | Gerandomiseerde studie | Mag een regel dragen, met vermelding |
| C | Observationeel, expert, blog | Alleen als hypothese of experiment |

## Kaart van `research/`

- [onderzoek-programma.md](onderzoek-programma.md) — Volgorde A1→…→B en waar schrijven.
- [wantlist.md](wantlist.md) — Bronnen die we nog willen verwerven.
- (A5) `vergelijking-harness-ide.md` — nog te maken; cellen met §-links.
- [radar.md](radar.md) — Tech-radar (Adopt/Trial/Assess/Hold); maandelijks `make radar-reminder`.
- [digest/](digest/README.md) — Inbound feeds; `digest-fetch` / `digest-propose` (cureren vóór radar).
- `experiments/` — Eén verslag per experiment: `make experiment s=<slug>`.
