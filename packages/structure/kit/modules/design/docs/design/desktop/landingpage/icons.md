# Desktop — icons

> **Role:** One icon family on the showcase.
> **Not here:** product icons and fonts ([materials-type](../../iphone/materials-type.md)).

Icons help the text. They do not replace it, except where the icon is a standard action (close, menu) **with** an `aria-label`.

## 1. One family

- SVG. No JPG, PNG or emoji as an icon.
- The same family as the product UI. No second pack on showcase routes.
- One stroke in the same layer: **1.75**. Stroke corners follow the family, not differently per icon.
- **Fill vs outline set-wide:** rest = outline across the whole showcase set. Filled only for an active state in that same family. Not outline and filled mixed on one bar.
- Colour: `currentColor`. Accent only if the icon sits **inside** the primary button.
- Sizes (**optical size**), no freestyling: **16** meta, **20** in the bar, **24** next to a section title. Bigger than 24: put the icon in a shape, do not stretch the glyph.
- **Fixed bounding box** per size (viewBox/hit area the same within 16, within 20, within 24). Centre glyphs in that box; no per-icon crop that makes the row jump.

## 2. When

- Next to an action, with a label, unless the action is close or an equally obvious standard.
- As a bullet only if every bullet has the same weight and the text works without the icon too.
- Decor next to a visible label: `aria-hidden="true"`.
- An icon that carries the meaning itself: a text alternative. A control also announces its state (open, selected).

## 3. Alignment

Icon and label share one vertical axis. Gap 8px. The icon does not jump when the row hovers.

A brand logo (LinkedIn, GitHub) stays the official mark, in `currentColor` or the original monochrome form. Do not redraw, do not stretch.

**Test:** on the showcase every icon comes from one family, at 16, 20 or 24px, and nowhere is an emoji used as a button.
