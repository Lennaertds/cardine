# Onderzoek

> **Rol:** Wat we over het domein weten, op welke bronnen dat steunt, en welke productregel erop rust.
> **Niet hier:** de productregels zelf (`product/`), code van experimenten (`apps/<app>/experiments/`).

## Onderzoeksvragen

1. Welke minimale harness-oppervlakte volstaat om een agent de projectstandaard te laten respecteren (meetbaar)?
2. Hoe moet structure-integratie (docs/rules/seams) in de loop landen zonder de standaard te dupliceren?
3. Welke indexing-aanpak geeft bruikbare context zonder secrets of vreemde projectdata te lekken?

## Hoe we bronnen beoordelen

| Niveau | Wat telt | Gebruik |
|--------|----------|---------|
| A | Meta-analyse of systematische review | Mag een productregel dragen |
| B | Gerandomiseerde studie | Mag een regel dragen, met vermelding |
| C | Observationeel, expert, blog | Alleen als hypothese of experiment |

## Kaart van `research/`

- [<onderwerp>.md](<onderwerp>.md) — <wat we weten, met bronnen en niveau>
- [wantlist.md](wantlist.md) — Bronnen die we nog willen verwerven.
- [radar.md](radar.md) — Tech-radar (Adopt/Trial/Assess/Hold); maandelijks `make radar-reminder`.
- [digest/](digest/README.md) — Inbound feeds; `digest-fetch` / `digest-propose` (cureren vóór radar).
- `experiments/` — Eén verslag per experiment: `make experiment s=<slug>`.
