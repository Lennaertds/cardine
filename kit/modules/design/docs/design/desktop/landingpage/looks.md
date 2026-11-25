# Desktop — looks

> **Role:** The one visual recipe. Every showcase page uses these values.
> **Not here:** the class itself ([glass.md](../../shared/glass.md)).

No page-local blur, shadow or radius. A deviation goes in as a modifier in `globals.css`, then into this file.

## 1. Colour roles

Only these tokens. No hex in a showcase component.

| Role | Token | Use |
|------|-------|-----|
| Page | `--background` | Base of the content layer |
| Text | `--foreground` | Titles, body, labels on glass |
| Secondary | `--muted` | Meta, caption. Never the lede |
| Action | `--accent` / `--on-accent` | Exactly one primary action per viewport |
| Surface | `--card` | Solid content **and** the tint in `.glass` |
| Border | `--stroke` | Hairline on glass and on solid surfaces |
| Scrim | `--sheet-scrim` | Behind a dialog |

Accent in at most a few places per page: the primary button, text links, one marker. A feature column does not colour its whole column accent.

Text is never `#000` or `#fff`. Light and dark are one pair: both reach 4.5:1 on body, and a border visible in light stays visible in dark. An error or success colour always comes with a word or icon.

Hover may make the shadow one step heavier (control to slightly deeper), without shifting the layout. No coloured glow on hover.

The public showcase follows `theme-dark` / `theme-light`. Product skins do not reskin the guest landing page.

## 2. Glass

The class, the hairline and Clear are in [glass.md](../../shared/glass.md). This file does not repeat the numbers. Shadow roles and radius below belong to the landing page.

## 3. Shadow roles

Same colour (`#000` via `color-mix`). Only the depth changes.

| Role | Shadow | For |
|------|--------|-----|
| **control** | `0 4px 16px` · 22% | Loose pill, icon button |
| **bar** | `0 10px 28px` · 18% light / 35% dark | Nav, toolbar — the `.glass` default |
| **panel** | `0 16px 40px` · 32% | Menu, dialog, detail panel |

No coloured glow, no `0 0 40px var(--accent)`.

## 4. Radius — concentric

Inner radius = outer radius minus the padding. Never a hardcoded second corner.

```css
inner-radius = max(0px, outer-radius - padding);
```

| Shape | When | Radius |
|-------|------|--------|
| Capsule | Nav cluster, segmented, primary pill | `999px` on outside **and** inside |
| Rounded rectangle | Panels, menus, content surfaces | `--r-group` outside; inside via the formula |
| Device mock | iPhone or window frame | `--r-device` |

Showcase groups follow the same concentric pattern as product chrome.

A capsule group gets no child with `--r-group`. A rectangular panel gets no `rounded-full` button that fights the corner, unless the button floats loose **outside** the panel.

## 5. Vibrancy on glass

Text and icons on Regular:

- colour `--foreground`, not `--muted`, not a grey in hex;
- weight 600 for labels, 650 for the active state;
- tracking slightly looser than body (`0.01em`), or the size tracking from [type.md](type.md) if it is a title.

Icons: `currentColor`. No own fill colour per icon.

## 6. Tint on the primary action

The primary button may let accent run through the glass:

```css
background: color-mix(in oklab, var(--accent) 88%, transparent);
color: var(--on-accent);
```

A fully opaque `background: var(--accent)` on a glass bar breaks the material. Either the button sits **inside** the glass group with this tint, or it stands loose as a solid pill on calm content. One of the two per viewport.

Secondary buttons get no accent fill.

## 7. Gradients — ambiance

A gradient is allowed only as soft ambiance **behind** the content layer (page base, photo scrim, scroll-edge fade). Never as proof, never as a text fill, never as an AI blob behind the hero.

- Only **neighbouring hues** in the theme. No jump to purple, indigo or neon.
- **Lightness in one direction** — lighter → darker or the reverse. No multi-stop "mesh".
- Content stays on solid or photo; the gradient sits behind it, not over it as a glow.
- Prohibited: purple/indigo glow, AI blob, rainbow edge, gradient text — [never-checklist.md](never-checklist.md).

## 8. Prohibited looks

| Prohibited | Why |
|------------|-----|
| Purple/indigo glow, AI blob, gradient text | Off-brand; [never-checklist](never-checklist.md) |
| Mesh gradient, rainbow edge, prismatic dispersion | Kit effect; [never.md](../../shared/never.md) |
| Glass card grid | The content layer becomes a functional layer |
| Per-page `backdrop-filter` | The look drifts |
| Traffic lights, dock, faux menu bar as site chrome | Cosplay. Only inside a product mock |
| A second shadow colour | The roles above are complete |

**Test:** computed `backdrop-filter` on the nav of every showcase route is `saturate(1.9) blur(40px)`. No other blur on those pages, except a documented scroll-edge fade.
