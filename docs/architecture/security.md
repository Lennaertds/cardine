# Security

> **Rol:** Welke gevoelige gegevens er zijn, waar ze staan, en hoe ze beschermd worden.
> **Niet hier:** de "nooit"-regels voor de agent ([AGENTS.md](../../AGENTS.md)), het privacybeleid in mensentaal (`business/`).

## Persoonsgegevens

Labfase: geen accounts voor derden. Bij latere gratis release: hier uitbreiden (accounts alleen als nodig).

| Gegeven | Waar | Wie leest | Bewaartermijn |
|---------|------|-----------|---------------|
| (lab: nog geen) | — | — | — |
| Index / chatcontext van eigen code (later) | lokaal / runtime | harness | tot gebruiker wist |

Nooit data uit andere projecten. Keys zijn geen persoonsgegevens maar secrets (onder).

## Secrets

| Secret | Waar het leeft | Wie het nodig heeft |
|--------|----------------|---------------------|
| `DEEPSEEK_API_KEY` (of equivalent) | `~/.dsh/.env` (door DSH gelezen); nooit committen | harness → LLM |
| Andere LLM-provider keys | `~/.secrets/<repo>/.env`, 600 | harness (configureerbaar) |
| Strix/LLM-key voor scans | `~/.secrets/<repo>/.env` / omgeving | `make security-scan*` |

Nieuwe variabelen → `.env.example` van de app die ze leest (zodra die bestaat), **zonder** echte waarden. Echte waarden leven in `~/.secrets/<repo>/.env` (buiten elke repo), nooit in de repo zelf.

### De agent en `.env`: twee grenzen, één waarheid

Geen instructie maar een grens, op twee plekken:

| Route | Grens | Bewijs |
|-------|-------|--------|
| Shell (`bash`, `grep`, `glob`) | `cardine-bwrap`: alleen `/usr`, `/etc` en de workspace worden gemount; `~/.secrets` bestaat daar niet | `make sandbox-secrets` |
| Filesystem-tools (`read`, `write`, `edit`) | `cardine-secrets-guard` (`tools/pre-execute`): weigert op pad-resolutie `.env`/keys en alles onder `~/.secrets`, `~/.dsh`, `~/.ssh`, `~/.aws`, `~/.kube` | `make secrets-check` (unit-tests) |

Waarom twee: de filesystem-tools draaien **niet** in de kooi maar in het DSH-hostproces (`dsh-fs-local`: *"cwd is a resolution default, not a containment boundary"*). Een bwrap-mount kan hen dus niet afschermen; alleen een listener vóór de tool wel. De guard is deny-only en resolvet paden (`realpath` + parent-walk), zodat `..`, symlinks en nog niet bestaande paden niet omzeilen.

**Kooi-details (`cardine-bwrap`).** Binnen de workspace worden `*.env`/`*.env.*` (behalve `*.example`), SSH-keys en certificaten gemaskeerd met een lege `/dev/null`-bind in een overlay. `CARDINE_BWRAP_ALLOW_SECRETS=1` zet de maskeerd-stap uit (alleen debug).

### Grenzen die je moet kennen

- **Nieuwe sessie nodig.** DSH leest `cordis.patch.yml` bij start. Een wijziging aan de guard geldt pas in de **volgende** sessie; controleer met `make secrets-check`.
- **Rechten zijn lokaal, geen repo-contract.** In de kooi bestaat `~/.secrets` bewust niet. De rechten (700/600) worden daarom op de host gecontroleerd en leveren een **waarschuwing** op, geen rood: `make check` moet op elke checkout groen kunnen zijn. Zet ze goed met `bash packages/lab/scripts/secrets-init.sh` in je eigen terminal; wat je dan ziet wil je oplossen.
- **`chmod 000` helpt niet tegen de tools.** De tools draaien als jouw gebruiker en kunnen als bezitter alsnog lezen; alleen de guard of rechten op een **map** (700 op repo) werken.
- **Symlinks helpen niet.** `read` volgt ze niet, maar `bash` en `grep` wel; een symlink naar `~/.secrets` is dus geen grens (en wordt door `check-secrets.sh` gemarkeerd als symlink naar buiten).

## Authenticatie en autorisatie

Lab: geen multi-user auth; solo lokaal met eigen API-keys. Prod-auth alleen na productisatie-ADR (gratis app; geen verplichte cloud-billing).
## Dreigingen en maatregelen

| Dreiging | Maatregel | Bewaakt door |
|----------|-----------|--------------|
| Lekken van secrets of vreemde projectdata in prompts/index | RULES + geen import uit andere repos; redaction bij LLM-seam | RULES; later test op allowlist |
| Agent leest of schrijft `.env`/keys via de shell | `cardine-bwrap` maskeert ze in de workspace (overlay + lege `/dev/null`-bind) | `sandbox-secrets` in `make check` |
| Agent leest `~/.secrets`/`~/.dsh`/`~/.ssh` via `read`/`write` | `cardine-secrets-guard` (`tools/pre-execute`, deny-only, realpath) | `secrets-check` in `make check` |
| Per ongeluk `_bootstrap` of secrets committen | `.git/info/exclude` voor bootstrap; `.gitignore` voor `.env` | pre-commit / gitignore |

## Actieve security-validatie (Strix)

Autonome pentest-agents die findings met **werkende PoC** valideren (niet alleen SAST-warnings). Standaardtool: [Strix](https://strix.ai/) (CLI + optionele coding-agent skills).

| Wat | Afspraak |
|-----|----------|
| Wanneer | Voor release / na auth- of API-wijzigingen; niet bij elke micro-fix. Lab: relevant zodra er een netwerk-facing app of LLM-proxy is |
| Commando | `make security-scan-quick` of `make security-scan` (zie [how-to](../how-to/security-scan.md)) |
| Scope | Alleen eigen code, staging, of targets met expliciete toestemming |
| Vereisten | Docker + `strix` + LLM-API-key |
| Niet in | `make check` (te traag, niet-deterministisch, kost tokens) |
| Skills | Optioneel: `npx skills add usestrix/strix` |

Ontbreekt installatie of key: target faalt met uitleg → regel in [BACKLOG.md](../work/BACKLOG.md) (§ Straks). Bewuste weglatingen: [Bewust later](#bewust-later) (P28).

## Bewust later

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Strix/Docker/LLM-key in CI | Nog geen app/runtime | Scans moeten zonder handwerk in CI |
| Auth / multi-user | Lab eerst; product later gratis | Productisatie met accounts |
| Secrets-manager | `.env` volstaat lokaal | Prod deelt env niet veilig |
| Redaction/allowlist-tests op LLM-seam | Na eerste LLM-call (DeepSeek e.d.) | Keys of vreemde data lekken in logs |
| Licentie OS vs closed | Nog open; hoogstwaarschijnlijk gratis | Portfolio/release-besluit |
