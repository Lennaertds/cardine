# Desktop — gate

> **Role:** When the landing page / showcase may be cinematic, and what desktop extras may not touch.
> **Not here:** craft map ([DESIGN.md](../DESIGN.md)); landing craft ([landingpage/](landingpage/layout.md)); product chrome (project file).

## 0. Two desktop surfaces

One site, typically `apps/web`.

| Surface | Craft |
|---------|-------|
| Showcase / desktop landing page | [landingpage/](landingpage/layout.md), behind the gate below |
| Desktop application | Project chrome (wide); content follows the iPhone application craft where that is the source |

[a11y.md](a11y.md) and [performance.md](performance.md) apply to both desktop surfaces. On a phone, motion, touch and materials in `iphone/` apply to both phone surfaces.

## 1. Gate (hard)

Cinematic extras on the **showcase / landing page** only if:

`≥768px` **and** `(pointer: fine)` **and** not `prefers-reduced-motion: reduce`.

| | Phone | Desktop browser |
|--|-------|-----------------|
| Input | Finger | Mouse/trackpad, scroll, hover |
| Motion | Minimal (nav, sheets) | May be cinematic on **showcase** routes |
| Layout | One column, touch chrome | Pins / width / parallax on the showcase |
| Gate | Always (no cinematic) | The gate above |

## 2. Where desktop extras do and do not belong

**Yes:** public showcase routes, marketing sections, a thin "enter the app" bridge.

**No:** product flows (logging, editing, sessions) — the touch pad stays leading, also in a wide window (no hover-only primary action).

**Type (showcase vs product):**

| Surface | Fonts | Sizes |
|---------|-------|-------|
| Product (also ≥768px) | `--font-sans` (+ mono) | Ladder in [materials-type](../iphone/materials-type.md) — no separate desktop type scale |
| Showcase landing / hero | May use `--font-display` | Showcase classes OK behind the gate |
| Showcase body | Sans or showcase root | Same page padding / max-width family |

## 3. Allowed cool things (catalogue)

Pick per slice — not all at once. Brand: existing tokens; no purple-glow SaaS, no terracotta serif, no neon cliché.

| Idea | Gate / trap |
|------|-------------|
| Lenis (or equivalent) smooth scroll | Desktop + fine pointer; off under reduced-motion |
| GSAP ScrollTrigger / scroll story | Showcase routes, not the product bundle |
| Pipeline pin | One scene |
| Text / mask reveals | `aria`; reduced-motion = end state |
| Parallax | Light; not an LCP killer |
| Magnetic / hover CTA | Never the only way to click |
| Pointer-tilt device mock | Static fallback on phone |
| Live chart scrub | Anonymous or real demo data |
| Source marquee | Pauses on hover/focus |
| WebGL / R3F | Lazy, desktop only, killed on battery/reduced-motion; 2D first where possible |
| Interactive hotspots | Click/keyboard opens the panel; not hover-only |
| Horizontal chapter rail | `matchMedia`; phone = vertical |
| Custom cursor | Skip on touch |
| Scroll progress + section dots | Reachable by keyboard |

## 4. Hard rules

1. **One codebase** — `matchMedia` / CSS; no separate marketing repo.
2. **The phone wins on conflict** — bundle/hydration/jank → off, or lazy desktop only.
3. **No second product IA** — extend through the agreed map, not with a parallel menu.
4. **Nothing fake** — no fake MAU / dummy feed / made-up quotes.
5. **A11y** — reduced-motion = end state; focus rings; no information only in hover.
6. **Library:** GSAP/Lenis only behind the showcase gate; **never** imported into the product path ([overlays-policy.md](../iphone/application/overlays-policy.md)).

## 5. Test

1. Wide window ≥1280px, mouse, Chrome/Firefox: the landing page scrolls smoothly; the CTA works without hover theatre.
2. `prefers-reduced-motion: reduce` → everything still / end state.
3. The same URL on the iPhone: no WebGL / no cinematic. Signed in, it is the application.

## 6. Never ship (desktop)

| Never | Instead |
|-------|---------|
| Showcase GSAP in the product path | Gate only |
| Hover-only primary in a product flow | Touch + click + keyboard |
| WebGL on phone | CSS gradient / still fallback |
| Fake MAU / dummy feed | Real or anonymous demo data |
