# apps/native-c — C (hot path)

Geldt naast de [root-AGENTS.md](../../AGENTS.md). Alleen wat specifiek is voor deze app.

## Wanneer

Alleen na meting + ADR ([polyglot.md](../../docs/architecture/polyglot.md)). Geen C “terwijl we toch bezig zijn”.

## Indeling

- Pure logica in `src/add.c` (+ header); tests in `tests/test_add.c`.
- **N-API** → Nest/Node (`package.json` bij `--starter`; stub `src/napi_addon.c`).
- **ctypes** → Python/analytics (`native_c_fallback.py` bij `--starter`).
- Seam + test op de nade (P23). Geen secrets / raw PII in native logs.

## Commando's

| Doel | Commando |
|------|----------|
| Setup | `make setup-native-c` |
| Check (in `make check`) | `make check-native-c` |
| Layout | `make native-c-check` |
| Bench | `make bench-native-c` |
