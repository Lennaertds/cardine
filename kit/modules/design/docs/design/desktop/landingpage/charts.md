# Desktop — charts

> **Role:** One demo chart on the showcase.
> **Not here:** product charts ([charts.md](../../iphone/application/charts.md)).

One chart, if the proof gets better with it. No dashboard on the landing page.

## 1. Which type

| Data | Chart |
|------|-------|
| Change over time | Line |
| Comparing a few bars | Bar |
| Share of more than five parts | Bar, not pie |

Direct labels when there are few points. A legend only if the line cannot be labelled next to itself, and then right by the chart.

## 2. Reading

- Axes have a unit and a readable scale. On narrow, fewer ticks, no rotated labels.
- Grid: `--stroke` at a low mix, so the line wins.
- Line and bar against the base ≥ 3:1. Labels ≥ 4.5:1.
- Colour is not the only distinction: a name by the series, or a dashed pattern.
- Tooltip shows the exact value, on hover **and** by keyboard. No hover-only number.
- Scrub is allowed, with anonymous or real demo data ([desktop.md](../desktop.md)).
- Numbers: `.type-numeric`, the page's locale.

## 3. States

- Loading: reserved height, solid surface. No empty axes.
- Empty: one sentence, no chart frame.
- Error: one sentence plus try again.
- Reduced-motion: the data is there immediately. No drawing animation.
- One sentence or `aria-label` summarises the conclusion for a screen reader. The chart is not the only form.

## 4. Density

One insight per chart. A second series only if the comparison is the section. No fill, shadow or gradient on the line.

Interactive points: a hit of at least 24×24, preferably the whole column as the target. On touch, the product rule of 44px if the same chart sits there.

**Test:** the demo chart is a line or a bar, has a unit, stays readable without hover, and uses no private data.
