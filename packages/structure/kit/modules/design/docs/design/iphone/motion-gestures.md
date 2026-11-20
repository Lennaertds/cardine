# UI iPhone — motion · gestures

> **Rol:** Velocity, momentum, spatial, rubber-band, gesture checklist.  
> **Niet hier:** springs ([motion-springs](motion-springs.md)); smoothness per frame ([motion-smoothness](motion-smoothness.md)).

## 1. Velocity handoff

Bij loslaten moet de animatie **doorgaan op de exacte finger-velocity** — geen naad tussen drag en spring.

```
relativeVelocity = gestureVelocity / (targetValue − currentValue)  // als API genormaliseerd wil
```

Motion/Framer: vaak absolute px/s via `velocity`.

## 2. Momentum projection

> Take a small input and make a big output.

Niet snappen naar nearest boundary vanaf release-punt. **Projecteer** resting position met velocity (scroll-deceleration), dan snap naar target dichtst bij die projectie.

```js
// decelerationRate ≈ 0.998 (scroll); 0.99 snappier
function project(initialVelocity /* px/s */, decelerationRate = 0.998) {
  return (initialVelocity / 1000) * decelerationRate / (1 - decelerationRate);
}
const projectedEndpoint = currentPosition + project(releaseVelocity);
const target = nearestSnapPoint(projectedEndpoint);
animateSpringTo(target, { velocity: releaseVelocity });
```

Gebruik dit voor bottom-sheets en horizontale carousels/boards.

## 3. Spatial consistency

- **Enter en exit langs hetzelfde pad.** In van rechts → weg naar rechts.
- **Anker aan de bron.** Popover/menu/sheet: `transform-origin` naar trigger. (Modals die echt viewport-centered zijn: center ok.)
- Mirror easing op reversible transitions (inverse cubic-bézier).
- Geen `scale(0)`: enter vanaf ≥ `scale(0.95)` + opacity.

## 4. Hint in de richting van de gesture

Intermediate frames moeten de uitkomst **telegraphen** — niet blind interpoleren.

## 5. Rubber-banding

Harde stop = “bevroren”. Progressieve weerstand past de rand.

```js
function rubberband(overshoot, dimension, constant = 0.55) {
  return (overshoot * dimension * constant) / (dimension + constant * Math.abs(overshoot));
}
```

Sheets en horizontale boards: rubber-band aan randen.

## 6. Gesture design checklist

- **Tap:** highlight touch-down; commit touch-up; ~10px hit padding; cancel door weg te slepen.
- **Drag/swipe:** ~10px hysteresis vóór richting commit, daarna 1:1.
- Detecteer plausible gestures **parallel** vanaf eerste move; cancel verliezers zodra intent duidelijk is. Vermijd alleen-final events (`swipeleft`).
- Minimaliseer disambiguation delays (double-tap alleen waar nodig).
- Horizontale surfaces: `touch-action` expliciet (`pan-x pan-y` als pagina ook verticaal moet kunnen).

## 7. Swipe-actions

| Regel | Detail |
|-------|--------|
| **Affordance hint** | Zonder hint ontdekt bijna niemand swipe — peek, ⋯, of first-run cue |
| **Friction op destroy** | Partial swipe = knop tonen; full-swipe alleen met undo/confirm-pad |
| **Nooit swipe-only** | Altijd button / long-press / detail-fallback (a11y + discoverability) |
| **Kleur = gevolg** | Neutraal surface; destructief rood — zelfde mapping overal |

Lijst-swipe: [overlays-forms](application/overlays-forms.md). Destroy-taal en undo: [controls](application/controls.md).
