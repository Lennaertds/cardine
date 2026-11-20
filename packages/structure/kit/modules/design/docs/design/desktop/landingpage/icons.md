# Desktop — icons

> **Rol:** Eén icoonfamilie op de showcase.  
> **Niet hier:** product-iconen en fonts ([materials-type](../../iphone/materials-type.md)).

Iconen helpen de tekst. Ze vervangen hem niet, behalve waar het icoon een standaardactie is (sluiten, menu) mét `aria-label`.

## 1. Eén familie

- SVG. Geen JPG, PNG of emoji als icoon.
- Dezelfde familie als de product-UI. Geen tweede pack op showcase-routes.
- Eén stroke in dezelfde laag: **1.75**. Hoeken van de stroke volgen de familie, niet per icoon anders.
- **Fill vs outline set-wide:** rust = outline over de hele showcase-set. Filled alleen voor een actieve staat in diezelfde familie. Niet outline en filled door elkaar op één balk.
- Kleur: `currentColor`. Accent alleen als het icoon ín de primaire knop staat.
- Maten (**optical size**), niet freestylen: **16** meta, **20** in de balk, **24** naast een sectietitel. Groter dan 24: het icoon in een vorm zetten, niet het glyph oprekken.
- **Fixed bounding box** per maat (viewBox/hit-area gelijk binnen 16, binnen 20, binnen 24). Glyphs centreren in die box; geen per-icoon crop die de rij laat verspringen.

## 2. Wanneer

- Naast een actie, met label, tenzij de actie sluiten of een even duidelijke standaard is.
- Als bullet alleen als elke bullet hetzelfde gewicht heeft en de tekst ook zonder icoon klopt.
- Decor naast een zichtbaar label: `aria-hidden="true"`.
- Icoon dat zelf de betekenis draagt: tekstalternatief. Een control kondigt ook staat aan (open, geselecteerd).

## 3. Uitlijning

Icoon en label delen één verticale as. Gap 8px. Het icoon verspringt niet als de rij hovert.

Een merklogo (LinkedIn, GitHub) blijft het officiële teken, in `currentColor` of de oorspronkelijke monochrome vorm. Niet hertekenen, niet uitrekken.

**Test:** op de showcase komt elk icoon uit één familie, op 16, 20 of 24px, en nergens staat een emoji als knop.
