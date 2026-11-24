# UI iPhone — surfaces · sticky section heads

> **Rol:** Gliding koppen binnen `.surface`-vakken.  
> **Niet hier:** kaarten ([surfaces-cards](surfaces-cards.md)); staten ([surfaces-states](surfaces-states.md)).

## K5. Sticky section heads (in-surface)

**Standaard: geen sticky.** Een korte kaart of een grote kaarttitel is één gesloten surface — titel + body scrollen mee. Mag `overflow: hidden` voor een dichte rand.

**Sticky alleen** als de kop een **tussentitel** is boven een **lange, scrollbare body** in hetzelfde vak. Dan blijft de kop even plakken zodat je weet waar je bent.

### Contract (alleen als sticky)

| Deel | Regel |
|------|--------|
| **Parent** | `.surface.surface-sticky-board` — **geen** `overflow: hidden` (breekt sticky) |
| **Head** | Sticky-head component + `.is-stuck` via scroll |
| **Pin top** | Onder page-title / sticky chrome (`--nav-h` + title-hoogte) |
| **At rest** | Bovenhoeken = `--r-group`; onderkant aansluitend op body |
| **Pinned (`.is-stuck`)** | **Alle vier** hoeken `--r-group` + lichte shadow; scroll-edge fade |
| **Materiaal** | Card-mix + blur (chrome-achtig, geen tweede glass-stack) — [materials-depth](../materials-depth.md) |

### Waar sticky

Lange boards / lijsten / chart-surfaces met tussentitel boven scrollbare body.

### Waar geen sticky

- Page-titles / chrome (eigen pin)
- Korte overview-kaarten waarvan de titel de hele kaart is
- Progress / short tip / day cards

### Niet

| Never | Instead |
|-------|---------|
| Sticky op elke surface-headline | Alleen tussentitel + lange body |
| `overflow-hidden` op een **sticky** parent | `.surface-sticky-board` |
| Alleen top-radius terwijl pinned | `.is-stuck` full radius |
| Ad-hoc sticky / half-radius | Deze primitive of géén sticky |

**Test:** Lange list: kop pin’t onder page-title. Korte overview: titel scrollt mee.
