# UI iPhone — motion · smoothness

> **Rol:** Frame-level smoothness.  
> **Niet hier:** springs ([motion-springs](motion-springs.md)); performance van de desktop ([performance.md](../desktop/performance.md)).

## 1. Frame-level smoothness

- Per-frame positieverandering onder perceptiedrempel (geen strobing).
- Snelle motion: subtiele blur/stretch mag; animeer vooral **`transform` + `opacity`**; `will-change` alleen als motion imminent.
- `requestAnimationFrame` als display-synced clock.
