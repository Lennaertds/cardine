# UI iPhone — motion · smoothness

> **Role:** Frame-level smoothness.
> **Not here:** springs ([motion-springs](motion-springs.md)); desktop performance ([performance.md](../desktop/performance.md)).

## 1. Frame-level smoothness

- Per-frame position change below the perception threshold (no strobing).
- Fast motion: subtle blur/stretch is allowed; animate **`transform` + `opacity`** above all; `will-change` only when motion is imminent.
- `requestAnimationFrame` as the display-synced clock.
