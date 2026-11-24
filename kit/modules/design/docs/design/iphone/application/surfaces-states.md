# UI iPhone — surfaces · empty / loading / error

> **Rol:** Lege, ladende en fout-staten — zelfde hiërarchie overal.  
> **Niet hier:** kaarten ([surfaces-cards](surfaces-cards.md)); sticky koppen ([surfaces-sticky-heads](surfaces-sticky-heads.md)).

## S1. Empty state

Elke lijst/feed/board die **0 items** kan hebben krijgt een empty state — geen blanke witruimte.

| Element | Regel |
|---------|--------|
| **Plaats** | In de content-zone van die sectie (niet als toast) |
| **Titel** (optioneel) | `.type-headline` — kort |
| **Body** | `.type-caption text-muted` of `.type-body text-muted` — één zin wat ontbreekt |
| **CTA** (optioneel) | Één secondary of primary (C1) die de lege staat oplost |
| **Icoon** | Optioneel muted; geen emoji-muur |

**Vier empty-soorten:**

| Soort | Copy-richting | CTA-richting |
|-------|---------------|--------------|
| **first-run** | Welkom / wat hier komt | Primaire eerste actie |
| **no-results** | Query leverde niks | Clear search / categories |
| **error** | Wat brak + wat nu ([S3](#s3-errors)) | Retry / back |
| **filtered** | Filters maakten de lijst leeg | Clear filters |

**Niet:** alleen `"…"` of kale `null`; geen Sonner voor “lijst is leeg”; log-file copy.

## S2. Loading

| Situatie | Patroon |
|----------|---------|
| Route suspense | Korte muted tekst, gecentreerd in page chrome |
| Inline sectie refresh | Muted caption in die sectie; **geen** vol-scherm flash |
| Skeleton | Layout vóór content als shift > ~1 scherm hoog |
| Optimistic UI | UI meteen; sync op achtergrond; rollback + één fout bij fail |
| Progress | Echte % of “tijd over” waar upload loopt |

**Niet:** leeg wit scherm bij load; drie “Loading…”-fonts tegelijk; optimistic zonder rollback-pad.

## S3. Errors

| Soort | Patroon |
|-------|---------|
| **Field validation** | Inline caption + `aria-invalid` ([overlays-forms](overlays-forms.md)) |
| **Actie faalde** (netwerk) | Sonner `toast.error` **of** inline banner als de user moet blijven fixen |
| **Scherm onbruikbaar** | Korte error + “Retry” / back — in page chrome, niet alleen console |

| As | Regel |
|----|--------|
| **Type → surface** | Validatie = inline; connectie = banner of toast; crash = eigen ruimte |
| **Severity → volume** | Minor inline; transient toast; blocking alleen als onbruikbaar |
| **Exit / retry** | Altijd pad — geen dood “OK” |
| **Mensentaal** | Wat brak, waarom, wat nu |

**Niet:** toast **en** blocking modal voor dezelfde fout.

## S4. Never (states)

| Never | Instead |
|-------|---------|
| Lege lijst zonder uitleg | S1 empty |
| Toast-spam bij lege inbox | Empty state |
| Skeleton + spinner + “Loading” tegelijk | Eén patroon uit S2 |
| Leeg scherm tijdens first paint | Skeleton / caption / bestaande chrome |
