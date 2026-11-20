# Desktop — looks

> **Rol:** De ene visuele receptuur. Elke showcase-pagina gebruikt deze waarden.  
> **Niet hier:** de class zelf ([glass.md](../../shared/glass.md)).

Geen pagina-lokale blur, schaduw of radius. Een afwijking hoort als modifier in `globals.css`, daarna in deze file.

## 1. Kleurrollen

Alleen deze tokens. Geen hex in een showcase-component.

| Rol | Token | Gebruik |
|-----|-------|---------|
| Pagina | `--background` | Bodem van de contentlaag |
| Tekst | `--foreground` | Titels, body, labels op glas |
| Secundair | `--muted` | Meta, bijschrift. Nooit de lede |
| Actie | `--accent` / `--on-accent` | Precies één primaire actie per viewport |
| Vlak | `--card` | Solid content én de tint in `.glass` |
| Rand | `--stroke` | Haarlijn op glas en op solid vlakken |
| Scrim | `--sheet-scrim` | Achter een dialoog |

Accent op hooguit een paar plekken per pagina: de primaire knop, tekstlinks, één marker. Een feature-kolom kleurt niet zijn hele kolom accent.

Tekst is nooit `#000` of `#fff`. Licht en donker zijn één paar: beide halen 4.5:1 op body, en een rand die in licht zichtbaar is, blijft in donker zichtbaar. Een fout- of succeskleur heeft altijd een woord of icoon erbij.

Hover mag de schaduw één stap zwaarder maken (control naar iets dieper), zonder de layout te verschuiven. Geen gekleurde gloed op hover.

Publieke showcase volgt `theme-dark` / `theme-light`. Product-skins herskinen de gast-landing niet.

## 2. Glas

De class, de haarlijn en Clear staan in [glass.md](../../shared/glass.md). Deze file herhaalt de getallen niet. Schaduwrollen en radius hieronder horen bij de landingspagina.

## 3. Schaduwrollen

Zelfde kleur (`#000` via `color-mix`). Alleen de diepte verandert.

| Rol | Schaduw | Voor |
|-----|---------|------|
| **control** | `0 4px 16px` · 22% | Losse pil, icon-knop |
| **bar** | `0 10px 28px` · 18% licht / 35% donker | Nav, toolbar — de `.glass`-default |
| **panel** | `0 16px 40px` · 32% | Menu, dialoog, detailpaneel |

Geen gekleurde glow, geen `0 0 40px var(--accent)`.

## 4. Radius — concentrisch

Binnenradius = buitenradius min de padding. Nooit een hardcoded tweede hoek.

```css
inner-radius = max(0px, outer-radius - padding);
```

| Vorm | Wanneer | Radius |
|------|---------|--------|
| Capsule | Nav-cluster, segmented, primaire pil | `999px` op buiten én binnen |
| Afgeronde rechthoek | Panelen, menus, contentvlakken | `--r-group` buiten; binnen via de formule |
| Apparaat-mock | iPhone- of vensterframe | `--r-device` |

Showcase-groepen volgen hetzelfde concentrische patroon als product-chrome.

Een capsule-groep krijgt geen kind met `--r-group`. Een rechthoekig paneel krijgt geen `rounded-full` knop die de hoek vecht, tenzij de knop los zweeft búiten het paneel.

## 5. Vibrancy op glas

Tekst en iconen op Regular:

- kleur `--foreground`, niet `--muted`, niet een grijstint in hex;
- weight 600 voor labels, 650 voor de actieve staat;
- tracking iets ruimer dan body (`0.01em`), of de size-tracking uit [type.md](type.md) als het een titel is.

Iconen: `currentColor`. Geen eigen vulkleur per icoon.

## 6. Tint op de primaire actie

De primaire knop mag accent door het glas laten lopen:

```css
background: color-mix(in oklab, var(--accent) 88%, transparent);
color: var(--on-accent);
```

Een volledig dichte `background: var(--accent)` op een glazen balk breekt het materiaal. Of de knop zit ín de glazen groep met deze tint, of ze staat los als solid pil op rustige content. Eén van de twee per viewport.

Secundaire knoppen krijgen geen accentvulling.

## 7. Gradients — ambiance

Een gradient mag alleen als zachte ambiance **achter** de contentlaag (pagina-bodem, foto-scrim, scroll-edge fade). Nooit als bewijs, nooit als tekstvulling, nooit als AI-blob achter de hero.

- Alleen **buur-hues** in het theme. Geen sprong naar paars, indigo of neon.
- **Lightness in één richting** — lichter → donkerder of omgekeerd. Geen multi-stop “mesh”.
- Content blijft op solid of foto; de gradient zit erachter, niet erover als glow.
- Verboden: paars/indigo glow, AI-blob, regenboog-rand, gradient-text — [never-checklist.md](never-checklist.md).

## 8. Verboden looks

| Verboden | Daarom |
|----------|--------|
| Paars/indigo glow, AI-blob, gradient-text | Vreemd merk; [never-checklist](never-checklist.md) |
| Mesh-gradient, regenboog-rand, prismatische dispersie | Kit-effect; [never.md](../../shared/never.md) |
| Glazen kaartgrid | Contentlaag wordt functionele laag |
| Per-pagina `backdrop-filter` | De look drijft |
| Stoplichten, dock, faux menu-balk als site-chrome | Cosplay. Alleen binnen een product-mock |
| Tweede schaduwkleur | De rollen hierboven zijn compleet |

**Test:** computed `backdrop-filter` op de nav van elke showcase-route is `saturate(1.9) blur(40px)`. Geen andere blur op die pagina’s, behalve een gedocumenteerde scroll-edge fade.
