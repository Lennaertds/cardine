# UI iPhone — materials · depth

> **Role:** Materials, depth, skins contract.
> **Not here:** the `.glass` class ([glass.md](../shared/glass.md)); typography ([materials-type](materials-type.md)).

## 1. Materials & depth

Translucent materials = a floating functional layer.

- **Nav / tabbar / sheets** as translucent layers: `backdrop-filter: blur()` + semi-transparent bg; content scrolls **under** the chrome.
- **Material weight = hierarchy:** heavier for structure (sidebar/chrome); lighter for interactive chips. **Never** stack light translucent on light translucent.
- Bigger surfaces = thicker (stronger blur + deeper shadow). Context-aware shadow: heavier over busy content.
- **Dim to focus** (modal + scrim); **separation without a scrim** for parallel panels. Stacked sheets: dim/push the parent back progressively.
- **Vibrancy:** text on blur = higher contrast, slightly heavier weight, a small tracking bump — no flat muted grey on glass.
- Scroll edge: blur/gradient fade instead of a hard 1px divider under sticky chrome.
- **Materialise, don't just fade:** animate blur radius + scale together on the enter/exit of glass.

```css
.toolbar {
  background: color-mix(in oklab, var(--card) 60%, transparent);
  backdrop-filter: blur(20px) saturate(180%);
  border-top: 1px solid color-mix(in oklab, var(--foreground) 12%, transparent);
}
```

Grouped inset **content** rows may stay solid `surface` (readability). Glass = chrome + sheets. The product uses the one class [`.glass`](../shared/glass.md).

**Depth bar:**

| Do | Don't (product) |
|----|-----------------|
| Sparse elevation on solid cards: contact (~1–3px) + optionally a soft mid — at most one lifted layer | **Never** product parallax (layers at different scroll speeds) |
| Hierarchy through a surface ladder (base → surface → elevated) and borders | Glow / coloured blur / `translateZ` theatre as depth |
| Dark ≠ pure `#000`: ~layered off-black, soft off-white text, accents ~20% desaturated | Flat invert or pure white glare |
| Hover lift only `(hover: hover) and (pointer: fine)` | Primary affordance or "premium depth" on touch through glow |

Elevation = sparse hierarchy, not a showcase. Cards: [surfaces-cards](application/surfaces-cards.md). Hover gate: [touch-targets](touch-targets.md).

## 2. Materials & skins (contract)

| Layer | Material |
|-------|----------|
| Product header, tabbar, sheet chrome | [`.glass`](../shared/glass.md) — one class, no second blur |
| Pinned page title | The same liquid glass as the header, only while the bar follows along (project chrome) |
| Grouped content, tables, feed cards | **Solid** `surface` / `bg-card` |
| Notice / critical banners | Near-solid (≥ ~96% opacity) |

- Never stack light glass on light glass (header glass + sticky live-bar glass → one of the two solid or a heavier material).
- Per skin: glass opacity may go up if the habitat is busy; text over blur = vibrancy — no flat muted grey.
- `prefers-reduced-transparency: reduce` → solidify the chrome.
- `prefers-contrast: more` → near-solid + a clear border on chrome **and** cards.

Scroll edge: blur/gradient fade under sticky chrome instead of a hard 1px rule.
