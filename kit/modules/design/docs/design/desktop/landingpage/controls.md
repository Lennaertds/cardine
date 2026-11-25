# Desktop — controls

> **Role:** Buttons and choices on the showcase.
> **Not here:** product buttons ([controls.md](../../iphone/application/controls.md)).

Same destination as on the phone, with hover as an extra. The landing page shares its primary action with the narrow page, so the hit stays big enough for a finger.

## 1. Roles

| Role | Look | Count |
|------|------|-------|
| **Primary** | Accent tint from [looks.md](looks.md) §6, capsule, `--on-accent` | One per viewport |
| **Secondary** | Glass group or `--stroke` hairline, `--foreground` | As many as the bar groups |
| **Quiet** | Text link, no fill | Secondary reference, footer |
| **Icon** | Glyph 20–22px in a round or concentric hit | Only with a visible label or `aria-label` |

No third filled style (no outline accent next to a tint accent next to a solid accent).

## 2. Sizes

| Control | Min. height | When |
|---------|-------------|------|
| Primary | 44px | Always. The same button exists below the gate |
| Secondary in the bar | 36px with a fine pointer, 44px if it is the only hit on narrow | Chrome |
| Icon | 36×36 fine pointer, 44×44 otherwise | Only if there is a text alternative |
| Menu item | 32px high, horizontal padding 12px | The menu is pointer-dense, items stay roomy |

Horizontal padding of a text button: 16px (primary 20px if the label is short). Radius: capsule in a capsule group; otherwise the concentric formula.

## 3. Hover, press, disabled

Only under `(hover: hover) and (pointer: fine)`.

- Hover: inset highlight up, or fill `--foreground` at 8%. Duration 160–200ms, ease-out. No scale above 1.02. No lift that shifts neighbours.
- Press: scale 0.98, opacity slightly down. Releasing returns.
- Disabled: opacity 0.4, no hover, `aria-disabled` or `disabled`.
- Pending: the label stays, `…` at the end, button disabled. No spinner that makes the width jump.
- `cursor: pointer` on everything clickable. Disabled: `not-allowed`, opacity 0.4 (band 0.38–0.5), no hover.
- At least 8px between two hits.
- Press is visible within 100ms. The scale does not change the layout box.

Magnetic follow (the button creeps towards the cursor) is allowed on the primary CTA, behind the gate, at most a few pixels. The click zone stays the real button. [desktop.md](../desktop.md).

## 4. Choices

- 2–5 peers in the chrome: one segmented group, not loose pills plus a segmented control for the same.
- An on/off is a switch with a visible state, not a chip.
- Filter chips belong to the product, not to the landing page.

## 5. Menu from a button

The button morphs into the menu ([motion.md](motion.md), [overlays.md](overlays.md)). Menu items are not glass buttons. They are rows with a hover fill.

**Test:** on the landing page there is one filled primary button; hover does nothing on a touch device; the button is at least 44px high.
