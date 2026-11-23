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

### De agent en bestanden: één schrijfroute, één leesgrens

De kooi is de enige schrijfrechter ([ADR 0017](../decisions/0017-de-agent-schrijft-in-de-kooi-en-de-fs-write-tools-staan-uit.md)). `write`, `edit` en `apply_patch` staan uit. Wat blijft (`read`, `read_image`, `glob`, `grep`) stopt op de workspace-guard.

| Route | In de workspace | Buiten de workspace | Bewijs |
|-------|-----------------|---------------------|--------|
| Shell lezen | moet | mag niet (`~/.ssh`, `~/.secrets`, `~/.dsh/.env`, `/etc/shadow`, een zusterrepo) | `make sandbox-check` |
| Shell schrijven | moet, en meteen op de host | mag niet; de host-byte blijft | `make sandbox-check` |
| `read` / `read_image` / `glob` / `grep` | moet | mag niet | guard-tests in `make sandbox-check` |
| `write` / `edit` / `apply_patch` | de tool staat uit | de tool staat uit | profiel in `install-lab.sh` |

De filesystem-tools die aan blijven draaien in het DSH-hostproces (`dsh-fs-local`: *"cwd is a resolution default, not a containment boundary"*). Een bwrap-mount dekt hen niet; de guard wel. De workspace van die guard is de cwd van de open sessie, niet de repo waar het lab ooit is geïnstalleerd. Die is deny-only en resolvet paden (`realpath` + parent-walk), zodat `..`, symlinks en nog niet bestaande paden niet omzeilen. Ze is defense-in-depth voor de lees-tools, en een vangnet als een ander profiel writes weer aanzet. Ze is niet de schrijfmuur.

**Kooi (`cardine-bwrap`).** De workspace is een `--bind`: een write staat meteen op de host, `git status` ook. `*.env`/`*.env.*` (behalve `*.example`), SSH-keys en certificaten zijn afgedekt met een read-only leeg bestand; de host-inode van die bestanden blijft. `/tmp` is een gedeelde host-map (mode 700), geen tmpfs, zodat `make` en `node` een tijdelijk bestand kunnen afgeven. De kooi heeft een eigen user-namespace. Het netwerk blijft open ([ADR 0017](../decisions/0017-de-agent-schrijft-in-de-kooi-en-de-fs-write-tools-staan-uit.md)): `npm`, `pip` en andere fetches vanuit de shell werken. Een mislukte mount eindigt rood, niet stil groen.

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
| Agent leest of schrijft `.env`/keys via de shell | `cardine-bwrap` dekt ze af; de host-inode blijft | `sandbox-check` in `make check` |
| Agent leest buiten de repo of een geheim via `read`/`glob`/`grep` | `cardine-secrets-guard` (`tools/pre-execute`, deny-only, realpath). `write`/`edit` staan uit | `sandbox-check` in `make check` |
| Shell-write verdwijnt (overlay) | workspace is een bind; de write staat op de host | `sandbox-check` eist de host-byte |
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
