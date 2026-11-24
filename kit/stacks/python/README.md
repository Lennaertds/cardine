# Stack python — `apps/analytics`

> **Rol:** Een Python-app voor data, ML of analytics opzetten volgens [stacks §4](../../../standaard/stacks.md#4-python-data-ml-analytics). Dit bestand wordt niet gekopieerd.

## 1. Generator

```bash
uv init --package apps/analytics
uv --directory apps/analytics add --dev pytest ruff mypy
```

Een andere naam dan `analytics`? Hernoem dan na het kopiëren `apps/analytics/`, `src/analytics/` en `ANALYTICS_` in `app.mk`.

## 2. Kit erover

```bash
kit/new-project.sh <project> --stacks python --starter
```

Dit voegt `app.mk`, `AGENTS.md`, `.env.example` en de mappen `tests/{unit,fixtures}/` en `experiments/` toe. `--starter` zet er ook `src/analytics/config.py` met een test bij, zodat `make check` meteen een echte test draait. Laat `--starter` weg bij een bestaande app.

## 3. Config in `pyproject.toml`

Alles in één bestand, geen aparte `.ini`:

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]

[tool.ruff]
line-length = 100

[tool.ruff.lint]
select = ["E", "F", "I", "B", "UP"]

[tool.mypy]
strict = true
files = ["src"]
```

## 4. Ingang

`make data-analytics` draait `uv run analytics build`. Laat `analytics:main` in `src/analytics/__init__.py` het commando `build` afhandelen, of maak er een `cli.py` van zodra er meer commando's zijn.

## 5. Controleren

```bash
make setup && make check-analytics
```
