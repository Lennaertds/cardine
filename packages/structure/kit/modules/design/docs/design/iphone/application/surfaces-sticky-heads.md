# UI iPhone — surfaces · sticky section heads

> **Role:** Gliding headers inside `.surface` boxes.
> **Not here:** cards ([surfaces-cards](surfaces-cards.md)); states ([surfaces-states](surfaces-states.md)).

## K5. Sticky section heads (in-surface)

**Default: no sticky.** A short card or a big card title is one closed surface — title + body scroll together. `overflow: hidden` is fine for a closed border.

**Sticky only** if the header is an **interim title** above a **long, scrollable body** in the same box. Then the header sticks for a while so you know where you are.

### Contract (only when sticky)

| Part | Rule |
|------|------|
| **Parent** | `.surface.surface-sticky-board` — **no** `overflow: hidden` (breaks sticky) |
| **Head** | Sticky-head component + `.is-stuck` via scroll |
| **Pin top** | Below the page title / sticky chrome (`--nav-h` + title height) |
| **At rest** | Top corners = `--r-group`; bottom flush with the body |
| **Pinned (`.is-stuck`)** | **All four** corners `--r-group` + a light shadow; scroll-edge fade |
| **Material** | Card mix + blur (chrome-like, no second glass stack) — [materials-depth](../materials-depth.md) |

### Where sticky

Long boards / lists / chart surfaces with an interim title above a scrollable body.

### Where not sticky

- Page titles / chrome (they have their own pin)
- Short overview cards whose title is the whole card
- Progress / short tip / day cards

### Never

| Never | Instead |
|-------|---------|
| Sticky on every surface headline | Interim title + long body only |
| `overflow-hidden` on a **sticky** parent | `.surface-sticky-board` |
| Top radius only while pinned | `.is-stuck` full radius |
| Ad-hoc sticky / half radius | This primitive, or no sticky |

**Test:** Long list: the header pins under the page title. Short overview: the title scrolls along.
