# UI iPhone — touch · keyboard

> **Rol:** Keyboard & composers.  
> **Niet hier:** formulieren ([overlays-forms](application/overlays-forms.md)); focus ([overlays-focus-toasts](application/overlays-focus-toasts.md)).

## 1. Keyboard & composers

- Viewport meta: `interactive-widget=resizes-content` zodat Android keyboard de layout krimpt.
- Fixed composers: boven keyboard blijven — luister naar `visualViewport` resize/scroll als `dvh` niet volstaat.
- Sheet + focused input: sheet-body scroll naar focused field; padding-bottom ≥ keyboard + safe-area.
- Zoek-sheets: phone = **full-height, top-anchored**; hoogte/top = `visualViewport` zodat resultaten direct onder het zoekveld staan en acties boven het keyboard blijven. Nooit `items-end` + krimpende lijst.
- Composer inputs: **altijd ≥ 16px**.

### Composer anatomie

| Deel | Regel |
|------|--------|
| Field | Field chrome [overlays-forms](application/overlays-forms.md) |
| Send | Primary of icon-btn ≥44; disabled als leeg |
| Attach (optioneel) | Secondary / icon; niet de enige path |

### Native `<select>`

- Gebruik sparingly; zelfde min-height ≥44 waar tapbaar.
- Label zichtbaar; geen custom dropdown die hover-only is op touch.

### Time & duration (geen phone keyboard)

- Tijd / duur: **scroll-wielen** — niet `type=text` + numeric keyboard, niet native `type=time` (AM/PM-locale).
- Eén zichtbare dubbele punt (`:`) tussen uren- en minutenwiel; waarde altijd `HH:MM` (duur: totale minuten onder de motorkap).
- Aria-labels gelocaliseerd.

**Test:** composer: 16px input, send ≥44, keyboard dekt send niet af op Android. Tijdvelden: scroll, geen toetsenbord.
