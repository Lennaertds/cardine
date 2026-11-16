# Spec — totaalproduct-onderdelen

> **Rol:** Plan voor één werkitem. Tijdelijk: na merge verwijderen; de code en de tests zijn dan de waarheid.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `docs/totaalproduct-onderdelen`
- **Status:** kader gedaan; herindeling 2026-11-16 (groepen + volgorde). Geen ADR.

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

## Onderdelen

Nummers blijven de laag-ids. Volgorde van beslissen: [totaalproduct.md](../../product/totaalproduct.md). Soort werk: af (Zed consumeren), import (bestaande software, geen onderzoekstraject), volgt import, onderzoek, ontwerp op de harness.

| # | Soort | Spec |
|---|-------|------|
| 1 | af — host Zed | [ide-shell](../../product/ide-shell.md), [ADR 0002](../../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| 2 | af — host Zed | [fs-events](../../product/fs-events.md) (geen ADR) |
| 8 | af — host Zed | [agent-ui](../../product/agent-ui.md), [onderdeel-agent-ui](onderdeel-agent-ui.md) (geen ADR) |
| 5 | import — voorstel, nog geen ADR | [onderdeel-harness](onderdeel-harness.md) — DSH `acp`, geen fork |
| 4 | volgt import | [onderdeel-tools](onderdeel-tools.md) |
| 6 | volgt import | [onderdeel-llm](onderdeel-llm.md) — eigenaar DSH, niet Zed |
| 3 | onderzoek | [onderdeel-indexing](onderdeel-indexing.md) |
| 7 | ontwerp op harness | [onderdeel-structure](onderdeel-structure.md) |
| 9 | ontwerp op harness | [onderdeel-session-spine](onderdeel-session-spine.md) |

## Slices

1. **Kader** — totaalproduct.md + indexing.md + onderdeel-specs + BACKLOG/INDEX/PRODUCT.
2. **Herindeling** — groepen hierboven; segment + bloat in totaalproduct; Agent-UI af; LLM niet als Zed-laag; DSH als voorstel zonder ADR.
3. Verder per laag volgens de beslisvolgorde: ja op de harness-import, daarna indexing-contract (MCP), daarna structure en spine. Geen onderzoekstraject voor een laag die je importeert.

## Acceptatie

- [x] Negen onderdelen + uitleg FS/events; gemiste lagen structure/UI/spine benoemd
- [x] Indexing-doc bevat “waard om te bekijken”
- [x] Elke onderdeel-spec heeft open beslissingen (geen stille ADR)
- [x] Per onderdeel een `docs/product/*.md`; totaalproduct = samenhang
- [x] `make links` groen (na afronden)
