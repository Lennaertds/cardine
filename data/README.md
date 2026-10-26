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

Nog geen lab-datasets. Geen data uit andere projecten. Index-caches en experimentoutput komen hier onder de juiste laag zodra de harness bestaat — met herkomst/licentie in deze tabel.
