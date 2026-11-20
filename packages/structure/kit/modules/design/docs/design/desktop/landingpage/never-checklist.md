# Desktop — never ship

> **Rol:** Wat niet de showcase op mag, plus de review.  
> **Niet hier:** site-breed ([never.md](../../shared/never.md)); product-never ([iphone/never-checklist.md](../../iphone/never-checklist.md)).

## 1. Never

| Never | Instead |
|-------|---------|
| Tweede `backdrop-filter` met andere blur | `.glass` uit [looks.md](looks.md) |
| Glazen kaartgrid, glas op features of op proza | Solid contentlaag |
| Regular en Clear door elkaar | Eén variant per pagina |
| Clear zonder dim, of Clear op tekst | Regular, of de drie voorwaarden |
| Regenboog-rand, paarse glow, gradient-text | Specular haarlijn, tokens |
| Stoplichten of een dock als site-chrome | Alleen binnen een product-mock |
| Eigen hex of een vierde font | Tokens, `--font-sans` / display achter de gate |
| `100vh` op de schil | `100dvh` hooguit op de hero-sectie |
| `transition: all`, `scale(0)`, `ease-in` | [motion.md](motion.md) |
| Hover-only inhoud | Klik, toetsenbord, of tekst in de sectie |
| GSAP of Lenis in de product-bundle | Showcase-gate |
| Fake MAU, dummy-quotes | Echte of anonieme demo |
| Skin die de gast-landing herskint | Default theme-tokens |
| Menu vanaf de onderkant op wide | Menu uit de knop |
| Losse `z-[n]` | `var(--z-*)` |
| Per-letter stagger, oneindige glans-loop | Stil in rust |
| Drie gevulde knopstijlen | Primary, secondary, quiet |
| Emoji, tweede icoonpack, stock-beeld | [icons.md](icons.md), [images.md](images.md) |
| Blauwe links, underline op niet-links | Proza-link = accent + underline ([ux.md](ux.md)) |
| `width` / `height` / `top` / `left` animeren | `transform`, `opacity`, `filter` |
| Taartdiagram, chart zonder eenheid | [charts.md](charts.md) |
| Beeld zonder gereserveerde verhouding | [performance.md](../performance.md) |
| Root `font-size: 62.5%` | `1rem` = 16px |

## 2. Review

0. Welke rij in [DESIGN.md](../../DESIGN.md)? Eén file.
1. Gate: extras alleen ≥ 768px, fijne pointer, geen reduced-motion.
2. Eén functionele laag. Content solid.
3. Look = `.glass` + schaduwrol + concentrische radius.
4. Eén primaire actie, dezelfde bestemming in balk en hero.
5. Type-rollen uit [type.md](type.md). Product-ladder onaangeroerd.
6. Reduced-motion = eindstaat. Reduced-transparency = solid. Focus-ring aan.

Output van een visuele review: tabel **Before | After | Why**.

## 3. Klaar

- [ ] Coverage-rij bestaat.
- [ ] Geen nieuwe blur, radius of schaduw buiten [looks.md](looks.md).
- [ ] Test-zin van die ene craft-file groen.
- [ ] Narrow en reduced-motion bekeken.
- [ ] Product-pad niet zwaarder (geen showcase-lib in de product-bundle).

## 4. Elders

- Gate en catalogus → [desktop.md](../desktop.md).
- Product-craft → [DESIGN.md](../../DESIGN.md) (applicatie).
