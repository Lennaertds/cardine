# Stap 3 — Feedbacklus

> **Rol:** Vóór je aan docs begint: zorgen dat `make check` bestaat, alles dekt en groen is. Dit levert het meest op en verandert geen documentatie (P13).
> **Niet hier:** de targets en het mechanisme ([makefile](../standaard/makefile.md)).

## Doen

1. **Kit-Makefile als basis.** In deze stap kopieer je met de hand; het script draait pas in [stap 5](5-verhuizen.md), na het verhuizen. Bestaat er al een Makefile, hernoem die dan tijdelijk en neem de kit-versie:

   ```bash
   git mv Makefile Makefile.oud
   cp kit/kern/Makefile <project>/Makefile && sed -i 's/{{PROJECT}}/<Project>/' <project>/Makefile
   cp -n kit/kern/scripts/check-links.sh <project>/scripts/
   ```

2. **Per app een `app.mk`** uit `kit/stacks/<stack>/apps/<app>/app.mk`. Pas de commando's aan op de scripts die de app al heeft, maar hou de targetnamen. Ontbreekt een tool (geen unit-tests, geen linter), laat die regel dan weg en zet een backlog-item; een commando dat niet bestaat maakt `check` rood:

   ```make
   check-web: ## web: lint, types en unit-tests
   	pnpm --filter @gymfreak/web lint
   	pnpm --filter @gymfreak/web typecheck
   ```

3. **Oude targets overzetten** naar de vaste namen. Eén tabel in de commit-boodschap of de verhuistabel:

   | Oud | Nieuw | Waar |
   |-----|-------|------|
   | `make start` | `make dev` | root (`DEV` uit de `app.mk`'s) |
   | `make web`, `make api` | `make dev-web`, `make dev-api` | `app.mk` |
   | `make clean` (alleen `.next`) | `make clean-web`; `make clean` doet alles | `app.mk` |
   | een eigen target die alleen jij gebruikt | dezelfde naam | `local.mk` |

   Een target die in geen enkele lijst past, blijft bestaan, in de `app.mk` van de app waar hij bij hoort, met `## uitleg`.

4. **Snel en volledig scheiden.** `check` = lint, types, unit-tests van **elke** app, zonder netwerk of database. Wat Postgres, een browser of een externe dienst nodig heeft, gaat naar `check-full`.

5. **Groen maken.** Faalt `make check` op bestaande fouten, los ze op of zet een tijdelijke uitzondering met een backlog-item. Een check die altijd rood is, leert de agent hem te negeren.

6. `Makefile.oud` weg zodra elke target een plaats heeft.

## Klaar als

- `make check` eindigt met `make check: groen` en dekt elke app.
- `make help` toont elke target die iemand gebruikt.
- `AGENTS.md` (of de oude router) noemt `make check` als eerste stap van afronden. Het herschrijven volgt in [stap 6](6-router-en-kaart.md).

Uitgewerkt voor GymFreak: [G-1](voorbeelden/gymfreak.md#stap-g-1--make-check-en-de-vaste-targets-g1).
