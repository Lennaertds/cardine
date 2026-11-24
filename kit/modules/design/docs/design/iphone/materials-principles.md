# UI iPhone — materials · principles

> **Rol:** Eight principles, process, quick reference.  
> **Niet hier:** materiaal en diepte ([materials-depth](materials-depth.md)); motion ([motion-springs](motion-springs.md)).

## 1. Eight design principles

1. **Purpose** — intentie; beslis wat je *niet* bouwt.
2. **Agency** — user in control; undo; confirm alleen voor destructief/irreversibel.
3. **Responsibility** — privacy op het juiste moment; veilig met data/AI.
4. **Familiarity** — metaforen + consistent gedrag (zelfde look = zelfde place/gedrag).
5. **Flexibility** — iPhone = quick touch; desktop showcase = pointer depth; inclusive.
6. **Simplicity — not minimalism** — strip noise; common path eerst; soms context toevoegen maakt het simpeler.
7. **Craft** — elk spacing/timing/alignment is te verdedigen.
8. **Delight** — gevolg van 1–7, geen confetti erbovenop.

Tactisch:

- Feedback-soorten: status · completion · warning · error.
- **Wayfinding** elk scherm: Where am I? Where can I go? What’s there? How do I get out?
- Proximity = relatie; controls dicht bij wat ze beïnvloeden.
- Specifieke labels (“Progress”) > vage catch-alls — behalve product-vaste tabnamen.

### Eén ding · choice overload · cognitive load

| Wet | Regel |
|-----|-------|
| **Hick** | Elk scherm vraagt **één** primaire ding. Rest secundair (“More”, overflow). |
| **Choice overload** | Niet 24 opties tegelijk; eerst één vraag of een kleine set. |
| **Cognitive load** | Groepeer, ruimte, minder simultane keuzes. Geen control-muur. |
| **Wizard / steps** | Multi-step OK als **één vraag per stap** + zichtbare progress. |
| **Proximity** | Within-group spacing kleiner dan between-group. |
| **Similarity** | Zelfde kleur/vorm/size = groep; herkleuren of andere radius splitst. |
| **Figure-ground** | Dim/blur achtergrond → overlay/sheet als figure. |
| **Serial position** | Hoogste waarde eerst én laatst (bookends). |
| **Peak-end** | Flows hebben één merkbare peak + sterke afsluiting. |
| **Von Restorff** | Eén isolatie t.o.v. kalme baseline (één accent-CTA). |
| **Visual hierarchy** | Size / contrast / whitespace / één accent-actie. |

**Test:** Onboarding toont één CTA; Settings dumpt geen peers zonder secties; wizards = één vraag per stap.

## 2. Process

- Interactive prototype > miljoen static mocks.
- Interaction en visuals **samen** ontwerpen — motion is geen afterthought.
- Test op echte hardware + echte context; motion soms slow-mo reviewen.

## 3. Quick reference

| Need | Technique | Concrete |
|------|-----------|----------|
| Default UI spring | Critically damped | damping 1.0, response 0.3–0.4 |
| Flick spring | Slight bounce | damping ~0.8, response 0.3–0.4 |
| Gesture → spring | Velocity handoff | release velocity |
| Flick land | Momentum project | `current + (v/1000)·d/(1−d)`, d≈0.998 |
| Interrupt | Presentation value | live transform lezen |
| Reverse | Carry velocity | geen brick wall |
| Reversible path | Mirror easing | inverse cubic-bézier |
| Commit vs reverse | Velocity **sign** | bij release |
| 1:1 drag | Pointer + capture | grab offset |
| Feedback | Pointer-down, continuous | nooit alleen end |
| Boundary | Rubber-band | progressive |
| Chrome | Translucent + blur | content scrolls under |
| Tracking | Size-specific | display −0.02em; body ~0 |
| Reduced motion | Cross-fade | media query |
