# UI iPhone — overlays · forms

> **Role:** Form validation + iOS grouped lists.
> **Not here:** focus and toasts ([overlays-focus-toasts](overlays-focus-toasts.md)); the keyboard ([touch-keyboard](../touch-keyboard.md)).

## 1. Forms & validation feedback

- Validate **inline** (field level), not only on submit.
- Show errors **on blur** (or submit), not red on every keystroke.
- Once a field is **errored** → **revalidate live** while typing.
- Success check **in-field** is fine — no Sonner that steals focus for a field OK.
- Error: `aria-invalid="true"` + a visible caption; focus the first invalid control.
- Network success → Sonner; a structural empty state → [surfaces-states](surfaces-states.md) S1.
- Unfinished input / drafts: autosave where a draft key exists; otherwise ask before dismiss.

## 2. Field chrome (framework)

| Part | Rule |
|------|------|
| **Label** | Visible — not a placeholder alone |
| **Control** | `min-height` that reaches a 44px hit where tappable; **font-size ≥ 16px** |
| **Border** | `border-stroke` + surface; radius = field token |
| **Error** | Caption under the control; colour + icon + text |
| **Hint** | Optional, muted; does not disappear when an error appears |

**Six field states:** default · hover · focus · filled · error · disabled.

**Specials:** date (presets first), clock time/duration (scroll wheels — [touch-keyboard](../touch-keyboard.md)), search (§3), file upload (§4), password (§8), mask (§7).

**Don't:** `text-sm` inputs under 16px; a placeholder as the only label.

## 3. Search fields

`type="search"` + visible label; clear ≥44 (or dense 36); debounce is fine; an empty query = the full list or an empty state; recent queries on focus; zero results always have a way out.

## 4. File upload

Visible label; preview type+size+name; honest progress; queue = independent lanes; drag with a pointer, button primary on touch; accepted types in the hint.

## 5. Autosave state machine

Where a draft key exists: **typing** → **saving** → **saved** | **offline** | **error**. Debounce ~800ms; "Saved" only after a successful write; unsaved guard on dismiss.

## 6. Inline edit

Whisper affordance; pixels stay put; Enter = save, Esc = cancel; blur = one chosen path everywhere; failure → rollback.

## 7. Input mask

Format in the UI, store raw; paste strips + reformats; validate on blur; the caret follows separators.

## 8. Password field

Live checklist; eye toggle ≥44; paste always; a long passphrase beats checkbox theatre.

## 9. Date — presets first

Today / Last 7 / 30 first; then a custom date field; mobile = sheet / thumb zone.

## 10. Stepper / wizard

Group by context; progress always visible; validate per step; drafts on back/refresh; busy/incomplete follows [C6](controls.md).

## 11. Microcopy in forms

Reward labels ("Create account"); errors = problem + next step; placeholder ≠ label; plain language.

## 12. Lists (iOS grouped)

- Caps section label + inset `surface` group.
- Rows: title left, value/chevron right; `min-h` ≈ 44px.
- Destructive row: red label text.
- Dividers inside the group.
- Swipe: always a button fallback; destroy follows [controls C8](controls.md).
