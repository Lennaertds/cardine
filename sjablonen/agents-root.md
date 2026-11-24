# AGENTS.md (root)

> **Rol:** Wat elke agent bij elke taak moet weten: grenzen, commando's, werkwijze, afronden, en waar de rest staat.
> **Niet hier:** regels voor één app ([agents-app](agents-app.md)), de kaart van de docs ([docs-index](docs-index.md)).

**Kitbestand:** [kit/kern/AGENTS.md](../kit/kern/AGENTS.md) · laag kern · P1–P3, P6, P13, P17, P20, P22–P25, P28

## Wanneer

Altijd, dag 1, met alleen wat dan al waar is. Het groeit op fouten: elke regel erbij is een fout die de agent anders herhaalt. Elke regel kost tokens bij *elke* taak (harness tax, P25): liever een hook/test dan een zin. Richtlengte ~35–70 regels — dichter bij de Agent Engineering-root dan bij een operations manual.

## Invullen

De volgorde is vast, met het belangrijkste vooraan (P3):

1. **Eén zin** wat het project is, en de link naar `README.md`.
2. **Nooit.** De kit heeft er al: secrets, ruwe data, git, geen nieuwe mappen, RULES + security (live), rest via INDEX. Voeg toe wat **destructief** of **onomkeerbaar** is in dit project, met het waarom in dezelfde zin. Obs/perf/deps/polyglot/radar: **geen** always-on-links en **geen** keyword-catalogus in dit bestand.
3. **Commando's.** Alleen dagelijkse targets in de tabel (`check`, `check-full`, `dev`, één test, dependency toevoegen, `make help`; solo: `make spec s=<slug>`). Opt-in = één zin onder de tabel + INDEX/`make help`, niet acht rijen en niet een tabel met doc-paden.
4. **Werken.** Harde leesroutes alleen voor wat bij *dat type* taak altijd geldt: INDEX → één bestand; met modules: UI → `DESIGN.md`, feature → `PRODUCT.md`, research → `RESEARCH.md`; architectuur → `ARCHITECTURE.md` staat altijd. Solo: nieuw open werk → `make spec` (BACKLOG = index, plan in spec). Opt-in engineering: opdracht noemt het → INDEX (geen catalogus hier). Rollen en subagents: [agent-rollen](../standaard/agent-rollen.md). De kit heeft ook, in **korte** vorm:
   - **intent** boven groene tests (P22);
   - **geen nieuwe modulegrenzen** zonder te vragen (P23);
   - **één slice** per sessie + review in frisse context (P1, P19, P24);
   - met module `cursor`: *subagents* / *delegeer* / *parallel* → `.cursor/agents/` ([cursor-agents](cursor-agents.md));
   - **uitvoeren wint van praten**;
   - **rapporteren beknopt** (`make check`-output wél tonen).
5. **Afronden.** Solo: check → docs → **dag-log entry** (`make log`, velden: aanleiding/bestanden/test/mislukt/item) → ADR alleen bij keuze met waarom → BACKLOG/spec. Team: check → docs → ADR-bij-keuze → PR. Explicit: **zonder te vragen** na repo-wijziging; pure Q&A overslaan. BACKLOG + log = spine (P27), niet de chat.

Optioneel, alleen als het team het echt afspreekt: één regel over welk model voor routinetaken vs. open redeneerwerk (P26).

## Voorbeeld (GymFreak, alleen wat de kit niet al heeft)

```markdown
## Nooit

- Geen gezondheidsdata uit `data/runtime/user/` of Health-exports lezen, loggen of in een antwoord tonen.
- Geen code of assets overnemen uit `Caddie/`: aparte projecten, aparte merken.
- Bestanden met "Schrijven: na toestemming" in de kop pas wijzigen na een uitdrukkelijk ja.
- Pad niet zeker of je het mag schrijven: [write-rules.md](docs/agent/write-rules.md).

## Werken

- Voorbeeld van een goed domein: `apps/api/src/sleep/` (module, service, `sleep-engine.ts` met tests).
- Postgres is de enige writer van user-data; de analytics-batch leest alleen.
- Start van een taak: RULES → het backlog-item → de kaart.
- Opdracht over UI, scherm, layout, PWA, look of craft: eerst [DESIGN.md](docs/design/DESIGN.md); daarna alleen het ene craft-bestand dat die kaart aanwijst.
- Uitvoeren wint van praten: *implementeer* / *bouw* / *ja* → deze beurt code, geen "zal ik beginnen?".
```

Een volledig ingevulde versie voor een teamproject staat bij [DEP2, stap D-3](../bestaand-project/voorbeelden/dep2.md#stap-d-3--agentsmd-d1-d9).

## Snelle toets

- [ ] Onder de 70 regels (`make docs-health`). Langer = harness tax (P25); streef ~50.
- [ ] Deletion test per regel: zou de agent zonder deze regel een fout maken? Zo niet, schrappen (P20).
- [ ] Geen mappenboom, geen keyword-catalogus van docs, geen stijlregels die de linter al afdwingt, geen status.
- [ ] Opt-in engineering (obs/perf/deps/polyglot/radar) alleen via INDEX/`make help`, **niet** als genummerde always-on Werken-stappen of als pad-tabel in AGENTS.
- [ ] Commandotabel heeft geen acht rijen voor zelden-gebruikte kit-targets; die staan onder `make help`.
- [ ] Een regel die afdwingbaar is, is ook afgedwongen (hook, test, CI) en staat hier hooguit als verwijzing (P14).
- [ ] Intent- en seam-regels uit de kit staan er (kort), niet weggeknipt.
- [ ] Rapportage: beknopte-rapportageregel staat er; geen lange narratieve statusupdates verwacht.
- [ ] Frisse agent: draait hij uit zichzelf `make check` en opent hij de kaart? Bij een UI-taak: eerst `DESIGN.md`? Bij "gebruik subagents": kijkt hij in `.cursor/agents/`? ([toets](../nieuw-project/4-agent.md#toets-met-een-frisse-agent))

### Dekking (Coldtea, bron §34)

Acht thema's die top-repos vaak in `AGENTS.md` zetten. Vink = de agent vindt het in dit *systeem* (niet per se inline hier). Structure/style hoort elders (P5).

| Thema | Afgedekt door | ✓ |
|-------|---------------|---|
| Don’t-rules | `AGENTS.md` § Nooit + RULES/security | |
| Commit / PR | Nooit committen zonder vraag; team: PR in Afronden | |
| Testing / validatie | `make check` (+ single-test in Commando’s) | |
| Code style | linter/formatter (niet in AGENTS) | |
| Links naar docs | kaart `docs/INDEX.md` (opt-in via opdracht + INDEX) | |
| CI / pre-commit | `make check` / hooks (verwijzing genoeg) | |
| Build & setup | commandotabel (dagelijks) + `make help` | |
| Project structure | *niet* in AGENTS; via INDEX / code (P5) | |
