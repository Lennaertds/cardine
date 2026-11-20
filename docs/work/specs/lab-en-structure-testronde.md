# Spec — lab-en-structure-testronde

> **Rol:** Systematisch testen en verbeteren van `packages/lab/` en `packages/structure/` naar volgende versies. Geen nieuwe features — alleen wat er al is controleren, fouten vinden en fixen.

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Doel

Beide packages zijn in een "afgewerkt 0.x" staat, maar **niet getest** op een schone machine. Deze spec gaat over:
1. Zélf draaien wat een gebruiker zou doen
2. Fouten loggen en fixen
3. Ophogen naar `lab-v0.2.0` en `structure-v0.3.0`

## Scope

- **In:** `packages/lab/` en `packages/structure/` — testen, debuggen, fixen, versie ophogen
- **Buiten scope:** Nieuwe features (andere Linux-distributies, macOS — zijn aparte specs), OS-uitbreidingen

## Status per package

### `packages/lab/` — versie `0.1.0`

| Onderdeel | Status | Wat testen |
|-----------|--------|------------|
| `install-lab.sh` | ✅ basis | Draait idempotent? Herkent REPO_ROOT? Geeft nette output op niet-Arch? |
| `cardine-bwrap` | ✅ basis | Werkt de bwrap-kooi? Mist er iets in de mounts? |
| `cardine-status.sh` | ✅ basis | Alle checks slagen (behalve API-key)? `--fix` herstelt paden? |
| `cardine-slice-check/` | ✅ basis | Draait `make check` zonder fouten? |
| `scripts/` | ✅ basis | Welke scripts werken nog los van de repo-structuur? |
| `package.json` | ✅ basis | Klopt de config voor npm/publish? `private: true` nog nodig? |
| `docs/cardine-lab.md` | ✅ basis | Kloppen de paden en beschrijvingen? |
| `systemd/` | ✅ basis | Werken de timers? |

### `packages/structure/` — versie `0.2.0`

| Onderdeel | Status | Wat testen |
|-----------|--------|------------|
| `pull_kit.sh` | ✅ basis | Werkt idempotent? Wat gebeurt er zonder Agent_Engineering sibling? |
| `new-project.sh` | ✅ basis | Maakt een nieuw project aan zonder fouten? |
| `kit/` | ✅ gepulled @46fb1ab | Zijn alle bestanden aanwezig die in `kit/COMMIT` staan? |
| `package.json` | ✅ basis | `files` veld dekt alles? Werkt `npm pack`? |
| `docs/cardine-structure.md` | ✅ basis | Kloppen de paden en beschrijvingen? |
| `CHANGELOG.md` | ✅ 0.2.0 | Volledig? |

## Testplan

### Slice 1 — lab: zelf install-lab.sh draaien

Voer uit op de huidige Arch-machine (niet in een sandbox/container):

```bash
bash packages/lab/install-lab.sh
```

Wat controleren:
- [ ] Geen foutmeldingen over ontbrekende paden (geen harde `$HOME`-paden of `Agent_Engineering`-paden in fouten)
- [ ] DSH wordt correct geïnstalleerd of overgeslagen (als al aanwezig)
- [ ] Jarvis wordt correct geïnstalleerd of overgeslagen
- [ ] DSH-profiel wordt gegenereerd met correcte paden
- [ ] `cardine-bwrap` pad in profiel klopt met `packages/lab/cardine-bwrap`
- [ ] `cardine-slice-check` pad in profiel klopt met `packages/lab/cardine-slice-check/index.js`
- [ ] `wrapper.sh` wordt correct aangemaakt met dynamische jarvis-server binary
- [ ] Op niet-Arch (bv. in Docker): slaat pacman-stap over, geeft duidelijke melding

**Log:** alle fouten, waarschuwingen en afwijkende paden noteren. Na fixen: opnieuw draaien.

### Slice 2 — lab: cardine-status.sh controleren

Na `install-lab.sh` (of los):

```bash
bash packages/lab/cardine-status.sh
bash packages/lab/cardine-status.sh --verbose
bash packages/lab/cardine-status.sh --json
bash packages/lab/cardine-status.sh --fix   # als er paden mis zijn
```

Wat controleren:
- [ ] Alle checks geven `ok` of `warn` (geen `fail` behalve API-key)
- [ ] `--json` geeft geldige JSON
- [ ] `--fix` herstelt verkeerde paden (test door een pad in `cordis.patch.yml` te breken en `--fix` te draaien)
- [ ] Sandbox-detectie werkt (binnen DSH-sessie)
- [ ] `make env-status` werkt en geeft dezelfde output

**Log:** welke checks falen, welke waarschuwingen zijn onterecht.

### Slice 3 — lab: cardine-bwrap testen

```bash
# Test of bwrap zelf werkt
bwrap --version

# Test of cardine-bwrap een shell kan starten
bash packages/lab/cardine-bwrap -- echo "hallo vanuit bwrap"

# Test of ~/.dsh bereikbaar is
bash packages/lab/cardine-bwrap -- ls -la ~/.dsh/

# Test of ~/.ssh verborgen is (ADR 0007)
bash packages/lab/cardine-bwrap -- ls ~/.ssh/ 2>&1 || echo "~/.ssh niet bereikbaar (correct)"
```

Wat controleren:
- [ ] `bwrap` werkt (vereist: `sudo pacman -S bubblewrap` / kernel-namespaces)
- [ ] `cardine-bwrap` start een shell
- [ ] `~/.dsh` is schrijfbaar (DSH-profiel persistent)
- [ ] `~/.ssh` is **niet** zichtbaar
- [ ] `~/.local` en `~/.jarvis` zijn leesbaar (tools werken)
- [ ] Foutmelding bij `--` zonder commando
- [ ] Foutmelding bij onbekende flags

**Log:** welke mounts missen, welke permissions kloppen niet.

### Slice 4 — lab: cardine-slice-check testen

```bash
# Test of de node-module werkt
node packages/lab/cardine-slice-check/index.js

# Test in context van DSH: echo '{"jsonrpc":"2.0","id":1,"method":"initialize"}' | dsh --profile acp
```

Wat controleren:
- [ ] De module draait zonder Node-fouten
- [ ] `make check` in de root werkt
- [ ] De slice-check wordt aangeroepen bij een DSH-turn (als DSH draait)

**Log:** Node-versie issues, module-resolutie problemen.

### Slice 5 — structure: pull_kit.sh testen

```bash
# Test zonder Agent_Engineering
bash packages/structure/pull_kit.sh

# Test met Agent_Engineering (als die als sibling staat)
bash packages/structure/pull_kit.sh
```

Wat controleren:
- [ ] Zonder Agent_Engineering: duidelijke foutmelding, geen half werk
- [ ] Met Agent_Engineering: pulled de kit van de pinned commit
- [ ] Idempotent: tweede run verandert niets
- [ ] `kit/COMMIT` bestaat en klopt met de gepullde inhoud
- [ ] Alle verwachte bestanden in `kit/` zijn aanwezig

**Log:** wat mist er in de kit? Welke bestanden worden niet gepulled?

### Slice 6 — structure: new-project.sh testen

```bash
# Test in een tijdelijke directory
cd /tmp
bash /pad/naar/packages/structure/kit/new-project.sh
```

Wat controleren:
- [ ] Script start zonder fouten
- [ ] `npx cardine-structure` werkt (via npm bin-link)
- [ ] Gemaakte project heeft de juiste structuur (kern + gekozen modules/stacks)
- [ ] `make check` in het nieuwe project is groen
- [ ] `readlink -f` resolutie werkt (0.2.0 fix)

**Log:** welke fouten treden op bij `npx`? Werkt de fallback?

### Slice 7 — structure: npm pack testen

```bash
# Simuleer wat npm publish doet
cd packages/structure
npm pack --dry-run
```

Wat controleren:
- [ ] `files` in `package.json` dekt alle benodigde bestanden
- [ ] Geen overbodige bestanden in de pack (node_modules, .git, etc.)
- [ ] Als `npm pack` werkt: maak een tarball en installeer lokaal

**Log:** ontbrekende bestanden, te veel bestanden.

### Slice 8 — Ophogen naar volgende versie

Na alle fixes:

**lab:**
- [ ] CHANGELOG.md: `0.2.0` entry met alle fixes
- [ ] `package.json`: versie `0.2.0`
- [ ] Git-tag voorbereiden: `lab-v0.2.0`

**structure:**
- [ ] CHANGELOG.md: `0.3.0` entry met alle fixes
- [ ] `package.json`: versie `0.3.0`
- [ ] Git-tag voorbereiden: `structure-v0.3.0`

## Acceptatie

- [ ] `bash packages/lab/install-lab.sh` draait zonder fouten op Arch
- [ ] `bash packages/lab/cardine-status.sh` — alle checks (behalve API-key) zijn groen
- [ ] `cardine-bwrap` verbergt `~/.ssh`, toont `~/.dsh` en tools
- [ ] `bash packages/structure/pull_kit.sh` werkt idempotent
- [ ] `npx cardine-structure` maakt een nieuw project
- [ ] `npm pack --dry-run` in beide packages toont de juiste bestanden
- [ ] `make check` groen
- [ ] Beide packages hebben opgehoogde versie + CHANGELOG entry