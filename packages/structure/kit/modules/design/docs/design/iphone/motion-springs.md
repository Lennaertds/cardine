# UI iPhone — motion · springs

> **Role:** Direct manipulation, interruptibility, springs.
> **Not here:** gestures and momentum ([motion-gestures](motion-gestures.md)); smoothness per frame ([motion-smoothness](motion-smoothness.md)).

## 1. Direct manipulation — 1:1 tracking

> Touch and content should move together.

- The element stays glued to the finger; respect the **grab offset** (do not snap to the centre on grab).
- Pointer Events + `setPointerCapture`.
- Keep a short **velocity/position history** (the last `pointermove`s) for release.

```js
el.addEventListener('pointerdown', (e) => {
  el.setPointerCapture(e.pointerId);
  const grabOffset = e.clientY - el.getBoundingClientRect().top;
  // track position + timestamp history for velocity
});
```

## 2. Interruptibility — the most important principle

> The thought and the gesture happen in parallel.

- **Never lock input during a transition.**
- Always animate from the **presentation value** (live on screen), never from the logical/target value on interrupt.
- **No CSS transitions/`@keyframes` for gesture-driven UI** (sheets, drag-dismiss, swipe). Those cannot be caught smoothly mid-flight. Use **springs**.
- On reverse: **blend velocity**, no hard cut ("brick wall").
- 2D motion = **separate X and Y springs**.

Sheets, chip drag, drawers must meet this. Fixed fade-ins that rarely occur may stay CSS.

## 3. Behaviour over animation — springs

### Easing = intent

| Curve | When |
|-------|------|
| **ease-out** | Default for UI enter / settle — start fast, land |
| **ease-in** / snappier exit | Dismiss; exit shorter than entrance ([motion-response](motion-response.md)) |
| **ease-in-out** | Moving between peers (tab content, indicator) |
| **linear** | Spinners / continuous loops only — never start/stop UI |
| **spring** | Gesture-driven + sparing touch feedback; no bounce on every fade |

The same curves everywhere = coherent. Ad hoc per component = stitched together.

- Springs for everything the user can **touch** (sheets, drag, swipe settle) — not for every fade.
- Parameters: **damping ratio** + **response** (no fixed "duration" in the physics sense).
  - Default UI: damping **`1.0`** (no overshoot), response **`0.3–0.4`**.
  - Momentum/flick: damping **`~0.8`**, response **`0.3–0.4`**.
- Bounce **only** if the gesture itself had momentum (flick/throw), or rare attention. No bounce on a menu fade-in.

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

**Do not animate** (frequency beats "pretty"):

| Frequency | Decision |
|-----------|----------|
| 100×/day | No animation |
| Dozens/day | Gone, or drastically shorter |
| Occasional (sheets) | Spring / standard |
| Rare | May delight |

Dense logger ticks: **instant or a ≤160ms press** — no theatre.
