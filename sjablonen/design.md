# docs/design/DESIGN.md

> **Rol:** Ingang bij elke UI-taak: principes, wat nooit, tokens, en de kaart naar één craft-bestand.
> **Niet hier:** wat het doet ([product](product.md)), de waarden van de tokens (de code).

**Kitbestanden:** [DESIGN.md](../kit/modules/design/docs/design/DESIGN.md), craft onder `shared/` · `desktop/` · `iphone/`, [`.cursor/agents/ui.md`](../kit/modules/design/.cursor/agents/ui.md) · module `design`

## Wanneer

Bij een UI met een eigen huisstijl, of zodra een agent schermen bouwt die op elkaar moeten lijken. Een intern dashboard met een standaard componentbibliotheek: niet nodig. Module `design` zet in `AGENTS.md` de harde route: UI-taak → dit bestand eerst, en zet de UI-subagent neer ([cursor-agents](cursor-agents.md)).

## Wat de kit al levert

Module `design` kopieert een **huisstandaard-craftbibliotheek** (premium look: glass-chrome, solid content, motion, touch, overlays). Die bestanden zijn klaar om te volgen — niet leeg.

| Map | Inhoud |
|-----|--------|
| `docs/design/shared/` | a11y, never, glass |
| `docs/design/desktop/` | gate, performance, a11y + `landingpage/` showcase-craft |
| `docs/design/iphone/` | touch, motion, materials, never-checklist + `application/` product-craft |

**Niet in de kit** (project vult): product-IA, lat-chrome, session-chrome, landing-beats, merkpersoonlijkheid, About/hotspots.

## Invullen (project)

1. **Eerste zin** blijft: "Open dit bij elke UI-taak; kies daarna één craft-bestand."
2. **Principes:** drie à vijf toetsbare huisregels (of verwijs naar craft die ze al vastlegt). Kit-placeholder mag blijven tot je ze aanscherpt.
3. **Nooit:** site-breed staat in `shared/never.md`. Project-extra’s onder **Nooit** in `DESIGN.md`.
4. **Tokens:** pad naar code + betekenis-tabel. Waarden blijven in CSS (P7).
5. **Kaart:** kit-rijen staan al. Voeg project-chrome toe (§ Project-chrome). Overschrijf de gedeelde vloer niet lichter.
6. **Craft uitbreiden:** nieuw onderwerp = nieuw bestand + één rij in de kaart. Geen hele map dump bij een taak.

## Voorbeeld (kaart, verkort)

```markdown
> **Rol:** Ingang bij elke UI-taak. Open dit bestand, daarna één craft-bestand.

## Gedeeld
| Bestand | Vraag |
|---------|--------|
| shared/a11y.md | Focus, contrast, prefs |
| shared/never.md | Site-breed verboden |
| shared/glass.md | Eén class `.glass` |

## Showcase desktop
| … | desktop/landingpage/… |

## Applicatie
| … | iphone/application/… |

## Project-chrome
| PageShell / tabs | lat-chrome.md (project) |
```

## Snelle toets

- [ ] Geen hexcodes of pixelwaarden die ook in de code staan.
- [ ] Kit-craft staat onder `docs/design/` na `--modules design`.
- [ ] Frisse agent bij "fix de sticky head": opent eerst `DESIGN.md`, dan `surfaces-sticky-heads`.
- [ ] Project-chrome staat in de kaart; lat/session zitten niet als GF-copy in de kit.
