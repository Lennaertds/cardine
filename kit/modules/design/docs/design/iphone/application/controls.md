# UI iPhone — controls

> **Role:** Buttons, chips, segmented, toggles, icon, pending.
> **Not here:** showcase buttons ([controls.md](../../desktop/landingpage/controls.md)); touch surfaces ([touch-targets](../touch-targets.md)).

## C1. Button hierarchy (product)

| Role | Visual | Class / pattern | Min. target |
|-----|---------|-----------------|-------------|
| **Primary** | Accent fill, `text-on-accent` | `.btn-primary` of `.action-primary` | ≥ **44×44** (`--hit-min`) |
| **Secondary** | Border / muted fill | `.hug` + `border-stroke` | ≥ 44 |
| **Destructive** | Red in confirm / ActionRow danger | Confirm / ActionRow | ≥ 44 |
| **Icon** | Glyph only | `.icon-btn` — glyph ~22–24px | ≥ 44 |
| **Dense** | Compact logger/chips | `.dense-control` | **36–40** |

**Do:** ActionRow max 2 pills + `⋯`; in-flight pending = C6 busy; incomplete form = enabled + validate on click; one radius system per row.
**Don't:** ad-hoc `bg-accent rounded-full` next to `.btn-primary` on the same screen; emoji-only primary.

**Test:** Primary actions on core screens = C1 classes or ActionRow.

## C2. Segmented control

| | |
|--|--|
| **When** | 2–5 **peers** (scope, filter) |
| **Class** | `.ios-segmented` (+ compact / scroll-varianten indien nodig) |
| **Type** | `--type-tab` |
| **Not** | On/off → C3 |

## C3. Chips & toggles

| Pattern | When | Rule |
|---------|---------|--------|
| **Filter chip** | Multi-select / snelle filters | `.chip-on` selected; hit dense of 44 |
| **Boolean** | One on/off | checkbox or `role="switch"` + visible state |
| **Radio** | Exactly one out of N | native radio or segmented if N≤5 peers |

**Filter chips — three states:** idle (outline) · active (filled `.chip-on`) · disabled.

| Rule | Do | Don't |
|-------|-----|------|
| **Count** | Result count in the **same frame** as the filter tap | A count that jumps a frame later |
| **Clear-all** | Multi-active: one tap clears all filters | Per-chip clear only, with no escape |
| **Layout** | Horizontal scroll + edge fade is OK | A multi-row chip wall |

**Toggle:** ~250ms ease-out; rail + knob + label in sync; light toggles optimistic + rollback; Space + `aria-checked`.

**Don't:** a chip row that is tabs; a chip + segmented control for the same choice.

## C4. Icon buttons

- Only `.icon-btn` (or the ActionRow icon slot).
- `aria-label` required if there is no visible text.
- Sheet close / settings gear = icon button ≥44.

## C5. Steppers & drag

- Dense steppers are OK inside `.dense-control`.
- Drag lists: Motion + haptic on commit/snap only.

**Slider:** filled track = value; full-row hit ≥ dense or 44; snap to round values; arrows/Home/End where focusable.

## C6. Pending vs incomplete

| Situation | Behaviour |
|----------|--------|
| **Incomplete form** | Submit stays **enabled**. Click → field errors + focus the first invalid one ([overlays-forms](overlays-forms.md)). |
| **In-flight request** | Busy: no double submit; label `…`; `aria-busy` where relevant. |
| **Not** | Disabled as the only explanation path for missing fields |

**Test:** Empty field → the button is clickable, inline errors; Save during a request → no second submit.

## C7. Never

| Never | Instead |
|-------|---------|
| A third primary style | C1 |
| Hover-only primary | Touch-pad |
| Chip-rij = tabs | `.ios-segmented` |
| Disabled submit as the only feedback on an incomplete form | C6 |

## C8. Destructive language

| Rule | Do | Don't |
|-------|-----|------|
| **Verb labels** | "Delete …", "Discard …" | Yes / No / OK / Confirm |
| **Red budget** | Red only for destruction | Red for Save or brand colour |
| **Off the happy path** | Delete not in the primary button position | The same place as Save |
| **Geography** | Danger at the bottom or ActionRow danger | Destructive next to primary |
| **Confirm (high risk)** | Confirm or hold to confirm | An extra Yes/No without a verb |
| **Undo (recoverable)** | Optimistic + Sonner undo | Confirm for every soft remove |
| **Purge friction** | **Either** type the name **or** hold — not both | Type + hold + confirm |

Confirm stays sparse ([overlays-policy](overlays-policy.md)). [materials-principles](../materials-principles.md).

**Test:** Destructive action: a verb on the button, red only there, primary stays Save.
