# Spec — onderdeel-session-spine

> **Rol:** Open keuzes voor session-state die workspace-wissel overleeft.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · vorm: [ideeen A9](../../research/ideeen-en-vragen.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/session-spine.md](../../product/session-spine.md)
- **Hypothese:** C′ — spine in `<cwd>/.agent/` (gitignore) + korte `status.md`; chat mag leeg na padwissel. Dit miste in je 1–6-lijst; Cursor-pijn §132.

## Wat het is

Waar “wat probeerden we / wat werkte” leeft als de IDE-chat of cwd wisselt. Harness-sessions (Pi/DSH) blijven bestaan; lab vertrouwt ze niet als enige SoR over workspace-grenzen.

## Stappenplan

Start naast of direct na structure. Eén stap per sessie. Uitkomst in [session-spine.md](../../product/session-spine.md). Deze stappen maken nog geen `.agent/` in een repo aan.

### Stap A — Conventie

1. P1: de spine staat in `<cwd>/.agent/` en dat pad staat in `.gitignore`.
2. P2: `status.md` is voor de mens, `ledger.jsonl` voor het verloop. Geen van beide bevat secrets.
3. P3: een harness session-id mag als verwijzing mee. Over een padwissel blijft de spine de bron.
4. P4: promoten naar `make log` blijft handmatig, aan het eind van een slice, in dezelfde afronding als nu.

### Stap B — Vastleggen

Schrijf de conventie in de productdoc. Wordt het pad een regel in RULES, dan vraagt die stap een ADR. De papier-test: na een cwd-wissel wijst de spine nog naar het pad waar het werk gebeurde.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| P1 | Pad `.agent/` vs `.planning/`? | A9-voorstel `.agent/` | conventie |
| P2 | Wat in JSONL vs status.md? | A8 dual | formaat |
| P3 | Sync met harness session-id? | optioneel complement | H1 |
| P4 | Promoten naar `make log` wanneer? | handmatig / einde slice | ritueel |

## Acceptatie (later)

- [ ] P1–P2 ADR of conventie in RULES/AGENTS
- [ ] Padwissel-test: spine blijft bruikbaar
