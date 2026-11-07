# Spec — onderdeel-structure

> **Rol:** Open keuzes voor standaard-afdwingen (docs + checks + hooks).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · vorm: [ideeen A6–A7](../../research/ideeen-en-vragen.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/structure.md](../../product/structure.md)
- **Hypothese:** Dual — dunne `AGENTS.md` + harde `make check`/hooks (A6); check-ladder (A7). Dit miste in je 1–6-lijst.

## Wat het is

Zorgt dat de agent (en jij) de **projectstandaard** volgt: RULES, seams, afronden, geen secrets. Cursor faalt hier vaak op “alleen prose”. Jouw voorsprong t.o.v. Cursor zit hier net zo goed als in indexing.

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
