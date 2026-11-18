# Spec — install-lab

> **Rol:** Plan voor één werkitem. Tijdelijk: na merge verwijderen; de code en de tests zijn dan de waarheid.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/install-lab`
- **Status:** in uitvoering

## Doel

Een nieuwe Arch Linux / Hyprland-machine (desktop of laptop) is met één commando (`make install-lab`) volledig klaar voor het lab-pad: Zed + DeepSeek Harness + jarvis-indexing, zodanig dat de gebruiker alleen nog zijn DeepInfra API-key in `~/.dsh/.env` hoeft te zetten.

## Scope

- **In:**
  - Idempotent script `scripts/install-lab.sh`: checkt/installeert DSH 0.2.2-rc.1, Node ≥ 24.9, zeditor, bwrap, jarvis-server.
  - Genereert `~/.dsh/profiles/acp/cordis.patch.yml` met DeepInfra-provider (`deepseek-ai/DeepSeek-V4-Flash`), geen tool-web, jarvis MCP, sandbox-policy workspace-write, approval ask, cardine-bwrap en cardine-slice-check.
  - Genereert `~/.config/zed/settings.json` met agent-server "DeepSeek Harness".
  - Maakt `~/.dsh/.env` aan met `DEEPSEEK_API_KEY=` (zonder waarde, chmod 600) — overschrijft nooit bestaande key.
  - Eindmelding met de instructie wat nog rest.
  - Makefile-target `make install-lab` dat het script aanroept.

- **Buiten scope:**
  - Geen API-key invullen of valideren.
  - Geen Zed-installatie via AUR/flatpak (alleen checken of `zeditor` op PATH staat).
  - Geen Node installeren via nvm/fnm (alleen checken of Node ≥ 24.9 op PATH staat).
  - Geen jarvis-server indexeren van deze repo (dat doet de gebruiker na installatie).

## Raakvlakken

- Modules en bestanden: `scripts/install-lab.sh`, `Makefile`, `docs/how-to/zed-dsh.md`, `docs/INDEX.md`
- Interface die verandert: `make install-lab` nieuw target
- Seams die raken: harness→LLM (provider deepinfra), harness→MCP (jarvis), harness→sandbox (bwrap + slice-check)
- Voorbeeld om te volgen: `scripts/check-links.sh` (conventie voor scripts/)

## Slices (elk apart testbaar, één sessie, door de hele stack)

1. Script + Makefile target + spec + backlog-regel. Doc-update van zed-dsh.md (xAI→DeepInfra). INDEX.md + README.md kort bijwerken.

## Acceptatie

- [ ] `scripts/install-lab.sh` bestaat, is uitvoerbaar en draait zonder fouten op een Arch-machine
- [ ] Het script is idempotent: een tweede run wijzigt niets essentieels
- [ ] `make install-lab` werkt
- [ ] Het profiel in `~/.dsh/profiles/acp/cordis.patch.yml` gebruikt DeepInfra i.p.v. xAI
- [ ] `~/.dsh/.env` wordt niet overschreven als het al bestaat
- [ ] `make check` groen