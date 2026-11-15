# Spec — onderdeel-structure

> **Rol:** Open keuzes voor standaard-afdwingen (docs + checks + hooks).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · vorm: [ideeen A6–A7](../../research/ideeen-en-vragen.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/structure.md](../../product/structure.md)
- **Hypothese:** Dual — dunne `AGENTS.md` + harde `make check`/hooks (A6); check-ladder (A7). Dit miste in je 1–6-lijst.

## Wat het is

Zorgt dat de agent (en jij) de **projectstandaard** volgt: RULES, seams, afronden, geen secrets. Cursor faalt hier vaak op “alleen prose”. Jouw voorsprong t.o.v. Cursor zit hier net zo goed als in indexing.

## Stappenplan

Start als de harness-kandidaat bekend is, zodat de haken een plek hebben. Eén stap per sessie. Uitkomst in [structure.md](../../product/structure.md). Vorm blijft [A6–A7](../../research/ideeen-en-vragen.md). Geen hook-code in deze stappen.

### Stap A — Dual en de ladder als zin

1. S1: bevestig dual. `AGENTS.md` blijft de kaart. Harde grenzen blijven in `make check` en [RULES.md](../../rules/RULES.md).
2. S2: teken twee haken op de gekozen harness. Vóór een schrijf-tool geldt de pad-allowlist uit tools. Aan het eind van een slice draait `make check`.
3. S3: schrijven blijft binnen die workspace-allowlist.
4. S4: always-on is `AGENTS.md`, `RULES.md` en de productdoc van het onderdeel waar de slice over gaat. De rest wordt gelezen wanneer de slice ze raakt.

### Stap B — ADR

Vraag ja op S1. In de productdoc staat daarna: een rode `make check` sluit de slice niet.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| S1 | A6 dual → ADR? | ja wanneer harness bestaat | enforcement |
| S2 | PreToolUse / Stop-hooks op `make check`? | harness-afhankelijk | H1 |
| S3 | Pad-allowlist write? | streng lab / ruimer | tools |
| S4 | Welke docs always-on vs JIT? | A8-vorm | tokens |

## Acceptatie (later)

- [ ] S1 ADR
- [ ] Rood check = niet “klaar” (A7) meetbaar in loop
