# Backlog

> **Rol:** **Index** van open werk: één korte regel per item + link naar de spec. Geen plan, slices of essay hier.
> **Niet hier:** het plan ([specs/](specs/)), afgewerkt werk (git en `logs/`), besluiten (`decisions/`).

Nieuw item op **Nu** (of Geparkeerd met een plan): alleen via `make spec s=<slug>` — die zet de indexregel én de spec. Handmatig een lange rij in deze tabel plakken is fout. **Straks** mag één korte regel zonder spec (tot je hem promoveert met `make spec`). Categorie is een kolom, geen map.

Afgewerkte items zijn uit deze index verwijderd; de documentatie leeft in [product/](../product/) en [decisions/](../decisions/).

## Volgorde (totaalproduct)

Werk **één stap tegelijk**. Samenhang en groepen: [totaalproduct.md](../product/totaalproduct.md). Eerstvolgende voltooiing is de persoonlijke stapel op Arch Linux Hyprland, niet de gids ([ADR 0012](../decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md), [ADR 0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)).

| Stap | Spec / doc | Waarom deze plek |
|------|------------|------------------|
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | Doorlopend: geen `apps`/generators tot ADR |

De afgewerkte stappen 0–8 (kader t/m session-spine) staan in [product/](../product/) en [totaalproduct.md](../product/totaalproduct.md#volgorde-van-beslissen-geen-code-tot-adr). Geen code/`--starter` tot een runtime-ADR. [0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft; [0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) is de harness-import, geen app-stack.

## Nu

| Volg | Item | Categorie | Status |
|------|------|-----------|--------|
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | bootstrap | open (guardrail) |
| 1 | [lab-en-structure-testronde](specs/lab-en-structure-testronde.md) | packages | Testen en fixen naar volgende versies — eerst bewijzen dat het werkt, dan pas uitbreiden |
| — | [lab-macos](specs/lab-macos.md) | packages | packages/lab/ werkend op macOS (Intel + Apple Silicon) |
| — | [lab-andere-linux](specs/lab-andere-linux.md) | packages | packages/lab/ uitbreiden naar Debian, Fedora, openSUSE |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| Zed zelf proberen, als de gepinde upstream | product | Vóór indexing. Klachten staan in [ide-shell](../product/ide-shell.md) |
| Nieuwe Zed-thread ziet `mcp__jarvis__searchCode` | harness | Mount staat. Een thread van vóór de insert niet |
| A5-matrix H×M (na genoeg harness/LLM-richting) | research | Voedt ADR stap 4/6 |
| Baseline indexing vs `rg` | product | Staat in [indexing.md](../product/indexing.md). |
| Runtime + `--starter` / generators | apps | Na ADR's; bootstrap bewaakt |
| API-key zelf in `~/.dsh/.env` zetten | harness | Hoe-to [lab-install](../how-to/zed-dsh.md); de waarde ontbreekt nog |
| [tokenlogger](specs/tokenlogger.md) | harness | Per-turn token-tracking voor kosteninzicht en H×M-metingen |
| Seam-tests | architecture | Pas na stack |
| OTel / `make obs-*` | observability | Geen app |
| Performance-budgets + `bench.sh` | performance | Geen meetpad zonder runtime |
| Strix-install + key | security | Geen netwerk-facing app nog |

## Geparkeerd

| Item | Categorie | Wacht op |
|------|-----------|----------|
| Thesis-deliverable als toetsbaar doel | product | Lab meetbaar + runtime |
| Pi-fork | apps | Expliciete runtime-keuze = Pi |
| Productisatie: portfolio + gratis release (OS of closed) | product | Lab-kwaliteit "echt goed" + expliciete keuze |
| Prod-hosting / multi-user auth | architecture | Productisatie-ADR |
| Repo-spine (`.agent/`) | product | Een koppeling die de pad-binding van de chat wél oplost |
