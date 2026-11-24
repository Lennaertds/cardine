# Design

> **Rol:** Ingang bij elke UI-taak. Principes, wat nooit, waar de tokens staan, en de kaart naar één craft-bestand.
> **Niet hier:** wat het doet (`product/`), componentcode (`apps/web/src/components/`).

Open dit bestand bij elke opdracht over UI, scherm, layout, PWA, look of craft. Kies daarna **één** craft-bestand hieronder. Laad geen hele map.

Kit-craft onder `shared/` (en later desktop/iphone) is de **huisstandaard**. Project-chrome en IA vul je hieronder aan; overschrijf de gedeelde vloer niet lichter.

## Principes

1. <bv. "Eén actie per scherm is primair; de rest is secundair."> *(Slice 0 vult de huisstandaard in.)*

## Nooit

Site-breed: [shared/never.md](shared/never.md). Een vlak mag strenger zijn via zijn never-checklist.

- <bv. project-extra’s hier>

## Tokens

De waarden staan in de code, niet hier: <`apps/web/src/styles/tokens.css`>. Hier staat alleen wat ze betekenen.

| Token | Betekenis |
|-------|-----------|
| <`--color-accent`> | <de primaire actie> |

## 1. Gedeeld — alle vlakken

| Bestand | Vraag |
|---------|--------|
| [shared/a11y.md](shared/a11y.md) | Focus, contrast, reduced-motion, reduced-transparency |
| [shared/never.md](shared/never.md) | Wat de hele site niet mag |
| [shared/glass.md](shared/glass.md) | De ene class `.glass`, en waar ze zit |

## 2. Desktop — gate en gewicht

Op desktop: eerst de [gate](desktop/desktop.md). Daarna, als het raakt: [performance](desktop/performance.md) of [a11y](desktop/a11y.md) (toetsenbordpad showcase).

| Bestand | Vraag |
|---------|--------|
| [desktop/desktop.md](desktop/desktop.md) | Wanneer cinematic mag; catalogus; nooit in productpad |
| [desktop/performance.md](desktop/performance.md) | Lazy, CLS, geen showcase-libs in product |
| [desktop/a11y.md](desktop/a11y.md) | Tab-volgorde en pointer op de landing |

## 3. Showcase — landingspagina desktop

`desktop/landingpage/`. Bron voor showcase-look. Project mag rijen toevoegen (beats, personality); overschrijf de huisstandaard niet lichter.

| Bestand | Vraag |
|---------|--------|
| [chrome.md](desktop/landingpage/chrome.md) | Zwevende balk, groepen, sidebar |
| [layout.md](desktop/landingpage/layout.md) | Kolom en ritme |
| [type.md](desktop/landingpage/type.md) | Showcase-type |
| [looks.md](desktop/landingpage/looks.md) | Kleur, schaduw, radius |
| [liquid-glass.md](desktop/landingpage/liquid-glass.md) | Regular versus Clear, waar glas niet mag |
| [principles.md](desktop/landingpage/principles.md) | Hiërarchie en harmonie |
| [controls.md](desktop/landingpage/controls.md) | Knoppen op de landingspagina |
| [motion.md](desktop/landingpage/motion.md) | Materialiseren, morph, scroll |
| [surfaces.md](desktop/landingpage/surfaces.md) | Solid content, één glaspaneel |
| [images.md](desktop/landingpage/images.md) | Beelden en tekst op foto |
| [icons.md](desktop/landingpage/icons.md) | Eén SVG-familie |
| [overlays.md](desktop/landingpage/overlays.md) | Menu uit de knop |
| [ux.md](desktop/landingpage/ux.md) | Doel, copy, links |
| [charts.md](desktop/landingpage/charts.md) | Demo-chart |
| [never-checklist.md](desktop/landingpage/never-checklist.md) | Wat de showcase extra niet mag |

## 4. iPhone — vloer (beide telefoonvlakken)

Bestanden direct in `iphone/` — niet voor de cinematic desktop-landing.

| Bestand | Vraag |
|---------|--------|
| [touch-targets.md](iphone/touch-targets.md) | 44px, dense, duimzone, hover-gate |
| [touch-haptics.md](iphone/touch-haptics.md) | Wanneer de telefoon trilt |
| [touch-keyboard.md](iphone/touch-keyboard.md) | Toetsenbord en composers |
| [motion-response.md](iphone/motion-response.md) | Tik antwoordt meteen; safe area |
| [motion-springs.md](iphone/motion-springs.md) | Springs, onderbreken |
| [motion-gestures.md](iphone/motion-gestures.md) | Velocity, momentum |
| [motion-smoothness.md](iphone/motion-smoothness.md) | Frames blijven vloeiend |
| [materials-depth.md](iphone/materials-depth.md) | Waar product-glas zit |
| [materials-type.md](iphone/materials-type.md) | Product-ladder |
| [materials-principles.md](iphone/materials-principles.md) | Acht principes + cognitieve wetten |
| [materials-a11y.md](iphone/materials-a11y.md) | Feedback zonder beweging |
| [never-checklist.md](iphone/never-checklist.md) | Review van de applicatie |

## 5. Applicatie — iPhone (bron)

`iphone/application/`. Desktop-applicatie herhaalt deze bestanden niet; project vult breed-chrome apart.

| Bestand | Vraag |
|---------|--------|
| [controls.md](iphone/application/controls.md) | Knoppen, chips, toggles, pending |
| [surfaces-states.md](iphone/application/surfaces-states.md) | Leeg, laden, fout |
| [surfaces-cards.md](iphone/application/surfaces-cards.md) | Wanneer iets een card is |
| [surfaces-sticky-heads.md](iphone/application/surfaces-sticky-heads.md) | Kop blijft plakken in een surface |
| [overlays-policy.md](iphone/application/overlays-policy.md) | Overlay-type en z-index |
| [overlays-forms.md](iphone/application/overlays-forms.md) | Velden en lijsten |
| [overlays-focus-toasts.md](iphone/application/overlays-focus-toasts.md) | Focus en één toaster |
| [folds.md](iphone/application/folds.md) | Accordion / disclosure / Settings-apply |
| [charts.md](iphone/application/charts.md) | Product-charts en stat-rij |

## 6. Project-chrome (leeg — project vult)

| Vraag | Open |
|-------|------|
| PageShell, tabbar, PWA-lat | `<project>/lat-chrome.md` — nog aanmaken |
| Sessiedock / live-bar | `<project>/session-chrome.md` — alleen als product dat heeft |
| Product-IA (tabs, routes) | product-docs / chrome — niet in kit |
