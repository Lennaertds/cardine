# UI iPhone — overlays · policy

> **Rol:** Stack/libs + overlay taxonomy.  
> **Niet hier:** focus en toasts ([overlays-focus-toasts](overlays-focus-toasts.md)); formulieren ([overlays-forms](overlays-forms.md)); dialogen op de showcase ([overlays.md](../../desktop/landingpage/overlays.md)).

## 1. Stack & library policy

**Niet hand-rollen** wat al een trusted library heeft. Check eerst `package.json`.

| Need | Library | Regel |
|------|---------|--------|
| Springs, gesture-driven, interruptible | **[motion](https://motion.dev)** (Framer Motion) | **Verplicht** voor sheets, drag-settle. Geen CSS `@keyframes` / `setTimeout`-physics voor gestures. |
| Hover, press, color, rare fade | **CSS transition** | Goedkoopste tool; Motion niet nodig |
| Toasts / ephemeral status | **[Sonner](https://sonner.emilkowal.ski)** | Eén `<Toaster />` in root; geen custom toast-stack |
| Charts (product) | Bestaande charts in repo | Geen churn zonder vraag |
| Showcase scroll theater | GSAP + Lenis | Alleen achter showcase-gate; **nooit** in productpad |

**Tool-ladder:** CSS transition → `@starting-style` → CSS animation → WAAPI → **Motion**. Motion zodra: spring, exit, gesture, interrupt.

- Animeer `transform` + `opacity`. Geen `width`/`height`/`top`/`left` per frame.

## 2. Overlay taxonomy

**Weight = intent.** Modal = interrupt. Sheet, action sheet en popover = non-blocking. Op mobile is **bottom sheet de default** voor multi-field / browse / lange content.

| Pattern | Wanneer |
|---------|---------|
| **Bottom sheet** | **Default** multi-field, browse, swipe-dismiss |
| **Action sheet** | Snelle 2–N keuzes; danger rood; backdrop dismiss |
| **Confirm dialog** | **Alleen** blocking / irreversibel — spaarzaam |
| **Toast** (Sonner) | Ephemeral success/error/info; undo-window — niet voor form field errors |
| **Message banner** | Inkomend / degraded terwijl dat scherm niet focus is — `--z-banner` |
| **Inline alert** | Field validation tot fix |

| Control | Betekenis |
|---------|-----------|
| **X** / close | Sluit de modal of flow helemaal |
| **←** / back | Één scherm terug in de stack |
| Swipe down | Dismiss sheet |

Quick actions → action sheet of bottom sheet, niet een nieuw centered modal. Deeplinks openen de **exacte** content.

### Context menu

| Platform | Gedrag |
|----------|--------|
| **Desktop** | Anchored menu; flip-to-fit; Delete onderaan rood |
| **Mobile** | Long-press → **zelfde acties** in action sheet — geen hover-only als primary |

### Tabs in overlays

| Aantal peers | Patroon |
|--------------|---------|
| **≤5** | `.ios-segmented` — [controls C2](controls.md) |
| **>5** | Sheet of list — nooit een shrunk desktop-tabbar |

### Tooltip

Delay ~300ms; edge-flip; Escape/blur dismiss; één korte zin; niet als enige uitleg op disabled knop ([controls C6](controls.md)).

**Niet:** ad-hoc `fixed inset-0` zonder portal; X en ← omwisselen; hover-only context menu als primary op touch.

## 3. Z-index stack (tokens)

Eén ladder — **alleen** `var(--z-*)`.

| Laag | Token | Typisch |
|------|-------|---------|
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

- Nieuwe overlay kiest **één** laag — geen raw `z-[9999]`.
- Nested sheets: max één nest; dieper = modal of redesign.
- Toast altijd boven confirm.

| Never | Instead |
|-------|---------|
| Arms race (`9999`) | Eén token-laag |
| Raw Tailwind `z-[n]` buiten de ladder | `z-[var(--z-…)]` |

## 4. Popovers & menus (geen sheet)

Notice trays, language pickers, tip popups: popover of sheet-taxonomy — niet toast. Ad-hoc modals → portal+sheet/confirm of EXCEPTION in project-docs.

**Test:** Multi-field op phone = sheet; Discard = confirm; ⋯ = action sheet; DevTools: sheet < nest < modal < toast.
