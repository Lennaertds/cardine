# UI iPhone — motion · springs

> **Rol:** Direct manipulation, interruptibility, springs.  
> **Niet hier:** gebaren en momentum ([motion-gestures](motion-gestures.md)); smoothness per frame ([motion-smoothness](motion-smoothness.md)).

## 1. Direct manipulation — 1:1 tracking

> Touch and content should move together.

- Element blijft plakken aan de vinger; respecteer **grab offset** (niet naar centrum snappen bij grab).
- Pointer Events + `setPointerCapture`.
- Houd korte **velocity/position history** (laatste `pointermove`s) voor release.

```js
el.addEventListener('pointerdown', (e) => {
  el.setPointerCapture(e.pointerId);
  const grabOffset = e.clientY - el.getBoundingClientRect().top;
  // track position + timestamp history for velocity
});
```

## 2. Interruptibility — belangrijkste principe

> The thought and the gesture happen in parallel.

- **Nooit input locken tijdens een transition.**
- Animeer altijd vanaf de **presentation value** (live on-screen), nooit vanaf de logical/target value bij interrupt.
- **Geen CSS transitions/`@keyframes` voor gesture-driven UI** (sheets, drag-dismiss, swipe). Die zijn niet soepel te grijpen mid-flight. Gebruik **springs**.
- Bij reverse: **velocity blenden**, geen hard-cut (“brick wall”).
- 2D motion = **aparte X- en Y-springs**.

Sheets, chip-drag, drawers moeten dit halen. Vaste fade-ins die zelden voorkomen mogen CSS blijven.

## 3. Behavior over animation — springs

### Easing = intent

| Curve | Wanneer |
|-------|---------|
| **ease-out** | Default voor UI enter / settle — snel starten, landen |
| **ease-in** / snappier exit | Dismiss; exit korter dan entrance ([motion-response](motion-response.md)) |
| **ease-in-out** | Verplaatsen tussen peers (tab content, indicator) |
| **linear** | Alleen spinners / continue loops — nooit start/stop UI |
| **spring** | Gesture-driven + spaarzame touch-feedback; geen bounce op elke fade |

Zelfde curves overal = coherent. Ad-hoc per component = gestikt.

- Springs voor alles wat de user kan **aanraken** (sheets, drag, swipe-settle) — niet voor elke fade.
- Parameters: **damping ratio** + **response** (geen vaste “duration” in physics-zin).
  - Default UI: damping **`1.0`** (geen overshoot), response **`0.3–0.4`**.
  - Momentum/flick: damping **`~0.8`**, response **`0.3–0.4`**.
- Bounce **alleen** als de gesture zelf momentum had (flick/throw), of zeldzame attention. Geen bounce op menu fade-in.

| Interaction | Damping | Response |
|-------------|---------|----------|
| Move / reposition | 1.0 | 0.4 |
| Rotation | 0.8 | 0.4 |
| Drawer / sheet | 0.8 | 0.3 |

Web (Motion / Framer Motion):

```js
// Critically damped default
animate(el, { y: 0 }, { type: 'spring', bounce: 0, duration: 0.4 });
// Momentum flick
animate(el, { y: target }, { type: 'spring', bounce: 0.2, duration: 0.4 });
```

**Niet animeren** (frequentie wint van “mooi”):

| Frequentie | Besluit |
|------------|---------|
| 100×/dag | Geen animatie |
| Tientallen×/dag | Weg of drastisch korter |
| Occasioneel (sheets) | Spring / standaard |
| Zeldzaam | Mag delight |

Dichte logger-tikken: **instant of ≤160ms press** — geen theater.
