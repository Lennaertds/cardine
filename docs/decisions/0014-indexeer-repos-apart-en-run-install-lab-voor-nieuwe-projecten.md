# 0014 — Indexeer repositories apart en run `install-lab.sh` op elke nieuwe machine

- **Status:** aanvaard
- **Datum:** 2026-11-22
- **Raakt:** `packages/lab/install-lab.sh`, `packages/lab/cardine-status.sh`, `docs/work/logs/`, Jarvis-index workflow

## Samenvatting

In de context van een nieuwe Arch Linux / Hyprland-machine waar `install-lab.sh` nog niet was gerund, geconfronteerd met (1) een `400: Invalid structured outputs: 'triggers'` API-fout door een gecachete sessiestatus en (2) een vastgelopen Jarvis-indexatie binnen `bwrap` met stale `.lock`-bestanden, kiezen we ervoor om (a) `install-lab.sh` altijd als eerste stap op een nieuwe machine te draaien, (b) elke git-repository apart te indexeren (niet de bovenliggende verzamelmap), (c) nieuwe indexaties vooraf handmatig in de terminal uit te voeren (buiten `bwrap`), en (d) een lockfile-healthcheck op te nemen in `cardine-status.sh`, om reproduceerbare projectstartervaringen te garanderen en fouten door verouderde sessies of sandbox-beperkingen te voorkomen. We aanvaarden dat dit een handmatige opstartstap blijft (niet volledig automatiseerbaar) en dat we twee terminal-commando's nodig hebben per nieuwe repo.

## Context

Tijdens het werken aan een schoolproject met een gedeelde repo (via de Cardine-stack) ontdekten we dat `install-lab.sh` op de nieuwe machine niet was uitgevoerd. Dit leidde tot twee fouten:

1. **400 API-fout:** Een bestaande Zed-thread stuurde een verouderde sessiestatus met een ongeldige tool-/schema-structuur naar het DeepInfra-endpoint. Omdat het DSH-profiel in Zed niet correct was geïnitialiseerd (door het ontbreken van `install-lab.sh`), herkende de thread de configuratiewijziging niet en bleef hij een incorrecte tool-structuur sturen. DeepInfra weigerde het verzoek met `400 invalid_request_error: Invalid structured outputs: 'triggers'`.

2. **Jarvis-index blokkade:** De agent probeerde via `mcp__jarvis__indexRepo` de repository te indexeren. Omdat de indexatie binnen de `bwrap`-sandbox liep, werd het proces afgebroken en bleven er stale PID-bestanden achter in `~/.jarvis/`. Latere indexpogingen faalden met `another index is already running`. Daarnaast mislukte de optionele `scip expt-convert`-stap.

3. **Verzamelmap-probleem:** De neiging bestond om één Jarvis-index te zetten op een bovenliggende map die zelf geen git-repo is maar wél twee geneste git-repositories bevat. Zoekt (via `zoekt-git-index`) is git-georiënteerd en behandelt zulke mappen niet correct — branch-tracking en incrementele updates werken dan niet.

## Besluit

**We handhaven en documenteren de volgende werkwijze voor het opzetten van een nieuwe machine of een nieuw project in de Cardine-stack:**

### A. `install-lab.sh` als verplichte eerste stap

Op elke nieuwe Arch Linux / Hyprland-machine (of bij een verse fork) moet `install-lab.sh` worden gerund vóórdat Zed + DSH wordt gestart:

```bash
cd <repo-root>/packages/lab
bash install-lab.sh
```

Dit script zet idempotent het DSH ACP-profiel, de sandbox (bwrap), jarvis-server en de correcte Node-versie klaar. Zonder deze stap ontbreken de profiel- en sandbox-instellingen die de agent nodig heeft om correct te functioneren.

### B. Indexeer elke git-repository apart, niet de verzamelmap

- **Correct:** `cd project-a && jarvis index "$(pwd)" --no-semantic --no-scip`
- **Correct:** `cd project-b && jarvis index "$(pwd)" --no-semantic --no-scip`
- **Fout:** `cd ~/Documents/Student_Zelfstandige && jarvis index "$(pwd)" --no-semantic --no-scip`

**Waarom:** Zoekt is git-georiënteerd en gebruikt `zoekt-git-index` per git-repository. Een verzamelmap zonder eigen `.git` (of met twee geneste `.git`-mappen) breekt branch-tracking, incrementele updates en `.gitignore`-resolutie. Jarvis doorzoekt standaard alle geregistreerde repo's tegelijk als geen `r:`-filter wordt meegegeven, dus er is geen functionele noodzaak om één index bovenin te zetten. Bovendien blijft SCIP en taal-detectie per repo zuiver (bv. Python-pipeline vs TypeScript-backend).

### C. Indexeer nieuwe projecten altijd vooraf in de terminal, niet vanuit de agent

Draai bij elk nieuw project eenmalig in de projectmap:

```bash
jarvis index "$(pwd)" --no-semantic --no-scip
```

**Waarom:** De agent draait zelf onder `bwrap` (sandbox). Het indexeringsproces wordt door de sandbox-beperkingen afgebroken of faalt op subtiele manieren (stale lockfiles, niet-afgesloten subprocessen). Door vooraf in de terminal te indexeren (zonder sandbox) bouw je de Zoekt-zoekindex direct en foutloos op.

### D. Lockfile-gezondheidscheck in `cardine-status.sh`

We nemen een check op in `packages/lab/cardine-status.sh` die:

- Controleert of er `~/.jarvis/index-*.lock`-bestanden bestaan
- Voor elk lock-bestand checkt of het bijbehorende PID nog actief is (`kill -0 <pid>`)
- Zo niet, ruimt hij het stale lock-bestand op met een melding

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Indexeren via de agent toestaan | Sandbox (bwrap) breekt subprocessen; leidt tot stale locks en onbetrouwbare indexen |
| Eén index op de verzamelmap zetten | Zoekt werkt per git-repo; branch-tracking, `.gitignore` en incrementele updates werken niet correct |
| Volledig automatiseren in `install-lab.sh` | De te indexeren paden zijn projectspecifiek; `install-lab.sh` kent de projectstructuur van de gebruiker niet |
| Lockfiles gewoon negeren en herbouwen | Lockfiles blokkeren élke indexpoging — herstel is niet mogelijk zonder opruiming |

## Gevolgen

- **Makkelijker:** Reproduceerbare setup; geen mysterieuze 400-fouten of vastgelopen indexaties meer.
- **Makkelijker:** Twee aparte repo-indexen geven zuiverder Zoekt-resultaten per project.
- **Moeilijker of risico:** Elke nieuwe machine en elk nieuw project vraagt twee handmatige terminal-stappen (`install-lab.sh` + `jarvis index ...`). Dit is niet volledig te automatiseren zonder de projectstructuur te kennen.
- **Te doen:** Lockfile-check toevoegen aan `cardine-status.sh` (optioneel, voor extra robuustheid).