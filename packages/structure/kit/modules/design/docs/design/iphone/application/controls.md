# UI iPhone — controls

> **Rol:** Buttons, chips, segmented, toggles, icon, pending.  
> **Niet hier:** knoppen op de showcase ([controls.md](../../desktop/landingpage/controls.md)); raakvlakken ([touch-targets](../touch-targets.md)).

## C1. Button-hiërarchie (product)

| Rol | Visueel | Class / patroon | Min. target |
|-----|---------|-----------------|-------------|
| **Primary** | Accent fill, `text-on-accent` | `.btn-primary` of `.action-primary` | ≥ **44×44** (`--hit-min`) |
| **Secondary** | Border / muted fill | `.hug` + `border-stroke` | ≥ 44 |
| **Destructive** | Rood in confirm / ActionRow danger | Confirm / ActionRow | ≥ 44 |
| **Icon** | Glyph only | `.icon-btn` — glyph ~22–24px | ≥ 44 |
| **Dense** | Compacte logger/chips | `.dense-control` | **36–40** |

**Wel:** ActionRow max 2 pills + `⋯`; in-flight pending = C6 busy; incomplete form = enabled + validate on click; één radius-systeem per rij.  
**Niet:** ad-hoc `bg-accent rounded-full` naast `.btn-primary` op hetzelfde scherm; emoji-only primary.

**Test:** Primaire acties op kernschermen = C1 classes of ActionRow.

## C2. Segmented control

| | |
|--|--|
| **Wanneer** | 2–5 **peers** (scope, filter) |
| **Class** | `.ios-segmented` (+ compact / scroll-varianten indien nodig) |
| **Type** | `--type-tab` |
| **Niet** | Aan/uit → C3 |

## C3. Chips & toggles

| Patroon | Wanneer | Regel |
|---------|---------|--------|
| **Filter chip** | Multi-select / snelle filters | `.chip-on` selected; hit dense of 44 |
| **Boolean** | Eén aan/uit | checkbox of `role="switch"` + zichtbare staat |
| **Radio** | Exact één uit N | native radio of segmented als N≤5 peers |

**Filter chips — drie states:** idle (outline) · active (filled `.chip-on`) · disabled.

| Regel | Wel | Niet |
|-------|-----|------|
| **Count** | Result-count in **zelfde frame** als filter-tap | Count die een frame later springt |
| **Clear-all** | Multi-actief: één tap alle filters weg | Alleen per-chip clear zonder escape |
| **Layout** | Horizontaal scroll + edge-fade OK | Multi-row chip-muur |

**Toggle:** ~250ms ease-out; rail + knob + label synchroon; lichte toggles optimistic + rollback; Space + `aria-checked`.

**Niet:** chip-rij die tabs is; chip + segmented voor dezelfde keuze.

## C4. Icon buttons

- Alleen `.icon-btn` (of ActionRow icon slot).
- `aria-label` verplicht als geen zichtbare tekst.
- Sheet close / settings gear = icon-btn ≥44.

## C5. Steppers & drag

- Dense steppers OK binnen `.dense-control`.
- Drag-lijsten: Motion + haptic op commit/snap only.

**Slider:** filled track = waarde; volle-rij hit ≥ dense of 44; snap naar ronde waarden; pijlen/Home/End waar focusbaar.

## C6. Pending vs incomplete

| Situatie | Gedrag |
|----------|--------|
| **Incomplete form** | Submit blijft **enabled**. Klik → field errors + focus eerste invalid ([overlays-forms](overlays-forms.md)). |
| **In-flight request** | Busy: geen dubbele submit; label `…`; `aria-busy` waar relevant. |
| **Niet** | Disabled als enige uitleg-pad voor ontbrekende velden |

**Test:** Leeg veld → knop klikbaar, inline errors; Save tijdens request → geen tweede submit.

## C7. Never

| Never | Instead |
|-------|---------|
| Derde primary-stijl | C1 |
| Hover-only primary | Touch-pad |
| Chip-rij = tabs | `.ios-segmented` |
| Disabled submit als enige feedback bij incomplete form | C6 |

## C8. Destructive language

| Regel | Wel | Niet |
|-------|-----|------|
| **Verb labels** | “Delete …”, “Discard …” | Yes / No / OK / Confirm |
| **Red budget** | Rood alleen voor vernietiging | Rood voor Save of merkkleur |
| **Off the happy path** | Delete niet op de primaire knoppositie | Zelfde plek als Save |
| **Geography** | Danger onderaan of ActionRow danger | Destructief naast primary |
| **Confirm (hoog risico)** | Confirm of hold-to-confirm | Extra Yes/No zonder werkwoord |
| **Undo (herstelbaar)** | Optimistic + Sonner-undo | Confirm voor elke soft remove |
| **Purge-frictie** | **Óf** type-naam **óf** hold — niet beide | Type + hold + confirm |

Confirm blijft spaarzaam ([overlays-policy](overlays-policy.md)). [materials-principles](../materials-principles.md).

**Test:** Destructieve actie: werkwoord op de knop, rood alleen daar, primary blijft Save.
