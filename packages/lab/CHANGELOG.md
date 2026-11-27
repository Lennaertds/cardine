# Changelog — cardine-lab

## [0.5.4] — 2026-11-27

### Fixed
- **A venv no longer breaks in the cage.** Every fresh venv contains
  `…/site-packages/pip/_vendor/certifi/cacert.pem`, and the cage masked every
  `*.pem` as a secret. pip and `venv` unlink a file before writing it, so over
  a mask the write landed in the mask itself, the mount stayed, and
  `rm -rf .venv` ended with `Device or resource busy`. A venv rebuilt on top
  of that mount then failed in `ensurepip`. That is the loop where an agent
  concluded the venv was broken and rebuilt it over and over. `cardine-bwrap`
  now skips `.venv`, `venv`, `.tox`, `.nox`, `site-packages`, `node_modules`
  and `__pypackages__` when masking; real secrets in the repo are still
  masked (ADR 0017, amended). See
  [sandbox-troubleshoot § 1d](../../docs/how-to/sandbox-troubleshoot.md#1d-a-venv-breaks-delete-fails-device-or-resource-busy).
- `check-bwrap-secrets.sh` now proves it: a venv-shaped tree must be fully
  deletable inside the cage and the delete must land on the host. The check is
  red with the previous `cardine-bwrap`.

### Changed
- `cardine-bwrap` starts in the caller's directory (`--chdir "$PWD"`) when that
  directory is bound into the cage, so a command reading `$PWD` no longer
  falls back to `/` or `~`. A cwd that is not bound leaves the cage in `/`, as
  before, instead of failing.

## [0.5.3] — 2026-11-26

### Added
- `cardine-move.sh` (`make move` / `make move-fix`, `cardine-lab move`): after a
  folder move or rename it re-points every absolute path in the DSH profile,
  rebuilds the `jarvis-server` wrapper when it is missing, and re-indexes the new
  root. It never restarts DSH; it prints the `dsh kill` reminder instead.
- `install-lab.sh --profile NAME --name LABEL`: a second project gets its own
  profile (`~/.dsh/profiles/<name>/`), its own Zed server
  (`DeepSeek Harness (<name>)`) and its own `package.json` with the lab packages
  linked. The plugin paths always point at THIS lab, so the slice check runs the
  profile's `make check` in the project's own root.
- `cardine-move.sh --profile NAME`, and without it the script reports every
  profile: the one that owns the root, the intact ones of other projects, and any
  whose root no longer exists. It also repairs a dead or missing
  `cardine-slice-check` link in the profile's `node_modules`.
- `lib/profile-paths.sh`: the single place that knows where a profile keeps
  absolute paths, shared by the installer and the move script.

### Changed
- npm is the only documented install route (`npm i -g @lennaertds/cardine-lab`).
- The `package.json` description is in English now (ADR 0018).

### Fixed
- `lib/` is in the published `files`: `cardine-lab move` sourced
  `lib/profile-paths.sh`, which the package did not ship, so the command died
  with "No such file or directory" for anyone who installed from npm.
- `install-lab.sh` printed "jarvis-server-wrapper.sh already exists" for a file
  that did not exist, when `uv tool list` could not find the tool. The block now
  installs `jarvis-mcp` (and the `jarvis` CLI) when either is missing, and fails
  red instead of green when the real binary cannot be found.
- `cardine-status.sh --fix` died on `rm -f` of a stale lock under a read-only
  `~/.jarvis` (a DSH sandbox), so the profile repair never ran. The lock cleanup
  is now best-effort.
- `cardine-status.sh` treated a moved profile as correct: an unanchored
  `jarvis-server` match also hit the `mcp-jarvis` `cwd:` line. The check now
  names the `cardine-bwrap` runner line. `DSH_PROFILE` follows `DSH_HOME` the way
  DSH does.

## [0.5.2] — 2026-11-24

### Changed
- The whole package is in English now (ADR 0018): README, package docs, CLI
  help and comments. `cardine-lab --help` and every error message are English;
  `new-project.sh` output too.
- `check-language.sh` added to `scripts/`: fails when Dutch text appears outside
  `bron/` and the historical logs.

### Fixed
- `docs/cardine-lab.md` in the published package still described the GitHub
  release route. It now documents the npm route only.

## [0.5.1] — 2026-11-24

### Fixed
- `cardine-status.sh` leidde `LAB_DIR` af uit `${PROJECT_DIR}/packages/lab`. In een
  npm-installatie is dat `@lennaertds/packages/lab`, wat niet bestaat, waardoor
  `cardine-bwrap` en `cardine-slice-check` als ontbrekend werden gemeld. `LAB_DIR`
  is nu de map van het script zelf; `PROJECT_DIR` (git-root van `$PWD`) staat
  apart voor de workspace-, mount- en indexchecks.
- De `secrets-grens`-check eiste `overlay-src` in `cardine-bwrap`, terwijl de
  wrapper sinds ADR 0017 `--bind` gebruikt. De check verifieert nu
  `--bind "$src"` plus de maskeer-stap `--ro-bind "$mask_file"`.
- De DSH-profielpadcheck meldde een afwijking bij een andere, wél bestaande
  installatie (repo naast npm). Alleen een pad dat niet bestaat is nu rood.
- Fix-hints noemen `cardine-lab status --fix` en `cardine-lab install` in plaats
  van het relatieve `packages/lab/...`, dat vanaf een andere cwd niet bestaat.

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
- **De kooi is de schrijfrechter** ([ADR 0017](../../docs/decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md)). `cardine-bwrap` bindt de workspace; shell-writes staan meteen op de host. De tmp-overlay is weg.
- `/tmp` is een gedeelde host-map (mode 700), geen tmpfs, zodat `make` en `node` een tijdelijk bestand kunnen afgeven.
- De shell-kooi draait in een user-namespace. Het netwerk blijft open; `make sandbox-check` eist een geslaagde TCP-connect vanuit de shell en wordt rood als de kooi het netwerk afsnijdt.
- Het lab-profiel uit `install-lab.sh`: `workspace-write` op de repo, `approval: never`, `write`/`edit`/`apply_patch` uit, `glob`/`grep` aan. `cardine-strict.patch.yml` is geen tweede profiel meer.
- `make check` loopt via `make sandbox-check` (route × richting, met tegenproef). Een gewone write moet op de host staan; een geheime host-inode blijft gelijk.
- `make finish` schrijft het bericht via de omgeving, zet `geschreven via de kooi` in de dag-log, en wordt rood als de regel niet terug te lezen is.

[0.4.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.4.0
[0.3.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.3.0
[0.2.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.2.0
[0.1.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.1.0