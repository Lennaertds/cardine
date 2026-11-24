# apps/native — Rust (hot path)

Geldt naast de [root-AGENTS.md](../../AGENTS.md). Alleen wat specifiek is voor deze app.

## Wanneer

Alleen na meting + ADR ([polyglot.md](../../docs/architecture/polyglot.md)). Geen nieuwe crate “terwijl we toch bezig zijn”.

## Indeling

- Pure logica in Rust (`src/lib.rs`); FFI is de rand.
- **napi** → Nest/Node (`package.json` bij `--starter`).
- **PyO3** → Python/analytics (`pyproject.toml` / maturin bij `--starter`, feature `pyo3-bridge`).
- Kies het pad dat de ADR noemt; beide scaffolds mogen naast elkaar staan.
- Geen secrets in native logs; geen persoonsgegevens uit `data/raw/` of `runtime/`.
- Seam naar de host-app: stabiele signatures + test aan beide kanten (P23).

## Commando's

| Doel | Commando |
|------|----------|
| Setup | `make setup-native` |
| Check (in `make check`) | `make check-native` |
| Alleen layout | `make native-check` |
| Bench | `make bench-native` |
| PyO3 develop (optioneel) | `uv --directory apps/native run maturin develop --features pyo3-bridge` |
