# Session / spine

> **Rol:** Bijhouden waar het agent-gesprek leeft.
> **Niet hier:** samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** overgeslagen · **ADR:** [0005](../decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md) · **Spec weg** — besluit in ADR, vorm in product-doc

## Wat de gebruiker kan

- Het gesprek hervatten in het Zed Agent Panel, via de DeepSeek Harness-sessie van deze workspace.

## Besluit

Geen repo-spine. Geen `.agent/`, geen `ledger.jsonl` in de werkmap. Het gesprek is het paneel en de DSH-sessie. Wat een slice blijvend moet vastleggen, gaat via `make log`.

Een hernoemde of verplaatste map laat het gesprek bij het oude pad. Dat is hetzelfde als bij Cursor en Claude. Een koppeling die dat wél oplost, heropent [ADR 0005](../decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md).

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Repo-spine P1–P4 | overgeslagen | geen beter koppelmechanisme dan de pad-gebonden sessie |
| `make log` | blijft | duurzame notitie aan het eind van een slice |

## Raakvlakken

- Gesprek: [agent-ui.md](agent-ui.md), [harness.md](harness.md)
- Duurzaam: `docs/work/logs/`

## Bewust niet

- Een tweede geheugen naast de harness-sessie.
- Spine met secrets committen.
