# 0016 — Secrets leven in `~/.secrets` en de filesystem-tools worden gesloten met een deny-only guard

- **Status:** aanvaard
- **Datum:** 2026-11-22
- **Raakt:** [security.md](../architecture/security.md), [0007](0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md), `.dsh/profiles/acp/cordis.patch.yml` (buiten deze repo), `packages/lab/cardine-secrets-guard/`, `packages/lab/scripts/check-secrets.sh`.

## Samenvatting

In de context van een agent die zowel via de shell als via `read`/`write` bij bestanden kan, geconfronteerd met het feit dat de bwrap-kooi **alleen de shell** begrenst en de filesystem-tools in het DSH-hostproces draaien, kozen we voor twee lagen — `~/.secrets` buiten elke repo plus een `tools/pre-execute`-guard die geheime paden weigert — en tegen symlinks of `chmod 000` als middel, om te bereiken dat de agent nooit een API-key leest, en we aanvaarden dat een nieuwe guard-regel pas na een DSH-herstart geldt.

## Context

Gemeten in een lopende sessie:

- `bash`, `grep` en `glob` draaien in `cardine-bwrap`: `~/.secrets` bestaat daar niet, ook niet via `/proc/<pid>/root` of een symlink.
- `read`, `write` en `edit` draaien in het hostproces. `dsh-fs-local` zegt zelf: *"config.cwd is a resolution default, not a containment boundary."* Een `chmod 000` op een bestand helpt dus niet (de tool draait als de bezitter), en `read` volgt symlinks niet maar `bash`/`grep` wel.
- De DeepSeek-key staat in `~/.dsh/.env`; cardine had geen eigen `.env` nodig (geen app leest er een) en `.env.example` verwees er al naar.
- Een eerdere poging om `.env` in de kooi te maskeren via `bwrap` werkte voor de shell, maar raakte het hostbestand toen er buiten de overlay geschreven werd. Duurzaam alleen als de tool óók dicht zit.

## Besluit

- **Secrets centraal.** Echte waarden leven in `~/.secrets/<repo>/.env` (map 700, bestand 600), buiten elke repo. Repo's bevatten alleen `.env.example`. Geen symlinks ernaar: die zijn geen grens.
- **Guard vóór de tools.** `cardine-secrets-guard` registreert een `tools/pre-execute`-listener (`prepend`) die `read`, `read_image`, `write`, `edit`, `glob`, `grep` en `apply_patch` weigert op geheim bestandspatroon (`.env`, `*.env.*` behalve `*.example`, SSH-keys, `*.pem`/`.p12`/`.pfx`) en op alles onder `~/.secrets`, `~/.dsh`, `~/.ssh`, `~/.aws`, `~/.kube`. Deny-only: een guard kan niet goedkeuren wat een andere laag weigert. Paden worden geresolved (`realpath` met parent-walk voor nog niet bestaande bestanden).
- **De kooi blijft voor de shell.** `cardine-bwrap` maskeert `.env`/keys in de workspace zoals in 0007 toegezegd.
- **Bewijs in `make check`.** `sandbox-secrets` (kooi + buitenwereld) en `secrets-check`. Hard (rood) zijn: een geheim in git, een symlink naar buiten, falende guard-tests, ontbrekende guard-registratie. Waarschuwing zijn: rechten van `~/.secrets` en een `.env` op schijf, want dat spreekt de lokale machine aan en niet de repository.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Symlinks naar `~/.secrets` | `bash` en `grep` volgen ze door; geen grens |
| `chmod 000` op `.env` | Tools draaien als de bezitter en lezen alsnog |
| `chmod 700` op elke repo | Werkt, maar maakt de repo voor iedereen privé en lost niets op voor `~/.dsh` |
| Alleen RULES/`AGENTS.md` | Instructie, geen grens; één tegenvoorbeeld volstaat het te doorbreken |
| bwrap ook voor de filesystem-tools | De tools draaien in het DSH-proces, niet in de kooi; zou DSH moeten forken |
| Workspace = "wat git ziet" | `.git` zelf ontbreekt dan, en nieuw/ongetrackt werk valt buiten de grens |

## Gevolgen

- **Makkelijker:** de agent kan geen key tonen, committen of in een antwoord zetten, ongeacht of hij via de shell of de tools werkt.
- **Moeilijker of risico:** een guard-wijziging geldt pas in een **nieuwe** DSH-sessie; de profielregel staat in `install-lab.sh` zodat herinstallatie hem niet weghaalt. Restrisico: het runnen van `env`/build-processen kan variabelen uit de shell tonen — dit besluit dekt bestandstoegang, niet de proces-omgeving.
- **Te doen:** per app een `.env.example`; keys invullen in `~/.secrets`. Rechten en lef in [security.md](../architecture/security.md).
