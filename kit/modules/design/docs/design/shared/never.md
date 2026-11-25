# Never — shared

> **Role:** Prohibitions that hold for the whole site. A surface may be stricter, never looser.
> **Not here:** landing page ([never-checklist](../desktop/landingpage/never-checklist.md)); application ([never-checklist](../iphone/never-checklist.md)).

| Never | Instead |
|-------|---------|
| Fake MAU, dummy feed, made-up quotes | Real sources or an anonymous demo |
| A second `backdrop-filter` with a different blur value | [`.glass`](glass.md) |
| Mesh gradient, or a `rgba(255, 255, 255, 0.15)` border from a glass kit | `--stroke` and the inset of `.glass` |
| Hover as the only way to do a primary action | Click, tap or keyboard |
| GSAP, Lenis or WebGL in the application bundle | Only behind the landing page / showcase gate |
| A second navigation structure next to the agreed IA | One IA; extend it through that map, not with a parallel menu |

Default is web (on a phone as a PWA). A native shell (Expo, App Store) only if the project explicitly chooses it.

**Test:** a new screen can point to every prohibition in this file or in the never list of its surface.
