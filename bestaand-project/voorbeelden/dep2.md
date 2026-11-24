# Voorbeeld — Data_Engineering_Project_2 (team)

> **Rol:** DEP2 uitgewerkt: wat goed is, wat beter kan, en de stappen over één sprint.
> **Niet hier:** het algemene stappenplan ([INDEX](../INDEX.md)), de beschrijving van het project zelf ([bron/stand-dep2](../../bron/stand-dep2.md)).

Team van vijf, sprints van twee weken. Kuilmaïsproef voor klant CADS (proefhoeve Bottelare): Python-ETL naar MSSQL (staging + DWH) en analyses voor drie cases. Gebaseerd op de momentopname in [stand-dep2](../../bron/stand-dep2.md); de repo zelf is niet bekeken. Controleer de bevindingen eerst in de echte repo, en bespreek het plan in een sprintmeeting voor je het uitvoert: het raakt iedereen.

## Kit

```bash
kit/new-project.sh DEP2 --team --no-git --dry-run --modules herordening,assignment,deliverables,claude
```

Geen stack: de structuur van `src/`, `sql/` en `scripts/` blijft. Neem alleen de `check-*`-targets uit [kit/stacks/python](../../kit/stacks/python/README.md) over als voorbeeld voor de `Makefile`.

## Wat al goed is (behouden)

| Wat | Waarom goed | Principe |
|-----|-------------|----------|
| Valkuilen expliciet: `ï` als `├п` op schijf, omzetting vóór de insert omdat padkolommen `VARCHAR` zijn | Precies wat een agent nergens anders vindt | P6 |
| Wat **niet** in `pipeline.sh` zit (case 3, schema `plantcount`, de oude case 1-lijn) | Grenzen benoemen voorkomt verkeerde aannames | P6 |
| Semantiek van de resets ("na een staging-reset ook de DWH resetten") | Destructieve acties uitgelegd | P17 |
| Welke DWH-kolommen leeg blijven | Voorkomt dat iemand ze "repareert" | P6 |
| `pipeline.sh` is idempotent (geslaagde stap overslaan, halve tabel leegmaken) | Uitgelegd in één alinea | P12 |
| `docs/` met CONTEXT en CASES | Begin van het skelet | [skelet](../../standaard/skelet.md) |
| Eén testbestand per module | Goede feedbackbasis | P13 |

## Wat beter kan

| # | Bevinding | Probleem | Principe |
|---|-----------|----------|----------|
| D1 | Er is geen `AGENTS.md`, terwijl vijf mensen elk een eigen tool gebruiken | Elke agent begint zonder commando's, grenzen of de waarschuwingen over resets | P2, P17 |
| D2 | `PROJECTSTRUCTUUR.md` somt elk configbestand, elk testbestand en elke module op | Afleidbaar; veroudert bij elke PR van vijf mensen | P5 |
| D3 | `configs/case1_improved.json`, `_v3`, `_v3_all`, `_v4`, `_v5` | Versies in bestandsnamen: welke is de geldende? | P16, §18 |
| D4 | Twee parallelle lijnen: het sterschema in `sql/` tegenover schema `plantcount` in `dronebeelden/`; en voor case 1 de pipeline via `rootscan_poc` tegenover een oudere dashboardlijn met een eigen SQLite | Context clash: een agent kan in de verkeerde lijn werken | P7, P9, §8 |
| D5 | Architectuurdocs verspreid: `case_wortelscans/README/db_architecture.md`, `poc/README.md`, `case_kurosens/README.md`, `docs/CASE2_DRONE.md` | Moeilijk te vinden; geen kaart | P2 |
| D6 | `case_wortelscans/README/last_changes.md` | Status in de repo, met vijf schrijvers | P8 |
| D7 | Geen check-commando; geen CI | Iedereen test anders | P13 |
| D8 | Mix van Nederlands en Engels in namen (`dronebeelden`, `case_wortelscans`, `plant_count`, `FactWortelmeting`, `object`, `plot`) zonder glossarium | Dezelfde zaak heeft meerdere namen | P10 |
| D9 | `reset_*.sh` droppen databases of wissen run-mappen | Een agent die "even reset" vernietigt uren rekenwerk | P14, P17 |
| D10 | `docs/vragen_klant.txt` | Status, geen waarheid | P8 |

## Stappen (verdeeld over één sprint)

### Stap D-1 — Afspraken in de sprintmeeting (15 min)

- Akkoord over: `AGENTS.md` als gemeenschappelijke basis, docs bijwerken hoort bij de Definition of Done, status alleen in de tracker, één docs steward per sprint ([team](../../nieuw-project/team.md)).
- Beslis D3 en D4 samen: welke config en welke lijn zijn canoniek? Dat worden ADR 0001 en 0002 (stap D-4).
- Verslag: `make meeting met=team`.

### Stap D-2 — `make check` en CI (D7)

Kit-`Makefile` als basis, met de checks in een eigen `CHECK`-target op root (er is geen `apps/`):

```make
CHECK += check-py check-js

check-py: ## python: ruff en pytest, zonder database
	uv run ruff check src tests
	uv run pytest -q -m "not db"

check-js: ## row editor: node-tests
	node --test tests/test_row_editor.js

CHECK_FULL += check-db
check-db: ## tests die MSSQL nodig hebben
	uv run pytest -q -m db
```

`.github/workflows/check.yml` uit de team-laag draait `make check` op elke PR. Tests die MSSQL nodig hebben krijgen de marker `@pytest.mark.db`.

### Stap D-3 — `AGENTS.md` (D1, D9)

Uit de kit, ingevuld:

````markdown
# DEP2 groep 3 — agent-instructies

Kuilmaïsproef voor klant CADS (proefhoeve Bottelare): ETL naar MSSQL (staging + DWH) en analyses voor drie cases. Voor mensen: [README.md](README.md).

## Nooit

- `scripts/reset_*.sh` niet draaien zonder expliciete vraag. Ze droppen een database of wissen run-mappen; opnieuw meten duurt lang.
- Niets uit `data/` of `artifacts/` committen (uitzondering: `data/processed/demo/`).
- `.env` niet lezen of tonen; nieuwe variabelen naar `.env.example`.
- Niet schrijven naar `dwh_db` buiten `src/etl/`.

## Commando's

| Doel | Commando |
|------|----------|
| Alles controleren | `make check` |
| Volledige pipeline | `make data` (roept `scripts/pipeline.sh` aan; slaat geslaagde stappen over) |
| Status databases | `uv run python -m etl.pipeline_status` |
| Dependencies | `uv add <pakket>` — nooit pip |

## Werken

- Kaart: [docs/INDEX.md](docs/INDEX.md). Sterschema en ETL: `docs/architecture/`.
- Paden met `maïs` staan op schijf soms als `├п`; loaders zetten om naar `ï` vóór de insert (VARCHAR-kolommen).
- Canonieke lijnen: ADR 0001 (configs) en 0002 (pipeline tegenover schema plantcount). Werk niet in `legacy/` tenzij gevraagd.
- Termen: [GLOSSARY.md](docs/context/GLOSSARY.md).

## Afronden

1. `make check` groen. 2. Geraakte docs bijgewerkt. 3. Keuze → ADR via PR. 4. Samenvatting in de PR.
````

Plus `CLAUDE.md` → `AGENTS.md` (module `claude`) voor wie Claude Code gebruikt.

### Stap D-4 — Afleiders en parallelle lijnen (D3, D4)

- ADR 0001: welke `case1_*.json` canoniek is. De andere weg (git bewaart ze). Meet een script nog oude varianten, dan wordt de variant een veld in de config in plaats van een bestandsnaam.
- ADR 0002: de pipeline (`sql/` + `src/etl/`) is de bron van waarheid. `dronebeelden/` + `*_db.py` en de SQLite-dashboardlijn worden **legacy**: naar `legacy/` met een `legacy/AGENTS.md` van twee regels ("niet uitbreiden; alleen lezen voor vergelijking"), of weg als niemand ze nog gebruikt.

### Stap D-5 — Docs naar het skelet (D2, D5, D6, D8, D10)

#### Doelstructuur docs

```
docs/
├── INDEX.md                         # was docs/README.md (leesvolgorde → kaart)
├── context/
│   ├── CONTEXT.md                   # bestaat
│   ├── CASES.md                     # bestaat (case 1, 2, 3)
│   ├── GLOSSARY.md                  # NIEUW — object, plot, ras, FAO, observatie, vlucht, orthomosaic, …
│   └── assignment.md                # NIEUW — opdracht, criteria, deadlines van het vak
├── architecture/
│   ├── ARCHITECTURE.md              # NIEUW — uit PROJECTSTRUCTUUR: lagen, pipeline-stappen, wat in git
│   ├── database.md                  # was case_wortelscans/README/db_architecture.md
│   ├── case1-wortelscans.md         # uit poc/README.md + info_data.md
│   ├── case2-drone.md               # was docs/CASE2_DRONE.md
│   └── case3-kurosens.md            # uit case_kurosens/README.md
├── how-to/
│   ├── pipeline-draaien.md          # de pipeline-sectie uit PROJECTSTRUCTUUR
│   └── databases-resetten.md        # reset-semantiek
├── decisions/
│   ├── _template.md
│   ├── 0001-canonieke-configs.md
│   └── 0002-pipeline-is-bron-van-waarheid.md
├── work/meetings/                   # verslagen met klant en coach
└── deliverables/                    # ingediende verslagen en presentaties
```

- `PROJECTSTRUCTUUR.md`: de waardevolle stukken (lagen, pipeline, valkuilen, lege kolommen, wat niet in de pipeline zit) naar `ARCHITECTURE.md` en `how-to/`. De lijsten van configs, tests en modules schrappen. **De beschrijving van één regel per module wordt de docstring** bovenaan elk `.py`-bestand.
- `last_changes.md` en `vragen_klant.txt` → issues in de tracker, dan weg.
- `example_script_rootfinder.py` (oud voorbeeld van de klant) → `legacy/` of `docs/archive/`.
- Data naar de vaste lagen ([data](../../standaard/data.md)): `data/derived/plots_uitgelijnd/` → `data/processed/demo/` als hij klein en anoniem is.

### Stap D-6 — PR-template en steward (team)

- `.github/pull_request_template.md` en de issue-templates uit de team-laag.
- De docs steward van de sprint doet het [onderhoud](../../nieuw-project/6-onderhoud.md) in de laatste week.

### Stap D-7 — Meten

- Dezelfde DEP2-taken vóór D-2 (C1) en na D-5 (C2), [meten](../../meten/INDEX.md).
- Een teamproject met sprints is een interessante tweede case naast een soloproject ([bachelorproef](../../meten/bachelorproef.md)). Vraag het team en de begeleider of je de meting mag gebruiken.
