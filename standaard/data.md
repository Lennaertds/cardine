# Data: vaste lagen

> **Rol:** Welke data in welke laag van `data/` hoort, wie ze schrijft, en wat in git mag.
> **Niet hier:** het `.gitignore`-blok ([git](git.md)), de catalogus per project ([sjabloon data-readme](../sjablonen/data-readme.md)).

| Laag | Wat | In git | Wie schrijft |
|------|-----|--------|--------------|
| `raw/<bron>/YYYY-MM-DD/` | Onbewerkte exports en downloads die jij of een gebruiker aanlevert | Nooit | Jij, één keer; daarna niemand |
| `external/<bron>/` | Data van derden met een eigen licentie: papers, open datasets | Nooit; alleen `README.md` met herkomst en licentie | Download |
| `interim/<stap>/` | Tussenresultaten: uitgepakte tekst, zoekindexen, opgekuiste tabellen | Nooit | Pipeline; mag altijd weg |
| `processed/<dataset>/` | Eindresultaat dat apps en rapporten lezen | Alleen `processed/demo/`: klein en anoniem | `make data` |
| `reference/<dataset>/` | Met de hand samengesteld: catalogi, mappings, regels als data, seeds | Ja, gereviewd als code | Jij, met de hand |
| `runtime/` | Wat de app tijdens het draaien schrijft: uploads, bestanden per gebruiker | Nooit | De app |
| `models/<model>/` | Getrainde modellen met `meta.json` | Nooit; liefst in een registry | De train-stap |

**Regels:**

- **Eén richting:** `raw/`, `external/` en `reference/` → `interim/` → `processed/`. Code schrijft nooit naar `raw/` of `reference/`.
- **Apps lezen alleen** `processed/`, `reference/` en `runtime/`, nooit `raw/`.
- **Elk pad komt uit één config per app**: een env-variabele met een default (zoals `USER_DATA_DIR` → `data/runtime/user/`). Geen paden verspreid door de code.
- **Reproduceerbaar:** maak je `processed/` leeg en draai je `make data`, dan krijg je hetzelfde resultaat.
- **Groot of binair** (boven ±1 MB, of vaak wijzigend): niet in gewone git. Moet het toch in git, gebruik dan Git LFS. Echte datasets horen in DVC of object storage.
- **Persoonsgegevens** staan alleen in `raw/`, `runtime/` en de database. Demo-data is geaggregeerd of verzonnen.
- **Geen testdata en geen afbeeldingen in `data/`.** Testdata hoort in `tests/fixtures/`, afbeeldingen voor docs in `docs/assets/`.
- **Een map per bron of dataset**, in kleine letters (`raw/apple-health/`, `reference/exercises/`), met een eigen `README.md` zodra de map meer dan één bestand bevat.

---
