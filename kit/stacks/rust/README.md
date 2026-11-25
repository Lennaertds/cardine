# Stack rust — `apps/native`

> **Role:** Opt-in Rust app for hot paths. FFI scaffolds: **napi** (Nest/Node) and **PyO3** (Python/analytics). Not a default in every project.
> **Not here:** when native is allowed ([polyglot.md](../../kern/docs/architecture/polyglot.md)). This file is not copied.

Choose **one** FFI path per ADR (or both seams if you need both hosts). Soft vs STRICT: [native-ci.md](../../kern/docs/how-to/native-ci.md).

## 1. Generator

```bash
mkdir -p apps/native
cargo init --lib apps/native --name native
```

Or keep the kit's `Cargo.toml` / `src/lib.rs` after `kit/new-project.sh` (test-kit does `mkdir` + copy).

Different app name? Rename `apps/native/`, the package name in `Cargo.toml` and `NATIVE_` / `-native` in `app.mk`.

## 2. Kit on top

```bash
kit/new-project.sh <project> --stacks rust --starter
```

Adds `app.mk`, `AGENTS.md`, `.env.example`, `scripts/native-check.sh`.
`--starter` installs **both** scaffolds:

| Path | Files | Host |
|-----|-----------|------|
| napi | `package.json`, `index.js`, `test/add.test.js` | Nest/Node |
| PyO3 | `pyproject.toml` (maturin), `native_fallback.py`, `tests/test_add.py`, feature `pyo3-bridge` | Python / analytics |

Without `--starter`: pure Rust + `cargo test`.

**Requirement:** ADR following polyglot (measurement → budget breach → native).

## 3. Check

```bash
make setup-native                    # cargo fetch; hint pnpm / maturin
make check-native                    # soft: cargo test; FFI if the toolchain is there
NATIVE_STRICT=1 make check-native    # hard: no JS/Python fallback
make check-full                      # soft check + native-bindings-strict
make native-check                    # layout
make bench-native                    # requires scripts/bench.sh
```

`CHECK` contains `check-native`. `cargo` is in `TOOLS`.

PyO3 locally (optional):

```bash
uv --directory apps/native run maturin develop --features pyo3-bridge
uv --directory apps/native run pytest -q
```

## 4. Seams

- **Nest:** load the napi `.node` behind a stable interface + test (P23).
- **Analytics:** import the PyO3 module / `native_fallback` behind a seam — see `apps/analytics/AGENTS.md` and polyglot.
