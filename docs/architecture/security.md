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
| `DEEPSEEK_API_KEY` (of equivalent) | `.env` lokaal; nooit committen | harness → LLM |
| Andere LLM-provider keys | `.env` lokaal | harness (configureerbaar) |
| Strix/LLM-key voor scans | `.env` / omgeving | `make security-scan*` |

Nieuwe variabelen → `.env.example` van de app die ze leest (zodra die bestaat), **zonder** echte waarden.

## Authenticatie en autorisatie

Lab: geen multi-user auth; solo lokaal met eigen API-keys. Prod-auth alleen na productisatie-ADR (gratis app; geen verplichte cloud-billing).
## Dreigingen en maatregelen

| Dreiging | Maatregel | Bewaakt door |
|----------|-----------|--------------|
| Lekken van secrets of vreemde projectdata in prompts/index | RULES + geen import uit andere repos; redaction bij LLM-seam | RULES; later test op allowlist |
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
