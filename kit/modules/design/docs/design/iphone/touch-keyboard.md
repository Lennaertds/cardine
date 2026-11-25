# UI iPhone — touch · keyboard

> **Role:** Keyboard & composers.
> **Not here:** forms ([overlays-forms](application/overlays-forms.md)); focus ([overlays-focus-toasts](application/overlays-focus-toasts.md)).

## 1. Keyboard & composers

- Viewport meta: `interactive-widget=resizes-content` so the Android keyboard shrinks the layout.
- Fixed composers: stay above the keyboard — listen to `visualViewport` resize/scroll if `dvh` is not enough.
- Sheet + focused input: scroll the sheet body to the focused field; padding-bottom ≥ keyboard + safe area.
- Search sheets: phone = **full height, top-anchored**; height/top from `visualViewport` so results sit right under the search field and actions stay above the keyboard. Never `items-end` plus a shrinking list.
- Composer inputs: **always ≥ 16px**.

### Composer anatomy

| Part | Rule |
|------|------|
| Field | Field chrome [overlays-forms](application/overlays-forms.md) |
| Send | Primary or icon button ≥44; disabled when empty |
| Attach (optional) | Secondary / icon; not the only path |

### Native `<select>`

- Use sparingly; same min-height ≥44 where tappable.
- Visible label; no custom dropdown that is hover-only on touch.

### Time & duration (no phone keyboard)

- Time / duration: **scroll wheels** — not `type=text` + numeric keyboard, not native `type=time` (AM/PM locale).
- One visible colon (`:`) between the hours and minutes wheels; the value is always `HH:MM` (duration: total minutes underneath).
- Aria labels localised.

**Test:** composer: 16px input, send ≥44, the keyboard does not cover send on Android. Time fields: scroll, no keyboard.
