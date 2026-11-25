# Desktop — principles

> **Role:** Why the showcase looks the way it does, and what we deliberately do not adopt.
> **Not here:** gate ([desktop.md](../desktop.md)).

Three principles, in this order. An effect that pushes the underlying story aside goes out.

## 1. Hierarchy

Two layers, always:

| Layer | What | Material |
|-------|------|----------|
| **Content** | Text, features, proof, photo, device mock | Solid `--card` / `--background`, or the image itself |
| **Functional** | Nav, toolbar, menu, one floating panel | [`.glass`](looks.md) |

Glass draws attention to the content underneath. It is not a texture for cards.

- One functional layer per viewport. A second glass surface on top is forbidden ([liquid-glass.md](liquid-glass.md)).
- At rest, content and glass do not touch: the first viewport keeps the title and CTA out of the bar. While scrolling, content may pass underneath; then the scroll edge applies.
- Colour in the content. Tint on glass only for the one primary action.

## 2. Harmony

One material, the same look everywhere. [looks.md](looks.md) is the only recipe.

- Same blur, highlight, shadow role and concentric radius on every showcase route.
- Controls in a group share one shape: all capsule, or all rounded rectangle. Do not mix within one bar.
- A menu grows out of its button. It is the same surface getting thicker, not a separate card from a corner.
- Bigger surface = thicker: deeper shadow, softer edge. The blur family stays that of `.glass`.

## 3. Consistency

Same place, same behaviour.

- Chrome on every showcase route: brand left, local links in the middle or next to it, primary action right. [chrome.md](chrome.md).
- Type roles are fixed. [type.md](type.md). No page with its own H1 size.
- Hover is extra. Click, keyboard and the narrow fallback do the same work. [a11y.md](../a11y.md).

## 4. Native Liquid Glass → web

Native Liquid Glass shifts from light to dark per pixel, and bends light through the system. On the web we do not imitate that with our own engine.

| Native behaviour | Ours |
|------------------|------|
| Regular glass adapts | `.glass` on the theme tokens (`theme-dark` / `theme-light`) |
| Small controls flip light/dark | Text on glass = `--foreground`, weight ≥ 600. No per-pixel flip |
| Clear over media | Only `.glass-clear`, three conditions in [liquid-glass.md](liquid-glass.md) |
| Lensing | Suggestion: blur + saturate + inset highlight + shadow. No SVG displacement as a base |
| Reduced transparency / contrast / motion | [a11y.md](../a11y.md) |

Public pages use the default theme tokens. A product skin may not drag the landing page to a different radius, uppercase title or neon accent.

## 5. What we do not import

- No LiquidKit, glass-refraction, or `@glass-sdk/liquid-glass`. WebGPU glass is out: Safari, battery, and the gate "the phone wins".
- No rainbow edge, chromatic aberration, or purple glow. That is kit style, not this look.
- No fake dock, menu bar or traffic lights as site chrome. A window frame is allowed only inside an explicit product mock.
- No fourth webfont. [materials-type](../../iphone/materials-type.md).

**Test:** a new showcase section can point to one layer (content or functional) and uses `.glass` or solid, not a third material.
