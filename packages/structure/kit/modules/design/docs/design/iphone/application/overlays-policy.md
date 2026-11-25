# UI iPhone — overlays · policy

> **Role:** Stack/libraries + overlay taxonomy.
> **Not here:** focus and toasts ([overlays-focus-toasts](overlays-focus-toasts.md)); forms ([overlays-forms](overlays-forms.md)); showcase dialogs ([overlays.md](../../desktop/landingpage/overlays.md)).

## 1. Stack & library policy

**Do not hand-roll** what a trusted library already has. Check `package.json` first.

| Need | Library | Rule |
|------|---------|------|
| Springs, gesture-driven, interruptible | **[motion](https://motion.dev)** (Framer Motion) | **Required** for sheets, drag settle. No CSS `@keyframes` / `setTimeout` physics for gestures. |
| Hover, press, colour, rare fade | **CSS transition** | The cheapest tool; Motion not needed |
| Toasts / ephemeral status | **[Sonner](https://sonner.emilkowal.ski)** | One `<Toaster />` in the root; no custom toast stack |
| Charts (product) | Existing charts in the repo | No churn without a request |
| Showcase scroll theatre | GSAP + Lenis | Only behind the showcase gate; **never** in the product path |

**Tool ladder:** CSS transition → `@starting-style` → CSS animation → WAAPI → **Motion**. Motion as soon as: spring, exit, gesture, interrupt.

- Animate `transform` + `opacity`. No `width`/`height`/`top`/`left` per frame.

## 2. Overlay taxonomy

**Weight = intent.** Modal = interrupt. Sheet, action sheet and popover = non-blocking. On mobile a **bottom sheet is the default** for multi-field / browse / long content.

| Pattern | When |
|---------|------|
| **Bottom sheet** | **Default** multi-field, browse, swipe dismiss |
| **Action sheet** | Quick 2–N choices; danger red; backdrop dismiss |
| **Confirm dialog** | **Only** blocking / irreversible — sparingly |
| **Toast** (Sonner) | Ephemeral success/error/info; undo window — not for form field errors |
| **Message banner** | Incoming / degraded while that screen is not in focus — `--z-banner` |
| **Inline alert** | Field validation until fixed |

| Control | Meaning |
|---------|---------|
| **X** / close | Closes the modal or flow entirely |
| **←** / back | One screen back in the stack |
| Swipe down | Dismiss sheet |

Quick actions → action sheet or bottom sheet, not a new centred modal. Deep links open the **exact** content.

### Context menu

| Platform | Behaviour |
|----------|-----------|
| **Desktop** | Anchored menu; flip to fit; Delete at the bottom in red |
| **Mobile** | Long-press → the **same actions** in an action sheet — no hover-only primary |

### Tabs in overlays

| Number of peers | Pattern |
|-----------------|---------|
| **≤5** | `.ios-segmented` — [controls C2](controls.md) |
| **>5** | Sheet or list — never a shrunk desktop tabbar |

### Tooltip

Delay ~300ms; edge flip; Escape/blur dismiss; one short sentence; not the only explanation on a disabled button ([controls C6](controls.md)).

**Don't:** ad-hoc `fixed inset-0` without a portal; swapping X and ←; a hover-only context menu as the primary on touch.

## 3. Z-index stack (tokens)

One ladder — **only** `var(--z-*)`.

| Layer | Token | Typically |
|-------|-------|-----------|
| Base UI | `--z-base` | 0 |
| Sticky chrome | `--z-sticky` | 20 |
| Dock | `--z-dock` | 48 |
| Product nav | `--z-nav` | 50 |
| Fullscreen editor | `--z-fullscreen` | 55 |
| Dropdown / tray | `--z-popover` | 60 |
| Message banner | `--z-banner` | 70 |
| Sheet | `--z-sheet` | 80 |
| Nested sheet | `--z-sheet-nest` | 90 |
| Confirm / blocking | `--z-modal` | 100 |
| Toast | `--z-toast` | 110 |

- A new overlay picks **one** layer — no raw `z-[9999]`.
- Nested sheets: at most one nest; deeper = a modal or a redesign.
- The toast is always above the confirm.

| Never | Instead |
|-------|---------|
| Arms race (`9999`) | One token layer |
| Raw Tailwind `z-[n]` outside the ladder | `z-[var(--z-…)]` |

## 4. Popovers & menus (no sheet)

Notice trays, language pickers, tip popups: popover or sheet taxonomy — not a toast. Ad-hoc modals → portal+sheet/confirm, or an EXCEPTION in the project docs.

**Test:** Multi-field on a phone = sheet; Discard = confirm; ⋯ = action sheet; DevTools: sheet < nest < modal < toast.
