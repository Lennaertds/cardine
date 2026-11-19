# How-to — Sandbox / bwrap troubleshoot

> **Rol:** Wat te doen als de sandbox (bwrap) niet werkt, of als DSH klaagt over `ENOENT` / ontbrekende runner.
>
> **Niet hier:** de installatie van DSH of jarvis ([zed-dsh.md](zed-dsh.md)), de approval-policy ([security.md](../architecture/security.md)).

## Symptomen

| Foutmelding | Oorzaak |
|-------------|---------|
| `spawn …/cardine-bwrap ENOENT` | Het pad naar `cardine-bwrap` in het DSH-profiel klopt niet. |
| `Error: sandbox mode "…" is requested but no sandbox backend is usable` | bwrap ontbreekt, of de runner kan niet starten. |
| `make: *** No rule to make target 'check'` | De slice-check draait `make check` in een directory zonder Makefile. |

## 1. cardine-bwrap niet gevonden (ENOENT)

Dit is de meest voorkomende oorzaak. Het DSH-profiel (`~/.dsh/profiles/acp/cordis.patch.yml`) verwijst naar een **absoluut pad** voor de bwrap-runner. Als dat pad niet klopt, kan DSH de sandbox niet starten.

### Check

```bash
grep 'cardine-bwrap' ~/.dsh/profiles/acp/cordis.patch.yml
```

**Verwacht:** een regel zoals:

```yaml
- /home/ventje/Documents/Student_Zelfstandige/Cardine/cardine/scripts/cardine-bwrap
```

**Als het pad niet klopt** (bijv. `…/Student_Zelfstandige/cardine/…` zonder `Cardine/`):

```bash
# Fix: vervang het foute pad door het juiste
sed -i 's|/home/ventje/Documents/Student_Zelfstandige/cardine/scripts/cardine-bwrap|/home/ventje/Documents/Student_Zelfstandige/Cardine/cardine/scripts/cardine-bwrap|g' \
  ~/.dsh/profiles/acp/cordis.patch.yml
```

### Waarom gebeurt dit?

`install-lab.sh` bepaalt `REPO_ROOT` via:

```bash
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && git rev-parse --show-toplevel 2>/dev/null || pwd)"
```

Dit werkt alleen als:
1. Het script wordt aangeroepen vanuit de `cardine/` git-repo (niet een subdirectory of parent).
2. Git beschikbaar is en de repo kent.

Als je het script draait vanuit een context waar git de root niet kan vinden (bv. een symlink, een verkeerde CWD, of een partial clone), valt het terug op `pwd` — en dat kan een verkeerd pad geven.

**Verhelping:** draai `install-lab.sh` altijd vanuit de `cardine/` directory:

```bash
cd ~/Documents/Student_Zelfstandige/Cardine/cardine
bash scripts/install-lab.sh
```

Of gebruik de Makefile:

```bash
make install-lab
```

## 2. bwrap helemaal niet geïnstalleerd

```bash
which bwrap
```

Als bwrap ontbreekt op Arch Linux:

```bash
sudo pacman -S bubblewrap
```

Of via `install-lab.sh` (die installeert het automatisch als sudo beschikbaar is):

```bash
make install-lab
```

## 3. DSH werkt zonder sandbox (danger-full-access)

Sinds de laatste configuratiewijziging staat het profiel op `danger-full-access` en `approval: auto`. Dit betekent:

- **Geen bwrap-sandbox** voor shell-commando's van de agent.
- **Geen toestemming vragen** — de agent handelt zelfstandig.
- **Wel `make check`** aan het einde van elke turn (via slice-check).

Dit is de bedoeling voor het lab: maximale vrijheid voor de agent, minimale frictie. Bij een eventuele product-release kan het beleid worden aangescherpt.

De instellingen staan in `~/.dsh/profiles/acp/cordis.patch.yml`:

```yaml
- id: sandbox-policy
  config:
    mode: danger-full-access

- id: approval
  config:
    policy: auto
```

Het sjabloon wordt gegenereerd door `scripts/install-lab.sh`.

## 4. Slice-check draait in verkeerde directory

De `cardine-slice-check` (in `scripts/cardine-slice-check/index.js`) checkt of `make check` groen is na elke turn. Als de agent in een directory werkt zonder Makefile (bv. `~` of `/tmp`), kreeg je:

```
make: *** No rule to make target 'check'.  Stop.
```

De slice-check zoekt nu zelf naar een Makefile:
1. Eerst in de agent's CWD.
2. Dan in parent-directories tot `/`.
3. Valt terug op de cardine-root (bepaald vanuit het script-pad).

Dit is gefixt in de huidige versie.

## 5. ~/.dsh/ niet persistent in de sandbox

### Symptoom

`install-lab.sh` draait zonder fouten, maar na een herstart is `~/.dsh/` leeg of verdwenen. Het DSH-profiel wordt niet geladen.

### Oorzaak

`cardine-bwrap` (de bwrap-runner die DSH gebruikt voor shell-commando's) mountte `~/.dsh/` niet. Elke bash-commando kreeg een verse tmpfs voor `~/.dsh/` — writes waren weg na de call.

### Fix

`cardine-bwrap` mount nu `~/.dsh/` als `--bind` (schrijfbaar) in plaats van het weg te laten. Hierdoor blijft het DSH-profiel behouden tussen calls.

```bash
# In scripts/cardine-bwrap:
args=(
  ...
  --bind "${HOME_DIR}/.dsh" "${HOME_DIR}/.dsh"
  ...
)
```

Daarnaast zorgt `cardine-bwrap` ervoor dat `~/.dsh/` bestaat vóór bwrap start (anders faalt `--bind`):

```bash
mkdir -p "${HOME_DIR}/.dsh" "${HOME_DIR}/.dsh/profiles" "${HOME_DIR}/.dsh/profiles/acp"
```

### Verifiëren

```bash
# Check of ~/.dsh persistent is binnen de sandbox
bash scripts/cardine-status.sh
```

Het status-script rapporteert onder "Sandbox / bwrap" of `~/.dsh/` persistent is.

## 6. Nieuwe DSH-sessie nodig na profielwijziging

Het DSH-profiel wordt **éénmalig geladen bij het starten van een agent-sessie** (in Zed). Wijzigingen in `cordis.patch.yml` worden pas actief na een **nieuwe thread** in het Agent-paneel.

### Check of het profiel is geladen

```bash
# Dump de huidige DSH-config
dsh --profile acp --dump-config 2>&1 | grep -A5 'sandbox-policy\|approval\|bwrap'
```

Als de output niet overeenkomt met wat in `cordis.patch.yml` staat: start een nieuwe DeepSeek Harness thread in Zed.

## Zie ook

- [zed-dsh.md](zed-dsh.md) — volledige installatiehandleiding
- [security.md](../architecture/security.md) — approval-policy en secrets
- [Status_Jarvis_dsh.md](../work/specs/Status_Jarvis_dsh.md) — status-check voor de hele omgeving