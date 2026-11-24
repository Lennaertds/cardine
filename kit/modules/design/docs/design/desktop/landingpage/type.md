# Desktop — type

> **Rol:** Showcase-typografie. De product-ladder blijft leidend buiten de showcase.  
> **Niet hier:** fonts ([materials-type](../../iphone/materials-type.md)).

Drie families, geen vierde. `--font-sans` voor UI en body. `--font-mono` alleen voor een echte code of id. `--font-display` alleen voor de hero-claim en het woordmerk, en alleen als die override al achter de gate bestaat. Default display = sans.

Product-schermen, ook ≥ 768px, blijven de ladder in [materials-type](../../iphone/materials-type.md). Deze file vergroot niets in het productpad.

## 1. Rollen op showcase

| Rol | Element | wide | regular | Weight | Leading | Tracking |
|-----|---------|------|---------|--------|---------|----------|
| **Claim** | Hero H1 | 64–72px | 44–52px | 700 | 1.05–1.12 | −0.03em |
| **Sectietitel** | H2 | 32–36px | 28px | 650 | 1.15 | −0.02em |
| **Lede** | Onder de claim | 20–22px | 18px | 450 | 1.45 | 0 |
| **Body** | Proza | 17–18px | 17px | 400 | 1.55 | 0 |
| **Label** | Op glas, eyebrow | 13px | 13px | 600 | 1.2 | 0.01em |
| **Meta** | Bron, voetnoot | 13px | 13px | 450 | 1.35 | 0 |

Claim en sectietitel mogen `clamp()` binnen de band hierboven. Body niet: 17px is de vloer.

Geen all-caps sectietitels op de showcase. Product-skins mogen uppercase in het product; de showcase negeert dat.

## 2. Hiërarchie

- Eén H1 per pagina. Op de landing is dat de claim.
- H2 = sectietitel. Hooguit één per sectie.
- Een H3 in een feature-kolom is de kolomnaam, zelfde maat als body + weight 650. Geen derde display-grootte.
- Lede is `--foreground`. Meta is `--muted`.
- Cijfers in een demo-chart: `.type-numeric`.

## 3. Maat en klasse

Showcase-claim gebruikt een showcase-class (of `.type-display` als die op die route bewust groter wordt gezet). Niet `text-6xl` los in een component, en niet `--type-display` op de product-root verhogen.

Knoppen: 15–16px, weight 600. Dat is chrome, geen titelrol.

## 4. Proza

- Links uitgelijnd. Maat: 65–72 tekens op wide (band 60–75). Op narrow 35–60.
- Body-leading blijft 1.55. Dat zit in 1.5–1.75. Niet oprekken naar 1.75 om “lucht” te veinzen.
- Gewicht nooit onder 400. Koppen 650–700. Labels 600.
- Geen uitgevulde tekst. Geen gecentreerde alinea’s. Een korte claim mag centreren op wide.
- Geen gradient-text, geen outline-text.
- `text-wrap: balance` mag op de claim en de sectietitel, als extra. De natuurlijke wrap moet ook kloppen.
- URL’s en ids: `overflow-wrap: anywhere`. Gewone zinnen niet breken met `word-break: break-all`.
- Niets onder 13px. Body niet onder 16px. 13px is alleen label en meta.

## 5. Koppen-ladder

H1, dan H2, dan H3. Geen niveau overslaan. Eén H1.

**Test:** hero-H1 valt in de claim-band; een product-H1 op een breed venster volgt de product-ladder. DevTools toont geen vierde font-family. Een prozaregel op wide blijft onder 75 tekens.
