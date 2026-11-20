# Stack sql — `apps/pipeline`

> **Rol:** Een datapipeline met SQL en Python opzetten volgens [stacks §5](../../../standaard/stacks.md#5-datapipeline-met-sql-etl-warehouse). Dit bestand wordt niet gekopieerd.

## 1. Generator

```bash
uv init --package apps/pipeline
uv --directory apps/pipeline add --dev pytest ruff mypy
uv --directory apps/pipeline add "psycopg[binary]"
```

Gebruik je dbt, volg dan de dbt-indeling in plaats van `sql/` en laat `data-pipeline` `dbt build` draaien.

## 2. Kit erover

```bash
kit/new-project.sh <project> --stacks sql --modules compose --starter
```

Dit voegt `app.mk`, `AGENTS.md`, `.env.example` en de mappen `sql/{migrations,staging,marts,checks}/` en `tests/unit/` toe; met `--starter` ook `src/pipeline/config.py` met een test (niet bij een bestaande app). Zet de config van pytest, ruff en mypy in `pyproject.toml`, zoals bij de [python-stack](../python/README.md#3-config-in-pyprojecttoml).

## 3. Hoe de targets werken

| Target | Wat |
|--------|-----|
| `migrate-pipeline` | Past elke `sql/migrations/NNNN-<slug>.sql` die nog niet in de tabel `schema_migrations` staat toe, in volgorde, elk in één transactie. |
| `data-pipeline` | Eerst `migrate-pipeline`, dan `uv run pipeline build` (extract en load), dan `staging/` en `marts/` in alfabetische volgorde. |
| `checks-pipeline` | Elke query in `sql/checks/` geeft de rijen terug die fout zijn. Nul rijen is groen. Draait in `make check-full`. |

Voorbeeld van een check, `sql/checks/sessions_have_user.sql`:

```sql
SELECT s.id
FROM marts.sessions AS s
LEFT JOIN marts.users AS u ON u.id = s.user_id
WHERE u.id IS NULL;
```

## 4. Controleren

```bash
make setup && make up && make data && make check-full
```
