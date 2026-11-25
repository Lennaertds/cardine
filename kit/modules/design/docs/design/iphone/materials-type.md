# UI iPhone — materials · type

> **Role:** Typography, fonts, icons, type ladder.
> **Not here:** showcase typography ([type.md](../desktop/landingpage/type.md)); material ([materials-depth](materials-depth.md)).

## 1. Fonts (inventory — fixed)

Product and showcase share **at most three** stacks. No fourth webfont "just in passing".

| Token | Stack | Where |
|-------|-------|------|
| `--font-sans` | `ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif` | **All product UI** (body default) |
| `--font-mono` | `ui-monospace, SFMono-Regular, "SF Mono", Menlo, monospace` | Codes, technical IDs — sparse |
| `--font-display` | default = same as `--font-sans` (override only behind the showcase gate) | Landing / hero brand name |

**Rules**

- Product (tabs, sheets, settings) = **only** `--font-sans` (+ mono if needed).
- No Inter / Roboto / random Google Font in the product path.
- Skins may tune weight/tracking — **not** load a second product face.
- The showcase may override `--font-display`; the product in a wide window stays sans + the ladder below.

**Test:** DevTools computed `font-family` on the product H1 and a Settings row = `--font-sans`. The landing hero may use display.

## 2. Typography mechanics

- **Tracking is size-specific.** Display/title: negative (`~-0.02em`…`-0.03em`); body ~`0`.
- **Leading inverse to size.** Tight on big headings; looser on body.
- Hierarchy = **weight + size + leading** together, not size alone.
- UI scale scales the root — layouts in `rem`/`em`.
- Numerics: `.type-numeric` (`tabular-nums`) on timers/stats.

## 3. Iconografie

- Tabbar / nav icons: **outline at rest, filled (or heavier stroke) when active** — one optical weight across all tabs.
- No emoji as a primary navigation icon.
- Hit area ≥ 44px; the glyph itself ~22–24px (glyph size, **not** a type role).
- Colour: `currentColor` / tokens — no hardcoded neon per icon.

## 4. Type ladder (product — source of truth)

Fixed `--type-*` tokens in `globals.css`. **No** ad-hoc `text-lg` / `text-xl` / `text-2xl` / `text-[10px]` / `clamp()` for hierarchy on product titles or meta.

| Role | Token | ≈px @16 | Class | Use |
|-----|-------|---------|-------|---------|
| Display / hero | `--type-display` | 34 | `.type-display` | **Only** showcase / rare hero — never a PWA page H1 |
| Page title (H1) | `--type-title` | 28 | `.page-title` | Screen titles |
| Section / card (H2) | `--type-headline` | 17 | `.type-headline` | Section headers, sheet titles, card titles |
| Body | `--type-body` | 17 | `.type-body` | Primary reading text; Settings row title |
| Lede / callout | `--type-callout` | 16 | `.page-lede` | Short intro under the page title |
| Stat / timer | `--type-stat` | 24 | `.type-stat` | A big metric (always + `.type-numeric`) |
| Tabs / segments | `--type-tab` | 13 | `.type-tab` / `.ios-segmented` | Segment labels |
| Caption / meta / eyebrow | `--type-caption` | 13 | `.type-caption` | Dates, footnotes, units, section labels |

**Do / don't**

| Do | Don't |
|----|-------|
| H1 → `.page-title` | `text-2xl` / `text-xl` as a page title |
| H2 / sheet title → `.type-headline` | `text-base font-semibold` as a section title |
| Meta / units → `.type-caption` | `text-[10px]` / a random `text-xs` for hierarchy |
| Big number → `.type-stat.type-numeric` | `text-2xl` on timers |
| Dense control labels | Tailwind `text-sm` on **buttons/chips** is OK (chrome, not a title role) |
| Unread / count badges | Micro `text-[10px]` is fine on a dense chrome pill — not content hierarchy |

**Dual track:** the product on desktop ≥768px follows **this** ladder. Showcase display = [desktop.md](../desktop/desktop.md) — may be bigger, not in the product path.

**Test:** Product content: no ad-hoc muted `text-sm`/`text-xs` for meta; H1/H2 = ladder classes.

### Hit & space tokens (CSS)

| Token | Value | Use |
|-------|--------|---------|
| `--hit-min` | 44px | Primary controls |
| `--hit-comfort` | 48px | Roomy primary |
| `--hit-dense` | 36px | Dense chips only |
| `--space-page` / `--space-group` | project | Page / group inset |

**Test:** No primary CTA with a computed height < 44 outside a `.dense-control` context.
