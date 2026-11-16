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
| 5 | import — beslist | [onderdeel-harness](onderdeel-harness.md) — DSH `acp`, geen fork ([ADR 0003](../../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)) |
| 4 | volgt import · beslist | [onderdeel-tools](onderdeel-tools.md) — [ADR 0007](../../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| 6 | volgt import · beslist | [onderdeel-llm](onderdeel-llm.md) — `deepseek-flash`, Claude ([ADR 0008](../../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md)) |
| 3 | beslist, agent-pad | [onderdeel-indexing](onderdeel-indexing.md) — jarvis MCP ([ADR 0006](../../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md)) |
| 7 | ontwerp op harness | [onderdeel-structure](onderdeel-structure.md) |
| 9 | overgeslagen | [onderdeel-session-spine](onderdeel-session-spine.md) — geen repo-spine ([ADR 0005](../../decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md)) |

## Slices

1. **Kader** — totaalproduct.md + indexing.md + onderdeel-specs + BACKLOG/INDEX/PRODUCT.
2. **Herindeling** — groepen hierboven; segment + bloat in totaalproduct; Agent-UI af; LLM niet als Zed-laag; DSH als voorstel zonder ADR.
3. Verder per laag volgens de beslisvolgorde: ja op de harness-import, daarna indexing-contract (MCP), daarna structure. Spine is overgeslagen. Geen onderzoekstraject voor een laag die je importeert.

## Acceptatie

- [x] Negen onderdelen + uitleg FS/events; gemiste lagen structure/UI/spine benoemd
- [x] Indexing-doc bevat “waard om te bekijken”
- [x] Elke onderdeel-spec heeft open beslissingen (geen stille ADR)
- [x] Per onderdeel een `docs/product/*.md`; totaalproduct = samenhang
- [x] `make links` groen (na afronden)
