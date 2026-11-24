# Makefile, apps/&lt;app&gt;/app.mk, local.mk

> **Rol:** De commando's van het project aanpassen zonder de vaste namen te breken.
> **Niet hier:** wat elke target doet en hoe het mechanisme werkt ([standaard/makefile](../standaard/makefile.md)).

**Kitbestanden:** [kit/kern/Makefile](../kit/kern/Makefile) · `app.mk` per stack: [next](../kit/stacks/next/apps/web/app.mk), [nest](../kit/stacks/nest/apps/api/app.mk), [python](../kit/stacks/python/apps/analytics/app.mk), [sql](../kit/stacks/sql/apps/pipeline/app.mk) · P13

## Wanneer

De root-`Makefile` kopieer je en pas je zelden aan. Je werkt in de `app.mk` van elke app, en in `local.mk` voor wat alleen jij gebruikt.

## Invullen

| Wat je wil | Waar | Hoe |
|------------|------|-----|
| Ander commando voor een vaste target | `apps/<app>/app.mk` | recept aanpassen, naam houden (`check-web` blijft `check-web`) |
| Andere poort | bovenaan de `app.mk` | `WEB_PORT ?= 3002`; overschrijven kan per keer: `make dev-web WEB_PORT=4000` |
| Nieuwe target voor één app | de `app.mk` van die app | naam met `-<app>`, `## uitleg`, in de juiste lijst (`CHECK_FULL += e2e-web`) |
| Nieuwe target voor het hele project | root-`Makefile`, onder de juiste `##@`-groep | `## uitleg`; bij `.PHONY` zetten |
| Iets alleen voor jou | `local.mk` (niet in git) | gewone targets met `## uitleg`; `make help` toont ze ook |
| Tweede app van dezelfde stack | `apps/<nieuw>/app.mk` | kopie, voorvoegsel en achtervoegsel hernoemen (`ADMIN_DIR`, `check-admin`) |

Recepten springen in met een **tab**. De `.editorconfig` uit de kit regelt dat.

## Voorbeeld (GymFreak, `local.mk`)

Een target die je eigen testaccount gebruikt, hoort niet in git:

```make
##@ Persoonlijk (local.mk)
boost: ## eigen testaccounts: max coins, alle thema's
	@node apps/api/scripts/dev-boost.mjs test@gymfreak.be lennaert@gymfreak.be
```

En in `apps/web/app.mk`, als web pas mag starten als de API luistert:

```make
dev-web: ## web: Next dev-server; wacht tot de API op API_PORT luistert
	@until (echo >/dev/tcp/127.0.0.1/$(API_PORT)) 2>/dev/null; do sleep 0.5; done
	pnpm --dir $(WEB_DIR) exec next dev --port $(WEB_PORT)
```

## Snelle toets

- [ ] `make help` toont elke target die iemand gebruikt, met uitleg.
- [ ] `make check` draait zonder netwerk of database, en eindigt met "groen".
- [ ] `security-scan*`, `obs-*`, `perf-check` en `bench` staan in `make help`, niet in `CHECK`.
- [ ] `deps-audit` staat in `make help` en in `check-full`, niet in `CHECK`.
- [ ] `native-bindings-strict` staat in `make help` en in `check-full`, niet in soft `CHECK`.
- [ ] `polyglot-check` staat in `make help`, niet in `CHECK` / `check-full`.
- [ ] Root-`AGENTS.md` noemt opt-in-targets in één zin → `make help`/INDEX, niet als acht always-on commandorijen of pad-catalogus.
- [ ] Met module `research`: `radar-*` / `digest-check` / `digest-reminder` / `digest-fetch` / `digest-propose` in `make help`, niet in `CHECK`.
- [ ] Elke target die data wist, heeft een guard.
- [ ] Geen recept langer dan ±10 regels; anders een script in `scripts/`.
