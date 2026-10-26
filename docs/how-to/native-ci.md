# How-to — native CI (STRICT)

> **Rol:** Soft lokaal vs harde FFI-checks in `check-full` / CI.
> **Niet hier:** wanneer native mag ([polyglot.md](../architecture/polyglot.md)); stack-setup (rust/c README).

## Soft vs strict

| Modus | Wanneer | Gedrag |
|-------|---------|--------|
| Soft (default) | `make check` / `check-native*` | `cargo test` / C-smoke; FFI-tests alleen als `node_modules` / `.venv` er is; JS/Python-**fallback** mag |
| Strict | `NATIVE_STRICT=1` of `make check-full` → `native-bindings-strict` | Geen fallback; artifact + binding-test verplicht voor gekozen FFI |

```bash
make check-native                         # soft
NATIVE_STRICT=1 make check-native         # hard
NATIVE_STRICT=1 NATIVE_FFI=pyo3 make check-native
make check-full                           # soft check + daarna native STRICT
```

## NATIVE_FFI

| Waarde | Betekenis |
|--------|-----------|
| `auto` (default) | Alles wat de starter-bestanden suggereren |
| `napi` | Node-addon (`package.json`) — geen JS-fallback |
| `pyo3` | Alleen Rust-stack: maturin + import `native` |
| `ctypes` | Alleen C-stack: `build/libnative_c.so` + Python-load |

## CI

Team-kit: workflow `.github/workflows/native.yml` draait setup + `make check-full` (incl. STRICT) wanneer native-apps bestaan. Pas toolchains aan (rustup, node, uv).

Lokaal zonder addon-build: houd `make check` soft; laat STRICT aan CI/`check-full`.
