# apps/analytics — Python

Applies on top of the [root AGENTS.md](../../AGENTS.md). Only what is specific to this app.

## Layout

- One module per source or domain in `src/analytics/` (`hevy.py`, `sleep.py`). Above ±400 lines: a sub-package with the same name.
- Paths always via `analytics.config.load_settings()`, never hard-coded. The layers are described in [data/README.md](../../data/README.md).
- Pure functions for transformations; read and write at the edge (`cli` or `__init__.main`).
- `experiments/` is never imported by `src/`. An experiment that stays becomes code with a test.

## Data

- Read from `raw/`, `external/` and `reference/`; write to `interim/` and `processed/`. Never to `raw/`.
- Never show or log rows from `raw/` or `runtime/`: they may contain personal data. Counts and schemas are fine.
- Test data: small, synthetic, in `tests/fixtures/`.

## Tests

- `tests/unit/test_<module>.py`. One test: `uv --directory apps/analytics run pytest tests/unit/test_<module>.py`.
- Types: `mypy --strict` on `src/`. A new public function = type hints + test.

## Native (Rust or C)

Hot path after a budget breach + ADR — see [polyglot.md](../../docs/architecture/polyglot.md):

| Stack | App | Python FFI |
|-------|-----|------------|
| `rust` | `apps/native` | PyO3 / maturin |
| `c` | `apps/native-c` | ctypes (`native_c_fallback.py`) |

Import it behind a stable seam in analytics; test the seam. Without an ADR: do not add a native dependency.
