# Versioning — status & versiebeheer voor Cardine en Agent_Engineering

> **Rol:** Beschrijft hoe je in één oogopslag ziet wat er geïnstalleerd is, welke versie, en of alles correct werkt.
>
> **Gebruik:** Dit is de centrale uitleg. Voor de concrete checklist, zie [Status_Jarvis_dsh.md](Status_Jarvis_dsh.md).

## Concept

Elk project (`cardine`, `agent-engineering`) heeft:

1. **Een `package.json`** met een `version`-veld (semver).
2. **Een status-script** dat checkt of alle onderdelen correct geïnstalleerd zijn.
3. **Een `make status` target** als snel toegangspunt.

Door de versie in `package.json` te bumpen weet je altijd hoe "up to date" jouw lokale checkout is.

## Overzicht

| Project | package.json | Status script | Make target |
|---------|-------------|---------------|-------------|
| `cardine/` | `cardine/package.json` versie `0.1.0` | `packages/lab/cardine-status.sh` | `make env-status` |
| `Agent_Engineering/` | `../Agent_Engineering/package.json` versie `0.1.0` | `scripts/agent-engineering-status.sh` | `make status` |

## Commando's

### Status van de hele omgeving (DSH + Jarvis + tooling)

```bash
# Vanuit cardine/
cd ~/Documents/Student_Zelfstandige/Cardine/cardine

# Basis status-rapport
make env-status

# Of direct via het script
bash packages/lab/cardine-status.sh

# Machineleesbaar (JSON)
bash packages/lab/cardine-status.sh --json

# Meer details
bash packages/lab/cardine-status.sh --verbose
```

### Status van de Agent_Engineering kit

```bash
cd ~/Documents/Student_Zelfstandige/Cardine/Agent_Engineering
make status
```

### Versie van een package zien

```bash
# Cardine
cd ~/Documents/Student_Zelfstandige/Cardine/cardine
node -e "console.log(require('./package.json').version)"

# Agent_Engineering
cd ~/Documents/Student_Zelfstandige/Cardine/Agent_Engineering
node -e "console.log(require('./package.json').version)"
```

Of via npm:

```bash
npm --prefix ~/Documents/Student_Zelfstandige/Cardine/cardine pkg get version
npm --prefix ~/Documents/Student_Zelfstandige/Cardine/Agent_Engineering pkg get version
```

## Wat de status-check rapporteert

Het `cardine-status.sh` script checkt:

1. **DSH** — staat DeepSeek Harness op PATH? Welke versie?
2. **Jarvis** — `jarvis-server` en `jarvis` CLI aanwezig?
3. **Zoekt + SCIP** — zijn de Zoekt search-index en SCIP binaries gebouwd?
4. **DSH profiel** — bestaat `~/.dsh/profiles/acp/cordis.patch.yml` met de juiste componenten?
5. **API-key** — staat `DEEPSEEK_API_KEY` ingevuld in `~/.dsh/.env`?
6. **Node.js** — ≥ v24.9?
7. **Cardine packages** — versie van cardine zelf en cardine-slice-check
8. **Repo-index** — is de repo al geïndexeerd door jarvis?
9. **DSH integratietest** — start DSH correct op met `--profile acp`?
10. **Agent_Engineering** — is de kit-map bereikbaar en welke versie?

## Versioning strategie

We gebruiken **semver** (major.minor.patch):

| Sprong | Betekenis | Voorbeeld |
|--------|-----------|-----------|
| **major** | Breaking change in setup/structuur | `0.1.0` → `1.0.0` |
| **minor** | Nieuw component of nieuwe feature | `0.1.0` → `0.2.0` |
| **patch** | Fix of kleine verbetering | `0.1.0` → `0.1.1` |

Een nieuwe versie release je door:

1. `package.json` updaten (version bump).
2. `make finish` draaien.
3. (Optioneel) taggen in git: `git tag v0.2.0 && git push --tags`.

## Zie ook

- [Status_Jarvis_dsh.md](Status_Jarvis_dsh.md) — handmatige checklist (uitgebreider)
- [install-lab.sh](../../../packages/lab/install-lab.sh) — alles in één keer installeren (idempotent)