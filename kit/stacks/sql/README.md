# Stack sql — `apps/pipeline`

> **Role:** Set up a data pipeline with SQL and Python following [stacks §5](../../../standard/stacks.md#5-data-pipeline-with-sql-etl-warehouse). This file is not copied.

## 1. Generator

```bash
uv init --package apps/pipeline
uv --directory apps/pipeline add --dev pytest ruff mypy
uv --directory apps/pipeline add "psycopg[binary]"
```

If you use dbt, follow the dbt layout instead of `sql/` and have `data-pipeline` run `dbt build`.

## 2. Kit on top

```bash
kit/new-project.sh <project> --stacks sql --modules compose --starter
```

This adds `app.mk`, `AGENTS.md`, `.env.example` and the folders `sql/{migrations,staging,marts,checks}/` and `tests/unit/`; with `--starter` also `src/pipeline/config.py` with a test (not for an existing app). Put the pytest, ruff and mypy config in `pyproject.toml`, as in the [python stack](../python/README.md#3-config-in-pyprojecttoml).

## 3. How the targets work

| Target | What |
|--------|-----|
| `migrate-pipeline` | Applies every `sql/migrations/NNNN-<slug>.sql` not yet in the `schema_migrations` table, in order, each in one transaction. |
| `data-pipeline` | First `migrate-pipeline`, then `uv run pipeline build` (extract and load), then `staging/` and `marts/` in alphabetical order. |
| `checks-pipeline` | Every query in `sql/checks/` returns the rows that are wrong. Zero rows is green. Runs in `make check-full`. |

Example of a check, `sql/checks/sessions_have_user.sql`:

```sql
SELECT s.id
FROM marts.sessions AS s
LEFT JOIN marts.users AS u ON u.id = s.user_id
WHERE u.id IS NULL;
```

## 4. Check

```bash
make setup && make up && make data && make check-full
```
