# Nooit — gedeeld

> **Rol:** Verboden die op de hele site gelden. Een vlak mag strenger zijn, niet losser.  
> **Niet hier:** landingspagina ([never-checklist](../desktop/landingpage/never-checklist.md)); applicatie ([never-checklist](../iphone/never-checklist.md)).

| Nooit | In plaats daarvan |
|-------|-------------------|
| Fake MAU, dummy-feed, verzonnen quotes | Echte bronnen of anonieme demo |
| Een tweede `backdrop-filter` met een ander blur-getal | [`.glass`](glass.md) |
| Mesh-gradient, of een rand `rgba(255, 255, 255, 0.15)` uit een glas-kit | `--stroke` en de inset van `.glass` |
| Hover als enige manier om een primaire actie te doen | Klik, tik, of toetsenbord |
| GSAP, Lenis of WebGL in de applicatie-bundle | Alleen achter de landingspagina- / showcase-gate |
| Een tweede navigatiestructuur naast de afgesproken IA | Eén IA; uitbreiden via die kaart, niet een parallel menu |

Default is web (op de telefoon als PWA). Een native shell (Expo, App Store) alleen als het project dat expliciet kiest.

**Test:** een nieuw scherm kan elk verbod aanwijzen in dit bestand of in de never-lijst van zijn vlak.
