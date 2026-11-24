# Opstartpakket — instructies voor de agent

> **Rol:** De procedure voor een agent die een project naar de standaard brengt: een leeg project opzetten of een bestaand herordenen, en daarna dit pakket weer weghalen.
> **Niet hier:** de standaard zelf ([standaard](standaard/INDEX.md)), het stappenplan in detail ([nieuw-project](nieuw-project/INDEX.md), [bestaand-project](bestaand-project/INDEX.md)).

Je staat in de root van een project. Deze map heet daar `_bootstrap/` en is tijdelijk: hij staat in `.git/info/exclude`, komt nooit in een commit en gaat weg aan het einde. Alle paden hieronder zijn relatief aan de projectroot, tenzij ze in een link staan.

De mens zette het pakket hier met `make bootstrap DIR=<project>` in de standaard. Hij vroeg je: "Lees `_bootstrap/BOOTSTRAP.md` en volg het voor dit project."

## Harde regels, gedurende de hele procedure

1. **Nooit lezen, tonen of committen:** `.env` en elke andere secret, en data in `data/raw/`, `data/runtime/` of een map met gebruikers- of gezondheidsdata. Inventariseer zulke mappen op naam en grootte (`fd`, `du`), nooit op inhoud.
2. **De regels van het project gaan voor.** Staat in `AGENTS.md`, `.cursorrules` of een workspace-rule iets strengers (niet committen, een map niet aanraken), dan volg je dat.
3. **Niet zelf committen**, tenzij de mens het in dit gesprek uitdrukkelijk toestaat. Na elke fase stop je met `git status --short`, een samenvatting en een voorgestelde commit-boodschap; de mens commit.
4. **Verhuizen met `git mv`**, nooit kopiëren en verwijderen. Niets overschrijven: het kitscript doet dat nooit, en jij ook niet met de hand.
5. **Geen code herschrijven** behalve paden die door een verhuizing veranderen. Code verhuist "bij aanraking", later.
6. **`make check` na elke fase.** Rood: eerst oplossen of melden, niet verder.
7. **Twijfel is een vraag**, geen gok. Een bestand zonder duidelijke plaats gaat als vraag naar de mens.
8. **Standaard-features die in de docs staan maar hier nog niet aangesloten zijn** (tooling, Make-target, secrets, Docker): niet negeren. Solo: één regel in `docs/work/BACKLOG.md` (§ Straks of § Geparkeerd) met *wat* ontbreekt en *waarop* je wacht. Team: equivalent issue. De documentatie blijft de bron van waarheid over *hoe* het hoort.

## Wat waar staat in dit pakket

Lees just-in-time, alleen wat de fase vraagt.

| Nodig voor | Lees |
|------------|------|
| Waar hoort een bestand? | [standaard/waar-hoort-dit](standaard/waar-hoort-dit.md), [standaard/skelet](standaard/skelet.md) |
| Wat hoort in een bestand, en wat niet? | [standaard/bestanden](standaard/bestanden.md), en de gids in [sjablonen](sjablonen/INDEX.md) |
| Makefile, targets, `app.mk` | [standaard/makefile](standaard/makefile.md) |
| Datalagen | [standaard/data](standaard/data.md) |
| De bestanden zelf, en het script | [kit](kit/README.md): `bash _bootstrap/kit/new-project.sh . …` |
| Een uitgewerkt voorbeeld | [GymFreak](bestaand-project/voorbeelden/gymfreak.md) (solo), [DEP2](bestaand-project/voorbeelden/dep2.md) (team) |

## Fase 0 — Soort project bepalen

```bash
git status --short | head; ls -A | grep -vx -e .git -e _bootstrap
```

- **Leeg** (niets buiten `.git` en `_bootstrap`): ga naar [Nieuw project](#nieuw-project).
- **Bestaand**: ga naar [Bestaand project](#bestaand-project). Is er een uitgewerkt voorbeeld voor dit project, gebruik dat als startpunt, maar controleer elk feit opnieuw: het project kan intussen veranderd zijn.

Vraag in beide gevallen: **solo of team?** Solo krijgt `.cursorrules` als dunne persoonlijke laag; team niet.

## Nieuw project

1. **Afstemmen.** Vraag wat het project doet (één zin), welke apps (web, API, data, pipeline), of er een database is, en of het een opdracht of klant heeft. Stel op basis daarvan het commando voor uit de tabel in [nieuw-project](nieuw-project/INDEX.md), met `--starter`. **Stop** tot de mens akkoord geeft.
2. **Kit kopiëren:** eerst `--dry-run`, toon de lijst, dan echt. Volg [stap 1](nieuw-project/1-kit-kopieren.md).
3. **Context en grenzen:** samen met de mens invullen, [stap 2](nieuw-project/2-context-en-grenzen.md). Vul niets in wat de mens niet zei; laat de `<placeholder>` staan en vraag.
4. **Apps en feedbacklus:** generators per stack, dan de stack opnieuw met `--starter`, tot `make check` groen is. [Stap 3](nieuw-project/3-apps-en-feedbacklus.md).
5. **Agent:** `AGENTS.md` en (solo) `.cursorrules` afwerken, [stap 4](nieuw-project/4-agent.md).
6. Naar [Afsluiten](#afsluiten).

## Bestaand project

Volg [bestaand-project](bestaand-project/INDEX.md), met deze pauzes.

### Fase 1 — Inventaris en plan (alleen lezen)

1. De inventaris uit [stap 1](bestaand-project/1-nulmeting-en-inventaris.md): alle docs, routers, rules, build-output in git, sync-restjes, de grootste bestanden, de Makefile-targets en package-scripts per app.
2. De droge run van de kit, **zonder** `--starter`. Kies modules en stacks op basis van de inventaris.
3. Elk bestand een soort en een doel ([stap 2](bestaand-project/2-classificeren.md)).
4. **Toon het plan** aan de mens, in deze vorm, en **stop**:

   | Fase | Wordt uitgevoerd | Verandert |
   |------|------------------|-----------|
   | Feedbacklus | … | welke bestanden nieuw, welke targets hernoemd |
   | Opruimen | … | wat uit git verdwijnt (met aantallen), wat weg gaat |
   | Verhuizen | … | elke `git mv` (oud → nieuw), elk codepad dat mee verandert |
   | Router en kaart | … | wat uit de oude router waarheen gaat |

   Plus: de vragen (bestanden zonder duidelijke plaats, keuzes tussen twee lijnen) en wat je **niet** aanraakt.

Pas na akkoord schrijf je. Het plan gaat als verhuistabel in `docs/work/specs/herordening.md` (sjabloon met de hand kopiëren, zie stap 1). Vraag of de mens een nulmeting wil ([meten](meten/INDEX.md)); zo ja, die eerst.

### Fase 2 tot 5 — Uitvoeren, elk met een pauze

| Fase | Stap | Klaar als |
|------|------|-----------|
| 2 | [Feedbacklus](bestaand-project/3-feedbacklus.md) | `make check` bestaat, dekt elke app en is groen |
| 3 | [Opruimen](bestaand-project/4-opruimen.md) | `git ls-files -ci --exclude-standard` is leeg |
| 4 | [Verhuizen](bestaand-project/5-verhuizen.md): docs, data, apps, **dan pas** de kit | elke rij van de verhuistabel afgevinkt; geen dode links |
| 5 | [Router en kaart](bestaand-project/6-router-en-kaart.md) | één `AGENTS.md`; solo een dunne `.cursorrules`; geneste `AGENTS.md` per app |

Na elke fase: `make check`, `git status --short`, een korte lijst van wat veranderde, een commit-boodschap, en **stop**. Een fase met veel verhuizingen (docs per map) mag je opdelen in meerdere pauzes.

### Fase 6 — Meten en vastleggen

Als er een nulmeting was: [stap 7](bestaand-project/7-meten-en-vastleggen.md). Anders alleen de ADR "herordening naar de standaard" met wat veranderde en wat bewust niet.

## Al op de standaard — kit-delta

Gebruik dit als het project **al** een `AGENTS.md`, `docs/INDEX.md` en `make check` heeft (bv. GymFreak na eerdere bootstrap), en je alleen nieuwe kitbestanden + router-vorm wilt bijtrekken. Geen herordening, geen `--starter`.

1. **Droge run** (zelfde modules/stacks als eerder; GymFreak: zie [gymfreak.md](bestaand-project/voorbeelden/gymfreak.md)):

   ```bash
   bash _bootstrap/kit/new-project.sh . --modules <…> --stacks <…> --no-git --dry-run
   ```

   Toon `+` (nieuw) vs `=` (bestaat). **Overschrijf nooit** een bestaand bestand met het script.

2. **Nieuwe kitbestanden** (`+`): script echt draaien of met de hand kopiëren. Typisch: `docs/architecture/{observability,performance,dependencies,polyglot}.md`, how-to’s, scripts, research radar/digest, voorbeeld-ADR `0000-…`.

3. **Merge bestaande bestanden** (vorm = kit, feiten = project):

   | Bestand | Doen |
   |---------|------|
   | `AGENTS.md` | Kit-vorm: korte Nooit (RULES + security live; rest via INDEX — **geen** polyglot/keyword-catalogus always-on); commandotabel = dagelijks + één zin opt-in → INDEX/`make help`; Werken = harde leesroutes + intent/seams/slice kort. Projectfeiten behouden. Geen acht always-on kit-routes, geen pad-tabel voor zelden-gebruikte docs. |
   | `docs/INDEX.md` | Nieuwe satellieten + “opt-in” bij obs/perf/deps/polyglot; ARCHITECTURE-regel: niet PWA/auth-dump. |
   | `Makefile` | Kit-targets toevoegen (`security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, …) zonder project-targets te wissen. |
   | `docs/architecture/security.md` e.d. | Alleen ontbrekende secties (Strix, `## Bewust later`); geen projectlijst wissen. |
   | Vet `ARCHITECTURE.md` (>~100 regels Runtime/Auth-catalogus) | Containers/stack/dataflow/hosting/seams houden; PWA/offline/push → `architecture/runtime-client.md`; JWT/demo/onboarding-details → `architecture/auth.md` (of bestaande data-model/legal). INDEX bijwerken. |
   | Kit-docs die net binnenkwamen | Geen `kit/stacks/…`-paden, geen “Agent Engineering bron §…”; native-map alleen als die stack bestaat. |

4. Solo: BACKLOG § Straks/Geparkeerd voor wat docs beloven maar tooling nog mist (Strix-install, OTel in apps, perf-budgets, digest-feeds, …) — zie harde regel 8.
5. `make check` (en waar zinvol `polyglot-check` / `perf-check`). `make deps-audit` mag rood zijn tot CVE’s opgelost zijn — niet stil in `make check` stoppen.
6. Naar [Afsluiten](#afsluiten) (pakket weghalen).

## Afsluiten

1. **Eindcontrole:**

   ```bash
   make check
   make docs-health
   bash _bootstrap/kit/new-project.sh . --modules <dezelfde> --stacks <dezelfde> --no-git --dry-run   # alleen bewust overgeslagen sjablonen
   rg -n '\{\{PROJECT\}\}|\{\{DATE\}\}' --hidden --glob '!_bootstrap' --glob '!node_modules' .   # leeg
   rg -n '_bootstrap' --hidden --glob '!_bootstrap' --glob '!.git' .                             # leeg: niets verwijst naar het pakket
   ```

2. **Pakket weghalen:**

   ```bash
   bash _bootstrap/scripts/bootstrap.sh --remove .
   git status --short          # geen sporen van _bootstrap
   ```

3. **Eindverslag** aan de mens: wat veranderde per fase, wat bewust bleef, de open vragen, en de vervolgtaken buiten het project (workspace-rules, user rules). De links in dit verslag mogen niet naar `_bootstrap/` wijzen: die map bestaat niet meer.
