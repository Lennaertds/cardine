# Desktop — layout

> **Rol:** Kolom, ritme en reflow voor elke showcase-pagina.  
> **Niet hier:** typografie ([type.md](type.md)); materiaal ([liquid-glass.md](liquid-glass.md)).

## 1. Pagina-mal

Elke showcase-route, van boven naar onder:

1. **Chrome** — één zwevende glazen balk ([chrome.md](chrome.md)).
2. **Eerste viewport** — één taak: begrijpen waar je bent.
3. **Secties** — verticale stapel. Eén scroll, geen geneste scrollcontainers.
4. **Footer** — dezelfde site-footer. Geen tweede footer in een sectie.

De balk zweeft boven de content. Content mag eronder door. Interactieve tekst blijft in de veilige zone: minstens de balkhoogte + 16px vrij aan de bovenkant van de eerste viewport.

## 2. Breedtes

| Naam | Maat | Wat |
|------|------|-----|
| narrow | &lt; 768px | Eén kolom. Geen pins, geen parallax. Zelfde secties, gestapeld |
| regular | 768–1279px | Eén contentkolom, ruimere gutter |
| wide | ≥ 1280px | De ontwerpbreedte. Tweeluik mag |

| Maat | Waarde |
|------|--------|
| Contentkolom | `max-width: 72rem` (1152px), gecentreerd |
| Proza | 65–72ch, links uitgelijnd |
| Hero-claim | max ~18ch, of 40rem als de regel langer moet |
| Gutter 768–1023 | 24px |
| Gutter 1024–1279 | 32px |
| Gutter ≥ 1280 | 40px |
| Full-bleed beeld | Mag de kolom uit, tot de viewport. Tekst blijft in de kolom |

Geen derde kolom. Een sidebar telt als chrome, niet als extra contentkolom ([chrome.md](chrome.md) § sidebar).

## 3. Ruimte — 8px, details op 4px

Alleen deze stappen. Geen `13px` of `22px` margin.

| Stap | px | Typisch |
|------|----|---------|
| 1 | 4 | Haarlijn-correctie, glans |
| 2 | 8 | Icoon tot label |
| 3 | 12 | Binnen een compacte groep |
| 4 | 16 | Label tot veld, titel tot lede |
| 5 | 24 | Gutter regular, kaart-padding |
| 6 | 32 | Lede tot CTA, kop tot grid |
| 7 | 48 | Binnen een lichte sectie |
| 8 | 64 | Tussen lichte secties |
| 9 | 80 | Sectie-padding onder 1280 |
| 10 | 96 | Sectie-padding ≥ 1280 |
| 11 | 120 | Na een zware sectie |

Verticale padding van een sectie: 96px vanaf 1280, 80px daaronder. Na een zware sectie (bewijs, lange proza) 120px.

Twee zware secties nooit direct na elkaar.

## 4. Uitlijning

- Tekst in een sectie deelt één linkerlijn.
- Een tweeluik is 6/6 of 7/5. Geen 8/4 waar de tekstkolom smaller wordt dan 36ch.
- Knoppen in een rij: 8px of 12px ertussen. Primaire knop links in een tekstblok, rechts in de chrome.
- Centreren mag voor een hero-claim op wide. Body nooit gecentreerd.
- Kolommen in een feature-rij delen hoogte niet door de tekst uit te rekken. De koppen staan op één lijn; de body eindigt waar ze eindigt.

## 5. Eerste viewport

- Hoogte: `min-height: 100dvh` op de hero-sectie mag. `100vh` niet.
- Op 1280×800 passen claim, lede, één primaire CTA en het beeld nog in beeld, zonder dat de CTA onder de fold valt.
- Het beeld is het product (device-mock of de echte scène), geen stockfoto.

## 6. Nabijheid en CSS

Wat bij elkaar hoort, staat dichterbij dan wat alleen op dezelfde pagina staat. Binnen een groep eerst ruimte, een lijn alleen als de groep anders niet leest (menu-rij, haarlijn op glas).

CSS is mobile-first: de smalle kolom is de basis, `min-width` voegt het tweeluik en de gate-extras toe. Desktop-first media queries die de telefoon “eraf halen” zijn af.

Lengtes in `rem`, behalve 1px-haarlijnen en de blur in px. `1rem` blijft 16px. De root niet op 62.5% zetten.

Beelden: `max-width: 100%`, vaste `aspect-ratio`. De pagina zelf scrollt niet horizontaal. Een horizontale snap mag een eigen baan hebben, met een zichtbare manier om verder te gaan.

Checkbreedtes: 375, 768, 1024, 1280, 1440. Landscape op een telefoon blijft één kolom en leesbaar.

De sticky balk dekt inhoud niet af: de eerste sectie en `scroll-margin` houden balkhoogte + 16px vrij.

## 7. Reflow

- wide → regular: tweeluik wordt stapel, beeld onder de tekst. Feature-rijen mogen wrappen of een horizontale snap met duidelijke scroll.
- regular → narrow: zelfde volgorde, één kolom, chrome wordt de smalle gast-chrome. Geen horizontaal verhaal dat alleen met de muis werkt.
- Venster mag elke breedte ≥ 768. Geen vaste “alleen 1440”.

**Test:** op 1440, 1280, 1024, 768 en 375 deelt de landing één contentkolom van max 72rem; gutters zijn 40 / 32 / 24 vanaf 1280; geen maat buiten de tabel; geen horizontale scroll van de pagina.
