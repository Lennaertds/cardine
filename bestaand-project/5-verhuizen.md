# Stap 5 — Verhuizen

> **Rol:** Elk bestand naar zijn vaste plek, volgens de verhuistabel, zonder geschiedenis of links te verliezen. Pas daarna vult de kit aan wat ontbreekt.
> **Niet hier:** waar elk bestand hoort ([skelet](../standaard/skelet.md), [waar hoort dit](../standaard/waar-hoort-dit.md)).

## Waarom eerst verhuizen, dan de kit

Het script overschrijft niets, maar het kijkt alleen naar de **doelnaam**. Draai je het vóór het verhuizen, dan zet het een leeg sjabloon naast een bestaand bestand met dezelfde rol: `RULES.md` naast `REGELS.md`, `INDEX.md` naast `INDEX_DOCS.md`. Daarna faalt `git mv` omdat het doel al bestaat. Dus: eerst krijgt elk bestaand bestand zijn vaste naam, dan vult de kit de gaten.

## Volgorde

1. **Docs**, per map één commit: `context/`, `rules/`, `product/`, `design/`, `architecture/`, `research/`, `decisions/`, `work/`.

   ```bash
   git mv docs/INDEX_DOCS.md docs/INDEX.md
   git mv docs/architecture/SECURITY.md docs/architecture/security.md
   rg -n 'INDEX_DOCS|SECURITY\.md' . --glob '!node_modules'      # restverwijzingen
   ```

   - Hou bestaande namen als ze al duidelijk zijn: churn kost ook. Een bestand dat de rol van een kitbestand heeft maar anders heet (`REGELS.md`), krijgt wel de kitnaam: zo staat in elk project hetzelfde op dezelfde plaats.
   - Een rename die alleen in hoofdletters verschilt, werkt op Linux in één `git mv`. Op macOS of Windows in twee: `git mv SECURITY.md tmp.md && git mv tmp.md security.md`.
   - Grote bestanden met meerdere soorten inhoud: opsplitsen volgens de verhuistabel (P11).
   - Mappenbomen en bestandslijsten: schrappen (P5). Een beschrijving per module wordt de docstring van die module.
   - Een groot besluitenlog splits je in losse ADR's alleen als de meting erom vraagt; een script is dan sneller dan de hand.

2. **Data** naar de lagen ([data](../standaard/data.md)). Paden in de code mee aanpassen, liefst achter één env-variabele per laag, en `data/README.md` invullen per dataset. Daarna de oude dataregels onderaan `.gitignore` weg ([stap 4](4-opruimen.md)), en controleren:

   ```bash
   git status --short data/                              # niets verdwenen of plots getrackt
   git ls-files -ci --exclude-standard                   # leeg
   ```

3. **Apps**: tests naar de vaste plek (`tests/integration/`, `tests/e2e/`, `tests/smoke/`) en configs naar de app-root. De rest **bij aanraking**: wanneer je toch aan een bestand werkt, verhuist het naar `features/<domein>/` of `src/<domein>/`. Geen grote verhuizing van code in één keer: dat breekt elke openstaande branch.

4. **De kit voor wat ontbreekt**, eerst droog:

   ```bash
   kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git --dry-run
   kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git
   ```

   - Nooit `--starter`: die startcode hoort bij een nieuwe app en botst met een bestaand pakket.
   - Lees de lijst met `+`. Staat er een sjabloon bij waarvan het project de inhoud al onder een andere naam heeft, dan ontbreekt er een rij in de verhuistabel: zet die erbij, verhuis, en draai opnieuw.
   - De lijst met `=` is wat al bestaat; dat bestand blijft zoals het is. Vergelijk het met het kitbestand en neem met de hand over wat ontbreekt. Voor `app.mk`, `.env.example` en `docker-compose.yml` geldt: de kitversie is een voorbeeld, de waarden van het project (poorten, servicenamen, versies) winnen.
   - Een nieuw sjabloon dat je in deze herordening niet invult, gaat terug weg. Een leeg bestand in de kaart is een afleider.

5. **Na elke commit:** `make check`. De link-check vangt verwijzingen naar oude paden.

## Klaar als

- Elke rij in de verhuistabel is afgevinkt, of heeft "bij aanraking" als status.
- Een tweede droge run van de kit toont alleen nog sjablonen die je bewust niet gebruikt.
- `make check` is groen, dus geen dode links.
- `rg` op elke oude naam geeft alleen nog treffers in de verhuistabel.
- Regels buiten de repo (workspace-rules, user rules) verwijzen niet meer naar oude paden.
