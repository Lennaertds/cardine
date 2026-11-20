# Desktop — principles

> **Rol:** Waarom de showcase er zo uitziet, en wat we bewust niet overnemen.  
> **Niet hier:** gate ([desktop.md](../desktop.md)).

Drie principes, in deze volgorde. Een effect dat het onderliggende verhaal wegduwt, gaat eruit.

## 1. Hiërarchie

Twee lagen, altijd:

| Laag | Wat | Materiaal |
|------|-----|-----------|
| **Content** | Tekst, features, bewijs, foto, device-mock | Solid `--card` / `--background`, of het beeld zelf |
| **Functioneel** | Nav, toolbar, menu, één zwevend paneel | [`.glass`](looks.md) |

Glas trekt de aandacht naar de content eronder. Het is geen textuur voor kaarten.

- Eén functionele laag per viewport. Een tweede glasvlak erboven is verboden ([liquid-glass.md](liquid-glass.md)).
- In rust raken content en glas elkaar niet: de eerste viewport houdt titel en CTA uit de balk. Tijdens scroll mag content eronder door; dan geldt de scroll-edge.
- Kleur in de content. Tint op glas alleen voor de ene primaire actie.

## 2. Harmonie

Eén materiaal, overal dezelfde look. [looks.md](looks.md) is de enige receptuur.

- Zelfde blur, glans, schaduwrol en concentrische radius op elke showcase-route.
- Controls in een groep delen één vorm: alles capsule, of alles afgeronde rechthoek. Niet mengen in één balk.
- Een menu groeit uit zijn knop. Het is hetzelfde vlak dat dikker wordt, geen losse kaart uit een hoek.
- Groter vlak = dikker: diepere schaduw, zachtere rand. De blur-familie blijft die van `.glass`.

## 3. Consistentie

Zelfde plek, zelfde gedrag.

- Chrome op elke showcase-route: merk links, lokale links midden of daarnaast, primaire actie rechts. [chrome.md](chrome.md).
- Type-rollen staan vast. [type.md](type.md). Geen pagina met een eigen H1-grootte.
- Hover is extra. Klik, toetsenbord en de smalle fallback doen hetzelfde werk. [a11y.md](../a11y.md).

## 4. Native Liquid Glass → web

Native Liquid Glass flitst van licht naar donker per pixel, en buigt licht via het systeem. Op het web doen we dat niet na met een eigen engine.

| Native gedrag | Bij ons |
|---------------|---------|
| Regular-glas past zich aan | `.glass` op de theme-tokens (`theme-dark` / `theme-light`) |
| Kleine controls flippen light/dark | Tekst op glas = `--foreground`, weight ≥ 600. Geen per-pixel flip |
| Clear over media | Alleen `.glass-clear`, drie voorwaarden in [liquid-glass.md](liquid-glass.md) |
| Lensing | Suggestie: blur + saturate + inset-glans + schaduw. Geen SVG-displacement als basis |
| Reduced transparency / contrast / motion | [a11y.md](../a11y.md) |

Publieke pagina’s gebruiken de default theme-tokens. Een product-skin mag de landing niet naar een andere radius, uppercase-titel of neon-accent trekken.

## 5. Wat we niet importeren

- Geen LiquidKit, glass-refraction, of `@glass-sdk/liquid-glass`. WebGPU-glas valt af: Safari, batterij, en de gate “gsm wint”.
- Geen regenboog-rand, chromatic aberration, of paarse glow. Dat is kit-stijl, niet deze look.
- Geen nepdock, menu-balk of stoplichten als site-chrome. Een vensterframe mag alleen binnen een expliciete product-mock.
- Geen vierde webfont. [materials-type](../../iphone/materials-type.md).

**Test:** een nieuwe showcase-sectie kan wijzen naar één laag (content of functioneel) en gebruikt `.glass` of solid, niet een derde materiaal.
