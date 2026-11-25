# apps/pipeline — SQL and Python

Applies on top of the [root AGENTS.md](../../AGENTS.md). Only what is specific to this app.

## Layout

- `sql/migrations/NNNN-<slug>.sql`: schema (DDL). Never change after merge, always add a new one. Ask permission first.
- `sql/staging/<source>__<table>.sql`: one-to-one cleaned source tables. Repeatable: `CREATE OR REPLACE` or `DROP … IF EXISTS`.
- `sql/marts/<topic>.sql`: what apps and reports read. Read from `staging` only.
- `sql/checks/<name>.sql`: returns the bad rows; zero rows = green.
- `src/pipeline/`: Python for extract, load and orchestration. One module per source.

## Data

- Read from `data/raw/`, `external/` and `reference/`; never write to `raw/`. See [data/README.md](../../data/README.md).
- Never show or log rows with personal data. Counts and schemas are fine.

## Commands

- `make data-pipeline` rebuilds everything; `make checks-pipeline` checks data quality.
- Test one SQL file: `psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -1 -f <path>`.
