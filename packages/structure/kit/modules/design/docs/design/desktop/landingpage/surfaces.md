# Desktop — surfaces

> **Role:** When a surface is solid, and when it is the one glass panel.
> **Not here:** the material ([liquid-glass.md](liquid-glass.md)); cards in the app ([surfaces-cards](../../iphone/application/surfaces-cards.md)).

The content layer is calm and opaque. Glass is the exception, and there is one.

## 1. Solid

These stay `--card` or plain `--background`, with `--r-group` if they have an edge:

- feature columns;
- prose blocks;
- the proof list and chart;
- forms;
- the footer;
- rows in a menu (the menu scale is glass; the row is a fill).

Row padding roomier than on the phone: at least 12px vertical, 16px horizontal. Section headings in title case, not uppercase.

A hairline or a shift from `--background` to `--card` separates sections. No card soup to make the page look "finished".

## 2. The one glass panel

Allowed as a functional layer:

- the site bar;
- a menu;
- a dialog;
- at most one detail panel over media.

Not two of the last three at once. The bar may stay while a menu is open, because the menu grows out of the bar and is the same layer — the items inside it are not a second `backdrop-filter`.

## 3. Detail panel over a photo

The photo is the content. The panel is the one glass surface.

- If the text on Regular glass does not reach enough contrast: a solid reading surface **inside** the panel (`--card` ≥ 96% opacity), not a second blur.
- No glass cards around text blocks.
- Hotspots are controls ([controls.md](controls.md)), not glass stickers.

## 4. Empty, loading, error

Rare on the showcase. If a demo block fails:

- one sentence in body type, `--foreground`;
- no illustration library, no glass empty card;
- the rest of the sections stays.

Product empty/loading stays [surfaces-states](../../iphone/application/surfaces-states.md).

## 5. Imagery

- Device mock: `--r-device`, shadow role panel, no glass-on-glass on the mock's screen.
- Photos: real product or scene images. No stock, no neon overlay.
- A full-bleed photo may carry Clear glass only if [liquid-glass.md](liquid-glass.md) §1 holds.
- Text on a photo: one method from [images.md](images.md) §2.

**Test:** on the landing page no feature column has a `backdrop-filter`. The only glass is the bar (and a menu when it is open).
