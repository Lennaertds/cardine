# apps/analytics — Python

Geldt naast de [root-AGENTS.md](../../AGENTS.md). Alleen wat specifiek is voor deze app.

## Indeling

- Eén module per bron of domein in `src/analytics/` (`hevy.py`, `sleep.py`). Boven ±400 regels: subpakket met dezelfde naam.
- Paden altijd via `analytics.config.load_settings()`, nooit hardgecodeerd. De lagen staan in [data/README.md](../../data/README.md).
- Pure functies voor transformaties; lezen en schrijven aan de rand (`cli` of `__init__.main`).
- `experiments/` wordt nooit geïmporteerd door `src/`. Een experiment dat blijft, wordt code met een test.

## Data

- Lees uit `raw/`, `external/` en `reference/`; schrijf naar `interim/` en `processed/`. Nooit naar `raw/`.
- Toon of log nooit rijen uit `raw/` of `runtime/`: die kunnen persoonsgegevens bevatten. Tellingen en schema's mogen.
- Testdata: klein, synthetisch, in `tests/fixtures/`.

## Tests

- `tests/unit/test_<module>.py`. Eén test: `uv --directory apps/analytics run pytest tests/unit/test_<module>.py`.
- Types: `mypy --strict` op `src/`. Nieuwe publieke functie = type-hints + test.

## Native (Rust of C)

Hot path na budget-breuk + ADR — zie [polyglot.md](../../docs/architecture/polyglot.md):

| Stack | App | Python-FFI |
|-------|-----|------------|
| `rust` | `apps/native` | PyO3 / maturin |
| `c` | `apps/native-c` | ctypes (`native_c_fallback.py`) |

Importeer achter een stabiele seam in analytics; test de nade. Zonder ADR: geen native dependency toevoegen.
