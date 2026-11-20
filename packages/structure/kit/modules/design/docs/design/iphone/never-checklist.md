# UI iPhone — never ship & review

> **Rol:** Never-ship + agent review-checklist.  
> **Niet hier:** site-breed ([never.md](../shared/never.md)).

## 1. Never ship

| Never | Instead |
|-------|---------|
| Hand-rolled sheet physics (keyframes + timeout) | Motion springs + velocity |
| Sliding full pages between tabs | Peek/spring of none |
| Ungated `:hover` | `(hover: hover) and (pointer: fine)` |
| `user-scalable=no` | 16px inputs |
| `100vh` app shell | `100dvh` |
| `transition: all` | Named properties |
| `scale(0)` enter | ≥ `scale(0.95)` + opacity |
| `ease-in` on UI | `ease-out` / spring |
| Glass on dense content tables | Solid surface |
| Toast voor form field errors | Inline validation |
| Haptic op elke herhaalde tick | Alleen commit/snap/success |
| Primary CTA `< 44px` buiten dense-exception | ≥ 44px of documented exception |
| Tweede `<Toaster />` | Eén in root |
| Showcase GSAP in product path | Showcase-gate only |
| “Fixed” na alleen Chrome device toolbar | Real iPhone PWA check |
| Ad-hoc sticky / half-radius | Craft sticky-heads; korte titels → geen sticky |
| X en ← omgewisseld | X = flow dicht; ← = één stap terug ([overlays-policy](application/overlays-policy.md)) |
| Leeg wit bij load | Skeleton / caption / chrome ([surfaces-states](application/surfaces-states.md)) |
| Terug naar feed/lijst reset scroll naar 0 | Exacte scrollpositie behouden |
| Mutatie wacht op server vóór UI | Optimistic + achtergrond-sync ([surfaces-states](application/surfaces-states.md)) |
| OS-permissions bij first launch / login | Vragen pas bij de feature |
| Push/deeplink landt op kale Home | Exacte content |
| Disabled submit als enige uitleg bij incomplete form | Enabled + validate on click ([controls](application/controls.md)) |
| Primary actie alleen achter hover | Touch-pad + `(hover: hover) and (pointer: fine)` |
| Raw `z-[9999]` / z-arms race | Alleen `var(--z-*)` ([overlays-policy](application/overlays-policy.md)) |
| Confirm voor elke herstelbare remove | Optimistic + undo-toast waar undo-pad geldt |
| Type-naam **en** hold op één purge | Of type, of hold |
| Placeholder als enig label | Persistent label ([overlays-forms](application/overlays-forms.md)) |
| Generieke knoplabels (“Submit”, “OK”) | Reward / verb label |
| Systeem-speak (“Invalid input”) | Mensentaal + volgende stap |
| Parallax / glow als product-diepte | Solid surface + spaarzame elevation ([materials-depth](materials-depth.md)) |
| Whole-card scale / glow-hover als diepte | Vaste footprint; lift alleen fine-pointer ([surfaces-cards](application/surfaces-cards.md)) |

## 2. Agent review-checklist

0. Type gedekt? → [DESIGN.md](../DESIGN.md). Controls → [controls.md](application/controls.md). Empty/loading/error → [surfaces-states.md](application/surfaces-states.md).
1. Voelt het als iOS: press-down, interruptible sheets, glass chrome, solid grouped content?
2. Geen dubbele chrome; één job; targets/exceptions correct; inputs ≥16px; safe-area.
3. Gesture-driven = **Motion** springs + velocity; geen locked CSS mid-gesture.
4. Overlay-type klopt (sheet / confirm / toast / action sheet); z = `var(--z-*)`.
5. Materials: geen light-on-light glass; vibrancy; contrast/transparency prefs.
6. Hover gated; overscroll root/contain; composer niet gezoomed.
7. Haptics binnen map; één toaster voor ephemeral; inline voor form errors.
8. Showcase-extra’s niet in productpad gelekt.
9. Device check expliciet waar needed.

UI-review output: markdown-tabel **Before | After | Why**.

## 3. Audit-protocol + definition of done

**Fail** = breekt een OK-regel in craft, of gebruikt raw overlay-`z-[n]` / ad-hoc empty / derde button-stijl zonder EXCEPTION.

### Audit-walk (bij craft-wijziging of nieuwe feature)

| Stap | Wat |
|------|-----|
| 1 | Open [DESIGN.md](../DESIGN.md) → kies type-rij |
| 2 | Open **één** craft-file die die rij noemt |
| 3 | Bouw / fix; Test-zin in die craft-file groen |
| 4 | Prioriteitsschermen glance (project-IA) |
| 5 | Overlays · auth · showcase alleen als geraakt |
| 6 | Per fail: code-fix **of** EXCEPTION-rij in project-docs (reden + file:§) |

### DoD — nieuwe product-UI feature

- [ ] Coverage-type bestaat; anders craft + coverage-rij toevoegen vóór ship
- [ ] Primaire CTA = primary-class / ActionRow (geen derde accent-pill)
- [ ] Lijst-empty/loading = EmptyState ([surfaces-states](application/surfaces-states.md))
- [ ] Overlay = portal + sheet / confirm / taxonomy (geen losse `createPortal`+`fixed inset-0`)
- [ ] Titels = `.page-title` / `.type-headline`; body = `.type-body`; meta = `.type-caption`; stats = `.type-stat` ([materials-type](materials-type.md))
- [ ] Fonts = `--font-sans` (product); geen vierde webfont
- [ ] Overlay-z = `z-[var(--z-*)]` alleen
- [ ] Device: iPhone-PWA als touch geraakt; showcase niet zwaarder maken

## 4. Uitzonderingen

Geen stille uitzonderingen. Elke afwijking documenteert het project (reden + file:§). Kit-E1–E6 uit GymFreak horen hier **niet** — die blijven product-eigen.

## 5. Scope elders

- Desktop-gate → [desktop.md](../desktop/desktop.md). Kaart → [DESIGN.md](../DESIGN.md).
- Niet in scope van de kit: een native app. Haptic- en tab-principes blijven de telefoon-craft in deze map.
