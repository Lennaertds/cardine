# UI iPhone — overlays · focus/toasts

> **Rol:** Focus/keyboard a11y + Sonner toasts.  
> **Niet hier:** welke overlay wanneer ([overlays-policy](overlays-policy.md)); formulieren ([overlays-forms](overlays-forms.md)).

## 1. Focus & keyboard a11y

| Regel | Eis |
|-------|-----|
| **Ring** | Zichtbare `:focus-visible` ring op alle controls (2px token stroke) |
| **Geen kale outline** | Nooit `outline: none` zonder vervanger |
| **Trap** | Modal / blocking confirm: focus **trap** tot dismiss; sheet: trap zolang open; Escape waar pointer-dismiss bestaat |
| **Nav** | Desktop product-nav keyboard bereikbaar; geen hover-only primaire actie |

**Test:** Tab door Confirm → focus blijft in dialoog; Escape sluit; geen control zonder zichtbare focus-ring.

## 2. Toasts (Sonner)

```tsx
// layout — exactly once
<Toaster theme={resolvedTheme} position="top-center" mobileOffset={16} richColors />
```

| Intent | Call |
|--------|------|
| Success / error / info | `toast.success` / `error` / `message` |
| Async | `toast.promise` of `loading` → update zelfde `id` |
| Persist | `{ duration: Infinity }` + expliciete dismiss |
| Undo (herstelbaar) | Toast met actie “Undo” + korte duration; [controls C8](controls.md) |

**Positie (huisstandaard):** `top-center` + `mobileOffset` / safe-area — niet bottom-right of custom stack. Geen tweede toaster.

| Severity | Duration |
|----------|----------|
| Info / success | Kort (~3–4s) |
| Warning | Langer (~6–7s) |
| Error / critical | Langer of `Infinity` + expliciete dismiss |
| Undo-window | Zichtbaar tot timeout; actie blijft tappable |

### Welke surface

| Volume | Surface |
|--------|---------|
| Ephemeral na actie (+ undo) | **Toast** |
| Persistent tot clear / open | **Banner** (`--z-banner`) |
| Blocking / irreversibel | **Modal** (Confirm) |
| Unread count | **Badge** op chrome |

- Type = kleur **én** icoon — nooit alleen kleur.
- Toaster **buiten** sheet/portal stacking contexts (root).
- Theme volgt theme-provider.
- Offset boven safe-area; niet achter tabbar.

**Test:** Success toast top-center ~3–4s; Undo blijft tappable tot timeout; inkomend bericht = banner niet Sonner.
