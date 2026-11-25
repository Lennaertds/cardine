# Desktop — overlays

> **Role:** Menus and dialogs on the showcase.
> **Not here:** product sheets ([overlays-policy](../../iphone/application/overlays-policy.md)).

An overlay comes out of the button that opened it, or it dims the page for one task. Not half of both.

## 1. Menu

- Opens from the source button. `transform-origin` on that button. Shadow role panel, material Regular.
- Items: solid fill on hover (`--foreground` at 8%), no own glass.
- Standard actions show an icon **and** a label. 20px icon, 12px to the text.
- Esc closes. Click outside closes. Focus goes into the menu and returns to the button.
- One menu open. A second click on another menu button closes the first one first.
- Width: min 12rem, max 20rem. Longer than eight items: the menu scrolls inside, the page does not.

No action sheet from the bottom on wide. That pattern is the phone's.

## 2. Dialog

For a decision that has to stop the page (a confirmation, a short form).

- Centred, max 32rem, Regular glass or solid `--card` if the form is long. Form body preferably solid.
- Corners `--r-group`, concentric for buttons inside.
- Scrim: `--sheet-scrim`. The page behind does not scroll.
- Buttons bottom right: quiet cancel, primary confirm. Destructive only if the action can be undone or really wipes — and then the existing confirm style, not a red glass pill next to it.
- Esc closes, unless there is unsaved input; then the dialog stays and the cancel button is reachable.
- Focus stays in the dialog until it closes.

On narrow the same task may be a sheet, via the product taxonomy. No second dialog implementation.

## 3. Z-index

Only `var(--z-*)` from the existing ladder ([overlays-policy](../../iphone/application/overlays-policy.md)).

| Layer | Token family |
|-------|--------------|
| Bar | `--z-nav` |
| Menu | `--z-popover` |
| Dialog + scrim | `--z-sheet` or the existing modal step |

No `z-[100]` in a showcase component.

## 4. Toast

One toaster in the root, the same as the product ([overlays-focus-toasts](../../iphone/application/overlays-focus-toasts.md)). The landing page shows no toast to announce a section.

Visible 3–5 seconds. Not a focus thief. `aria-live="polite"`. A dialog with unsaved input asks before it closes. Destructive buttons sit away from the primary.

**Test:** a menu grows out of its button, closes with Esc, and focus returns. There is no second toaster.
