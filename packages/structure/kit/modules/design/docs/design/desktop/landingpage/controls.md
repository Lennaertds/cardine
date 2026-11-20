# Desktop — controls

> **Rol:** Knoppen en keuzes op de showcase.  
> **Niet hier:** product-knoppen ([controls.md](../../iphone/application/controls.md)).

Zelfde bestemming als op de telefoon, met hover als extra. De landing deelt haar primaire actie met de smalle pagina, dus de treffer blijft groot genoeg voor een vinger.

## 1. Rollen

| Rol | Look | Aantal |
|-----|------|--------|
| **Primary** | Accent-tint uit [looks.md](looks.md) §6, capsule, `--on-accent` | Eén per viewport |
| **Secondary** | Glazen groep of haarlijn `--stroke`, `--foreground` | Zoveel als de balk groept |
| **Quiet** | Tekstlink, geen vulling | Secundaire verwijzing, footer |
| **Icon** | Glyph 20–22px in een ronde of concentrische hit | Alleen met zichtbaar label of `aria-label` |

Geen derde gevulde stijl (geen outline-accent naast een tint-accent naast een solid-accent).

## 2. Maten

| Control | Min. hoogte | Wanneer |
|---------|-------------|---------|
| Primary | 44px | Altijd. Dezelfde knop bestaat onder de gate |
| Secondary in de balk | 36px bij fijne pointer, 44px als het de enige treffer op narrow is | Chrome |
| Icon | 36×36 fine pointer, 44×44 anders | Alleen als er een tekst-alternatief is |
| Menu-item | 32px hoog, padding horizontaal 12px | Menu is pointer-dicht, items blijven ruim |

Padding horizontaal van een tekstknop: 16px (primary 20px als het label kort is). Radius: capsule in een capsule-groep; anders de concentrische formule.

## 3. Hover, press, disabled

Alleen onder `(hover: hover) and (pointer: fine)`.

- Hover: inset-glans omhoog, of fill `--foreground` op 8%. Duur 160–200ms, ease-out. Geen scale boven 1.02. Geen lift die buren verschuift.
- Press: scale 0.98, opacity iets omlaag. Loslaten keert terug.
- Disabled: opacity 0.4, geen hover, `aria-disabled` of `disabled`.
- Pending: label blijft, achteraan `…`, knop disabled. Geen spinner die de breedte laat springen.
- `cursor: pointer` op alles wat klikt. Disabled: `not-allowed`, opacity 0.4 (band 0.38–0.5), geen hover.
- Minimaal 8px tussen twee treffers.
- Press is zichtbaar binnen 100ms. De schaal verandert de layout-box niet.

Magnetic follow (de knop kruipt naar de cursor) mag op de primaire CTA, achter de gate, hooguit een paar pixels. De klikzone blijft de echte knop. [desktop.md](../desktop.md).

## 4. Keuzes

- 2–5 peers in de chrome: één segmented groep, niet losse pills plus een segmented voor hetzelfde.
- Een aan/uit is een switch met zichtbare staat, geen chip.
- Filterchips horen bij het product, niet op de landing.

## 5. Menu vanuit een knop

De knop morph’t naar het menu ([motion.md](motion.md), [overlays.md](overlays.md)). Items in het menu zijn geen glazen knoppen. Ze zijn rijen met hover-fill.

**Test:** op de landing is er één gevulde primaire knop; hover doet niets op een touch-device; de knop is minstens 44px hoog.
