# UI iPhone — motion · gestures

> **Role:** Velocity, momentum, spatial, rubber band, gesture checklist.
> **Not here:** springs ([motion-springs](motion-springs.md)); smoothness per frame ([motion-smoothness](motion-smoothness.md)).

## 1. Velocity handoff

On release the animation must **continue at the exact finger velocity** — no seam between drag and spring.

```
relativeVelocity = gestureVelocity / (targetValue − currentValue)  // if the API wants it normalised
```

Motion/Framer: often absolute px/s via `velocity`.

## 2. Momentum projection

> Take a small input and make a big output.

Do not snap to the nearest boundary from the release point. **Project** the resting position with the velocity (scroll deceleration), then snap to the target closest to that projection.

```js
// decelerationRate ≈ 0.998 (scroll); 0.99 snappier
function project(initialVelocity /* px/s */, decelerationRate = 0.998) {
  return (initialVelocity / 1000) * decelerationRate / (1 - decelerationRate);
}
const projectedEndpoint = currentPosition + project(releaseVelocity);
const target = nearestSnapPoint(projectedEndpoint);
animateSpringTo(target, { velocity: releaseVelocity });
```

Use this for bottom sheets and horizontal carousels/boards.

## 3. Spatial consistency

- **Enter and exit along the same path.** In from the right → out to the right.
- **Anchor to the source.** Popover/menu/sheet: `transform-origin` towards the trigger. (Modals that are truly viewport-centred: centre is fine.)
- Mirror easing on reversible transitions (inverse cubic-bézier).
- No `scale(0)`: enter from ≥ `scale(0.95)` + opacity.

## 4. Hint in the direction of the gesture

Intermediate frames must **telegraph** the outcome — no blind interpolation.

## 5. Rubber banding

A hard stop = "frozen". Progressive resistance fits the edge.

```js
function rubberband(overshoot, dimension, constant = 0.55) {
  return (overshoot * dimension * constant) / (dimension + constant * Math.abs(overshoot));
}
```

Sheets and horizontal boards: rubber band at the edges.

## 6. Gesture design checklist

- **Tap:** highlight on touch-down; commit on touch-up; ~10px hit padding; cancel by dragging away.
- **Drag/swipe:** ~10px hysteresis before the direction commits, then 1:1.
- Detect plausible gestures **in parallel** from the first move; cancel losers as soon as the intent is clear. Avoid only-final events (`swipeleft`).
- Minimise disambiguation delays (double-tap only where needed).
- Horizontal surfaces: explicit `touch-action` (`pan-x pan-y` if the page must scroll vertically too).

## 7. Swipe actions

| Rule | Detail |
|------|--------|
| **Affordance hint** | Without a hint almost nobody discovers swipe — peek, ⋯, or a first-run cue |
| **Friction on destroy** | Partial swipe = show the button; full swipe only with undo/confirm |
| **Never swipe-only** | Always a button / long-press / detail fallback (a11y + discoverability) |
| **Colour = consequence** | Neutral surface; destructive red — the same mapping everywhere |

List swipe: [overlays-forms](application/overlays-forms.md). Destroy language and undo: [controls](application/controls.md).
