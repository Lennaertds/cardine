# apps/native — Rust (hot path)

Applies on top of the [root AGENTS.md](../../AGENTS.md). Only what is specific to this app.

## When

Only after measurement + ADR ([polyglot.md](../../docs/architecture/polyglot.md)). No new crate "while we're at it".

## Layout

- Pure logic in Rust (`src/lib.rs`); FFI is the edge.
- **napi** → Nest/Node (`package.json` with `--starter`).
- **PyO3** → Python/analytics (`pyproject.toml` / maturin with `--starter`, feature `pyo3-bridge`).
- Choose the path the ADR names; both scaffolds may sit side by side.
- No secrets in native logs; no personal data from `data/raw/` or `runtime/`.
- Seam to the host app: stable signatures + a test on both sides (P23).

## Commands

| Goal | Command |
|------|---------|
| Setup | `make setup-native` |
| Check (in `make check`) | `make check-native` |
| Layout only | `make native-check` |
| Bench | `make bench-native` |
| PyO3 develop (optional) | `uv --directory apps/native run maturin develop --features pyo3-bridge` |
