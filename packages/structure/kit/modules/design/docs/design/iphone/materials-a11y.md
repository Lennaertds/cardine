# UI iPhone — materials · a11y

> **Role:** Multimodal feedback + reduced motion/a11y.
> **Not here:** the floor for all surfaces ([a11y.md](../shared/a11y.md)).

## 1. Multimodal feedback

1. **Causality** — feedback at the real causal moment.
2. **Harmony** — visual (+ haptic/sound if ever) on **the same frame**.
3. **Utility** — meaningful moments only (success, error, commit, snap). Over-feedback = ignored.

Use the Vibration API sparingly; PWA haptics where the platform allows it. [touch-haptics](touch-haptics.md).

## 2. Reduced motion & a11y

Reduced motion ≠ no feedback.

| Signal | Behaviour |
|--------|-----------|
| `prefers-reduced-motion: reduce` | No slides/springs/parallax; short opacity cross-fade; no overshoot |
| `prefers-reduced-transparency: reduce` | Frostier/solid chrome; blur off |
| `prefers-contrast: more` | Near-solid + a clear border |

Avoid full-viewport moving backgrounds, slow loops (~0.2 Hz), abrupt brightness jumps. Large moving objects semi-transparent while travelling.

Focus rings stay. No information in hover only.
