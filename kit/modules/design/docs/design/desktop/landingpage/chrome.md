# Desktop — chrome

> **Role:** The floating bar, groups, and an optional sidebar.
> **Not here:** material ([liquid-glass.md](liquid-glass.md)).

One bar. Everything that navigates lives in it, or in a menu that grows out of one of its buttons.

## 1. The bar

- Regular `.glass`, shadow role **bar**, floating: not a dense strip along the top edge of the window.
- Inset from the viewport: the same gutter as the content ([layout.md](layout.md)), or 16px if the gutter would look smaller. Top and bottom corners share the radius.
- Height around `--chrome-bar-h` (4.15rem). Not a second, taller "marketing header".
- `position: sticky` or fixed. Content scrolls underneath. Scroll edge below the bar.
- Z-index: `var(--z-nav)` or the existing chrome token. No loose `z-50`.

Composition, left to right:

| Slot | Content |
|------|---------|
| Leading | Wordmark → `/` |
| Centre of next to the brand | Local showcase links. At most four text links |
| Trailing | One primary action |

A guest page has no bell, no skin switcher, no product tabs. Those belong to the signed-in shell (project chrome).

The same slots on every showcase route. No mix of top bar, sidebar **and** bottom tabs at the same level. A sidebar is local chapters, not a second primary nav. Breadcrumbs only if there are three levels **and** there is no sidebar.

## 2. Groups

Items that belong together share one background.

- Navigation links = one group.
- The primary action may stand apart, with a fixed spacer (16px or 24px) between the groups.
- Within one group: either icons only, or text only. Not an icon button next to a text button on the same fill.
- A hidden item disappears completely (no empty gap in the capsule).
- The same grouping on every showcase route.

## 3. Sidebar

Only if a page has local chapters (long documentation), never next to the hero features.

- Floating Regular glass, not a dense column down to the floor.
- The content (or only the background photo) visually runs under the sidebar.
- Text and buttons stay in the free zone: left padding ≥ sidebar width + 24px.
- Fixed width, between 200px and 260px. No resizable splitter in v1.
- Below 1024px the sidebar becomes a group in the bar or a menu. No permanent column that pushes the prose below 36ch.

Inspector (a panel on the right with detail): one at a time.

## 4. What is not chrome

- Traffic lights, a faux Apple menu bar, a dock at the bottom of the site.
- A second sticky bar under the first (breadcrumbs, filters). Those belong in the content, solid, or as one group **inside** the bar.
- A glass footer. The footer is content.

A product mock **may** show a window frame, including a calm title bar. That frame lives in the content layer and uses `--r-device`. It is not a control for the website.

## 5. State

- Active route: weight 650, `--foreground`. No accent pill behind one of many links.
- Hover, fine pointer only: highlight up, or a fill of `--foreground` at 8%. No layout shift.
- Focus visible: ring, [a11y.md](../a11y.md).

**Test:** one glass bar on every showcase route; the primary button sits in the same place; there is no second sticky strip.
