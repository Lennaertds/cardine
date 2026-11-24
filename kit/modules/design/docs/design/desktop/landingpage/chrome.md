# Desktop — chrome

> **Rol:** De zwevende balk, groepen, en een eventuele sidebar.  
> **Niet hier:** materiaal ([liquid-glass.md](liquid-glass.md)).

Eén balk. Alles wat navigeert zit daarin, of in een menu dat uit een knop van die balk groeit.

## 1. De balk

- Regular `.glass`, schaduwrol **bar**, zwevend: niet een dichte strook aan de bovenrand van het venster.
- Inset van de viewport: dezelfde gutter als de content ([layout.md](layout.md)), of 16px als de gutter kleiner zou ogen. Onder- en bovenhoek delen de radius.
- Hoogte in de buurt van `--chrome-bar-h` (4.15rem). Niet een tweede, hogere “marketing header”.
- `position: sticky` of fixed. Content scrollt eronder. Scroll-edge onder de balk.
- Z-index: `var(--z-nav)` of het bestaande chrome-token. Geen los `z-50`.

Samenstelling, van links naar rechts:

| Slot | Inhoud |
|------|--------|
| Leading | Woordmerk → `/` |
| Center of naast het merk | Lokale showcase-links. Hooguit vier tekstlinks |
| Trailing | Eén primaire actie |

Een gast-pagina heeft geen bel, geen skin-switcher, geen product-tabs. Die horen bij de ingelogde schil (project-chrome).

Dezelfde slots op elke showcase-route. Geen mix van topbalk, sidebar én bottom-tabs op hetzelfde niveau. Een sidebar is lokale hoofdstukken, niet een tweede primaire nav. Kruimels alleen als er drie niveaus zijn én er geen sidebar is.

## 2. Groepen

Items die bij elkaar horen delen één achtergrond.

- Navigatielinks = één groep.
- De primaire actie mag losstaan, met een vaste spacer (16px of 24px) tussen de groepen.
- In één groep: óf alleen iconen, óf alleen tekst. Niet een icoon-knop naast een tekstknop op dezelfde vulling.
- Een verborgen item verdwijnt helemaal (geen leeg gat in de capsule).
- Zelfde groepering op elke showcase-route.

## 3. Sidebar

Alleen als een pagina lokale hoofdstukken heeft (lange documentatie), nooit naast de hero-features.

- Zwevend Regular-glas, niet een dichte kolom tot de vloerrand.
- De content (of alleen de achtergrondfoto) loopt visueel onder de sidebar door.
- Tekst en knoppen blijven in de vrije zone: padding links ≥ sidebarbreedte + 24px.
- Breedte vast, tussen 200px en 260px. Geen resizable splitter in v1.
- Onder 1024px wordt de sidebar een groep in de balk of een menu. Geen permanente kolom die de proza onder 36ch duwt.

Inspector (een paneel rechts met detail): één tegelijk.

## 4. Wat geen chrome is

- Stoplichten, een faux Apple-menubalk, een dock onderaan de site.
- Een tweede sticky bar onder de eerste (kruimels, filters). Die horen in de content, solid, of als één groep ín de balk.
- Glazen footer. De footer is content.

Een product-mock mag wél een vensterframe tonen, inclusief een rustige titelbalk. Dat frame zit in de contentlaag en gebruikt `--r-device`. Het is geen besturing van de website.

## 5. Toestand

- Actieve route: weight 650, `--foreground`. Geen accent-pill achter één van vele links.
- Hover, alleen bij fijne pointer: glans omhoog, of een fill van `--foreground` op 8%. Geen verschuiving van de layout.
- Focus-zichtbaar: ring, [a11y.md](../a11y.md).

**Test:** één glazen balk op elke showcase-route; de primaire knop zit op dezelfde plek; er is geen tweede sticky strook.
