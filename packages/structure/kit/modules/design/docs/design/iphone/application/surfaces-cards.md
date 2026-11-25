# UI iPhone — surfaces · cards

> **Role:** When to use a card and when not to.
> **Not here:** empty, loading and error states ([surfaces-states](surfaces-states.md)); sticky headers ([surfaces-sticky-heads](surfaces-sticky-heads.md)).

## K1. Taxonomy

| Kind | When |
|------|------|
| **Grouped list** | Settings/Profile rows, lists |
| **Summary card** | Day or status summary — one job per card |
| **Insight / tip card** | Tips — solid, no glass |
| **Overview card** | Short overview — **no** sticky; a closed border is OK |
| **Item / set card** | Repeated logger or feed items |
| **Feed post** | Feed-like cards |
| **No card** | A single paragraph, an empty state, form fields in a sheet |

**Rule:** if removing border+radius+bg does not hurt understanding → **no** card.

## K2. Material

- Content cards = **solid** `surface` / `bg-card` — [materials-depth](../materials-depth.md).
- Glass only for chrome/sheets — never on dense content rows.
- **Nested radius:** inner = outer − padding. Ladder e.g. 4 · 8 · 12 · 16 · 24.
- **Hover lift:** only `(hover: hover) and (pointer: fine)`; the footprint stays.

## K3. Boards (calendar / timelines)

Where the product has boards:

- Sticky mid-headers only through [surfaces-sticky-heads](surfaces-sticky-heads.md).
- Dense chips 36–40 are OK.
- Local z inside the board — **no** overlay `--z-*`.
- Past/inactive items at lower contrast; current/future clear.

## K4. Never

| Never | Instead |
|-------|---------|
| A card around every paragraph | SectionBlock or plain |
| Glass on dense content rows | Solid surface |
| A dashboard of 6 cards in the first viewport | One job |
| Whole-card `scale` (breaks the grid) | Lift/shadow within a fixed footprint |
| Glow / coloured blur as card depth | Solid + sparse elevation ([materials-depth](../materials-depth.md)) |
