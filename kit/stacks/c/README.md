# Stack c — `apps/native-c`

> **Rol:** Opt-in C-app voor hot paths. FFI-scaffolds: **N-API** (Nest/Node) en **ctypes** (Python/analytics). Spiegel van [stacks/rust](../rust/README.md).
> **Niet hier:** wanneer native mag ([polyglot.md](../../kern/docs/architecture/polyglot.md)). Dit bestand wordt niet gekopieerd.

Naast `apps/native` (Rust), zodat beide stacks in één project kunnen.

## 1. Generator

```bash
mkdir -p apps/native-c
```

Kit zet `src/`, `tests/`, `app.mk` neer. Andere naam? Hernoem map + `NATIVE_C_` / `-native-c` in `app.mk`.

## 2. Kit erover

```bash
kit/new-project.sh <project> --stacks c --starter
```

`--starter` zet **beide** scaffolds:

| Pad | Bestanden | Host |
|-----|-----------|------|
| N-API | `package.json`, `index.js`, `test/`, stub `src/napi_addon.c` | Nest/Node |
| ctypes | `native_c_fallback.py`, `tests/test_add_py.py`, shared-lib via Make | Python / analytics |

**Voorwaarde:** ADR volgens polyglot (meting → budget-breuk → native C).

## 3. Controleren

```bash
make setup-native-c
make check-native-c                    # soft: compile-smoke + FFI als toolchain klaar
NATIVE_STRICT=1 make check-native-c    # hard: .so + binding, geen fallback
make check-full                        # soft check + native-bindings-strict
make native-c-check
make bench-native-c
```

`CHECK` bevat `check-native-c` (soft). STRICT: [native-ci.md](../../kern/docs/how-to/native-ci.md). `cc`/`clang` in `TOOLS`.
