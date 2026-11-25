# UI iPhone — overlays · focus/toasts

> **Role:** Focus/keyboard a11y + Sonner toasts.
> **Not here:** which overlay when ([overlays-policy](overlays-policy.md)); forms ([overlays-forms](overlays-forms.md)).

## 1. Focus & keyboard a11y

| Rule | Requirement |
|------|-------------|
| **Ring** | A visible `:focus-visible` ring on all controls (2px token stroke) |
| **No bare outline** | Never `outline: none` without a replacement |
| **Trap** | Modal / blocking confirm: focus is **trapped** until dismiss; sheet: trapped while open; Escape wherever pointer dismiss exists |
| **Nav** | Desktop product nav reachable by keyboard; no hover-only primary action |

**Test:** Tab through Confirm → focus stays in the dialog; Escape closes; no control without a visible focus ring.

## 2. Toasts (Sonner)

```tsx
// layout — exactly once
<Toaster theme={resolvedTheme} position="top-center" mobileOffset={16} richColors />
```

| Intent | Call |
|--------|------|
| Success / error / info | `toast.success` / `error` / `message` |
| Async | `toast.promise` or `loading` → update the same `id` |
| Persist | `{ duration: Infinity }` + explicit dismiss |
| Undo (recoverable) | Toast with an "Undo" action + short duration; [controls C8](controls.md) |

**Position (house standard):** `top-center` + `mobileOffset` / safe area — not bottom-right or a custom stack. No second toaster.

| Severity | Duration |
|----------|----------|
| Info / success | Short (~3–4s) |
| Warning | Longer (~6–7s) |
| Error / critical | Longer, or `Infinity` + explicit dismiss |
| Undo window | Visible until the timeout; the action stays tappable |

### Which surface

| Volume | Surface |
|--------|---------|
| Ephemeral after an action (+ undo) | **Toast** |
| Persistent until cleared / opened | **Banner** (`--z-banner`) |
| Blocking / irreversible | **Modal** (Confirm) |
| Unread count | **Badge** on chrome |

- Type = colour **and** icon — never colour alone.
- The toaster sits **outside** sheet/portal stacking contexts (root).
- The theme follows the theme provider.
- Offset above the safe area; not behind the tabbar.

**Test:** Success toast top-centre ~3–4s; Undo stays tappable until the timeout; an incoming message = banner, not Sonner.
