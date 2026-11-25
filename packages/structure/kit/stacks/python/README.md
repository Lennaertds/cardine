# Stack python — `apps/analytics`

> **Role:** Set up a Python app for data, ML or analytics following [stacks §4](../../../standard/stacks.md#4-python-data-ml-analytics). This file is not copied.

## 1. Generator

```bash
uv init --package apps/analytics
uv --directory apps/analytics add --dev pytest ruff mypy
```

A different name than `analytics`? After copying, rename `apps/analytics/`, `src/analytics/` and `ANALYTICS_` in `app.mk`.

## 2. Kit on top

```bash
kit/new-project.sh <project> --stacks python --starter
```

This adds `app.mk`, `AGENTS.md`, `.env.example` and the folders `tests/{unit,fixtures}/` and `experiments/`. `--starter` also adds `src/analytics/config.py` with a test, so `make check` runs a real test straight away. Leave `--starter` out for an existing app.

## 3. Config in `pyproject.toml`

Everything in one file, no separate `.ini`:

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

## 4. Entry point

`make data-analytics` runs `uv run analytics build`. Let `analytics:main` in `src/analytics/__init__.py` handle the `build` command, or turn it into a `cli.py` as soon as there are more commands.

## 5. Check

```bash
make setup && make check-analytics
```
