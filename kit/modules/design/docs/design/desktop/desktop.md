# Desktop — gate

> **Rol:** Wanneer de landingspagina / showcase cinematic mag, en wat desktop-extra’s niet mogen raken.  
> **Niet hier:** craft-kaart ([DESIGN.md](../DESIGN.md)); landing-craft ([landingpage/](landingpage/layout.md)); product-chrome (projectbestand).

## 0. Twee desktopvlakken

Eén site, typisch `apps/web`.

| Vlak | Craft |
|------|--------|
| Showcase / landingspagina desktop | [landingpage/](landingpage/layout.md), achter de gate hieronder |
| Applicatie desktop | Project-chrome (breed); content volgt iPhone-applicatie-craft waar die de bron is |

[a11y.md](a11y.md) en [performance.md](performance.md) gelden voor beide desktopvlakken. Op de telefoon gelden motion, touch en materials in `iphone/` voor beide telefoonvlakken.

## 1. Gate (hard)

Cinematic extra’s op de **showcase / landingspagina** alleen als:

`≥768px` **én** `(pointer: fine)` **én** niet `prefers-reduced-motion: reduce`.

| | Telefoon | Desktop-browser |
|--|-------------------|-------------------------|
| Input | Vinger | Muis/trackpad, scroll, hover |
| Motion | Minimaal (nav, sheets) | Mag cinematic op **showcase**-routes |
| Layout | Één kolom, touch-chrome | Pins / breedte / parallax op showcase |
| Gate | Altijd (geen cinematic) | Gate hierboven |

## 2. Waar desktop-extra’s wél / niet

**Wel:** publieke showcase-routes, marketing-secties, dunne “enter the app”-brug.

**Niet:** productflows (loggen, bewerken, sessies) — touch-pad blijft leidend, ook op breed venster (geen hover-only primaire actie).

**Type (showcase vs product):**

| Surface | Fonts | Sizes |
|---------|-------|-------|
| Product (ook ≥768px) | `--font-sans` (+ mono) | Ladder in [materials-type](../iphone/materials-type.md) — geen aparte desktop type-schaal |
| Showcase landing / hero | Mag `--font-display` | Showcase-classes OK achter gate |
| Showcase body | Sans of showcase-root | Zelfde page padding / max-width-familie |

## 3. Toegestane cool-dingen (catalogus)

Kiezen per slice — niet alles tegelijk. Merk: bestaande tokens; geen paars-glow SaaS, geen terracotta-serif, geen neon-cliché.

| Idee | Gate / valkuil |
|------|----------------|
| Lenis (of equiv.) smooth scroll | Desktop + fine pointer; uit bij reduced-motion |
| GSAP ScrollTrigger / scroll-story | Showcase-routes, niet product-bundle |
| Pipeline-pin | Één scène |
| Tekst-/mask-reveals | `aria`; reduced-motion = eindstaat |
| Parallax | Licht; geen LCP-killer |
| Magnetic / hover-CTA | Nooit de enige klik-manier |
| Pointer-tilt device-mock | Statische fallback op gsm |
| Live chart scrub | Anonieme of echte demo-data |
| Bronnen-marquee | Pauzeer bij hover/focus |
| WebGL / R3F | Lazy, desktop-only, kill op battery/reduced-motion; 2D eerst waar mogelijk |
| Interactieve hotspots | Click/keyboard opent panel; niet hover-only |
| Horizontale chapter-rail | `matchMedia`; gsm = verticaal |
| Custom cursor | Skip op touch |
| Scroll-progress + sectie-dots | Keyboard-bereikbaar |

## 4. Harde regels

1. **Eén codebase** — `matchMedia` / CSS; geen aparte marketing-repo.
2. **Gsm wint bij conflict** — bundle/hydration/jank → uit of lazy desktop-only.
3. **Geen tweede product-IA** — uitbreiden via de afgesproken kaart, niet een parallel menu.
4. **Geen nep** — geen fake MAU / dummy-feed / verzonnen quotes.
5. **A11y** — reduced-motion = eindstaat; focus-ringen; geen info alleen in hover.
6. **Library:** GSAP/Lenis alleen achter showcase-gate; **nooit** importeren in het productpad ([overlays-policy.md](../iphone/application/overlays-policy.md)).

## 5. Test

1. Breed venster ≥1280px, muis, Chrome/Firefox: landing scrollt soepel; CTA werkt zonder hover-theater.
2. `prefers-reduced-motion: reduce` → alles stil / eindstaat.
3. Dezelfde URL op de iPhone: geen WebGL / geen cinematic. Ingelogd is het de applicatie.

## 6. Never ship (desktop)

| Never | Instead |
|-------|---------|
| Showcase GSAP in product path | Gate only |
| Hover-only primary in productflow | Touch + klik + toetsenbord |
| WebGL op gsm | CSS-gradient / stil fallback |
| Nep-MAU / dummy-feed | Echte of anonieme demo-data |
