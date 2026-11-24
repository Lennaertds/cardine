# Naamgeving en docs-kop

> **Rol:** Hoe je bestanden, mappen, ADR's, tests en afbeeldingen noemt, en met welke kop elke doc begint.
> **Niet hier:** waar ze staan ([skelet](skelet.md)).

**Docs**

- **Vaste namen in hoofdletters** voor de ingangen: `README.md`, `AGENTS.md`, `INDEX.md`, en per docs-map het ingangsbestand met de naam van de map: `CONTEXT.md`, `GLOSSARY.md`, `RULES.md`, `PRODUCT.md`, `DESIGN.md`, `ARCHITECTURE.md`, `RESEARCH.md`, `DECISIONS.md`, `BACKLOG.md`. Alleen `docs/INDEX.md` heet `INDEX`.
- **In code- en datamappen heet de ingang `README.md`**, want GitHub toont die.
- **kebab-case in kleine letters** voor alle andere docs: `data-import.md`, `how-to/reset-database.md`.
- **ADR's genummerd met vier cijfers**: `0007-postgres-enige-writer.md`. Het nummer is stabiel, de titel is een beslissing.
- **Datum vooraan** voor alles wat in de tijd ligt: `logs/2026-10-18.md`, `meetings/2026-10-18-coach.md`, `experiments/2026-10-18-sleep-baseline.md`.
- **Een sjabloon heet `_template.md`** en staat in de map waarvan het de bestanden maakt: `decisions/`, `work/specs/`, `work/logs/`, `work/meetings/`, `research/experiments/`, `product/`. Het underscore sorteert bovenaan en botst nooit met een echte naam. De make-targets `adr`, `spec`, `log`, `meeting` en `experiment` kopiëren het ([makefile](makefile.md#docs-en-werk)).
- **De bestandsnaam bevat het onderwerp in gewone woorden.** Een code mag ervoor (`H-gym.md`), maar nooit alleen een code (`H.md`). Elke code staat in `GLOSSARY.md`.
- **Eén taal per project voor docs.** Code-identifiers mogen Engels zijn. Het glossarium koppelt beide.

**Code, data en bestanden**

- TypeScript-bestanden in kebab-case (`sleep-engine.ts`, `date-field.tsx`), Python-modules en datasets in snake_case (`day_features.py`).
- Een testbestand krijgt het achtervoegsel dat de testrunner standaard verwacht: Jest of Nest `.spec.ts`, Vitest `.test.ts`, Playwright `.spec.ts`, pytest `test_*.py`. De **plaats** ligt vast ([stacks §1](stacks.md#1-elke-app)), het achtervoegsel volgt de tool.
- Afbeeldingen beschrijvend, in kleine letters: `iphone-calendar-dark.png`, niet `IMG_0086.PNG`.
- **Eén slug per werkitem**: spec `docs/work/specs/<slug>.md`, branch `<type>/<slug>` (bv. `feat/diet-budget`), en dezelfde slug in de PR-titel.

**Nooit**

- Versies in bestandsnamen (`_v3`, `_final`, `_new`). Versies zitten in git. Moet een oude variant blijven voor vergelijking, zet die dan in `docs/archive/` of `experiments/`.
- `*.sync-conflict-*`, `copy of …`, spaties in namen.

---

## Kopregel van een doc

Elke doc onder `docs/` begint met een korte kop. Die helpt mens en agent te beslissen of ze verder moeten lezen.

```markdown
# <Titel>

> **Rol:** <welke vraag dit bestand beantwoordt, in één zin>
> **Niet hier:** <waar de aanpalende informatie staat>
```

Optioneel voor projecten waar de agent niet overal mag schrijven: `> **Schrijven:** vrij | na toestemming`. Hou de kop bij twee à drie regels: elke doc betaalt die bij elke lezing.

---
