# Stap 3 — Apps en feedbacklus

> **Rol:** Elke app genereren, de kit eroverheen leggen, en `make check` groen krijgen met een echte test. Dit levert het meest op van alle stappen (P13).
> **Niet hier:** de indeling binnen een app ([stacks](../standaard/stacks.md)), wat elke target doet ([makefile](../standaard/makefile.md)).

## Doen

1. **Generator per app, in deze volgorde: generator eerst, kit daarna.** De generators weigeren een map die niet leeg is. De commando's staan in de gids per stack:

   | Stack | Gids |
   |-------|------|
   | Next.js → `apps/web` | [kit/stacks/next](../kit/stacks/next/README.md) |
   | NestJS → `apps/api` | [kit/stacks/nest](../kit/stacks/nest/README.md) |
   | Python → `apps/analytics` | [kit/stacks/python](../kit/stacks/python/README.md) |
   | SQL-pipeline → `apps/pipeline` | [kit/stacks/sql](../kit/stacks/sql/README.md) |

2. **Kit over de apps:**

   ```bash
   kit/new-project.sh . --stacks next,nest --starter
   ```

   Dit zet per app `app.mk`, `AGENTS.md`, `.env.example` en de vaste mappen neer. De root-`Makefile` vindt de `app.mk` vanzelf.

3. **Scripts toevoegen** die `app.mk` aanroept (`lint`, `typecheck`, `test`, …): zie stap 3 in elke stackgids.

4. **Installeren en controleren:**

   ```bash
   make setup        # .env uit .env.example, dependencies per app, pre-commit
   make up           # alleen met de module compose
   make check        # lint, types, unit-tests van elke app + links
   make dev          # alle apps tegelijk
   ```

5. **Eén echte test per app** die slaagt, ook al test hij bijna niets. Met `--starter` brengen de Python-stacks er een mee (`test_config.py`).

6. **Team:** CI draait `make check` op elke PR (`.github/workflows/check.yml` uit de team-laag). Zet branch protection op `main`.

## Klaar als

- `make check` eindigt met `make check: groen`.
- `make help` toont een groep per app.
- `make doctor` toont geen `MIST`.
- In `ARCHITECTURE.md` staan de poorten uit de `app.mk`'s (`WEB_PORT`, `API_PORT`).

## Extra apps en targets

- **Tweede app van dezelfde stack:** kopieer `kit/stacks/<stack>/apps/<app>/` met de hand naar `apps/<nieuwe-app>/` en hernoem het voorvoegsel in `app.mk`.
- **Eigen target van het project** (bv. `boost`): in de `app.mk` van de app waar hij bij hoort, met `## uitleg`.
- **Persoonlijke target** (bv. met je eigen testaccount): in `local.mk`; staat niet in git.

## Valkuilen

- `make check` raakt het netwerk of de database: dat hoort in `check-full`. `check` moet in seconden tot een minuut draaien, anders draait de agent hem niet.
- Een generator maakt een eigen `README.md` of `AGENTS.md`: de kit slaat die over (uitvoer met `=`). Neem de regels uit de kit-`AGENTS.md` met de hand over.
- Boilerplate van de generator (voorbeeldlogo's, demo-routes) meteen weg: het zijn afleiders.
