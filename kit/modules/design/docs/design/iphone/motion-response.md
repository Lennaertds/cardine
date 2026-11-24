# UI iPhone — motion · response

> **Rol:** Response + mobile-native baseline.  
> **Niet hier:** springs ([motion-springs](motion-springs.md)); gebaren ([motion-gestures](motion-gestures.md)).

## 1. Response — kill latency

Directheid valt “off a cliff” zodra er lag is.

- **Feedback op pointer-down, niet op release.** `:active` / highlight zodra de vinger landt.
- Audit debounces, kunstmatige timers, transition-waits, ~300ms tap delay. Alles niet-essentieel op het input-pad = regressie.
- Bij drag/slider/drawer: UI **1:1** met de pointer tijdens de gesture — nooit pas animeren als de gesture klaar is.

### Timingbanden

| Band | Duur | Gebruik |
|------|------|---------|
| Tap / press | **< 100ms** | `:active`, highlight — anders voelt het als lag |
| Entrance | **200–300ms** | Sheets, cards, panels — cubic ease-out ([motion-springs](motion-springs.md)) |
| Exit | **sneller** (~150ms bij ~250ms entrance) | Dismiss snappy; niet spiegelen 1:1 in tijd |
| Stagger | **~50ms** tussen items | Lijsten/cards; 30ms = blob, 100ms = crawl |
| Attention | **500–800ms** + bounce | Alleen notificatie/zeldzame focus — spaarzaam |

Product: geen scroll-driven / parallax-theater. `prefers-reduced-motion: reduce` → eindstaat of korte fade ([a11y](../shared/a11y.md)).

```css
.button:active {
  transform: scale(0.97);
  transition: transform 100ms ease-out;
}
```

### Mobile-native baseline — verplicht

| Symptoom | Fix |
|----------|-----|
| Sticky hover na tap | `:hover` **alleen** in `@media (hover: hover) and (pointer: fine)` |
| Grijze/blauwe tap-flash | `-webkit-tap-highlight-color: transparent` op `html` |
| Verkeerde viewport-hoogte | App/sheets: `100dvh`; marketing-hero: `100svh` — vermijd kale `100vh` |
| Zoom bij focus input | Inputs ≥ **16px** — **nooit** `user-scalable=no` / `maximum-scale=1` |
| Tap voelt traag | `touch-action: manipulation` op `button, a, [role="button"]` + `:active` |
| Pull-to-refresh hijack | `overscroll-behavior: none` op `html, body`; `contain` op inner scroll |
| Content onder notch / home-indicator | `viewport-fit=cover` + `env(safe-area-inset-*)` (fallback `0px`) |
| Long-press selecteert knoptekst | `user-select: none` + `-webkit-touch-callout: none` op **controls**, niet `body` |
| Carousel vs page scroll | Vertel assen: `pan-x` / `pan-y` / `pan-x pan-y` |
| Statusbar mismatch | `theme-color` per light/dark (+ update bij in-app theme toggle) |
| Keyboard duwt UI | Viewport: `interactive-widget=resizes-content` (Android); iOS: test met open keyboard |

```css
/* Floor — ship before first product component */
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

**Hover-recept:** geen ongegate `hover:` op product. Touch krijgt feedback via `:active` / `.pressable`, niet via sticky `:hover`.

**Input modes:** `inputmode` / `type` / `enterkeyhint` waar van toepassing.

**Nooit:** UA-sniffing i.p.v. `(hover)`/`(pointer)`; `touchmove`+`preventDefault` voor overscroll; klaar verklaren vanuit alleen Chrome device toolbar.
