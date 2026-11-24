# UI iPhone — materials · type

> **Rol:** Typography, fonts, icons, type ladder.  
> **Niet hier:** typografie op de showcase ([type.md](../desktop/landingpage/type.md)); materiaal ([materials-depth](materials-depth.md)).

## 1. Fonts (inventaris — vast)

Product en showcase delen **maximaal drie** stacks. Geen vierde webfont “even tussendoor”.

| Token | Stack | Waar |
|-------|-------|------|
| `--font-sans` | `ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif` | **Alle product-UI** (body default) |
| `--font-mono` | `ui-monospace, SFMono-Regular, "SF Mono", Menlo, monospace` | Codes, technische IDs — spaarzaam |
| `--font-display` | default = zelfde als `--font-sans` (override alleen achter showcase-gate) | Landing / hero merknaam |

**Regels**

- Product (tabs, sheets, settings) = **alleen** `--font-sans` (+ mono indien nodig).
- Geen Inter / Roboto / willekeurige Google Font in product path.
- Skins mogen weight/tracking tunen — **niet** een tweede product-face laden.
- Showcase mag `--font-display` overrulen; product op breed scherm blijft sans + ladder hieronder.

**Test:** DevTools computed `font-family` op product-H1 en Settings-rij = `--font-sans`. Landing hero mag display.

## 2. Typography mechanics

- **Tracking is size-specific.** Display/title: negatief (`~-0.02em`…`-0.03em`); body ~`0`.
- **Leading inverse met size.** Strak op grote headings; losser op body.
- Hiërarchie = **weight + size + leading** samen, niet size alleen.
- UI-scale schaalt root — layouts in `rem`/`em`.
- Numerics: `.type-numeric` (`tabular-nums`) op timers/stats.

## 3. Iconografie

- Tabbar / nav icons: **outline in rust, filled (of zwaarder stroke) als active** — één optisch gewicht over alle tabs.
- Geen emoji als primaire navigatie-icoon.
- Hit area ≥ 44px; glyph zelf ~22–24px (glyph-size, **geen** type-rol).
- Kleur: `currentColor` / tokens — geen hardcoded neon per icoon.

## 4. Type ladder (product — SoT)

Vaste `--type-*` tokens in `globals.css`. **Geen** ad-hoc `text-lg` / `text-xl` / `text-2xl` / `text-[10px]` / `clamp()` voor hiërarchie op producttitels of meta.

| Rol | Token | ≈px @16 | Class | Gebruik |
|-----|-------|---------|-------|---------|
| Display / hero | `--type-display` | 34 | `.type-display` | **Alleen** showcase / zeldzame hero — nooit PWA page H1 |
| Page title (H1) | `--type-title` | 28 | `.page-title` | Screen titles |
| Section / card (H2) | `--type-headline` | 17 | `.type-headline` | Section headers, sheet titles, card titles |
| Body | `--type-body` | 17 | `.type-body` | Primaire leestekst; Settings-rij titel |
| Lede / callout | `--type-callout` | 16 | `.page-lede` | Korte intro onder page title |
| Stat / timer | `--type-stat` | 24 | `.type-stat` | Grote metric (altijd + `.type-numeric`) |
| Tabs / segments | `--type-tab` | 13 | `.type-tab` / `.ios-segmented` | Segment labels |
| Caption / meta / eyebrow | `--type-caption` | 13 | `.type-caption` | Datums, footnotes, units, section labels |

**Wel / niet**

| Wel | Niet |
|-----|------|
| H1 → `.page-title` | `text-2xl` / `text-xl` als page title |
| H2 / sheet title → `.type-headline` | `text-base font-semibold` als section title |
| Meta / units → `.type-caption` | `text-[10px]` / willekeurige `text-xs` voor hiërarchie |
| Big number → `.type-stat.type-numeric` | `text-2xl` op timers |
| Dense control labels | Tailwind `text-sm` op **knoppen/chips** OK (chrome, geen titelrol) |
| Unread / count badges | Mag micro `text-[10px]` op dichte chrome-pil — geen content-hiërarchie |

**Dual-track:** product op desktop ≥768px volgt **deze** ladder. Showcase display = [desktop.md](../desktop/desktop.md) — mag groter, niet in productpad.

**Test:** Product content: geen ad-hoc muted `text-sm`/`text-xs` voor meta; H1/H2 = ladder-classes.

### Hit & space tokens (CSS)

| Token | Waarde | Gebruik |
|-------|--------|---------|
| `--hit-min` | 44px | Primaire controls |
| `--hit-comfort` | 48px | Ruime primary |
| `--hit-dense` | 36px | Dense chips only |
| `--space-page` / `--space-group` | project | Page / group inset |

**Test:** Geen primary CTA met computed height < 44 buiten `.dense-control` context.
