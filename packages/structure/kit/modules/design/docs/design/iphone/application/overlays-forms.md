# UI iPhone — overlays · forms

> **Rol:** Forms validation + iOS grouped lists.  
> **Niet hier:** focus en toasts ([overlays-focus-toasts](overlays-focus-toasts.md)); het toetsenbord ([touch-keyboard](../touch-keyboard.md)).

## 1. Forms & validation feedback

- Valideer **inline** (field-level), niet alleen op submit.
- Fouten tonen **op blur** (of submit), niet rood bij elke toetsaanslag.
- Zodra een field **errored** is → **live revalidate** tijdens typen.
- Success-check **in-field** OK — geen Sonner die focus steelt voor veld-OK.
- Fout: `aria-invalid="true"` + zichtbare caption; focus eerste invalid control.
- Success van netwerkactie → Sonner; structurele lege staat → [surfaces-states](surfaces-states.md) S1.
- Onvoltooide invoer / drafts: autosave waar draft-key bestaat; anders vragen vóór dismiss.

## 2. Field chrome (stramien)

| Deel | Regel |
|------|--------|
| **Label** | Zichtbaar — niet alleen placeholder |
| **Control** | `min-height` die 44px hit haalt waar tapbaar; **font-size ≥ 16px** |
| **Border** | `border-stroke` + surface; radius = field-token |
| **Error** | Caption onder control; kleur + icoon + tekst |
| **Hint** | Optioneel muted; verdwijnt niet als error verschijnt |

**Zes field-states:** default · hover · focus · filled · error · disabled.

**Specials:** datum (presets first), kloktijd/duur (scroll-wielen — [touch-keyboard](../touch-keyboard.md)), search (§3), file upload (§4), password (§8), mask (§7).

**Niet:** `text-sm` inputs onder 16px; placeholder als enige label.

## 3. Search fields

`type="search"` + zichtbaar label; clear ≥44 (of dense 36); debounce OK; empty query = volle lijst of empty state; recent queries bij focus; zero-results altijd uitweg.

## 4. File upload

Label zichtbaar; preview type+size+naam; eerlijke progress; queue = onafhankelijke lanes; drag op pointer, knop primair op touch; accepted types in hint.

## 5. Autosave statusmachine

Waar draft-key bestaat: **typing** → **saving** → **saved** | **offline** | **error**. Debounce ~800ms; “Saved” alleen na geslaagde write; unsaved guard bij dismiss.

## 6. Inline edit

Whisper-affordance; pixels blijven; Enter = save, Esc = cancel; blur = één gekozen pad overal; fail → rollback.

## 7. Input mask

Format in UI, store raw; paste strippen + herformatteren; validate op blur; caret volgt separators.

## 8. Password field

Live checklist; eye toggle ≥44; paste altijd; lange passphrase wint van checkbox-theater.

## 9. Date — presets first

Today / Last 7 / 30 eerst; daarna custom date field; mobile = sheet / thumb-zone.

## 10. Stepper / wizard

Groepeer op context; progress altijd zichtbaar; validate per stap; drafts bij back/refresh; busy/incomplete volgt [C6](controls.md).

## 11. Microcopy in forms

Reward-labels (“Create account”); errors = probleem + volgende stap; placeholder ≠ label; mensentaal.

## 12. Lists (iOS grouped)

- Caps section label + inset `surface` groep.
- Rijen: titel links, waarde/chevron rechts; `min-h` ≈ 44px.
- Destructive rij: rode labeltekst.
- Dividers binnen groep.
- Swipe: altijd knop-fallback; destroy volgt [controls C8](controls.md).
