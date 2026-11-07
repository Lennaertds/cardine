# Spec — totaalproduct-onderdelen

> **Rol:** Plan voor één werkitem. Tijdelijk: na merge verwijderen; de code en de tests zijn dan de waarheid.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `docs/totaalproduct-onderdelen`
- **Status:** open (slice 1 = docs-kader)

## Doel

Alle onderdelen van het persoonlijke totaalproduct (IDE → LLM) vastleggen in docs, met per onderdeel een spec van open keuzes — zodat we gericht kunnen beslissen i.p.v. Cursor-pariteit najagen.

## Scope

- **In:** [totaalproduct.md](../../product/totaalproduct.md) als samenhang; **per onderdeel** een `docs/product/<naam>.md` om bij te houden; negen `onderdeel-*.md` specs voor open keuzes; PRODUCT/INDEX; [cursor-vervang-lagen](cursor-vervang-lagen.md) kaart → totaalproduct.
- **Buiten scope:** ADRs; apps-code; A4-§ in AE (blijft aparte slices); thesis-diepte; productisatie voor derden.

## Raakvlakken

- Product: `docs/product/totaalproduct.md`, `indexing.md`, `PRODUCT.md`
- Specs: `onderdeel-*.md`
- Research: `ideeen-en-vragen.md` (B-hypothese blijft)
- Voorbeeld: [cursor-vervang-lagen](cursor-vervang-lagen.md)

## Onderdelen (9 — jij had 1–6; 7–9 aangevuld)

| # | Spec |
|---|------|
| 1 | [onderdeel-ide-shell](onderdeel-ide-shell.md) |
| 2 | [onderdeel-fs-events](onderdeel-fs-events.md) |
| 3 | [onderdeel-indexing](onderdeel-indexing.md) |
| 4 | [onderdeel-tools](onderdeel-tools.md) |
| 5 | [onderdeel-harness](onderdeel-harness.md) |
| 6 | [onderdeel-llm](onderdeel-llm.md) |
| 7 | [onderdeel-structure](onderdeel-structure.md) |
| 8 | [onderdeel-agent-ui](onderdeel-agent-ui.md) |
| 9 | [onderdeel-session-spine](onderdeel-session-spine.md) |

## Slices

1. **Kader** — totaalproduct.md + indexing.md + negen onderdeel-specs met open keuzes + BACKLOG/INDEX/PRODUCT.
2. Per onderdeel: onderzoek → §/score → ADR (één tegelijk; start IDE of indexing naar voorkeur).

## Acceptatie

- [x] Negen onderdelen + uitleg FS/events; gemiste lagen structure/UI/spine benoemd
- [x] Indexing-doc bevat “waard om te bekijken”
- [x] Elke onderdeel-spec heeft open beslissingen (geen stille ADR)
- [x] Per onderdeel een `docs/product/*.md`; totaalproduct = samenhang
- [x] `make links` groen (na afronden)
