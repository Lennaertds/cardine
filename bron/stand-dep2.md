# Projectstructuur

Drie lagen. `data/` is de ruwe input en staat niet in git. `artifacts/` is lokale uitvoer van analyses en het dashboard, ook niet in git. `staging_db` en `dwh_db` staan op de MSSQL-container. Het sterschema staat in `case_wortelscans/README/db_architecture.md`.

Foto's, orthomosaics en run-mappen staan hier als map. Elk bronbestand staat apart.

## Root

```
.
├── .env                 # wachtwoord en host, niet in git
├── .env.example         # kopieer naar .env en vul MSSQL_SA_PASSWORD in
├── .gitignore
├── .python-version
├── docker-compose.yml   # container dep2-mssql
├── pyproject.toml       # dependencies, uv
├── uv.lock
└── README.md            # uv installeren, data in data/ zetten
```

## data/

Niet in git, behalve `derived/plots_uitgelijnd/`.

```
data/
├── M2609 Bemestingsproef LCV.xlsx          # object, ras, FAO, N, plotnummers
├── wortelscans/
│   ├── 1e observatie - 19-06-2026/         # png per plot en diepte
│   └── 2e observatie - 09-07-2026/
├── Dronebeelden/PerceelKloosterstraat/     # orthomosaics *.tif (RGB, HR, NIR)
├── RuweDroneFotos/                         # één bronmap per vlucht
├── Kurosens/                               # hyperspectrale cubes, case 3
└── derived/plots_uitgelijnd/               # plotgrenzen, wél in git
    └── handmatig/                          # met de hand uitgelijnd, krijgt voorrang
```

De vluchtmappen en TIF-namen bevatten `maïs`. Op deze schijf staat die letter soms als `├п`. De loaders zetten dat om naar `ï` vóór de insert, omdat de padkolommen `VARCHAR` zijn.

## artifacts/

Niet in git. `artifacts/runs/` is één map per analyse-run. De drone-pipeline leest daaruit. Case 1 schrijft er ook baselines, annotaties en notities.

## docs/

```
docs/
├── README.md            # leesvolgorde
├── CONTEXT.md           # kuilmaïs, klant CADS, proefhoeve Bottelare
├── CASES.md             # case 1 wortel, case 2 drone, case 3 Kurosens
├── CASE2_DRONE.md       # groenbedekking, plantentelling, uitlijnen
├── PROJECTSTRUCTUUR.md  # dit bestand
└── vragen_klant.txt
```

## configs/

```
configs/
├── case1_inventory.json
├── case1_pilot.json
├── case1_baseline.json
├── case1_improved.json
├── case1_improved_v3.json
├── case1_improved_v3_all.json
├── case1_improved_v4.json
├── case1_improved_v5.json
├── case1_reference.json
├── case1_scoring.json
├── case2_droneviews.json
├── case2_plantcount.json
├── case2_plantcount_steps.json
├── case2_plantcount_accepted.json
├── case2_green_cover.json
└── case2_green_cover_season.json
```

## sql/ en dronebeelden/

`sql/` is het sterschema. `dronebeelden/` is een apart schema `plantcount` voor de groepsscripts. Dat schema zit niet in `pipeline.sh`.

```
sql/
├── staging_db.sql
├── dwh_db.sql
├── staging_dbdiagram.txt
└── dwh_dbdiagram.txt
dronebeelden/
├── sql_plantcount.sql
└── sql_green_cover.sql
```

## scripts/

```
scripts/
├── init_staging.sh                 # container + lege staging_db, dropt niets
├── init_dwh.sh                     # container + lege dwh_db, dropt niets
├── reset_staging.sh                # dropt staging_db en zet het schema terug
├── reset_dwh.sh                    # dropt dwh_db en zet het schema terug
├── reset_plant_count.sh            # plantcount1- en plantcount2-runs weg, feiten leeg
├── reset_plant_count_steps.sh      # alleen plantcount2-runs weg, feiten leeg
├── reset_green_cover_season.sh     # seizoen én losse vluchtmetingen weg, feiten leeg
└── pipeline.sh
```

## src/etl/

Dit is de pipeline naar MSSQL.

```
src/etl/
├── __init__.py
├── db.py                          # verbinding, leest .env in de root
├── pipeline_status.py             # klaar / leeg / half / mislukt, en leeg <stap>
├── load_staging_wortel.py         # object, plot, datum, wortel_foto
├── load_staging_drone.py          # datum verder, drone_vlucht, drone_tif
├── load_dwh_basics.py             # dimensies, zelfde sleutels als staging
├── load_dwh_wortel_resultaten.py  # meet de foto's via rootscan_poc en vult FactWortelmeting
├── load_dwh_drone_resultaten.py   # nieuwste runs naar FactPlotObservatie
└── test_db.py                     # eerste rijen van elke tabel; argument is de databasenaam
```

## src/dep2_project_group_3/

Analyses en het dashboard. Alleen de vier meet-scripts hieronder draaien in `pipeline.sh`: `plant_count.py`, `plant_count_steps.py`, `green_cover.py` (via het seizoen) en `green_cover_season.py`. De rest is dashboard, case 1 of een zijspoor naar schema `plantcount`.

### Case 2, meting

```
plant_count.py            # stap 1: uitsneden per plot uit de HR-tif van 18 mei
plant_count_steps.py      # stap 2 tot 5: telling en planten per ha
green_cover.py            # bodembedekking van één vlucht, gewone RGB-tif
green_cover_season.py     # vijf vluchten; hergebruikt een afgewerkte vlucht
plot_geometry.py          # welke plotgrenzen bij welk dronebeeld horen
plot_mesh.py              # gedeelde hoekpunten van het plotgrid
drone_views.py            # kleine JPEG's plus plotomtrek; vergelijkbare_naam voor de ï
image_viewer.py           # fullscreen foto in het dashboard
row_alignment.py          # een raster overzetten tussen twee strookranden
row_editor.py             # editor voor die strookranden
alignment_ui.py           # plotgrid vervormen via de hoeken
alignment_editor.py       # het scherm van die editor, coördinaten in EPSG:32631
fingerprint.py            # vingerafdruk van een beeld en lokale registratie
fingerprint_editor.py     # kandidaten naast handmatige grondpunten
```

### Case 2, database en pagina's buiten de pipeline

```
plant_count_db.py         # geaccepteerde telling naar schema plantcount
green_cover_db.py         # groenbedekking naar schema plantcount
green_cover_ui.py         # pagina met de methode en de cijfers
green_cover_season_ui.py  # curve over de vijf datums
cases.py                  # pagina's /case2, /case3 en de uitleg van de telling
```

`plant_count_db.py` en `green_cover_db.py` gebruiken `dronebeelden/sql_*.sql` en `artifacts/database/plantcount.env`. Ze schrijven niet naar `dwh_db`.

### Case 1, wortelscans buiten de pipeline

De pipeline meet de foto's via `case_wortelscans/poc/rootscan_poc.py`. Onderstaande scripts zijn de eerdere dashboard-lijn: baseline, verbeteringen, handmatige maskers en een eigen SQLite. Die SQLite is niet `dwh_db`.

```
inventory.py              # controle van de aangeleverde foto's, geen meting
pilot.py                  # kleine ontwikkelset vastleggen
baseline.py               # de aangeleverde batch-methode, nog niet gevalideerd
improved.py               # experiment v2, vergeleken met de baseline
reference.py              # vaste uitsneden die iemand met de hand annoteert
annotations.py            # handgetekende wortelmaskers in artifacts/annotations
scoring.py                # algoritme tegen die maskers
results_db.py             # afgewerkte runs naar een lokale SQLite
results_ui.py             # het dashboard op http://127.0.0.1:8792/
dashboard.py              # de case 1-startpagina binnen dat dashboard
dashboard_shell.py        # zijbalk en dezelfde opmaak op elke pagina
project_ui.py             # proefveld als raster van plots
notes.py                  # notities op het dashboard, artifacts/notes/notities.jsonl
logbook.py                # één HTML-pagina uit docs/ en artifacts/
```

## case_wortelscans/

```
case_wortelscans/
├── poc/
│   ├── rootscan_poc.py                  # segmentatie: lengte, oppervlakte, tips, bedekking
│   ├── test_resolutie_stabiliteit.py    # 850 px tegen een hogere resolutie
│   └── README.md                        # wat de POC doet en wat hij nog niet bewijst
└── README/
    ├── db_architecture.md               # staging en DWH zoals ze nu zijn
    ├── info_data.md                     # hoe de wortelfoto's genoemd zijn
    ├── last_changes.md                  # laatste wijzigingen aan de segmentatie
    └── example_script_rootfinder.py     # het oude voorbeeld van de klant, niet in de pipeline
```

`rootscan_poc.py` schrijft zelf nog een CSV en overlays als je het los draait. `load_dwh_wortel_resultaten` doet dat niet: die roept de meetfuncties aan en schrijft `FactWortelmeting`.

## case_kurosens/

Case 3. Niet in `pipeline.sh` en niet in de DWH. De cubes liggen onder `data/Kurosens/`. Een `.bil` hoort bij zijn `.bil.hdr`.

```
case_kurosens/
├── README.md
├── inspect_hsi.py          # quicklook van een cube; optioneel ruwe bandstatistieken
├── manual_aoi.py           # cirkel tekenen, Enter bewaart
└── manual-aoi/
    ├── ..._manual_aoi.png  # overlay van de cirkel
    ├── ..._manual_aoi_mask.npy
    └── ..._manual_aoi.txt  # middelpunt en straal in pixels
```

`inspect_hsi.py` zoekt standaard de potrand en legt de AOI 12 pixels naar binnen. `--calculate-stats` schrijft een CSV met ruwe digitale waarden, zonder zwart-witcorrectie. `manual_aoi.py` opent een venster: slepen vanuit het middelpunt, Enter of S bewaart in `manual-aoi/`. De pagina `/case3` van het dashboard zit in `cases.py` en toont alleen wat er al is.

## tests/

Eén testbestand per module. `test_row_editor.js` hoort bij `row_editor.py`.

```
tests/
├── test_baseline.py
├── test_cases.py
├── test_dashboard.py
├── test_fingerprint.py
├── test_green_cover.py
├── test_green_cover_season.py
├── test_image_viewer.py
├── test_improved.py
├── test_inventory.py
├── test_logbook.py
├── test_notes.py
├── test_pilot.py
├── test_plant_count.py
├── test_plant_count_db.py
├── test_plant_count_steps.py
├── test_plot_geometry.py
├── test_plot_mesh.py
├── test_reference.py
├── test_results_db.py
├── test_results_ui.py
├── test_row_alignment.py
├── test_row_editor.js
└── test_scoring.py
```

## Pipeline

Vanuit de root:

```bash
bash scripts/pipeline.sh
```

Het script zoekt zelf de root. Python gaat via `uv run python -m` met `src` op `PYTHONPATH`. Een geslaagde stap wordt overgeslagen. Een half gevulde tabel wordt alleen voor die stap leeggemaakt. Een mislukte analyse-run wordt opnieuw gedaan.

1. `init_staging.sh`, daarna `load_staging_wortel` en `load_staging_drone`.
2. `init_dwh.sh`, daarna `load_dwh_basics`.
3. `load_dwh_wortel_resultaten`. Ongeveer tien minuten bij een lege `FactWortelmeting`.
4. `plant_count`, `plant_count_steps` en `green_cover_season` naar `artifacts/runs/`.
5. `load_dwh_drone_resultaten` vult `FactPlotObservatie`.
6. `pipeline_status` en `test_db` voor beide databases.

`DimPlot.aantal_rijen` en `plot_oppervlakte_vierkante_meter` blijven leeg. Op `FactPlotObservatie` blijven `gem_lengte_centimeter`, `aantal_pluimen_per_plot` en `ndvi_gem` leeg. De plantentelling staat alleen op 18 mei.

`reset_staging.sh` en `reset_dwh.sh` droppen één database. Na een staging-reset ook de DWH resetten. De drie beeld-resets gooien de run-mappen van die stap weg en legen `FactPlotObservatie`.
