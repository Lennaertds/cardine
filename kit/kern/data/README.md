# Data

> **Role:** Which dataset sits where, where it comes from, and whether it may go into git.
> **Not here:** how the pipeline works (`docs/architecture/`), what a field means (`docs/context/GLOSSARY.md`).

| Layer | What | In git | Who writes |
|-------|------|--------|------------|
| `raw/<source>/YYYY-MM-DD/` | Raw exports and downloads | never | you, once; nobody after that |
| `external/<source>/` | Third-party, with its own licence | never, only README.md | download |
| `external/digest/` | Raw inbound feeds (module `research`) | never, only README/`.gitkeep` | `make digest-fetch` |
| `interim/<step>/` | Intermediate results of the pipeline | never | pipeline; always safe to delete |
| `processed/<dataset>/` | What apps and reports read | only `demo/` | `make data` |
| `reference/<dataset>/` | Hand-assembled: catalogues, mappings, seeds | yes | you, through review |

## Datasets

| Path | Origin | Licence | Personal data | Recreate |
|------|--------|---------|---------------|----------|
| <`raw/hevy/2026-10-01/`> | <export from the Hevy app> | <own data> | <yes: workouts> | <export again> |
