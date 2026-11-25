# Design

> **Role:** Entry point for every UI task. Principles, what is never allowed, where the tokens live, and the map to one craft file.
> **Not here:** what it does (`product/`), component code (`apps/web/src/components/`).

Open this file for every task about UI, screen, layout, PWA, look or craft. Then pick **one** craft file below. Do not load a whole folder.

Kit craft under `shared/` (and later desktop/iphone) is the **house standard**. Add project chrome and IA below; never override the shared floor more loosely.

## Principles

1. <e.g. "One action per screen is primary; the rest is secondary."> *(Slice 0 fills in the house standard.)*

## Never

Site-wide: [shared/never.md](shared/never.md). A surface may be stricter through its never-checklist.

- <e.g. project extras here>

## Tokens

The values live in the code, not here: <`apps/web/src/styles/tokens.css`>. Here is only what they mean.

| Token | Meaning |
|-------|---------|
| <`--color-accent`> | <the primary action> |

## 1. Shared — all surfaces

| File | Question |
|------|----------|
| [shared/a11y.md](shared/a11y.md) | Focus, contrast, reduced-motion, reduced-transparency |
| [shared/never.md](shared/never.md) | What the whole site may not do |
| [shared/glass.md](shared/glass.md) | The one `.glass` class, and where it lives |

## 2. Desktop — gate and weight

On desktop: the [gate](desktop/desktop.md) first. Then, if it applies: [performance](desktop/performance.md) or [a11y](desktop/a11y.md) (keyboard path through the showcase).

| File | Question |
|------|----------|
| [desktop/desktop.md](desktop/desktop.md) | When cinematic is allowed; catalogue; never in the product path |
| [desktop/performance.md](desktop/performance.md) | Lazy, CLS, no showcase libraries in the product |
| [desktop/a11y.md](desktop/a11y.md) | Tab order and pointer on the landing page |

## 3. Showcase — desktop landing page

`desktop/landingpage/`. The source for the showcase look. A project may add rows (beats, personality); never override the house standard more loosely.

| File | Question |
|------|----------|
| [chrome.md](desktop/landingpage/chrome.md) | Floating bar, groups, sidebar |
| [layout.md](desktop/landingpage/layout.md) | Column and rhythm |
| [type.md](desktop/landingpage/type.md) | Showcase type |
| [looks.md](desktop/landingpage/looks.md) | Colour, shadow, radius |
| [liquid-glass.md](desktop/landingpage/liquid-glass.md) | Regular versus Clear, where glass is not allowed |
| [principles.md](desktop/landingpage/principles.md) | Hierarchy and harmony |
| [controls.md](desktop/landingpage/controls.md) | Buttons on the landing page |
| [motion.md](desktop/landingpage/motion.md) | Materialising, morph, scroll |
| [surfaces.md](desktop/landingpage/surfaces.md) | Solid content, one glass panel |
| [images.md](desktop/landingpage/images.md) | Images and text on photos |
| [icons.md](desktop/landingpage/icons.md) | One SVG family |
| [overlays.md](desktop/landingpage/overlays.md) | Menu out of the button |
| [ux.md](desktop/landingpage/ux.md) | Goal, copy, links |
| [charts.md](desktop/landingpage/charts.md) | Demo chart |
| [never-checklist.md](desktop/landingpage/never-checklist.md) | What the showcase may not do on top of that |

## 4. iPhone — floor (both phone surfaces)

Files directly in `iphone/` — not for the cinematic desktop landing page.

| File | Question |
|------|----------|
| [touch-targets.md](iphone/touch-targets.md) | 44px, dense, thumb zone, hover gate |
| [touch-haptics.md](iphone/touch-haptics.md) | When the phone vibrates |
| [touch-keyboard.md](iphone/touch-keyboard.md) | Keyboard and composers |
| [motion-response.md](iphone/motion-response.md) | A tap answers immediately; safe area |
| [motion-springs.md](iphone/motion-springs.md) | Springs, interrupting |
| [motion-gestures.md](iphone/motion-gestures.md) | Velocity, momentum |
| [motion-smoothness.md](iphone/motion-smoothness.md) | Frames stay smooth |
| [materials-depth.md](iphone/materials-depth.md) | Where product glass lives |
| [materials-type.md](iphone/materials-type.md) | Product ladder |
| [materials-principles.md](iphone/materials-principles.md) | Eight principles + cognitive laws |
| [materials-a11y.md](iphone/materials-a11y.md) | Feedback without motion |
| [never-checklist.md](iphone/never-checklist.md) | Review of the application |

## 5. Application — iPhone (source)

`iphone/application/`. The desktop application does not repeat these files; a project fills in wide chrome separately.

| File | Question |
|------|----------|
| [controls.md](iphone/application/controls.md) | Buttons, chips, toggles, pending |
| [surfaces-states.md](iphone/application/surfaces-states.md) | Empty, loading, error |
| [surfaces-cards.md](iphone/application/surfaces-cards.md) | When something is a card |
| [surfaces-sticky-heads.md](iphone/application/surfaces-sticky-heads.md) | A header sticks inside a surface |
| [overlays-policy.md](iphone/application/overlays-policy.md) | Overlay type and z-index |
| [overlays-forms.md](iphone/application/overlays-forms.md) | Fields and lists |
| [overlays-focus-toasts.md](iphone/application/overlays-focus-toasts.md) | Focus and one toaster |
| [folds.md](iphone/application/folds.md) | Accordion / disclosure / Settings apply |
| [charts.md](iphone/application/charts.md) | Product charts and stat row |

## 6. Project chrome (empty — the project fills it in)

| Question | Open |
|----------|------|
| PageShell, tabbar, PWA lat | `<project>/lat-chrome.md` — still to create |
| Session dock / live bar | `<project>/session-chrome.md` — only if the product has one |
| Product IA (tabs, routes) | product docs / chrome — not in the kit |
