# Desktop — motion

> **Role:** How glass and sections move.
> **Not here:** the catalogue of effects ([desktop.md](../desktop.md) §3); motion in the app ([motion-springs](../../iphone/motion-springs.md)).

Motion and material are one decision. A surface that only fades reads as an accordion, not as glass.

Every movement has a cause: a pointer, an opening menu, a scroll section. Decorative motion does not exist.

## 0. Duration tokens

One set. No per-component millisecond values.

| Token | Duration | Easing | For |
|-------|----------|--------|-----|
| press | 120ms | ease-out | scale 0.98 |
| hover | 160–200ms | ease-out | highlight |
| enter | 280–400ms | ease-out or damped spring | materialising, menu open |
| exit | 60–70% of enter | same curve, shorter | closing |
| ceiling | 500ms | — | nothing longer, except a scroll-linked scene |

Entering slows down (ease-out). Leaving is shorter. Linear only for a marquee or a real progress bar.

Only `transform`, `opacity` and `filter`. Not `width`, `height`, `top` or `left`. Opacity does not linger between 0 and 0.2: fully gone, or visible.

Feedback on pointer-down within 100ms. The animation does not block the next click. A second click replaces the running movement; the end state follows the last action, not the `animationend` event.

At most one scenic movement per section. Hover and press do not count. A list may stagger at 30–50ms per item, at most six items. No per-letter stagger.

## 1. Materialising

Enter and exit of a glass surface:

- opacity 0 → 1;
- blur from about 8px to the `.glass` blur (exit reversed);
- scale from 0.96 → 1. Never from `scale(0)`.

Duration 280–400ms. Easing: ease-out, or a critically damped spring (damping 1, response 0.3–0.4). No ease-in. No bounce.

`prefers-reduced-motion: reduce` → the end state immediately. No blur animation, no scale.

## 2. Interaction

- Hover highlight: 160–200ms, ease-out. Fine pointer only.
- Press: 120ms to scale 0.98.
- A control that momentarily "lifts" in glass (slider knob, switch) returns to rest. No permanent shimmer loop.
- A menu opens from the button: same origin, the shadow goes from role control to role panel. Duration ≤ 320ms. Closing is the same way back, at the velocity of a pointer that swipes it away — otherwise the reverse curve.

No per-letter stagger. No bounce on panels.

## 3. Scroll

**Scroll-driven motion only behind the showcase gate**, and only on showcase routes. The product gets no scroll theatre: no pin, no scroll-linked reveal, no Lenis/GSAP there.

- One pinned scene at a time. Do not pin the hero as well.
- Parallax at most a few percent. The image stays sharp; the LCP image does not wait on a script.
- A text reveal ends in readable text. `prefers-reduced-motion: reduce` → end state immediately; no scroll-linked animation, no smooth scroll hijacking the wheel.
- Smooth scroll (Lenis or equivalent) turns off under reduced-motion and on narrow.
- Section dots or a progress bar are buttons: focusable, they activate the section.

GSAP and Lenis stay out of the product bundle. [desktop.md](../desktop.md).

## 4. Interrupting

- An animation the user dismisses stops from the current value. No playing to the end.
- An open menu closes when a second menu opens. One overlay.
- A window that loses focus (a dialog in front): the glass behind it goes quieter (slightly higher tint, no highlight animation), it does not dim to a second scrim.

## 5. Prohibited

| Prohibited | Instead |
|------------|---------|
| `transition: all` | opacity, transform, filter, background-color |
| `ease-in` on UI | ease-out or damped spring |
| Endless glow pulse | still at rest |
| Scroll jack that traps the page without dots | natural scroll + dots as an extra |
| Scroll theatre in the product (pin, scroll reveal, Lenis) | showcase gate only; the product stays still |
| Motion as the only feedback in product flows | product rules |

**Test:** reduced-motion on the landing page shows every section in its end state, the marquee stands still, and no smooth-scroll script loads that hijacks the wheel.
