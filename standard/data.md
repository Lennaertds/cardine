# Data: fixed layers

> **Role:** Which data belongs in which layer of `data/`, who writes it, and what may go into git.
> **Not here:** the `.gitignore` block ([git](git.md)), the per-project catalogue ([data-readme template](../sjablonen/data-readme.md)).

| Layer | What | In git | Who writes |
|-------|------|--------|------------|
| `raw/<source>/YYYY-MM-DD/` | Raw exports and downloads that you or a user provide | Never | You, once; nobody after that |
| `external/<source>/` | Third-party data with its own licence: papers, open datasets | Never; only `README.md` with origin and licence | Download |
| `interim/<step>/` | Intermediate results: extracted text, search indexes, cleaned tables | Never | Pipeline; always safe to delete |
| `processed/<dataset>/` | End result that apps and reports read | Only `processed/demo/`: small and anonymous | `make data` |
| `reference/<dataset>/` | Hand-assembled: catalogues, mappings, rules as data, seeds | Yes, reviewed as code | You, by hand |
| `runtime/` | What the app writes while running: uploads, per-user files | Never | The app |
| `models/<model>/` | Trained models with `meta.json` | Never; preferably in a registry | The training step |

**Rules:**

- **One direction:** `raw/`, `external/` and `reference/` → `interim/` → `processed/`. Code never writes to `raw/` or `reference/`.
- **Apps only read** `processed/`, `reference/` and `runtime/`, never `raw/`.
- **Every path comes from one config per app**: an env variable with a default (such as `USER_DATA_DIR` → `data/runtime/user/`). No paths scattered through the code.
- **Reproducible:** empty `processed/`, run `make data`, and you get the same result back.
- **Large or binary** (above ±1 MB, or changing often): not in plain git. If it must be in git, use Git LFS. Real datasets belong in DVC or object storage.
- **Personal data** lives only in `raw/`, `runtime/` and the database. Demo data is aggregated or made up.
- **No test data and no images in `data/`.** Test data belongs in `tests/fixtures/`, images for docs in `docs/assets/`.
- **One folder per source or dataset**, lowercase (`raw/apple-health/`, `reference/exercises/`), with its own `README.md` as soon as the folder holds more than one file.

---
