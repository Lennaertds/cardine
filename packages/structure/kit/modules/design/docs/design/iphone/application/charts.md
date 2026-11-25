# UI iPhone — charts

> **Role:** Product charts + a compact stat row.
> **Not here:** demo charts on the showcase ([charts.md](../../desktop/landingpage/charts.md)); cards ([surfaces-cards](surfaces-cards.md)).

## CH1. Stat row (compact)

| | |
|--|--|
| **Max** | **3** columns in one strip (more → a sheet, or a deliberate second row) |
| **Tap** | Opens **inline** below the strip — no new route unless the product works that way |
| **Type** | Value big + `tabular-nums`; unit/caption `.type-caption text-muted` |

## CH2. Charts

| Rule | Detail |
|------|--------|
| Data | Own or anonymous demo — no fake MAU |
| **Y-axis at 0** | A truncated baseline lies. Deviate only deliberately + marked |
| **Title = takeaway** | A conclusion sentence, not a generic "Quarterly volume" |
| **Data-ink** | Strip grid/shadow/3D; label the series directly; one hero series |
| Labels | Always visible or through accessible text; **no** information only in hover |
| Colour | Tokens / currentColor |
| Motion | Light; reduced-motion = end state |
| Library | Existing charts — no churn without a request ([overlays-policy](overlays-policy.md)) |

**Test:** y at 0 or marked; title = takeaway; readable without hover; still under reduced-motion.

## CH3. Never

| Never | Instead |
|-------|---------|
| Hover-only tooltips as the only label | Always text/aria |
| Y-axis truncated without a mark | At 0, or deliberate + caption |
| A generic chart title | A takeaway sentence |
| Chart shadow / 3D / dense grid | Data ink: lines + labels |
| 5+ columns in one strip | Max 3, or a sheet with details |
