# Desktop — never ship

> **Role:** What may not go on the showcase, plus the review.
> **Not here:** site-wide ([never.md](../../shared/never.md)); product never ([iphone/never-checklist.md](../../iphone/never-checklist.md)).

## 1. Never

| Never | Instead |
|-------|---------|
| Second `backdrop-filter` with a different blur | `.glass` from [looks.md](looks.md) |
| Glass card grid, glass on features or on prose | Solid content layer |
| Regular and Clear mixed | One variant per page |
| Clear without dim, or Clear on text | Regular, or the three conditions |
| Rainbow edge, purple glow, gradient text | Specular hairline, tokens |
| Traffic lights or a dock as site chrome | Only inside a product mock |
| Own hex or a fourth font | Tokens, `--font-sans` / display behind the gate |
| `100vh` on the shell | `100dvh` at most on the hero section |
| `transition: all`, `scale(0)`, `ease-in` | [motion.md](motion.md) |
| Hover-only content | Click, keyboard, or text in the section |
| GSAP or Lenis in the product bundle | Showcase gate |
| Fake MAU, dummy quotes | Real or anonymous demo |
| A skin that reskins the guest landing page | Default theme tokens |
| Menu from the bottom on wide | Menu out of the button |
| Loose `z-[n]` | `var(--z-*)` |
| Per-letter stagger, endless highlight loop | Still at rest |
| Three filled button styles | Primary, secondary, quiet |
| Emoji, second icon pack, stock image | [icons.md](icons.md), [images.md](images.md) |
| Blue links, underline on non-links | Prose link = accent + underline ([ux.md](ux.md)) |
| Animating `width` / `height` / `top` / `left` | `transform`, `opacity`, `filter` |
| Pie chart, chart without a unit | [charts.md](charts.md) |
| Image without a reserved ratio | [performance.md](../performance.md) |
| Root `font-size: 62.5%` | `1rem` = 16px |

## 2. Review

0. Which row in [DESIGN.md](../../DESIGN.md)? One file.
1. Gate: extras only ≥ 768px, fine pointer, no reduced-motion.
2. One functional layer. Content solid.
3. Look = `.glass` + shadow role + concentric radius.
4. One primary action, the same destination in the bar and the hero.
5. Type roles from [type.md](type.md). Product ladder untouched.
6. Reduced-motion = end state. Reduced-transparency = solid. Focus ring on.

Output of a visual review: a **Before | After | Why** table.

## 3. Done

- [ ] A coverage row exists.
- [ ] No new blur, radius or shadow outside [looks.md](looks.md).
- [ ] The test sentence of that one craft file is green.
- [ ] Narrow and reduced-motion checked.
- [ ] The product path did not get heavier (no showcase library in the product bundle).

## 4. Elsewhere

- Gate and catalogue → [desktop.md](../desktop.md).
- Product craft → [DESIGN.md](../../DESIGN.md) (application).
