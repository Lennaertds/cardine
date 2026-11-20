# apps/pipeline — SQL en Python

Geldt naast de [root-AGENTS.md](../../AGENTS.md). Alleen wat specifiek is voor deze app.

## Indeling

- `sql/migrations/NNNN-<slug>.sql`: schema (DDL). Nooit wijzigen na merge, altijd een nieuwe. Vraag eerst toestemming.
- `sql/staging/<bron>__<tabel>.sql`: één-op-één opgekuiste brontabellen. Herhaalbaar: `CREATE OR REPLACE` of `DROP … IF EXISTS`.
- `sql/marts/<onderwerp>.sql`: wat apps en rapporten lezen. Alleen lezen uit `staging`.
- `sql/checks/<naam>.sql`: geeft de foute rijen terug; nul rijen = groen.
- `src/pipeline/`: Python voor extract, load en orkestratie. Eén module per bron.

## Data

- Lees uit `data/raw/`, `external/` en `reference/`; nooit schrijven naar `raw/`. Zie [data/README.md](../../data/README.md).
- Toon of log nooit rijen met persoonsgegevens. Tellingen en schema's mogen.

## Commando's

- `make data-pipeline` bouwt alles opnieuw; `make checks-pipeline` controleert de datakwaliteit.
- Eén SQL-bestand testen: `psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -1 -f <pad>`.
