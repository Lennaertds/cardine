# Desktop — liquid glass

> **Rol:** Waar het materiaal zit, welke variant, en wat nooit glas is.  
> **Niet hier:** de pixels ([looks.md](looks.md)); de class zelf ([glass.md](../../shared/glass.md)).

Glas is de laag die zweeft. Content blijft leesbaar zonder blur.

## 1. Twee varianten, nooit door elkaar

Op één pagina één variant. Een Regular-balk en een Clear-pil in dezelfde viewport zijn verboden.

### Regular — de default

- Elke nav, toolbar, menu en hoogstens één detailpaneel.
- Werkt over tekst, over kleur en over beeld.
- Past mee met het theme. Grote vlakken (sidebar, menu, paneel) flippen niet van licht naar donker terwijl je scrollt.

### Clear — alleen als alle drie kloppen

1. Het vlak ligt op **mediarijke** content (full-bleed foto of film, geen tekstkolom).
2. Een dim-laag onder het glas schaadt het beeld niet.
3. Wat óp het glas staat is groot en helder (woordmerk, één knop). Geen bijschrift van 13px.

Ontbreekt één voorwaarde: Regular, of solid.

Clear draagt altijd een dim-laag (`color-mix` naar zwart, ongeveer 28–40%). Zonder dim is het onleesbaar. Lokale dim (alleen onder het vlak) gaat voor een paginabrede sluier.

## 2. Waar glas wel is

| Element | Variant |
|---------|---------|
| Site-nav | Regular |
| Groep toolbar-knoppen | Regular, zelfde vlak als de nav of één capsule erin |
| Menu / popover | Regular, dikker (schaduwrol “panel”) |
| Eén functioneel paneel over media | Regular, of Clear als §1 slaagt |
| Primaire CTA | Regular + accent-tint, of solid accent als de knop op rustige content staat |

## 3. Waar glas niet is

- Feature-kolommen, artikeltekst, tabellen, formulieren, lijsten, footer.
- Een grid van glazen kaarten.
- Tekst direct op een tweede glaslaag (item op een glazen menu = fill of vibrancy, geen eigen `backdrop-filter`).
- Productcontent, sheets, tabellen. Die blijven [materials-depth](../../iphone/materials-depth.md): glas = chrome.

## 4. Laagjes (één class, vaste volgorde)

Een glazen vlak is deze stapel, niets extra’s per pagina:

1. **Blur + saturate** — de achtergrond wordt melk, niet een eigen gradient.
2. **Tint** — `color-mix` van `--card` (Regular) of lager (Clear).
3. **Inset-glans** — 0.5px lichte lijn langs de bovenrand. Dat is de specular. Geen bewegende regenboog.
4. **Schaduw** — scheidt het vlak van tekst eronder. Zwaarder naarmate het vlak groter is ([looks.md](looks.md) § schaduw).
5. **Haarlijn** — 1px `--stroke` gemengd met transparant, zodat de rand blijft bestaan op een vlakke achtergrond.

Schaduw wordt zwaarder boven drukke content. Op het web is de default de zwaardere schaduw, omdat content onder de balk door scrollt.

## 5. Scroll-edge

Content die onder een glazen balk doorgaat lost op, in plaats van tegen een harde 1px-lijn te stoppen.

- Zachte fade: mask of gradient aan de onderkant van de balk, ongeveer 12–20px.
- Donkere content onder de balk: de fade dimt, ze wordt geen witte waas.
- Een gepinde subkop gebruikt een **harde** edge over de volle hoogte van balk + subkop, zodat die twee als één blok lezen.

## 6. Dikte bij morph

Een knop die een menu wordt, wordt dikker:

- schaduw van rol “control” naar rol “panel”;
- iets sterkere tint (meer `--card` in de mix);
- de blur-familie blijft `.glass`.

Geen aparte filter-stack voor het menu.

## 7. Rust versus interactie

In rust is het vlak stil. Bij hover of press licht de glans op (iets hogere inset-wit). Dat is feedback, geen loop. Beweging → [motion.md](motion.md).

**Test:** alle showcase-routes delen één `.glass`-class. Nergens een tweede `backdrop-filter` op een kaart of lijst.

## 8. Wat we niet uit glassmorphism-kits halen

[glassmorphism.com](https://glassmorphism.com/) en soortgelijke gidsen beschrijven een los recept: vaste `rgba`-vulling, een rand `1px solid rgba(255, 255, 255, 0.15)`, en een mesh-gradient erachter. Dat recept komt niet in de site.

- De vulling blijft `color-mix` op `--card`, niet een losse witte of zwarte rgba.
- De rand blijft `--stroke`. De glans is de inset van `.glass`, geen tweede witte rand.
- Geen mesh-gradient als achtergrond. De pagina houdt `--background`, een foto, of solid content.
- `backdrop-filter` en `-webkit-backdrop-filter` blijven het paar uit `.glass` (`saturate` + `blur`). Een tweede blur-getal is verboden.
