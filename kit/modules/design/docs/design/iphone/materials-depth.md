# UI iPhone — materials · depth

> **Rol:** Materials, depth, skins contract.  
> **Niet hier:** de class `.glass` ([glass.md](../shared/glass.md)); typografie ([materials-type](materials-type.md)).

## 1. Materials & depth

Translucente materialen = floating functionele laag.

- **Nav / tabbar / sheets** als translucent layers: `backdrop-filter: blur()` + semi-transparante bg; content scrollt **onder** chrome.
- **Material weight = hiërarchie:** zwaarder voor structure (sidebar/chrome); lichter voor interactive chips. **Nooit** light translucent op light translucent stacken.
- Grotere surfaces = dikker (sterkere blur + diepere shadow). Context-aware shadow: zwaarder over drukke content.
- **Dim om te focussen** (modal + scrim); **scheiding zonder scrim** voor parallelle panels. Stacked sheets: parent progressief dimmen/terugduwen.
- **Vibrancy:** tekst op blur = hoger contrast, iets zwaarder weight, lichte tracking-bump — geen flat muted gray op glass.
- Scroll-edge: blur/gradient fade i.p.v. harde 1px divider onder sticky chrome.
- **Materialize, don’t just fade:** blur-radius + scale samen animeren bij enter/exit van glass.

```css
.toolbar {
  background: color-mix(in oklab, var(--card) 60%, transparent);
  backdrop-filter: blur(20px) saturate(180%);
  border-top: 1px solid color-mix(in oklab, var(--foreground) 12%, transparent);
}
```

Grouped inset **content**-rijen mogen solide `surface` blijven (leesbaarheid). Glass = chrome + sheets. Product gebruikt de ene class [`.glass`](../shared/glass.md).

**Diepte-lat:**

| Do | Don't (product) |
|----|-----------------|
| Spaarzame elevation op solid cards: contact (~1–3px) + eventueel soft mid — max één lifted laag | **Nooit** product-parallax (lagen op verschillende scroll-snelheid) |
| Hiërarchie via surface-ladder (base → surface → elevated) en borders | Glow / colored blur / `translateZ`-theater als diepte |
| Dark ≠ pure `#000`: ~layered off-black, soft off-white text, accents ~20% desaturate | Flat invert of pure white glare |
| Hover-lift alleen `(hover: hover) and (pointer: fine)` | Primary affordance of “premium depth” op touch via glow |

Elevation = spaarzame hiërarchie, geen showcase. Cards: [surfaces-cards](application/surfaces-cards.md). Hover-gate: [touch-targets](touch-targets.md).

## 2. Materials & skins (contract)

| Laag | Materiaal |
|------|-----------|
| Product header, tabbar, sheet chrome | [`.glass`](../shared/glass.md) — één class, geen tweede blur |
| Gepinde paginatitel | Zelfde liquid glass als de header, alleen terwijl de balk meevolgt (project-chrome) |
| Grouped content, tables, feed cards | **Solid** `surface` / `bg-card` |
| Notice / critical banners | Near-solid (≥ ~96% opacity) |

- Nooit light-glass op light-glass stacken (header glass + sticky live-bar glass → één van de twee solid of zwaarder materiaal).
- Per skin: glass opacity mag omhoog als habitat busy is; tekst over blur = vibrancy — geen flat muted gray.
- `prefers-reduced-transparency: reduce` → solidify chrome.
- `prefers-contrast: more` → near-solid + duidelijke border op chrome én cards.

Scroll-edge: blur/gradient fade onder sticky chrome i.p.v. harde 1px rule.
