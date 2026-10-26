# Spec — bootstrap-geen-stack-tot-adr

> **Rol:** Plan voor één werkitem. Tijdelijk: na merge verwijderen; de code en de tests zijn dan de waarheid.

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Doel

BOOTSTRAP-stap 2 blijft afgerond; geen stap 3 / `--starter` / stack tot expliciete Pi/TS-keuze + ADR (0001).

## Scope

- **In:** Bewaken dat agents geen generators/stack toevoegen; kit-delta’s (docs/AGENTS) blijven ok.
- **Buiten scope:** Runtime-keuze zelf (apart Straks/ADR); apps bouwen.

## Raakvlakken

- Modules en bestanden: `AGENTS.md`, `docs/decisions/0001-…`, `README.md`
- Seams die raken: geen
- Voorbeeld om te volgen: ADR 0001

## Slices (elk apart testbaar, één sessie)

1. Bij elke bootstrap/kit-delta: bevestig geen stack; verwijs naar deze spec + ADR 0001.
2. Na runtime-ADR: dit item afvinken en stap 3 openen.

## Acceptatie

- [ ] Geen `apps/<stack>` zonder ADR
- [ ] `make links` groen
