# UI iPhone — touch · targets

> **Role:** Tab transitions + touch targets.
> **Not here:** buttons ([controls](application/controls.md)); haptics ([touch-haptics](touch-haptics.md)).

## 1. Tab transitions

Tabs are **peers**, not a hierarchy.

- **No full-screen slide** between product tabs as if it were a stack push.
- Interactive peek (finger 1:1) + spring settle with velocity/momentum is allowed — that is gesture feedback, not a "page push".
- Commit: spring from the presentation value; **no** `setTimeout` lock that blocks input ([motion-springs](motion-springs.md)).
- Reduced motion: cross-fade or instant; no peek theatre.

## 2. Touch targets & dense controls

| Surface | Target |
|---------|--------|
| Primary product CTA | ≥ **44×44px** (or hitSlop / padding that reaches it) |
| Tabbar items, top-nav taps | ≥ 44px touch |
| **Dense controls** (chips, steppers, compact rows) | May be **36–40px** visually — **only** in a documented dense context; always ≥ 16px type on inputs |
| Action-row primary pills | ≥ 44px height |
| Dense secondary text buttons | min `--hit-dense` (36px) — never a 16px high `button` |
| Stand-alone text links + small avatars | Visually small is fine; hit ≥ 36–44px through `::after` hitSlop — no layout change |

Exceptions must be recognisable in a code comment / `.dense-control` — no silent `h-8` on primary Confirm.

**Test:** `elementFromPoint` around a quiet link hits the link; dense secondary button computed height ≥ 36; header avatar effective hit ≥ 44×44.

## 3. Hover trap

Touch fakes hover: the first tap = sticky hover; actions stay "open" until you tap elsewhere.

| Rule | Detail |
|------|--------|
| **No primary behind hover** | Hover only for extras (favourite, overflow). The job is always visible/tappable |
| **Touch home** | Actions in the card, the swipe pad, or a sheet — not only desktop hover |
| **Capability media** | All `:hover` / `hover:` inside `@media (hover: hover) and (pointer: fine)` — no UA sniffing |
| **Coarse pointer** | `(pointer: coarse)` → bigger controls; hit ≥ 44px (or the dense exception in §2) |

The same gate as [motion-response](motion-response.md). Primary only behind hover: [never-checklist](never-checklist.md).

## 4. Thumb zone

The primary action sits where the thumb of a one-handed phone reaches: the lower half, not in a corner above the notch.

- Product tabs sit in the bottom tabbar, above `safe-area-inset-bottom`. Scrolling may hide/show the bar per project chrome.
- A primary button may not live only in the header if that is the only way to do the job.
- The landing page has one primary action in the first viewport, at least 44px, not behind the home indicator.
- Desktop application: the same actions, reachable by keyboard. The thumb zone does not apply there.
