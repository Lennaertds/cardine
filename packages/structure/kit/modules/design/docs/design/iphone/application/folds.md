# UI iPhone — folds / accordion

> **Rol:** `<details>` folds, Settings-blokken, deep-link open.  
> **Niet hier:** sheets en dialogen ([overlays-policy](overlays-policy.md)).

## F1. Wanneer fold

| Gebruik | Patroon |
|---------|---------|
| Secundaire Settings-blokken | `FoldSection` / `<details>` |
| Lange optionele content onder de fold | Niet voor primaire navigatie of tab-peers |

| Modus | Gedrag |
|-------|--------|
| **Accordion** | Exact **één** panel open; open van A sluit B |
| **Disclosure** | Meerdere open tegelijk |

**Niet:** fold als vervanging van sheet voor multi-step forms; niet als tab (→ `.ios-segmented` — [controls C2](controls.md)).

## F2. Anatomie

| Deel | Regel |
|------|--------|
| Header | **Button** (of summary met button-rol); `aria-expanded` + `aria-controls`; Enter/Space |
| Summary / hit | Min. hit 44px hoogte |
| Chevron | Roteert open/dicht; **zelfde timingcurve** als panel |
| Title | Type-caption / headline — [materials-type](../materials-type.md) |
| Body | Solid surface of grouped rows; geen glass in fold-body |
| Motie | Height via grid `0fr→1fr` of gemeten hoogte — niet `height: auto` spring |

## F3. Deep link

- Hash / helper opent één benoemde fold.
- Na open: scroll fold in beeld; één gedrag per app (hash blijven of clear).
- Ongeldige hash = no-op.

## F4. Settings apply-model

| Veldsoort | Apply |
|-----------|-------|
| Lichte toggles / prefs | **Instant** (optimistic; rollback + toast bij fail) |
| Identity (email, wachtwoord, account) | Expliciet **Save / Cancel** |

| Layout | Regel |
|--------|-------|
| Groepering | Op **taak / intent**, niet op datamodel |
| Danger | Onderaan / aparte zone — [controls C8](controls.md) |

## F5. Never

| Never | Instead |
|-------|---------|
| Nested folds > 1 diep | Flatten of sheet |
| Fold zonder summary-label | Altijd leesbare summary |
| Accordion die meerdere open laat | Eén open, of benoem als disclosure |
| Chevron out-of-sync met panel | Zelfde duration/easing |
