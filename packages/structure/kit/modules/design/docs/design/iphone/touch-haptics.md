# UI iPhone — touch · haptics

> **Rol:** Haptics policy (web vibrate).  
> **Niet hier:** multimodale feedback ([materials-a11y](materials-a11y.md)); raakvlakken ([touch-targets](touch-targets.md)).

## 1. Haptics

Web: `navigator.vibrate` waar beschikbaar (Android; iOS Safari beperkt). Zelfde policy als native.

| Moment | Intensity | Voorbeeld |
|--------|-----------|-----------|
| Stap/detent (picker tick, segmented) | Licht / selection | `vibrate(8)` |
| Snap home / sheet detent / drag commit | Licht impact | `vibrate(10)` |
| Destructieve commit | Medium | `vibrate([15, 30, 15])` |
| Success / error notification | Pattern | success kort; error dubbel |

**Absoluut:**

1. Zelfde frame als de visual (causaal moment, niet einde animatie).
2. **Eén** haptic per user-action — nooit per scroll-frame, nooit op entrance die user niet veroorzaakte.
3. Nooit de enige feedback — visual moet standalone werken (veel iPhones / silent).
4. **Verboden** op elke herhaalde tick in een dichte logger (tientallen× per sessie) — alleen commit / snap / success.
