# UI iPhone — motion · response

> **Role:** Response + mobile-native baseline.
> **Not here:** springs ([motion-springs](motion-springs.md)); gestures ([motion-gestures](motion-gestures.md)).

## 1. Response — kill latency

Directness falls off a cliff as soon as there is lag.

- **Feedback on pointer-down, not on release.** `:active` / highlight the moment the finger lands.
- Audit debounces, artificial timers, transition waits, the ~300ms tap delay. Anything non-essential on the input path = regression.
- For drag/slider/drawer: the UI is **1:1** with the pointer during the gesture — never animate only once the gesture is done.

### Timing bands

| Band | Duration | Use |
|------|----------|-----|
| Tap / press | **< 100ms** | `:active`, highlight — otherwise it feels like lag |
| Entrance | **200–300ms** | Sheets, cards, panels — cubic ease-out ([motion-springs](motion-springs.md)) |
| Exit | **faster** (~150ms for a ~250ms entrance) | Dismiss snappy; do not mirror 1:1 in time |
| Stagger | **~50ms** between items | Lists/cards; 30ms = blob, 100ms = crawl |
| Attention | **500–800ms** + bounce | Notification/rare focus only — sparingly |

Product: no scroll-driven / parallax theatre. `prefers-reduced-motion: reduce` → end state or a short fade ([a11y](../shared/a11y.md)).

```css
.button:active {
  transform: scale(0.97);
  transition: transform 100ms ease-out;
}
```

### Mobile-native baseline — mandatory

| Symptom | Fix |
|---------|-----|
| Sticky hover after tap | `:hover` **only** inside `@media (hover: hover) and (pointer: fine)` |
| Grey/blue tap flash | `-webkit-tap-highlight-color: transparent` on `html` |
| Wrong viewport height | App/sheets: `100dvh`; marketing hero: `100svh` — avoid a bare `100vh` |
| Zoom on input focus | Inputs ≥ **16px** — **never** `user-scalable=no` / `maximum-scale=1` |
| Tap feels slow | `touch-action: manipulation` on `button, a, [role="button"]` + `:active` |
| Pull-to-refresh hijack | `overscroll-behavior: none` on `html, body`; `contain` on inner scroll |
| Content under the notch / home indicator | `viewport-fit=cover` + `env(safe-area-inset-*)` (fallback `0px`) |
| Long-press selects button text | `user-select: none` + `-webkit-touch-callout: none` on **controls**, not `body` |
| Carousel vs page scroll | Declare the axes: `pan-x` / `pan-y` / `pan-x pan-y` |
| Status bar mismatch | `theme-color` per light/dark (+ update on the in-app theme toggle) |
| Keyboard pushes the UI | Viewport: `interactive-widget=resizes-content` (Android); iOS: test with the keyboard open |

```css
/* Floor — ship before the first product component */
html {
  -webkit-tap-highlight-color: transparent;
  -webkit-text-size-adjust: 100%;
  overscroll-behavior: none;
}
button, a, [role="button"], .tappable {
  touch-action: manipulation;
  user-select: none;
  -webkit-user-select: none;
}
@media (pointer: coarse) {
  input, textarea, select { font-size: 16px; }
}
@media (hover: hover) and (pointer: fine) {
  /* ALL :hover rules live here — nowhere else */
}
.sheet-body, .list-scroll {
  overflow-y: auto;
  overscroll-behavior: contain;
}
```

**Hover recipe:** no ungated `hover:` in the product. Touch gets feedback through `:active` / `.pressable`, not through sticky `:hover`.

**Input modes:** `inputmode` / `type` / `enterkeyhint` where they apply.

**Never:** UA sniffing instead of `(hover)`/`(pointer)`; `touchmove`+`preventDefault` for overscroll; declaring it done from the Chrome device toolbar alone.
