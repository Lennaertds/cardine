# UI iPhone — touch · haptics

> **Role:** Haptics policy (web vibrate).
> **Not here:** multimodal feedback ([materials-a11y](materials-a11y.md)); surfaces ([touch-targets](touch-targets.md)).

## 1. Haptics

On the web: `navigator.vibrate` where available (Android; iOS Safari limited). The same policy as native.

| Moment | Intensity | Example |
|--------|-----------|---------|
| Step/detent (picker tick, segmented) | Light / selection | `vibrate(8)` |
| Snap home / sheet detent / drag commit | Light impact | `vibrate(10)` |
| Destructive commit | Medium | `vibrate([15, 30, 15])` |
| Success / error notification | Pattern | success short; error double |

**Absolutely:**

1. The same frame as the visual (the causal moment, not the end of an animation).
2. **One** haptic per user action — never per scroll frame, never on an entrance the user did not cause.
3. Never the only feedback — the visual must work on its own (many iPhones / silent).
4. **Forbidden** on every repeated tick in a dense logger (dozens per session) — commit / snap / success only.
