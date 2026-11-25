# Glass — the one class

> **Role:** The implementation of `.glass` for all surfaces. Where glass is allowed is described per craft file.
> **Not here:** where glass is allowed per surface ([liquid-glass.md](../desktop/landingpage/liquid-glass.md), [materials-depth](../iphone/materials-depth.md)).

One class. No second blur, no mesh gradient, no fixed white border from a kit.

## 1. `.glass`

```css
.glass {
  background: color-mix(in oklab, var(--card) 42%, transparent);
  backdrop-filter: saturate(1.9) blur(40px);
  -webkit-backdrop-filter: saturate(1.9) blur(40px);
  box-shadow:
    inset 0 0.5px 0 color-mix(in oklab, #fff 42%, transparent),
    0 10px 28px color-mix(in oklab, #000 18%, transparent);
}
```

Dark theme: outer shadow 35% black, inset highlight 18% white. That override stays in `globals.css` next to `.glass`.

Hairline on a flat base:

```css
border: 1px solid color-mix(in oklab, var(--stroke) 55%, transparent);
```

`prefers-reduced-transparency: reduce` makes this almost solid: `--card` at ≥ 92%, blur off. The hairline stays. [a11y.md](a11y.md).

## 2. Clear

`.glass-clear` exists only once the conditions in [liquid-glass](../desktop/landingpage/liquid-glass.md) §1 are met, and only as a class in `globals.css`. Tint towards 18–24% `--card`, the same blur family, a dim underneath. Until that class exists: Regular.

## 3. Where the class lives

Glass = **functional chrome**, not content.

| Layer | Glass on | Not on |
|-------|----------|--------|
| Showcase / landing page | Nav, menu, at most one functional panel. [liquid-glass](../desktop/landingpage/liquid-glass.md) | Prose, card grids, hero copy |
| Application | Header, tabbar / top nav, sheet chrome, pinned title. [materials-depth](../iphone/materials-depth.md) | Cards, tables, dense content |

**Test:** every glass bar uses this class. Nowhere a second `backdrop-filter` with a different blur value.
