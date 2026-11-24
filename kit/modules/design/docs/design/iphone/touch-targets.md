# UI iPhone — touch · targets

> **Rol:** Tab transitions + touch targets.  
> **Niet hier:** knoppen ([controls](application/controls.md)); haptics ([touch-haptics](touch-haptics.md)).

## 1. Tab transitions

Tabs zijn **peers**, geen hiërarchie.

- **Geen full-screen slide** tussen product-tabs alsof het een stack-push is.
- Interactive peek (vinger 1:1) + spring-settle met velocity/momentum mag — dat is gesture feedback, geen “page push”.
- Commit: spring vanaf presentation value; **geen** `setTimeout` lock die input blokkeert ([motion-springs](motion-springs.md)).
- Reduced motion: cross-fade of instant; geen peek-theater.

## 2. Touch targets & dense controls

| Surface | Target |
|---------|--------|
| Primaire product-CTA | ≥ **44×44px** (of hitSlop / padding die dat haalt) |
| Tabbar items, top-nav taps | ≥ 44px touch |
| **Dense controls** (chips, steppers, compacte rijen) | Mag **36–40px** visueel — **alleen** in gedocumenteerde dense-context; altijd ≥ 16px type op inputs |
| Action-row primaire pills | ≥ 44px hoogte |
| Dense secundaire tekst-knoppen | min `--hit-dense` (36px) — nooit 16px hoge `button` |
| Stand-alone tekstlinks + kleine avatars | Visueel klein mag; hit ≥ 36–44px via `::after` hitSlop — geen layoutwijziging |

Exceptions moeten in code comment / `.dense-control` herkenbaar zijn — geen stille `h-8` op primary Confirm.

**Test:** `elementFromPoint` rond een quiet-link raakt de link; dense secundaire knop computed height ≥ 36; header-avatar effectieve hit ≥ 44×44.

## 3. Hover-trap

Touch faket hover: eerste tap = sticky hover; acties blijven “open” tot ergens anders tikt.

| Regel | Detail |
|-------|--------|
| **Geen primary achter hover** | Hover alleen extras (favorite, overflow). De job is altijd zichtbaar/tikbaar |
| **Touch-home** | Acties in de card, swipe-pad, of sheet — niet alleen desktop-hover |
| **Capability media** | Alle `:hover` / `hover:` in `@media (hover: hover) and (pointer: fine)` — geen UA-sniff |
| **Coarse pointer** | `(pointer: coarse)` → grotere controls; hit ≥ 44px (of dense-exception §2) |

Zelfde gate als [motion-response](motion-response.md). Primary-only-achter-hover: [never-checklist](never-checklist.md).

## 4. Duimzone

De primaire actie zit waar de duim van een telefoon in één hand komt: de onderste helft, niet in een hoek boven de notch.

- Product-tabs zitten in de bottom-tabbar, boven `safe-area-inset-bottom`. Scroll mag de balk verbergen/tonen volgens project-chrome.
- Een primaire knop mag niet alleen in de header staan als dat de enige manier is om de job te doen.
- De landingspagina heeft één primaire actie in de eerste viewport, minstens 44 px, niet achter de home-indicator.
- Desktop-applicatie: dezelfde acties, bereikbaar met toetsenbord. De duimzone geldt daar niet.
