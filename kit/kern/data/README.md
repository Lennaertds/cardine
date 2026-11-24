# Data

> **Rol:** Welke dataset waar staat, waar hij vandaan komt, en of hij in git mag.
> **Niet hier:** hoe de pipeline werkt (`docs/architecture/`), wat een veld betekent (`docs/context/GLOSSARY.md`).

| Laag | Wat | In git | Wie schrijft |
|------|-----|--------|--------------|
| `raw/<bron>/YYYY-MM-DD/` | Onbewerkte exports en downloads | nooit | jij, één keer; daarna niemand |
| `external/<bron>/` | Van derden, met eigen licentie | nooit, alleen README.md | download |
| `external/digest/` | Ruwe inbound feeds (module `research`) | nooit, alleen README/`.gitkeep` | `make digest-fetch` |
| `interim/<stap>/` | Tussenresultaten van de pipeline | nooit | pipeline; mag altijd weg |
| `processed/<dataset>/` | Wat apps en rapporten lezen | alleen `demo/` | `make data` |
| `reference/<dataset>/` | Met de hand samengesteld: catalogi, mappings, seeds | ja | jij, via review |

## Datasets

| Pad | Herkomst | Licentie | Persoonsgegevens | Opnieuw maken |
|-----|----------|----------|------------------|---------------|
| <`raw/hevy/2026-10-01/`> | <export uit de Hevy-app> | <eigen data> | <ja: trainingen> | <opnieuw exporteren> |
