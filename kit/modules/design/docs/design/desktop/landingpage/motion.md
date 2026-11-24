# Desktop — motion

> **Rol:** Hoe glas en secties bewegen.  
> **Niet hier:** de catalogus van effecten ([desktop.md](../desktop.md) §3); motion in de app ([motion-springs](../../iphone/motion-springs.md)).

Beweging en materiaal zijn één beslissing. Een vlak dat alleen fade’t, leest als een accordion, niet als glas.

Elke beweging heeft een oorzaak: een pointer, een open menu, een scroll-sectie. Decoratieve motion bestaat niet.

## 0. Duur-tokens

Eén set. Niet per component een eigen milliseconden-getal.

| Token | Duur | Easing | Voor |
|-------|------|--------|------|
| press | 120ms | ease-out | scale 0.98 |
| hover | 160–200ms | ease-out | glans |
| enter | 280–400ms | ease-out of damped spring | materialiseren, menu open |
| exit | 60–70% van enter | dezelfde curve, korter | sluiten |
| plafond | 500ms | — | niets langer, behalve een scroll-gekoppelde scène |

Aankomen vertraagt (ease-out). Weggaan is korter. Lineair alleen voor een marquee of een echte voortgangsbalk.

Alleen `transform`, `opacity` en `filter`. Niet `width`, `height`, `top` of `left`. Opacity blijft niet hangen tussen 0 en 0.2: helemaal weg, of zichtbaar.

Feedback op pointer-down binnen 100ms. De animatie blokkeert de volgende klik niet. Een tweede klik vervangt de lopende beweging; de eindstaat volgt de laatste actie, niet het `animationend`-event.

Per sectie hooguit één scenische beweging. Hover en press tellen daar niet in. Een lijst mag staggeren met 30–50ms per item, maximaal zes items. Geen per-letter stagger.

## 1. Materialiseren

Enter en exit van een glazen vlak:

- opacity 0 → 1;
- blur van ongeveer 8px naar de `.glass`-blur (exit omgekeerd);
- scale van 0.96 → 1. Nooit vanaf `scale(0)`.

Duur 280–400ms. Easing: ease-out, of een critically damped spring (damping 1, response 0.3–0.4). Geen ease-in. Geen bounce.

`prefers-reduced-motion: reduce` → meteen de eindstaat. Geen blur-animatie, geen scale.

## 2. Interactie

- Hover-glans: 160–200ms, ease-out. Alleen fijne pointer.
- Press: 120ms naar scale 0.98.
- Een control die even “optilt” in glas (slider-knop, switch) keert terug naar rust. Geen permanente shimmer-loop.
- Een menu opent vanuit de knop: zelfde origin, de schaduw gaat van rol control naar rol panel. Duur ≤ 320ms. Sluiten is dezelfde weg terug, met de velocity als de pointer hem wegveegt — anders de omgekeerde curve.

Geen per-letter stagger. Geen bounce op panelen.

## 3. Scroll

**Scroll-driven motion alleen achter de showcase-gate**, en alleen op showcase-routes. Product krijgt geen scroll-theater: geen pin, geen scroll-gekoppelde reveal, geen Lenis/GSAP daar.

- Eén pinned scène tegelijk. De hero niet óók pinnen.
- Parallax hooguit een paar procent. Het beeld blijft scherp; de LCP-afbeelding wacht niet op een script.
- Tekst-reveal eindigt in leesbare tekst. `prefers-reduced-motion: reduce` → eindstaat meteen; geen scroll-gekoppelde animatie, geen smooth-scroll die het wiel overneemt.
- Smooth scroll (Lenis of gelijk) valt uit bij reduced-motion en op narrow.
- Sectie-dots of een voortgangsbalk zijn knoppen: focusbaar, activeren de sectie.

GSAP en Lenis blijven uit de product-bundle. [desktop.md](../desktop.md).

## 4. Onderbreken

- Een animatie die de gebruiker wegklikt, stopt vanaf de huidige waarde. Geen afspelen tot het einde.
- Een open menu sluit als een tweede menu opent. Eén overlay.
- Venster dat focus verliest (een dialoog ervoor): het glas erachter wordt stiller (iets hogere tint, geen glans-animatie), het dimt niet tot een tweede scrim.

## 5. Verboden

| Verboden | In plaats daarvan |
|----------|-------------------|
| `transition: all` | opacity, transform, filter, background-color |
| `ease-in` op UI | ease-out of damped spring |
| Oneindige glow-pulse | stil in rust |
| Scroll-jack die de pagina vangt zonder dots | natuurlijke scroll + dots als extra |
| Scroll-theater in product (pin, scroll-reveal, Lenis) | alleen showcase-gate; product stil |
| Motion als enige feedback in productflows | product-regels |

**Test:** reduced-motion op de landing toont elke sectie in eindstaat, de marquee staat stil, en er laadt geen smooth-scroll script dat het wiel overneemt.
