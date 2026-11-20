# UI iPhone — materials · a11y

> **Rol:** Multimodal feedback + reduced motion/a11y.  
> **Niet hier:** vloer voor alle vlakken ([a11y.md](../shared/a11y.md)).

## 1. Multimodal feedback

1. **Causality** — feedback op het echte causale moment.
2. **Harmony** — visual (+ haptic/sound indien ooit) op **hetzelfde frame**.
3. **Utility** — alleen meaningful moments (success, error, commit, snap). Over-feedback = genegeerd.

Vibration API spaarzaam; PWA-haptics waar platform het toelaat. [touch-haptics](touch-haptics.md).

## 2. Reduced motion & a11y

Reduced motion ≠ geen feedback.

| Signal | Gedrag |
|--------|--------|
| `prefers-reduced-motion: reduce` | Geen slides/springs/parallax; korte opacity cross-fade; geen overshoot |
| `prefers-reduced-transparency: reduce` | Frostiger/solide chrome; blur uit |
| `prefers-contrast: more` | Near-solid + duidelijke border |

Vermijd full-viewport moving backgrounds, langzame loops (~0.2 Hz), abrupte brightness jumps. Grote moving objects semi-transparent tijdens travel.

Focus-ringen blijven. Geen info alleen in hover.
