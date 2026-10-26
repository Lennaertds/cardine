# Spec — onderzoek-a2-harnesses

> **Rol:** Plan voor één werkitem. Tijdelijk: na merge verwijderen; de code en de tests zijn dan de waarheid.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `docs/onderzoek-a2-harnesses`
- **Status:** gedaan (2026-10-26)

## Doel

A1 (§69) is gedaan; A2 levert vergelijkbare feiten over andere harnesses (Pi, DeepSeek Harness, peers) in Agent_Engineering `bron/` (§ + index), zodat A5/B later op bronnen rusten i.p.v. chat.

## Scope

- **In:** A2 volgens [onderzoek-programma](../../research/onderzoek-programma.md); feiten in AE `bron/bronnen.md` (+ index); wantlist hier bijwerken.
- **Buiten scope:** stack/ADR/runtime-keuze; A3/A4/A5 tot A2 genoeg assen heeft; kit-edits in AE zonder brug + ja.

## Raakvlakken

- Modules en bestanden: `docs/research/onderzoek-programma.md`, `docs/research/wantlist.md`, sibling AE `bron/`
- Interface die verandert: geen code
- Seams die raken: geen (onderzoek)
- Voorbeeld om te volgen: A1 / §69-route in AE

## Slices (elk apart testbaar, één sessie)

1. Pi-harness: “wat meeneem voor lab” aanscherpen (§33 + nieuwe feiten indien nodig).
2. DeepSeek Harness (≠ model-§) + 1–2 peers: kernfeiten als § in AE.
3. Wantlist/onderzoek-programma bijwerken; BACKLOG-status.

## Acceptatie

- [x] Nieuwe §76–§79 in AE `bron/` + index (+ §33 cross-ref)
- [x] Geen stack/ADR “op gevoel”
- [x] `make links` groen in dit project
