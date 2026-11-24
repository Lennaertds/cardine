# UI iPhone — surfaces · cards

> **Rol:** Wanneer wel/geen card.  
> **Niet hier:** lege, ladende en foutstaten ([surfaces-states](surfaces-states.md)); sticky koppen ([surfaces-sticky-heads](surfaces-sticky-heads.md)).

## K1. Taxonomie

| Soort | Wanneer |
|-------|---------|
| **Grouped list** | Settings/Profile-rijen, lijsten |
| **Summary card** | Dag- of statussamenvatting — één job per card |
| **Insight / tip card** | Tips — solid, geen glass |
| **Overview card** | Korte overview — **geen** sticky; gesloten rand OK |
| **Item / set card** | Herhaalde logger- of feed-items |
| **Feed post** | Feed-achtige kaarten |
| **Geen card** | Enkele alinea, empty state, form fields in sheet |

**Regel:** als border+radius+bg weghalen het begrip niet schaadt → **geen** card.

## K2. Materiaal

- Content cards = **solid** `surface` / `bg-card` — [materials-depth](../materials-depth.md).
- Glass alleen chrome/sheets — nooit op dichte content-rijen.
- **Nested radius:** inner = outer − padding. Ladder bv. 4 · 8 · 12 · 16 · 24.
- **Hover-lift:** alleen `(hover: hover) and (pointer: fine)`; footprint blijft.

## K3. Boards (kalender / tijdlijnen)

Waar het product boards heeft:

- Sticky mid-heads alleen via [surfaces-sticky-heads](surfaces-sticky-heads.md).
- Dense chips 36–40 OK.
- Locale z binnen board — géén overlay `--z-*`.
- Past/inactive items lager contrast; huidige/toekomst helder.

## K4. Never

| Never | Instead |
|-------|---------|
| Card om elke paragraaf | SectionBlock of plain |
| Glass op dense content-rijen | Solid surface |
| Dashboard van 6 cards first viewport | Eén job |
| Whole-card `scale` (grid breekt) | Lift/shadow binnen vaste footprint |
| Glow / colored blur als card-diepte | Solid + spaarzame elevation ([materials-depth](../materials-depth.md)) |
