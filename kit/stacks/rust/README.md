# Stack rust — `apps/native`

> **Rol:** Opt-in Rust-app voor hot paths. FFI-scaffolds: **napi** (Nest/Node) en **PyO3** (Python/analytics). Geen default in elk project.
> **Niet hier:** wanneer native mag ([polyglot.md](../../kern/docs/architecture/polyglot.md)). Dit bestand wordt niet gekopieerd.

Kies **één** FFI-pad per ADR (of beide seams als je beide hosts nodig hebt). Soft vs STRICT: [native-ci.md](../../kern/docs/how-to/native-ci.md).

## 1. Generator

```bash
mkdir -p apps/native
cargo init --lib apps/native --name native
```

Of laat de kit-`Cargo.toml` / `src/lib.rs` staan na `kit/new-project.sh` (test-kit doet `mkdir` + kopie).

Andere app-naam? Hernoem `apps/native/`, package-naam in `Cargo.toml` en `NATIVE_` / `-native` in `app.mk`.

## 2. Kit erover

```bash
kit/new-project.sh <project> --stacks rust --starter
```

Zet `app.mk`, `AGENTS.md`, `.env.example`, `scripts/native-check.sh`.  
`--starter` zet **beide** scaffolds neer:

| Pad | Bestanden | Host |
|-----|-----------|------|
| napi | `package.json`, `index.js`, `test/add.test.js` | Nest/Node |
| PyO3 | `pyproject.toml` (maturin), `native_fallback.py`, `tests/test_add.py`, feature `pyo3-bridge` | Python / analytics |

Zonder `--starter`: pure Rust + `cargo test`.

**Voorwaarde:** ADR volgens polyglot (meting → budget-breuk → native).

## 3. Controleren

```bash
make setup-native                    # cargo fetch; tip pnpm / maturin
make check-native                    # soft: cargo test; FFI als toolchain er is
NATIVE_STRICT=1 make check-native    # hard: geen JS/Python-fallback
make check-full                      # soft check + native-bindings-strict
make native-check                    # layout
make bench-native                    # vereist scripts/bench.sh
```

`CHECK` bevat `check-native`. `cargo` staat in `TOOLS`.

PyO3 lokaal (optioneel):

```bash
uv --directory apps/native run maturin develop --features pyo3-bridge
uv --directory apps/native run pytest -q
```

## 4. Seams

- **Nest:** laad napi-`.node` achter stabiele interface + test (P23).
- **Analytics:** importeer PyO3-module / `native_fallback` achter seam — zie `apps/analytics/AGENTS.md` en polyglot.
