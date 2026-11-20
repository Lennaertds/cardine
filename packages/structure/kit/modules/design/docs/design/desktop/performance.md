# Desktop — performance

> **Rol:** Beide desktopvlakken blijven licht. Een effect van de showcase dat de applicatie raakt, gaat uit.  
> **Niet hier:** beelden ([images.md](landingpage/images.md)).

De eerste viewport is snel leesbaar. De rest mag lazy.

## 1. Laden

- Systemfonts of één webfont-paar. Geen preload van een vierde webfont.
- GSAP, Lenis, WebGL: dynamic import, alleen achter de gate, nooit in de product-bundle.
- Scripts van derden: `async` of `defer`, of ze komen niet.
- Onder de fold: lazy component én lazy beeld.
- Een blok dat langer dan een seconde op data wacht, reserveert zijn hoogte en toont een rustige solid placeholder. Geen spinner die de kolom laat springen.

## 2. Layout blijft staan

- Elk beeld en elke chart heeft een gereserveerde box (`aspect-ratio` of width/height).
- Animeren met `transform`, `opacity` en `filter`. Niet met `width`, `height`, `top` of `left`.
- Lees de layout niet om hem in dezelfde frame te schrijven.
- Scroll- en resize-handlers: throttle. Input die filtert: debounce.
- Hoofdthread blijft in de buurt van 16ms per frame op de landing zonder pin. Een pin-scène is de uitzondering, en er is er één.

## 3. Netwerk

- Hero scherp en klein ([images.md](landingpage/images.md)).
- Traag netwerk: de pagina blijft leesbaar zonder de cinematic laag. Kerncopy staat in HTML.
- Offline hoort bij de PWA, niet bij een aparte showcase-melding.

## 4. Check voor ship

Op de landing, Chrome én Firefox, plus één echte telefoon:

- geen horizontale scroll op 375px;
- beelden gecomprimeerd (WebP waar zinvol); onder de fold `loading="lazy"`;
- Lighthouse (Performance, A11y, Best practices, SEO) zonder rode CLS door een beeld of een font;
- reduced-motion laadt de zware scroll-lib niet.

**Test:** de eerste paint toont claim en knop zonder te wachten op GSAP. Een beeld onder de fold heeft `loading="lazy"` en een vaste verhouding.
