# UI iPhone — folds / accordion

> **Role:** `<details>` folds, Settings blocks, deep-link open.
> **Not here:** sheets and dialogs ([overlays-policy](overlays-policy.md)).

## F1. When a fold

| Use | Pattern |
|-----|---------|
| Secondary Settings blocks | `FoldSection` / `<details>` |
| Long optional content under the fold | Not for primary navigation or tab peers |

| Mode | Behaviour |
|------|-----------|
| **Accordion** | Exactly **one** panel open; opening A closes B |
| **Disclosure** | Several open at once |

**Don't:** a fold as a replacement for a sheet on multi-step forms; not as a tab (→ `.ios-segmented` — [controls C2](controls.md)).

## F2. Anatomy

| Part | Rule |
|------|------|
| Header | **Button** (or summary with the button role); `aria-expanded` + `aria-controls`; Enter/Space |
| Summary / hit | Min. hit 44px high |
| Chevron | Rotates open/closed; the **same timing curve** as the panel |
| Title | Type-caption / headline — [materials-type](../materials-type.md) |
| Body | Solid surface or grouped rows; no glass in the fold body |
| Motion | Height via the `0fr→1fr` grid or a measured height — not a `height: auto` spring |

## F3. Deep link

- A hash / helper opens one named fold.
- After opening: scroll the fold into view; one behaviour per app (keep the hash or clear it).
- An invalid hash = no-op.

## F4. Settings apply model

| Field kind | Apply |
|------------|-------|
| Light toggles / prefs | **Instant** (optimistic; rollback + toast on failure) |
| Identity (email, password, account) | Explicit **Save / Cancel** |

| Layout | Rule |
|--------|------|
| Grouping | By **task / intent**, not by data model |
| Danger | At the bottom / a separate zone — [controls C8](controls.md) |

## F5. Never

| Never | Instead |
|-------|---------|
| Nested folds > 1 deep | Flatten or use a sheet |
| A fold without a summary label | Always a readable summary |
| An accordion that lets several open | One open, or name it a disclosure |
| A chevron out of sync with the panel | The same duration/easing |
