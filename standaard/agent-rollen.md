# Agent-rollen en subagents

> **Rol:** Welke rol bij welk soort opdracht hoort, welke docs/code die rol opent, en wanneer je een Cursor-subagent start i.p.v. alleen de leesroute.
> **Niet hier:** de kitbestanden zelf ([kit](../kit/README.md)), hoe je ze invult ([sjablonen/cursor-agents](../sjablonen/cursor-agents.md), [agents-root](../sjablonen/agents-root.md)).

Twee lagen (P2, P24, P25):

| Laag | Waar | Wanneer |
|------|------|---------|
| **Leesroute** | Eén regel in `AGENTS.md` § Werken | Altijd bij dat soort opdracht; goedkoop; geldt voor elke tool |
| **Subagent** | `.cursor/agents/<rol>.md` | Op *subagents* / *delegeer* / *parallel*, grote multi-sporen, of review van eigen diff — eigen context window |

Geen lange rol-essays in `AGENTS.md`. Detail staat in de kaart (`DESIGN.md`, `PRODUCT.md`, …) en in het agentbestand. Obs/perf/deps/polyglot/radar hebben **geen** eigen always-on leesroute en geen vaste subagent: alleen INDEX + opdracht die het noemt.

## Rollen

| Rol | Triggers (voorbeelden) | Eerst openen | Daarna code / data | Kitbestand |
|-----|------------------------|--------------|--------------------|------------|
| **ui** | UI, scherm, layout, PWA, look, craft | `docs/design/DESIGN.md` → één craft | `apps/web/src/features/`, `components/ui/`, tokens | module `design` → `.cursor/agents/ui.md` |
| **product** | feature, gedrag, acceptatie, domeinregel | `docs/product/PRODUCT.md` → één domein | `apps/*/src/.../<domein>/` | module `product` → `.cursor/agents/product.md` |
| **architecture** | seams, containers, modules, dataflow | `docs/architecture/ARCHITECTURE.md` → één subsystem | langs bestaande seams; geen nieuwe `utils/` | module `cursor` → `.cursor/agents/architecture.md` |
| **research** | onderzoek, analyse, literatuur, experiment | `docs/research/RESEARCH.md` → één onderwerp/experiment | `apps/analytics/` of `pipeline/`, `data/` (niet `raw/` schrijven) | module `research` → `.cursor/agents/research.md` |
| **reviewer** | review, check diff, frisse blik, na implement | opdracht/spec + diff die de parent meegaf | readonly; `make check` | module `cursor` → `.cursor/agents/reviewer.md` |
| **clarify** | check mijn prompt, is dit duidelijk, `/clarify` | alleen de gebruikersprompt (+ @-bestanden) | geen code; score + herschreven prompt | module `cursor` → `.cursor/agents/clarify.md` |

App-valkuilen blijven in `apps/<app>/AGENTS.md` (P15), niet in de rolbestanden.

**Clarify is nooit altijd-aan.** Elke taak eerst door een subagent jagen kost roundtrips (P25) en botst met *uitvoeren wint van praten*. Roep hem aan als jij twijfelt, of na twee mislukte correcties (§12).

## Wanneer de main agent delegeert

Delegeer (subagent) als minstens één geldt:

1. De gebruiker zegt *subagents*, *delegeer*, *parallel*, of `/<rol>`.
2. Het werk heeft **meerdere onafhankelijke sporen** (bv. UI + API) die parallel kunnen.
3. **Review van eigen diff** in dezelfde sessie — reviewer-subagent of nieuwe sessie (P24, bron §1).
4. Diep **zoek-/analysewerk** dat de hoofdcontext zou vervuilen; parent wil alleen de samenvatting.

Blijf in de main agent bij één smalle slice met één leesroute.

## Taakstructuren (orchestrator)

Parent plant en syntheseert; specialisten voeren uit. Elke pijl is een handoff met korte, gestructureerde output.

```text
UI-fix
  main ──leesroute──▶ DESIGN (+ eventueel /ui)
  main ──▶ reviewer   (optioneel na de fix)

Feature-slice
  main|product ──▶ domein-doc + slice
  main ──▶ implementatie (of architecture als seams onzeker)
  main ──▶ reviewer     (spec + anti-smell, schone context)

Analyse / research
  main|research ──▶ RESEARCH + bronnen
  main ──▶ product of experiment-doc als er een claim uit komt

Grote wijziging (parallel)
  main ──▶ architecture (grenzen)  ║  research/ui/product (sporen)
  main ──▶ implementatie per slice
  main ──▶ reviewer
```

## Voorbeelden: prompt → aanpak

### 1. UI-fixes met attachments

```text
UI Fixes volgens de attachments in volgorde:
1) De balk is te groot en past niet op beeld
2) …
Gebruik subagents waar passend.
```

| Stap | Wie | Wat |
|------|-----|-----|
| 1 | main | Leesroute UI → `DESIGN.md` → één craft (niet alleen de screenshot) |
| 2 | `/ui` of main | Fixes **in de gegeven volgorde**, één scherm/component per keer |
| 3 | optioneel `/reviewer` | Diff vs. craft + “past op beeld” |

Zonder craft-doc of schermnaam: eerst `/clarify` of één vraag (“welk scherm / welke balk?”).

### 2. Onduidelijke backlog-ToDo

```text
Deze ToDo @docs/work/BACKLOG.md (regel …) is echt onduidelijk en slecht geformuleerd, fix dat
```

| Stap | Wie | Wat |
|------|-----|-----|
| 1 | main | Open het backlog-item + gelinkte spec als die er is |
| 2 | main (solo) | Herschrijf de **één-regel** in BACKLOG en/of de spec (`make spec` als die ontbreekt): doel, scope, klaar-als |
| — | niet | Geen feature bouwen; geen `/ui` — dit is werk/docs, geen productcode |

Twijfel je of “fix” = tekst of implementatie: `/clarify` eerst.

### 3. Data → analyse uitleggen + vereenvoudigen

```text
Wat is het stappenplan van de ruwe data tot de analyse en leg uit.
Ik denk dat we dit simpeler kunnen doen.
```

| Stap | Wie | Wat |
|------|-----|-----|
| 1 | main of `/architecture` | `ARCHITECTURE.md` (dataflow) + `data/README.md` |
| 2 | `/research` als er experiment/literatuur bij hoort | Anders analytics-paden via `apps/analytics/` |
| 3 | main | Uitleg in stappen; voorstel tot vereenvoudiging als **opties + impact**, geen stille rewrite van de pipeline |
| 4 | bij akkoord “vereenvoudig” | Nieuwe slice/ADR; niet alles in één sessie |

### 4. Prompt eerst checken

```text
/clarify
UI Fixes volgens de attachments: 1) balk te groot 2) …
```

| Stap | Wie | Wat |
|------|-----|-----|
| 1 | `/clarify` | Score, ontbrekende info, herschreven prompt |
| 2 | jij | Plak de betere prompt of antwoord de vragen |
| 3 | main/`/ui` | Pas dan uitvoeren |

### 5. Feature bouwen (helder)

```text
Implementeer slice 2 uit @docs/work/specs/diet-budget.md. Gebruik subagents.
```

| Stap | Wie | Wat |
|------|-----|-----|
| 1 | `/product` of main | `PRODUCT.md` → domein-doc; slice-grenzen respecteren |
| 2 | main | Code volgens bestaande modules |
| 3 | `/reviewer` | Spec-compliance + `make check` |

## Harness tax

- Maximaal één leesroute-regel per rol in `AGENTS.md`.
- Subagentbestanden kort houden; geen kopie van `AGENTS.md`.
- Module `cursor` zet de gedeelde agents (`architecture`, `reviewer`, `clarify`) en de regel *subagents → `.cursor/agents/`*; `design` / `product` / `research` zetten hun eigen rol-agent.
- Geen clarify vóór routinetaken die al een pad, volgorde en “klaar als” hebben.
