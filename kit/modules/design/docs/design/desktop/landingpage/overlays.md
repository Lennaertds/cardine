# Desktop — overlays

> **Rol:** Menu's en dialogen op de showcase.  
> **Niet hier:** product-sheets ([overlays-policy](../../iphone/application/overlays-policy.md)).

Een overlay komt uit de knop die hem opende, of hij dimt de pagina om één taak. Niet allebei half.

## 1. Menu

- Opent vanuit de bronknop. `transform-origin` op die knop. Schaduwrol panel, materiaal Regular.
- Items: solid fill bij hover (`--foreground` op 8%), geen eigen glas.
- Standaardacties tonen een icoon én een label. 20px icoon, 12px naar de tekst.
- Esc sluit. Klik buiten sluit. Focus gaat het menu in en keert terug naar de knop.
- Eén menu open. Een tweede klik op een andere menuknop sluit het eerste eerst.
- Breedte: min 12rem, max 20rem. Langer dan acht items: het menu scrollt van binnen, de pagina niet.

Geen actie-sheet vanaf de onderkant op wide. Dat patroon is van de telefoon.

## 2. Dialoog

Voor een beslissing die de pagina moet tegenhouden (een bevestiging, een kort formulier).

- Gecentreerd, max 32rem, Regular-glas of solid `--card` als het formulier lang is. Formulier-body liever solid.
- Hoeken `--r-group`, concentrisch voor knoppen erin.
- Scrim: `--sheet-scrim`. De pagina erachter scrollt niet.
- Knoppen rechtsonder: quiet annuleren, primary bevestigen. Destructief alleen als de actie ongedaan te maken is of echt wist — en dan de bestaande confirm-stijl, geen rode glazen pil ernaast.
- Esc sluit, tenzij er onopgeslagen invoer is; dan blijft de dialoog en de annuleren-knop is bereikbaar.
- Focus zit in de dialoog tot ze sluit.

Op narrow mag dezelfde taak een sheet zijn, via de product-taxonomy. Geen tweede dialoog-implementatie.

## 3. Z-index

Alleen `var(--z-*)` uit de bestaande ladder ([overlays-policy](../../iphone/application/overlays-policy.md)).

| Laag | Token-familie |
|------|----------------|
| Balk | `--z-nav` |
| Menu | `--z-popover` |
| Dialoog + scrim | `--z-sheet` of de bestaande modal-stap |

Geen `z-[100]` in een showcase-component.

## 4. Toast

Eén toaster in de root, dezelfde als het product ([overlays-focus-toasts](../../iphone/application/overlays-focus-toasts.md)). De landing toont geen toast om een sectie aan te kondigen.

Zichtbaar 3–5 seconden. Geen focus-dief. `aria-live="polite"`. Een dialoog met onopgeslagen invoer vraagt voor ze sluit. Destructieve knoppen staan weg van de primary.

**Test:** een menu groeit uit zijn knop, sluit met Esc, en de focus keert terug. Er is geen tweede toaster.
