# UI iPhone — charts

> **Rol:** Product charts + compacte stat-rij.  
> **Niet hier:** demo-charts op de showcase ([charts.md](../../desktop/landingpage/charts.md)); kaarten ([surfaces-cards](surfaces-cards.md)).

## CH1. Stat-rij (compact)

| | |
|--|--|
| **Max** | **3** kolommen op één strip (meer → sheet of tweede rij bewust) |
| **Tap** | Opent **inline** onder de strip — geen nieuwe route tenzij product zo is |
| **Type** | Waarde groot + `tabular-nums`; unit/caption `.type-caption text-muted` |

## CH2. Charts

| Regel | Detail |
|-------|--------|
| Data | Eigen of anonieme demo — geen fake MAU |
| **Y-as bij 0** | Truncated baseline liegt. Afwijken alleen bewust + gemarkeerd |
| **Title = takeaway** | Conclusie-zin, niet generiek “Quarterly volume” |
| **Data-ink** | Strip grid/shadow/3D; label de reeks direct; één hero-reeks |
| Labels | Altijd zichtbaar of via toegankelijke text; **geen** info alleen in hover |
| Kleur | Tokens / currentColor |
| Motion | Licht; reduced-motion = eindstaat |
| Library | Bestaande charts — geen churn zonder vraag ([overlays-policy](overlays-policy.md)) |

**Test:** y bij 0 of gemarkeerd; title = takeaway; leesbaar zonder hover; reduced-motion stil.

## CH3. Never

| Never | Instead |
|-------|---------|
| Hover-only tooltips als enige label | Altijd tekst/aria |
| Y-as getruncateerd zonder markering | Bij 0, of bewust + caption |
| Generieke chart-titel | Takeaway-zin |
| Chart-shadow / 3D / dense grid | Data-ink: lijnen + labels |
| 5+ kolommen op één strip | Max 3 of sheet details |
