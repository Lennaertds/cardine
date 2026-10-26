# Onderzoek

> **Rol:** Wat we over het domein weten, op welke bronnen dat steunt, en welke productregel erop rust.
> **Niet hier:** de productregels zelf (`product/`), code van experimenten (`apps/<app>/experiments/`).

## Programma (agents: start hier)

Volledig: [onderzoek-programma.md](onderzoek-programma.md) — A1→A2→A5→A4→A3, daarna A6–A9, dan B. Ruwe lijst: [ideeen-en-vragen.md](ideeen-en-vragen.md).

## Onderzoeksvragen

1. Welke minimale harness-oppervlakte volstaat om een agent de projectstandaard te respecteren (meetbaar)?
2. Structure-integratie: in docs, in de app vastgezet (A6), of beide — wat kost minder overhead?
3. Welke indexing-aanpak (na §69: exact/regex-first) zonder secrets/vreemde projectdata?
4. (A1–A5) Leren van Cursor / Pi / DeepSeek Harness / peers — technisch + benchmarks — vóór stack/fork-ADR?
5. (A7) Wat moet naast `make check` vóór push/prod (continu testen, revert)?
6. (A8–A9) Agent-docformaat + session/spine over workspace-grenzen?

## Hoe we bronnen beoordelen

| Niveau | Wat telt | Gebruik |
|--------|----------|---------|
| A | Meta-analyse of systematische review | Mag een productregel dragen |
| B | Gerandomiseerde studie | Mag een regel dragen, met vermelding |
| C | Observationeel, expert, blog | Alleen als hypothese of experiment |

## Kaart van `research/`

- [onderzoek-programma.md](onderzoek-programma.md) — Volgorde + bronsoorten + waar schrijven.
- [ideeen-en-vragen.md](ideeen-en-vragen.md) — Jouw vragen 1–9 + B; niet kwijtraken.
- [wantlist.md](wantlist.md) — Bronnen die we nog willen verwerven.
- (A5) `vergelijking-harness-ide.md` — nog te maken; cellen met §-links.
- [radar.md](radar.md) — Tech-radar (Adopt/Trial/Assess/Hold); maandelijks `make radar-reminder`.
- [digest/](digest/README.md) — Inbound feeds; `digest-fetch` / `digest-propose` (cureren vóór radar).
- `experiments/` — Eén verslag per experiment: `make experiment s=<slug>`.
