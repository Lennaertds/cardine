# Spec — tokenlogger

> **Rol:** Plan voor één werkitem. Tijdelijk: na merge verwijderen; de code en de tests zijn dan de waarheid.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/tokenlogger`
- **Status:** open

## Doel

Per turn en per sessie bijhouden hoeveel tokens (input + output) de LLM-aanroepen kosten, zodat het lab inzicht krijgt in verbruik, efficiëntie en de H×M-metingen kan voeden.

## Scope

- **In:**
  - Tokenlogger als harness-module die bij elke LLM-aanroep input/output-tokens logt.
  - Logformaat: per-aanroep met timestamp, model, input_tokens, output_tokens, cost (berekend uit model-pricing).
  - Sessie-niveau aggregatie (totalen per Zed/DSH-sessie).
  - Exporteerbaar naar JSONL of CSV voor analyse.
  - Config van model-pricing per provider in `.env` of harness-config.
- **Buiten scope:**
  - Geen UI/dashboard voor tokenverbruik (pure logging).
  - Geen real-time waarschuwingen bij budget-overschrijding.
  - Geen integratie met OTel of observability-stack (tenzij later expliciet besloten).

## Raakvlakken

- Modules en bestanden: `packages/lab/` (waar de harness draait), `docs/product/harness.md`, `docs/product/llm.md`
- Interface die verandert: DSH/tool-loop krijgt token-tracking hook
- Seams die raken: harness → LLM-provider (DeepSeek, Claude, …)
- Voorbeeld om te volgen: bestaande `docs/product/indexing.md` voor de research/keuze-opzet

## Slices (elk apart testbaar, één sessie, door de hele stack)

1. **Minst viable:** Token-teller bij LLM response parsing — log input/output tokens naar een JSONL-bestand in `data/runtime/`.
2. **Sessie-aggregatie:** Haspel per DSH-sessie (start/stop), met totalen per sessie in een apart logbestand.
3. **Pricing-config:** Model-pricing uit `.env` of config-file halen, cost-per-call en cumulatief berekenen.

## Acceptatie

- [ ] Na een turn met een echte LLM-aanroep staat er een token-log in `data/runtime/tokens/` met correcte input/output aantallen
- [ ] meerdere sessies geven aparte logs (geen cross-sessie vervuiling)
- [ ] `make check` groen
- [ ] Productregels / RULES blijven gelden (geen secrets in logs, geen data uit andere projecten)