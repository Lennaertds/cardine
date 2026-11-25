# UI iPhone — materials · principles

> **Role:** Eight principles, process, quick reference.
> **Not here:** material and depth ([materials-depth](materials-depth.md)); motion ([motion-springs](motion-springs.md)).

## 1. Eight design principles

1. **Purpose** — intent; decide what you do *not* build.
2. **Agency** — the user is in control; undo; confirm only for destructive/irreversible.
3. **Responsibility** — privacy at the right moment; safe with data/AI.
4. **Familiarity** — metaphors + consistent behaviour (same look = same place/behaviour).
5. **Flexibility** — iPhone = quick touch; desktop showcase = pointer depth; inclusive.
6. **Simplicity — not minimalism** — strip noise; common path first; sometimes adding context makes it simpler.
7. **Craft** — every spacing/timing/alignment is defensible.
8. **Delight** — a consequence of 1–7, not confetti on top.

In practice:

- Kinds of feedback: status · completion · warning · error.
- **Wayfinding** on every screen: Where am I? Where can I go? What's there? How do I get out?
- Proximity = relation; controls close to what they affect.
- Specific labels ("Progress") > vague catch-alls — except fixed product tab names.

### One thing · choice overload · cognitive load

| Wet | Regel |
|-----|-------|
| **Hick** | Every screen asks for **one** primary thing. The rest is secondary ("More", overflow). |
| **Choice overload** | Not 24 options at once; one question or a small set first. |
| **Cognitive load** | Group, space, fewer simultaneous choices. No wall of controls. |
| **Wizard / steps** | Multi-step is OK with **one question per step** + visible progress. |
| **Proximity** | Within-group spacing smaller than between-group. |
| **Similarity** | Same colour/shape/size = a group; recolouring or a different radius splits it. |
| **Figure-ground** | Dim/blur the background → overlay/sheet as the figure. |
| **Serial position** | Highest value first **and** last (bookends). |
| **Peak-end** | Flows have one memorable peak + a strong close. |
| **Von Restorff** | One isolation against a calm baseline (one accent CTA). |
| **Visual hierarchy** | Size / contrast / whitespace / one accent action. |

**Test:** Onboarding shows one CTA; Settings does not dump peers without sections; wizards = one question per step.

## 2. Process

- An interactive prototype > a million static mocks.
- Design interaction and visuals **together** — motion is not an afterthought.
- Test on real hardware + real context; sometimes review motion in slow motion.

## 3. Quick reference

| Need | Technique | Concrete |
|------|-----------|----------|
| Default UI spring | Critically damped | damping 1.0, response 0.3–0.4 |
| Flick spring | Slight bounce | damping ~0.8, response 0.3–0.4 |
| Gesture → spring | Velocity handoff | release velocity |
| Flick land | Momentum project | `current + (v/1000)·d/(1−d)`, d≈0.998 |
| Interrupt | Presentation value | read the live transform |
| Reverse | Carry velocity | no brick wall |
| Reversible path | Mirror easing | inverse cubic-bézier |
| Commit vs reverse | Velocity **sign** | bij release |
| 1:1 drag | Pointer + capture | grab offset |
| Feedback | Pointer-down, continuous | never the end state only |
| Boundary | Rubber-band | progressive |
| Chrome | Translucent + blur | content scrolls underneath |
| Tracking | Size-specific | display −0.02em; body ~0 |
| Reduced motion | Cross-fade | media query |
