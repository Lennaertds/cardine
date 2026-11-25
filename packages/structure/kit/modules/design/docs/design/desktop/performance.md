# Desktop — performance

> **Role:** Both desktop surfaces stay light. A showcase effect that touches the application goes off.
> **Not here:** images ([images.md](landingpage/images.md)).

The first viewport is readable fast. The rest may be lazy.

## 1. Loading

- System fonts or one webfont pair. No preload of a fourth webfont.
- GSAP, Lenis, WebGL: dynamic import, only behind the gate, never in the product bundle.
- Third-party scripts: `async` or `defer`, or they do not ship.
- Below the fold: lazy component **and** lazy image.
- A block that waits on data for more than a second reserves its height and shows a calm solid placeholder. No spinner that makes the column jump.

## 2. Layout stays put

- Every image and every chart has a reserved box (`aspect-ratio` or width/height).
- Animate with `transform`, `opacity` and `filter`. Not with `width`, `height`, `top` or `left`.
- Do not read layout to write it in the same frame.
- Scroll and resize handlers: throttled. Filtering input: debounced.
- The main thread stays around 16ms per frame on the landing page without a pin. A pin scene is the exception, and there is one.

## 3. Network

- Hero sharp and small ([images.md](landingpage/images.md)).
- Slow network: the page stays readable without the cinematic layer. Core copy is in the HTML.
- Offline belongs to the PWA, not to a separate showcase notice.

## 4. Pre-ship check

On the landing page, Chrome and Firefox, plus one real phone:

- no horizontal scroll at 375px;
- images compressed (WebP where useful); below the fold `loading="lazy"`;
- Lighthouse (Performance, A11y, Best practices, SEO) without red CLS from an image or a font;
- reduced-motion does not load the heavy scroll library.

**Test:** the first paint shows the claim and the button without waiting for GSAP. An image below the fold has `loading="lazy"` and a fixed ratio.
