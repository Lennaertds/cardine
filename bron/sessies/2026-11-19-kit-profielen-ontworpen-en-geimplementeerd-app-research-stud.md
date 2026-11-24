# Sessie: Kit-profielen ontworpen en geïmplementeerd

**Datum:** 2026-11-19 09:50

## Wat gedaan

- **Idee uit chat:** geen één universele kit, maar profielen per projectsoort
- **4 profielen gemaakt:**
  - `app` — applicatie bouwen (GymFreak, Caddie): 11 modules, kiest stacks
  - `research` — onderzoek met software (Agent Engineering, Cardine): 5 modules + python
  - `studie` — studieplanning: assignment + werk/kalender.md, deadlines.md, studielog.md
  - `schoolwerk` — oefeningen DL/DB/Python/algo: assignment, compose, python + containers/
- **Drieplaats-regel gevolgd:**
  - `standaard/profielen.md` — definitie en uitleg
  - `kit/profiles/` — `.profile`-bestanden + `extra/<naam>/` met extra bestanden
  - `sjablonen/profielen.md` — gids voor aanmaken van nieuwe profielen
- **`new-project.sh`** uitgebreid met `--profile` vlag die `.profile` inleest, variabelen zet en extra bestanden kopieert
- **Extra bestanden via `local.mk`** (niet via aparte Makefile, want kern-Makefile include al `local.mk`)
- **`kit/README.md`** geüpdatet met profielentabel
- **`standaard/INDEX.md`** geüpdatet met link naar profielen.md
- **`sjablonen/INDEX.md`** geüpdatet met profiel-gids
- **`make check` groen** — links + test-kit

## Hoe het werkt

```bash
# App project
make new DIR=~/code/gymfreak ARGS="--profile app --stacks next,python"

# Research project
make new DIR=~/code/agent-engineering ARGS="--profile research"

# Studieplanning
make new DIR=~/code/studie-2025 ARGS="--profile studie"

# Schoolwerk oefeningen
make new DIR=~/code/dl-oefeningen ARGS="--profile schoolwerk"
```

## Open punten

- Token-logger voor DeepSeekHarness nog niet onderzocht (was prioriteit 🔴)
- Structuur 4-pijlers (§9) nog niet in de kit gegoten
- Check of DeepInfra multimodale modellen ondersteunt

## Volgende stap

Kiezen:
1. 🔴 Token-logger onderzoeken voor DeepSeekHarness
2. 🟡 4-pijlers structuur in kit gieten
3. Iets anders

---

