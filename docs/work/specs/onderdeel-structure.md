# Spec — onderdeel-structure

> **Rol:** Open keuzes voor standaard-afdwingen (docs + checks + hooks).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · vorm: [ideeen A6–A7](../../research/ideeen-en-vragen.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** beslist — [ADR 0004](../../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md). Hook-code pas met een applicatie.
- **Product (bijhouden):** [../../product/structure.md](../../product/structure.md)
- **Hypothese:** Dual — dunne `AGENTS.md` + harde `make check`/hooks (A6); check-ladder (A7). Dit miste in je 1–6-lijst.

## Wat het is

Zorgt dat de agent (en jij) de **projectstandaard** volgt: RULES, seams, afronden, geen secrets. Cursor faalt hier vaak op “alleen prose”. Jouw voorsprong t.o.v. Cursor zit hier net zo goed als in indexing.

## Stappenplan

Start als de harness-kandidaat bekend is, zodat de haken een plek hebben. Eén stap per sessie. Uitkomst in [structure.md](../../product/structure.md). Vorm blijft [A6–A7](../../research/ideeen-en-vragen.md). Geen hook-code in deze stappen.

### Stap A — Dual en de ladder als zin (gedaan)

1. S1: bevestig dual. `AGENTS.md` blijft de kaart. Harde grenzen blijven in `make check` en [RULES.md](../../rules/RULES.md).
2. S2: teken twee haken op de gekozen harness. Vóór een schrijf-tool geldt de pad-allowlist uit tools. Aan het eind van een slice draait `make check`.
3. S3: schrijven blijft binnen die workspace-allowlist.
4. S4: always-on is `AGENTS.md`, `RULES.md` en de productdoc van het onderdeel waar de slice over gaat. De rest wordt gelezen wanneer de slice ze raakt.

### Stap B — ADR (gedaan)

Ja op S1: [ADR 0004](../../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md). Een rode `make check` sluit de slice niet.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| S1 | A6 dual → ADR? | beslist — [0004](../../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) | — |
| S2 | Haken op DSH? | uitgewerkt — `tools/pre-execute` + `make check` aan slice-einde | — |
| S3 | Pad-allowlist write? | beslist — workspace-allowlist, [0007](../../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) | — |
| S4 | Welke docs always-on vs JIT? | uitgewerkt — AGENTS, RULES, productdoc van de slice | — |

## Acceptatie (later)

- [x] S1 ADR — [0004](../../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md)
- [ ] Rood check = niet “klaar” (A7) meetbaar in de loop, pas met een applicatie
