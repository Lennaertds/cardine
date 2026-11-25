# How-to — native CI (STRICT)

> **Role:** Soft locally vs hard FFI checks in `check-full` / CI.
> **Not here:** when native is allowed ([polyglot.md](../architecture/polyglot.md)); stack setup (rust/c README).

## Soft vs strict

| Mode | When | Behaviour |
|------|------|-----------|
| Soft (default) | `make check` / `check-native*` | `cargo test` / C smoke; FFI tests only if `node_modules` / `.venv` is there; the JS/Python **fallback** is allowed |
| Strict | `NATIVE_STRICT=1` or `make check-full` → `native-bindings-strict` | No fallback; artifact + binding test required for the chosen FFI |

```bash
make check-native                         # soft
NATIVE_STRICT=1 make check-native         # hard
NATIVE_STRICT=1 NATIVE_FFI=pyo3 make check-native
make check-full                           # soft check + then native STRICT
```

## NATIVE_FFI

| Value | Meaning |
|-------|---------|
| `auto` (default) | Everything the starter files suggest |
| `napi` | Node addon (`package.json`) — no JS fallback |
| `pyo3` | Rust stack only: maturin + import `native` |
| `ctypes` | C stack only: `build/libnative_c.so` + Python load |

## CI

Team kit: the workflow `.github/workflows/native.yml` runs setup + `make check-full` (incl. STRICT) when native apps exist. Adapt the toolchains (rustup, node, uv).

Locally without an addon build: keep `make check` soft; leave STRICT to CI/`check-full`.
