# Stack c — `apps/native-c`

> **Role:** Opt-in C app for hot paths. FFI scaffolds: **N-API** (Nest/Node) and **ctypes** (Python/analytics). Mirror of [stacks/rust](../rust/README.md).
> **Not here:** when native is allowed ([polyglot.md](../../kern/docs/architecture/polyglot.md)). This file is not copied.

Next to `apps/native` (Rust), so both stacks can live in one project.

## 1. Generator

```bash
mkdir -p apps/native-c
```

The kit installs `src/`, `tests/`, `app.mk`. Different name? Rename the folder + `NATIVE_C_` / `-native-c` in `app.mk`.

## 2. Kit on top

```bash
kit/new-project.sh <project> --stacks c --starter
```

`--starter` installs **both** scaffolds:

| Path | Files | Host |
|-----|-----------|------|
| N-API | `package.json`, `index.js`, `test/`, stub `src/napi_addon.c` | Nest/Node |
| ctypes | `native_c_fallback.py`, `tests/test_add_py.py`, shared-lib via Make | Python / analytics |

**Requirement:** ADR following polyglot (measurement → budget breach → native C).

## 3. Check

```bash
make setup-native-c
make check-native-c                    # soft: compile smoke + FFI if the toolchain is ready
NATIVE_STRICT=1 make check-native-c    # hard: .so + binding, no fallback
make check-full                        # soft check + native-bindings-strict
make native-c-check
make bench-native-c
```

`CHECK` contains `check-native-c` (soft). STRICT: [native-ci.md](../../kern/docs/how-to/native-ci.md). `cc`/`clang` in `TOOLS`.
