# Desktop — charts

> **Rol:** Een demo-chart op de showcase.  
> **Niet hier:** product-charts ([charts.md](../../iphone/application/charts.md)).

Eén chart, als het bewijs er beter van wordt. Geen dashboard op de landing.

## 1. Welk type

| Data | Chart |
|------|-------|
| Verloop | Lijn |
| Vergelijking van een paar staven | Staaf |
| Aandeel van meer dan vijf delen | Staaf, geen taart |

Directe labels als er weinig punten zijn. Een legenda alleen als de lijn niet naast zichzelf gelabeld kan worden, en dan pal bij de chart.

## 2. Lezen

- Assen hebben eenheid en een leesbare schaal. Op smal minder ticks, geen gedraaide labels.
- Raster: `--stroke` op lage mix, zodat de lijn wint.
- Lijn en staaf tegen de bodem ≥ 3:1. Labels ≥ 4.5:1.
- Kleur is niet de enige onderscheiding: naam bij de reeks, of een streeppatroon.
- Tooltip toont de exacte waarde, op hover én via toetsenbord. Geen hover-only cijfer.
- Scrub mag, met anonieme of echte demo-data ([desktop.md](../desktop.md)).
- Cijfers: `.type-numeric`, locale van de pagina.

## 3. Staten

- Laden: gereserveerde hoogte, solid vlak. Geen lege assen.
- Leeg: één zin, geen chart-frame.
- Fout: één zin plus opnieuw proberen.
- Reduced-motion: de data staat er meteen. Geen inteken-animatie.
- Een zin of `aria-label` vat de conclusie samen voor een screenreader. De chart is niet de enige vorm.

## 4. Dichtheid

Eén inzicht per chart. Een tweede reeks alleen als de vergelijking de sectie is. Geen vulling, schaduw of gradient op de lijn.

Interactieve punten: hit minstens 24×24, liever de hele kolom als treffer. Op touch de product-regel van 44px als dezelfde chart daar staat.

**Test:** de demo-chart is een lijn of staaf, heeft een eenheid, blijft leesbaar zonder hover, en gebruikt geen privé-data.
