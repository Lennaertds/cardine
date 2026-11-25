# apps/native-c — C (hot path)

Applies on top of the [root AGENTS.md](../../AGENTS.md). Only what is specific to this app.

## When

Only after measurement + ADR ([polyglot.md](../../docs/architecture/polyglot.md)). No C "while we're at it".

## Layout

- Pure logic in `src/add.c` (+ header); tests in `tests/test_add.c`.
- **N-API** → Nest/Node (`package.json` with `--starter`; stub `src/napi_addon.c`).
- **ctypes** → Python/analytics (`native_c_fallback.py` with `--starter`).
- Seam + test on the seam (P23). No secrets / raw PII in native logs.

## Commands

| Goal | Command |
|------|---------|
| Setup | `make setup-native-c` |
| Check (in `make check`) | `make check-native-c` |
| Layout | `make native-c-check` |
| Bench | `make bench-native-c` |
