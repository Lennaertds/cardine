# 0015 — `tool-todo` uitschakelen + `jarvis-check` in Makefile + `indexRepo`-verbod in AGENTS.md

- **Status:** aanvaard
- **Datum:** 2026-11-22
- **Raakt:** `packages/lab/cardine-status.sh`, `packages/lab/install-lab.sh`, `packages/structure/kit/kern/Makefile`, `packages/structure/kit/kern/AGENTS.md`, root `Makefile`, root `AGENTS.md`, DSH ACP-profiel `cordis.patch.yml`

## Samenvatting

In de context van een werkende Zed + DSH + Jarvis-stack op Arch Linux / Hyprland, geconfronteerd met (1) een persistente `400: Invalid structured outputs: 'triggers'` API-fout op DeepInfra (`deepseek-ai/DeepSeek-V4-Flash`) door de ingebouwde DSH `tool-todo`-plugin die een niet-OpenAI-compatibel JSON-schema (`triggers`) mee-stuurt, en (2) vastgelopen Jarvis-indexatie binnen `bwrap` (stale `.lock`-bestanden) wanneer de agent `mcp__jarvis__indexRepo` aanriep, kozen we voor (a) `tool-todo` permanent uitschakelen in ACP-profiel + `install-lab.sh`, (b) een `make jarvis-check` target met lock-PID-controle in `cardine-status.sh`, en (c) een hard verbod op `mcp__jarvis__indexRepo` in AGENTS.md, om reproduceerbaar foutloze sessies te garanderen zonder dat de agent destructieve index-acties in de sandbox start.

## Context

Tijdens het werken aan meerdere repositories (Cardine, Agent_Engineering, dep2-project-group-3) met DeepSeek Harness (`dsh` 0.2.2-rc.1) en DeepSeek V4 Flash via DeepInfra traden twee terugkerende fouten op:

1. **`400: Invalid structured outputs: 'triggers':`** Simpele vragen werkten altijd; zodra een taak meerdere stappen of tool-calls nodig had, gaf DeepInfra een `400 invalid_request_error`. Uit inspectie van de daadwerkelijke DSH-uitgaande JSON-payload bleek de ingebouwde plugin `@deepseek-ai/dsh-tool-todo` (`todo_write`) een JSON-schema mee te sturen met een `triggers`-veld. DeepInfra's OpenAI-compatibele endpoint valideert strikter dan bv. `deepseek.com` en staat `triggers` in schema's niet toe. Na het uitschakelen van `tool-todo` (`disabled: true` in het ACP-profiel) was de `400` verdwenen, mits ook alle oude `dsh`-achtergrondprocessen waren gestopt (Zed hergebruikt de oude instantie anders via *Resumed Sessions*).

2. **Jarvis-indexatie blokkade binnen `bwrap`:** De agent probeerde `mcp__jarvis__indexRepo` voor niet-geïndexeerde repositories. Binnen de `bwrap`-sandbox werd het indexeringsproces afgebroken (sandbox staat forken/full subprocess management niet toe), waarna stale `.lock`-bestanden in `~/.jarvis/` alle volgende indexpogingen blokkeerden met `another index is already running`.

3. **Geen structurele borging:** Bestaande checks in `cardine-status.sh` detecteerden wel of de repo geïndexeerd was, maar niet of er stale locks waren. De AGENTS.md bevatte geen verbod op het aanroepen van `mcp__jarvis__indexRepo`.

## Besluit

### A. `tool-todo` permanent uitschakelen

In het DSH ACP-profiel (`~/.dsh/profiles/acp/cordis.patch.yml`) staat onder `- id: tool-web` het blok `- id: tool-todo` met `disabled: true`. Deze wijziging is ook opgenomen in `packages/lab/install-lab.sh` zodat elke verse installatie het direct correct heeft. Na een profiel-wijziging moeten alle `dsh`-processen worden herstart (`pkill -f "bin/dsh"`).

### B. `make jarvis-check` in root en kit Makefile

Het target `jarvis-check`:
- Controleert of er `~/.jarvis/index-*.lock`-bestanden bestaan.
- Voor elk lock-bestand: leest het PID, checkt of het proces nog leeft (`kill -0`). Zo niet, waarschuwt het de gebruiker met het opruim-commando.
- Checkt of de huidige git-root al in `jarvis status <slug>` bekend is; zo niet, geeft het een tip om `make index` te draaien.
- Dit target wordt aangeroepen vanuit `env-status` en `context` (één keer per sessie bij de start).

### C. `make index` target

Een simpel target dat `jarvis index "$(CURDIR)" --no-semantic` in de terminal uitvoert — alleen bedoeld om buiten de sandbox te draaien.

### D. `mcp__jarvis__indexRepo` hard verbod in AGENTS.md

In zowel de root `AGENTS.md` als de kit-template `kit/kern/AGENTS.md` is onder `## Nooit` een regel toegevoegd:
> Geen `mcp__jarvis__indexRepo` aanroepen (breekt in sandbox, laat stale `.lock`-bestanden achter); bij ontbrekende index: gebruiker vragen `make index` te draaien.

### E. `cardine-status.sh` uitgebreid

Sectie 8 (Repo-indexering) is uitgebreid met een stale lock-check vóór de index-status check. Bij een stale lock opent het script een waarschuwing met het `rm -f` commando. In `--fix` mode ruimt het stale locks automatisch op.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| `tool-todo` laten staan, DeepInfra-tolerantie afwachten | DeepInfra lost dit niet op — hun schema-validatie is OpenAI-compatibel en correct; `tool-todo` stuurt een niet-standaard veld. Bovendien hebben we `todo_write` niet nodig in onze workflow. |
| Indexeren via de agent toestaan met een wrapper | De `bwrap`-sandbox verbiedt forken — elke index-poging binnen de sandbox zal breken of onvolledig zijn. Volledig indexeren buiten sandbox is de enige betrouwbare weg. |
| Lockfiles alleen in cardine-status.sh controleren zonder AGENTS.md-regel | De agent probeert dan nog steeds `indexRepo` (want het is een MCP-tool), wat tijd en tokens verspilt en verwarring schept. Het harde verbod in AGENTS.md voorkomt dat überhaupt. |
| Apart script voor jarvis-check in packages/lab/scripts/ | Past beter in `cardine-status.sh` (daar staat alle omgevings-logica al) en een `Makefile` target voor gebruiksgemak. |

## Gevolgen

- **Makkelijker:** Geen mysterieuze `400`-fouten meer bij langere sessies; `tool-todo` is uitgeschakeld maar de agent gebruikt `todo_write` toch niet.
- **Makkelijker:** Bij elke `make context` of `make env-status` wordt automatisch gecheckt of Jarvis-locks stale zijn en of de repo geïndexeerd is.
- **Makkelijker:** Nieuwe projecten die via `npx cardine-structure` worden aangemaakt, krijgen het `indexRepo`-verbod en de `jarvis-check` meteen mee.
- **Moeilijker of risico:** De agent kan niet meer zelfstandig een repo indexeren — de gebruiker moet `make index` in de terminal doen. Dit is acceptabel omdat het een eenmalige handeling per repo is.
- **Te doen:** `install-lab.sh` updaten met de `tool-todo` `disabled: true` (al gedaan in deze sessie).