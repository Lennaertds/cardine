# Desktop — liquid glass

> **Role:** Where the material lives, which variant, and what is never glass.
> **Not here:** the pixels ([looks.md](looks.md)); the class itself ([glass.md](../../shared/glass.md)).

Glass is the layer that floats. Content stays readable without blur.

## 1. Two variants, never mixed

One variant per page. A Regular bar and a Clear pill in the same viewport are forbidden.

### Regular — the default

- Every nav, toolbar, menu and at most one detail panel.
- Works over text, over colour and over imagery.
- Follows the theme. Large surfaces (sidebar, menu, panel) do not flip from light to dark while you scroll.

### Clear — only if all three hold

1. The surface sits on **media-rich** content (full-bleed photo or film, not a text column).
2. A dim layer under the glass does not hurt the image.
3. What sits **on** the glass is large and bright (wordmark, one button). No 13px caption.

If one condition fails: Regular, or solid.

Clear always carries a dim layer (`color-mix` towards black, about 28–40%). Without dim it is unreadable. A local dim (only under the surface) beats a page-wide veil.

## 2. Where glass is

| Element | Variant |
|---------|---------|
| Site nav | Regular |
| Group of toolbar buttons | Regular, same surface as the nav or one capsule inside it |
| Menu / popover | Regular, thicker (shadow role "panel") |
| One functional panel over media | Regular, or Clear if §1 holds |
| Primary CTA | Regular + accent tint, or solid accent if the button sits on calm content |

## 3. Where glass is not

- Feature columns, article text, tables, forms, lists, footer.
- A grid of glass cards.
- Text directly on a second glass layer (an item in a glass menu = fill or vibrancy, no own `backdrop-filter`).
- Product content, sheets, tables. Those stay [materials-depth](../../iphone/materials-depth.md): glass = chrome.

## 4. Layers (one class, fixed order)

A glass surface is this stack, nothing extra per page:

1. **Blur + saturate** — the background goes milky, not its own gradient.
2. **Tint** — `color-mix` of `--card` (Regular) or lower (Clear).
3. **Inset highlight** — a 0.5px light line along the top edge. That is the specular. No moving rainbow.
4. **Shadow** — separates the surface from text underneath. Heavier as the surface is bigger ([looks.md](looks.md) § shadow).
5. **Hairline** — 1px `--stroke` mixed with transparent, so the edge survives on a flat background.

Shadow gets heavier over busy content. On the web the default is the heavier shadow, because content scrolls underneath the bar.

## 5. Scroll edge

Content that passes under a glass bar dissolves, instead of stopping at a hard 1px line.

- Soft fade: mask or gradient at the bottom of the bar, about 12–20px.
- Dark content under the bar: the fade dims, it does not turn into a white haze.
- A pinned subheader uses a **hard** edge over the full height of bar + subheader, so the two read as one block.

## 6. Thickness on morph

A button that becomes a menu gets thicker:

- shadow from role "control" to role "panel";
- a slightly stronger tint (more `--card` in the mix);
- the blur family stays `.glass`.

No separate filter stack for the menu.

## 7. Rest versus interaction

At rest the surface is still. On hover or press the highlight lights up (slightly higher inset white). That is feedback, not a loop. Motion → [motion.md](motion.md).

**Test:** all showcase routes share one `.glass` class. Nowhere a second `backdrop-filter` on a card or list.

## 8. What we do not take from glassmorphism kits

[glassmorphism.com](https://glassmorphism.com/) and similar guides describe a loose recipe: a fixed `rgba` fill, a `1px solid rgba(255, 255, 255, 0.15)` border, and a mesh gradient behind it. That recipe does not enter the site.

- The fill stays `color-mix` on `--card`, not a loose white or black rgba.
- The border stays `--stroke`. The highlight is the inset of `.glass`, not a second white border.
- No mesh gradient as background. The page keeps `--background`, a photo, or solid content.
- `backdrop-filter` and `-webkit-backdrop-filter` stay the pair from `.glass` (`saturate` + `blur`). A second blur value is forbidden.
