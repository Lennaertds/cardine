# Changelog — cardine-lab

## [0.5.0] — 2026-11-24

### Added
- `bin/cardine-lab` — CLI van het package: `cardine-lab install [--force]` en
  `cardine-lab status [--json|--verbose|--fix]`. Lost paden op met `readlink -f`,
  zodat het werkt vanaf elke cwd.
- `files`-allowlist in `package.json`, zodat alleen de scripts, plugins en docs
  van het package worden gepubliceerd.

### Fixed
- `PACMAN_FAILED` werd nooit gezet: `pacman_install` markeerde een mislukking
  niet, dus de waarschuwing over ontbrekende systeempakketten kwam er nooit uit.
  Een mislukte `pacman -S` zet de vlag nu ook.
- `cardine-status.sh` resolvet eerst symlinks voordat het `../..` neemt.

## [0.1.0] — 2026-11-20

### Added
- Initiële publieke release: install-lab.sh, cardine-bwrap, cardine-slice-check
- Package.json met naam, versie, beschrijving
- CHANGELOG.md met 0.1.0 entry
- Harde paden uit install-lab.sh verwijderd ($HOME-relatief gemaakt i.p.v. absoluut)
- REPO_ROOT bepaling robuuster gemaakt
- README.md geüpdatet

## [0.2.0] — 2026-11-20

### Changed
- Scoped name: `cardine-lab` → `@lennaertds/cardine-lab`
- `publishConfig` toegevoegd voor GitHub Packages
- GitHub URLs: `ventje` → `Lennaertds`
- README installatie-instructies bijgewerkt met scoped name

## [0.3.0] — 2026-11-22

### Added
- **Secrets-grens in de kooi** — `cardine-bwrap` maskeert `.env`/`.env.*` (behalve `*.example`), SSH-keys en certificaten binnen de workspace en legt de workspace op een tmp-overlay, zodat writes de host niet raken. Bewijs: `make sandbox-secrets`. Uitzetten: `CARDINE_BWRAP_ALLOW_SECRETS=1`.
- `cardine-secrets-guard` — DSH `tools/pre-execute`-plugin die de filesystem-tools (`read`/`write`/`edit`) op secrets-paden weigert; deny-only, pad-resolutie via `realpath`. Wordt door `install-lab.sh` geregistreerd in `cordis.patch.yml`.
- `scripts/secrets-init.sh` en `scripts/secrets-apply.sh` — secrets-centrale `~/.secrets/<repo>/` opzetten en een repo voorbereiden (check-script, `make check`-koppeling, `.gitignore`, `AGENTS.md`).
- `scripts/check-secrets.sh`, `check-secrets-repo.sh` en `check-bwrap-secrets.sh` — controles op rechten, geen `.env` in git of op schijf, geen symlinks naar buiten, guard actief; gekoppeld aan `make check`.

### Changed
- **Standaardmodel** `deepseek-ai/DeepSeek-V4-Flash` → `deepseek-ai/DeepSeek-V4.1-Flash-1017`; `DeepSeek-V4-Flash-0731` en `DeepSeek-V3.2` als fallback in de modelkeuze (omzeilt de `400 Invalid structured outputs: 'triggers'`-fout van DeepInfra).
- DSH-plugins `tool-web`, `tool-todo` en `tool-goal` standaard `disabled: true` (sturen een tool-schema met `triggers` mee dat DeepInfra weigert).
- `cardine-status.sh` — nieuwe stap "stale Jarvis locks" met de oplossing erbij; index-status apart gerapporteerd.

## [0.4.0] — 2026-11-23

### Changed
- **De kooi is de schrijfrechter** ([ADR 0017](../../docs/decisions/0017-de-agent-schrijft-in-de-kooi-en-de-fs-write-tools-staan-uit.md)). `cardine-bwrap` bindt de workspace; shell-writes staan meteen op de host. De tmp-overlay is weg.
- `/tmp` is een gedeelde host-map (mode 700), geen tmpfs, zodat `make` en `node` een tijdelijk bestand kunnen afgeven.
- De shell-kooi draait in een user-namespace. Het netwerk blijft open; `make sandbox-check` eist een geslaagde TCP-connect vanuit de shell en wordt rood als de kooi het netwerk afsnijdt.
- Het lab-profiel uit `install-lab.sh`: `workspace-write` op de repo, `approval: never`, `write`/`edit`/`apply_patch` uit, `glob`/`grep` aan. `cardine-strict.patch.yml` is geen tweede profiel meer.
- `make check` loopt via `make sandbox-check` (route × richting, met tegenproef). Een gewone write moet op de host staan; een geheime host-inode blijft gelijk.
- `make finish` schrijft het bericht via de omgeving, zet `geschreven via de kooi` in de dag-log, en wordt rood als de regel niet terug te lezen is.

[0.4.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.4.0
[0.3.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.3.0
[0.2.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.2.0
[0.1.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.1.0