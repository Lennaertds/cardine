# 0017 — De agent schrijft in de kooi en de fs-write-tools staan uit

- **Status:** aanvaard
- **Datum:** 2026-11-23
- **Raakt:** [security.md](../architecture/security.md), [tools.md](../product/tools.md), [0007](0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md), [0016](0016-secrets-leven-buiten-de-repos-en-de-filesystem-tools-zijn-gesloten.md), `packages/lab/cardine-bwrap`, `packages/lab/install-lab.sh`, `packages/lab/scripts/check-sandbox.sh`.

## Samenvatting

In de context van een lab-agent die zonder goedkeuringsvraag in één project moet kunnen werken, geconfronteerd met een shell-kooi waarvan de writes in een overlay verdwenen en met filesystem-tools die buiten die kooi de host raakten, kozen we voor bind-mounts plus het uitzetten van `write`/`edit`/`apply_patch` en tegen een opruimende overlay of een guard als enige muur, om te bereiken dat een write meteen op de host staat en buiten de repo niet kan, en we aanvaarden dat de lab-omgeving `approval: never` gebruikt tot upstream `auto` zonder fork kan.

## Context

Gemeten op 2026-11-22 ([dag-log](../work/logs/2026-11-22.md), [FIX-OMGEVING](../work/specs/FIX-OMGEVING.md)):

- De shell draait in `bwrap` (PID 1). `~/.dsh/.env`, `~/.ssh` en `~/.secrets` zijn daar niet zichtbaar.
- De workspace lag op een tmp-overlay. Een append in de kooi was voor een latere lees in dezelfde beurt soms weg, terwijl de shell hem wel zag. `git status` op de host toonde het werk niet. Dat is de oorzaak van verdwenen werk.
- `read`/`write`/`edit` draaien in het DSH-hostproces. Die route vroeg bij elke edit (`approval: ask`) en was de enige die de host betrouwbaar raakte.
- `dsh-tool-fs` registreert `write` en `edit` tenzij het profiel ze op `false` zet. `applyPatch` staat standaard uit. Meten in de geïnstalleerde pakket-README (`@deepseek-ai/dsh-tool-fs`): `write: false` en `edit: false` laten de tool weg. Een extra unregister-plugin is niet nodig.

Drie schrijfmodellen lagen open:

| Model | Wat de host ziet | Kosten |
|-------|------------------|--------|
| bind | elke write, meteen | een buggy write staat ook meteen op schijf |
| overlay | niets, tot een sync | verdwijn-venster; sync kan halverwege crashen |
| snapshot-sync | een kopie na afloop | elke call kopieert, inclusief `node_modules` |

## Besluit

- **Bind, geen overlay.** `cardine-bwrap` mount de workspace met `--bind`. Er is geen `--overlay-src` en geen sync-back. `git status` op de host is de waarheid.
- **Secrets blijven gemaskeerd.** `.env`/`.env.*` (behalve `*.example`), SSH-keys en certificaten in de workspace krijgen een read-only leeg bestand eroverheen. Dat is een mount in de kooi; de host-inode blijft. Een `.env` hoort niet in de repo ([0016](0016-secrets-leven-buiten-de-repos-en-de-filesystem-tools-zijn-gesloten.md)).
- **`/tmp` is een gedeelde host-map** (mode 700, per aanroep, opgeruimd bij afloop en stale na een uur). Geen tmpfs: `make` en `node` moeten een tijdelijk bestand aan de host kunnen geven.
- **Eigen user-namespace.** `--unshare-user`. De kooi draait niet als de host-uid in de kernel-map; een write op de bind blijft wel van die uid op de host (gemeten).
- **Het netwerk van de shell blijft open.** Geen afsluiting van het netwerk in de kooi. `npm`, `pip` en andere fetches vanuit de shell moeten werken, net als alles wat de agent via een proces op internet doet. Dit is een vaste lab-keuze (2026-11-23): een eerdere afsluiting is teruggedraaid. `make sandbox-check` eist een geslaagde TCP-connect vanuit de kooi en wordt rood als de kooi het netwerk toch afsnijdt.
- **Fs-write-tools uit.** In het lab-profiel: `read` en `readImage` aan, `write`, `edit` en `applyPatch` uit. `glob`/`grep` blijven aan en lopen door de workspace-guard.
- **De open sessie is de workspace van de guard.** `read`, `glob` en `grep` volgen de cwd van de thread. Een pad dat bij het installeren in de Zed-server is gezet, overschrijft die cwd niet: dezelfde server opent ook andere projecten (gemeten op Caddie, 2026-11-23). `CARDINE_WORKSPACE` blijft alleen de terugval als de sessie geen cwd heeft. Het profielveld `workspaceRoot` is de terugval van DSH voor een aanroep zonder sessie.
- **Geen dialoog.** `approval: never` is het vangnet van deze lab-omgeving. De PR-route naar upstream krijgt later `auto`, omdat Zed "nooit vragen" daar zonder fork eist. `never` is tot dan de lab-keuze, geen algemene productregel.
- **Herkomst.** De agent commit en pusht niet. Wat de kooi schreef staat ongecommit in `git status`. `make finish` zet `geschreven via de kooi` in de dag-log en faalt als die regel niet terug te lezen is.
- **Nieuwe partij, zelfde kooi.** Een subagent of hook die bestanden moet wijzigen start in deze kooi. Geen tweede pad met host-fs-writes.
- **User-namespace is gemeten.** `make sandbox-check` eist een uid-map die niet de host-identiteit `0 0 4294967295` is. Een kooi die de namespace niet krijgt, is rood. Dezelfde check eist dat een TCP-connect naar `1.1.1.1:443` vanuit de shell slaagt.

`install-lab.sh` is de enige bron van het profiel. `cardine-strict.patch.yml` is geen tweede waarheid meer.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Overlay met sync-back aan het eind van elke shell | Elke call kopieert; een crash midden in de sync verliest bytes; het verdwijn-venster van 2026-11-22 komt terug |
| Alleen de workspace-guard aanscherpen | De in-process tools zijn niet te kooien; een denylijst op een sleutelbos |
| `approval: ask` houden | De eis is dat een sessie niet vraagt |
| `danger-full-access` | Geen grens; de shell-kooi is dan een decor |
| Docker om de agent | [0007](0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md): te zwaar, Zed en `dsh` blijven native |
| Netwerk van de shell afsluiten | `npm`, `pip` en fetches vanuit de agent breken. De lab-keuze is dat de shell het netwerk houdt |

## Gevolgen

- **Makkelijker:** een write in de kooi staat meteen op de host. `make check` bewijst beide richtingen, met een tegenproef.
- **Moeilijker of risico:** een foutieve shell-write is meteen een echte bestandswijziging. De maskers en `git status` (geen stille commit) zijn de rem. De shell kan het internet op; dat is aanvaard. Een profielwijziging geldt pas na een nieuwe DSH-sessie.
- **Te doen:** na het landen van deze code Zed sluiten, `pkill -f "bin/dsh"`, één nieuw venster, nieuwe thread, en `make sandbox-check` op de host.
