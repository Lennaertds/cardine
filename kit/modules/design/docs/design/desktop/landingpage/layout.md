# Desktop — layout

> **Role:** Column, rhythm and reflow for every showcase page.
> **Not here:** typography ([type.md](type.md)); material ([liquid-glass.md](liquid-glass.md)).

## 1. Page template

Every showcase route, top to bottom:

1. **Chrome** — one floating glass bar ([chrome.md](chrome.md)).
2. **First viewport** — one job: understand where you are.
3. **Sections** — a vertical stack. One scroll, no nested scroll containers.
4. **Footer** — the same site footer. No second footer inside a section.

The bar floats above the content. Content may pass underneath. Interactive text stays in the safe zone: at least the bar height + 16px free at the top of the first viewport.

## 2. Widths

| Name | Size | What |
|------|------|------|
| narrow | &lt; 768px | One column. No pins, no parallax. Same sections, stacked |
| regular | 768–1279px | One content column, roomier gutter |
| wide | ≥ 1280px | The design width. A diptych may |

| Measure | Value |
|---------|-------|
| Content column | `max-width: 72rem` (1152px), centred |
| Prose | 65–72ch, left-aligned |
| Hero claim | max ~18ch, or 40rem if the line has to be longer |
| Gutter 768–1023 | 24px |
| Gutter 1024–1279 | 32px |
| Gutter ≥ 1280 | 40px |
| Full-bleed image | May leave the column, out to the viewport. Text stays in the column |

No third column. A sidebar counts as chrome, not as an extra content column ([chrome.md](chrome.md) § sidebar).

## 3. Space — 8px, details at 4px

These steps only. No `13px` or `22px` margins.

| Step | px | Typically |
|------|----|-----------|
| 1 | 4 | Hairline correction, highlight |
| 2 | 8 | Icon to label |
| 3 | 12 | Inside a compact group |
| 4 | 16 | Label to field, title to lede |
| 5 | 24 | Regular gutter, card padding |
| 6 | 32 | Lede to CTA, heading to grid |
| 7 | 48 | Inside a light section |
| 8 | 64 | Between light sections |
| 9 | 80 | Section padding below 1280 |
| 10 | 96 | Section padding ≥ 1280 |
| 11 | 120 | After a heavy section |

Vertical padding of a section: 96px from 1280, 80px below that. After a heavy section (proof, long prose) 120px.

Never two heavy sections directly after each other.

## 4. Alignment

- Text in a section shares one left line.
- A diptych is 6/6 or 7/5. No 8/4 where the text column gets narrower than 36ch.
- Buttons in a row: 8px or 12px between them. Primary button left in a text block, right in the chrome.
- Centring is allowed for a hero claim on wide. Body never centred.
- Columns in a feature row do not share height by stretching the text. The headings line up; the body ends where it ends.

## 5. First viewport

- Height: `min-height: 100dvh` on the hero section is fine. Not `100vh`.
- At 1280×800 the claim, lede, one primary CTA and the image still fit, without the CTA falling below the fold.
- The image is the product (device mock or the real scene), not a stock photo.

## 6. Proximity and CSS

What belongs together sits closer than what merely sits on the same page. Inside a group space comes first; a line only if the group does not read otherwise (menu row, hairline on glass).

CSS is mobile-first: the narrow column is the base, `min-width` adds the diptych and the gate extras. Desktop-first media queries that "strip off" the phone are out.

Lengths in `rem`, except 1px hairlines and the blur in px. `1rem` stays 16px. Do not put the root at 62.5%.

Images: `max-width: 100%`, fixed `aspect-ratio`. The page itself does not scroll horizontally. A horizontal snap may have its own track, with a visible way to continue.

Check widths: 375, 768, 1024, 1280, 1440. Landscape on a phone stays one column and readable.

The sticky bar does not cover content: the first section and `scroll-margin` keep bar height + 16px free.

## 7. Reflow

- wide → regular: the diptych becomes a stack, image below the text. Feature rows may wrap or become a horizontal snap with clear scrolling.
- regular → narrow: same order, one column, chrome becomes the narrow guest chrome. No horizontal story that only works with a mouse.
- The window may be any width ≥ 768. No fixed "1440 only".

**Test:** at 1440, 1280, 1024, 768 and 375 the landing page shares one content column of max 72rem; gutters are 40 / 32 / 24 from 1280 down; no measure outside the table; no horizontal page scroll.
