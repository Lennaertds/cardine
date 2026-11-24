# Makefile

> **Rol:** Welke make-targets elk project heeft, wat ze doen, en hoe een app er de zijne aan toevoegt.
> **Niet hier:** de Makefile zelf ([kit/kern/Makefile](../kit/kern/Makefile)), de targets van één stack ([kit](../kit/README.md#stacks)), hoe je hem aanpast per project ([sjabloon](../sjablonen/makefile.md)).

## Waarom één Makefile

- **Vaste namen over alle projecten heen.** `make check` betekent overal hetzelfde: groen of niet. Mens, agent en CI hoeven per project niets op te zoeken (P13).
- **De agent leest één tabel.** `AGENTS.md` noemt de targets, niet de onderliggende `pnpm`-, `uv`- of `docker`-commando's. Verandert een tool, dan verandert alleen de Makefile.
- **`make` zonder argument toont alles.** Elke target met `## uitleg` verschijnt in `make help`, gegroepeerd per `##@`-kop.

## Hoe apps zich aanmelden

De root-`Makefile` kent geen enkele app. Elke app heeft een eigen `apps/<app>/app.mk`, en de root neemt die automatisch op:

```make
-include $(sort $(wildcard apps/*/app.mk))
-include local.mk
```

Een `app.mk` vult lijsten aan en definieert zijn eigen targets met het achtervoegsel `-<app>`:

```make
CHECK += check-web
check-web: ## web: lint, types en unit-tests
	pnpm --dir apps/web run lint
```

De root-target `check` hangt af van `$(CHECK)` en draait dus elke `check-<app>`. Komt er een app bij, dan kopieer je één `app.mk` en hoef je de root niet aan te passen.

| Lijst | Root-target | Wat een app eraan toevoegt |
|-------|-------------|----------------------------|
| `TOOLS` | `doctor` | de tools die hij nodig heeft (`node pnpm`, `uv`, `psql`) |
| `SETUP` | `setup` | `setup-<app>`: dependencies installeren |
| `DEV` | `dev` | `dev-<app>`: dev-server; `make dev` start ze parallel |
| `CHECK` | `check` | `check-<app>`: lint, types, unit-tests. Snel, zonder netwerk of database |
| `CHECK_FULL` | `check-full` | integratie, e2e, datakwaliteit: alles wat een dienst nodig heeft |
| `FMT` | `fmt` | `fmt-<app>` |
| `BUILD` | `build` | `build-<app>` |
| `SMOKE` | `smoke` | `smoke-<app>`: tegen `URL=`, of een eigen `<APP>_URL` |
| `BENCH` | `bench` | `bench-<app>`: perf-smoke; vereist `apps/<app>/scripts/bench.sh`. **Niet** in `check` |
| `DATA` | `data` | pipeline-stappen naar `data/processed/` |
| `SEED` | `seed` | testgebruikers en demo-data |
| `DB_RESET` | `db-reset` | lokale database leegmaken; **weigert** als `DATABASE_URL` niet naar localhost wijst |
| `CLEAN` | `clean` | `clean-<app>`: build-output en caches |
| `PORTS` | `status` | de poorten die de app lokaal gebruikt |

## De targets

### Starten

| Target | Wat |
|--------|-----|
| `help` | Alle targets met uitleg. Standaard bij `make`. |
| `setup` | `env`, dan `setup-<app>` voor elke app, dan `pre-commit install`. Eén keer na een clone. |
| `env` | Kopieert elke `.env.example` naar `.env` als die nog niet bestaat. Overschrijft nooit. |
| `doctor` | Toont per tool uit `TOOLS` of hij geïnstalleerd is; faalt als er een ontbreekt. |

### Lokaal draaien

| Target | Wat |
|--------|-----|
| `dev` | Alle `dev-<app>` tegelijk (`make -j`). Ctrl-C stopt alles. |
| `up` · `down` · `logs` | `docker compose` starten (en wachten tot de healthchecks groen zijn), stoppen, logs volgen. |
| `status` | Containers en welke poorten uit `PORTS` bezet zijn. |

### Controleren

| Target | Wat |
|--------|-----|
| `context s=<slug>` | Context-bundle: RULES.md + BACKLOG + spec in 1 uitvoer. Vervangt 3-4 losse `read_file` calls. Zonder `s=` enkel RULES + BACKLOG. |
| `finish MSG=…` | `check` + loggen in 1 call. Maakt een log-entry met de boodschap in `docs/work/logs/<vandaag>.md`. |
| `check` | `links` en elke `check-<app>`. **Moet groen zijn vóór je afrondt.** Faalt ook als er nog geen app is, zodat een leeg project nooit "groen" lijkt. |
| `check-full` | `check` plus `deps-audit` plus `native-bindings-strict` plus `CHECK_FULL`. Draait vóór een release of in de nachtelijke CI. |
| `links` | Dode relatieve links in alle `.md`-bestanden ([check-links.sh](../kit/kern/scripts/check-links.sh)). |
| `smoke URL=…` | Smoke-tests tegen een draaiende omgeving, bv. na een deploy. |
| `fmt` · `build` | Formatteren en productiebuild, per app. |
| `security-scan` · `security-scan-quick` | Strix-pentest op `TARGET=` (default `.`). **Niet** in `check`. Vereist Docker + `strix` + LLM-key. |
| `container-setup` | Container-safe functies voor npm/pip/cargo. Installeert Podman niet — dat is systeembeheer. Zet shell-functies klaar in `scripts/container-safe.sh`. **Niet** in `check`. |
| `obs-up` · `obs-down` · `obs-status` | LGTM-stack (module `observability`). Faalt duidelijk zonder die module. |
| `perf-check` | Structuur van `docs/architecture/performance.md`. **Niet** in `check`. |
| `bench` | Alle `bench-<app>` (BENCH-lijst). Faalt tot `scripts/bench.sh` bestaat. |
| `deps-audit` | CVE-audits (npm/pnpm, pip-audit/uv; cargo stub) + structuur `dependencies.md`. **In** `check-full`, niet in `check`. |
| `native-bindings-strict` | `NATIVE_STRICT=1` voor `apps/native` en/of `native-c` (geen JS/Python-fallback). **In** `check-full`, niet in soft `check`. Zie how-to `native-ci.md`. |
| `polyglot-check` | Structuur van `docs/architecture/polyglot.md` + aanwezigheid voorbeeld-ADR. **Niet** in `check`. |
| `radar-check` | Structuur van `docs/research/radar.md` (module `research`). Faalt duidelijk zonder module. **Niet** in `check`. |
| `radar-reminder` | Tip + `Laatst herzien:`-datum (maandelijks ritueel). **Niet** in `check`. |
| `digest-check` | Scaffold `docs/research/digest/` (module `research`). **Niet** in `check`. |
| `digest-reminder` | Tip: SOURCES/feeds cureren (P5). **Niet** in `check`. |
| `digest-fetch` | RSS/Atom → `data/external/digest/`; `DIGEST_DRY_RUN=1` / `DIGEST_FIXTURE=`. **Niet** in `check`. |
| `digest-propose` | Voorstel in `docs/research/digest/proposals/` (geen auto-`radar.md`). **Niet** in `check`. |

### Data en database

| Target | Wat |
|--------|-----|
| `data` | De pipeline: `raw/`, `external/` en `reference/` naar `processed/`. Herhaalbaar. |
| `seed` | Testgebruikers en demo-data in de lokale database. |
| `db-reset` | Lokale database leegmaken, migreren, seeden. Met een guard op localhost. |

### Docs en werk

| Target | Maakt | Uit sjabloon |
|--------|-------|--------------|
| `adr t="Postgres is de enige writer"` | `docs/decisions/0007-postgres-is-de-enige-writer.md` met het volgende nummer en de datum | `docs/decisions/_template.md` |
| `spec s=diet-budget` | `docs/work/specs/diet-budget.md` en een regel bovenaan **Nu** in `BACKLOG.md` | `docs/work/specs/_template.md` |
| `log` | `docs/work/logs/<vandaag>.md` als hij nog niet bestaat; toont het pad | `docs/work/logs/_template.md` |
| `meeting met=coach` | `docs/work/meetings/<vandaag>-coach.md` | `docs/work/meetings/_template.md` |
| `experiment s=sleep-baseline` | `docs/research/experiments/<vandaag>-sleep-baseline.md` | `docs/research/experiments/_template.md` |
| `docs-health` | Dode links, lengte van elke `AGENTS.md`, de vijftien docs die het langst niet wijzigden | — |

Elke target die een map nodig heeft die niet in het project zit (bv. `spec` in een teamproject), faalt met een melding welke kit-module hem neerzet.

### Opruimen

| Target | Wat |
|--------|-----|
| `clean` | `clean-<app>` voor elke app, `tmp/` weg, `data/interim/` leeg. Nooit `raw/`, `processed/` of een database. |

## Regels voor eigen targets

1. **Projecttargets in `app.mk` of de root, persoonlijke in `local.mk`.** `local.mk` staat in `.gitignore`. Een target die alleen jij gebruikt (bv. een dev-boost voor je eigen testaccount), komt daar.
2. **Elke target die iets zinnigs doet, krijgt `## uitleg`.** Zonder uitleg verschijnt hij niet in `make help` en dus ook niet voor de agent.
3. **Destructief = guard.** Een target die data wist, controleert eerst waar hij naartoe schrijft, en weigert anders met een duidelijke melding.
4. **Geen logica in de Makefile die een test nodig heeft.** Wordt een recept langer dan ±10 regels, maak er dan `scripts/<naam>.sh` of `apps/<app>/scripts/` van, en laat de target dat aanroepen.
5. **Meldingen zeggen wat je moet doen.** Niet "Error 1", wel "Docker draait niet. Start de daemon en probeer opnieuw."
6. **Recepten springen in met een tab.** `.editorconfig` uit de kit zet dat goed voor `Makefile` en `*.mk`.
