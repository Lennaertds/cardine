# Spec — fix-omgeving (agent alleen in de sandbox)

> **Rol:** Plan om de agent definitief binnen één project te kooien: lezen én schrijven in de workspace zonder te vragen, en niets daarbuiten — door de **onbreekbare kooi** de enige schrijfrechter te maken. Tijdelijk: na afronden verwijderen (de code en de tests zijn dan de waarheid).
>
> **Niet hier:** de historie van eerdere sessies ([dag-log 2026-11-22](../logs/2026-11-22.md)); besluitteksten (`docs/decisions/`).

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/fix-omgeving`
- **Status:** code geland (2026-11-23) — herstart van Zed en DSH nog nodig voordat het profiel live is. Besloten met het advies uit § Openstaande beslissingen: **bind**, gedeelde `/tmp`, netwerk open, `approval: never`. Zie [ADR 0017](../../decisions/0017-de-agent-schrijft-in-de-kooi-en-de-fs-write-tools-staan-uit.md).

## Doel

De agent werkt in Zed / DSH / `bwrap` binnn het project zonder één goedkeuringsvraag: lezen, wijzigen, shell, `make`. Alles buiten de workspace (`~`, `~/.ssh`, `~/.secrets`, `~/.dsh`, andere repo's, `/etc`) is voor élke route onzichtbaar en onwijzigbaar. Wat in de kooi geschreven wordt, staat **meteen** op schijf — en wat de agent deed, is achteraf als zijn wijziging te herkennen.

## Waar we nu staan (gemeten 2026-11-22, deze sessie)

| Feit | Bewijs | Gevolg |
|------|--------|--------|
| De shell draait in de kooi | `PID 1 = bwrap`, `~/.dsh/.env` onzichtbaar, `/etc` is tmpfs, workspace is `overlay` | Shell-lezen en shell-schrijven zijn afgeschermd |
| De kooi start met de **install-lab-config** | `~/.dsh/profiles/acp/cordis.patch.yml` heeft `approval: ask` en `sandbox-policy: workspace-write` | De agent vraagt nog bij elke edit |
| `cardine-strict.patch.yml` is **niet** geïnstalleerd | het bestand bestaat niet als profiel; ADR 0017 bestaat niet | Het strikte profiel is een losse schets |
| Shell-writes in de kooi verdwijnen | `check-bwrap-secrets.sh` eist letterlijk "host-kopieën ongewijzigd (overlay)"; dag-log 2026-11-22 § Misliep: appends "verdwijnen" | **Schrijven via de shell is onbetrouwbaar** — oorzaak van "verdwenen werk" in FIXES.md |
| `read`/`write`/`edit` draaien buiten de kooi | security.md, ADR 0016 | Die route is de enige die de host raakt, en de zwakste schakel |

De huidige "grens" is dus een mix van twee half-af verstendigingen: de zwakke, mens-gestuurde weg raakt de schijf, de sterke, mechanische weg raakt haar niet. Dat is precies het probleem om te draaien.

## Uitgangspunt (het kernplan)

> **De onbreekbare kooi is de enige schrijfrechter; de zwakke route grijpt nooit in.**

- De zwakke route (de in-process fs-tools `read`/`write`/`edit`) kan per definitie alles wat DSH mag. Ze afschermen met een guard is "een denylijst op een sleutelbos". Ze **uitschakelen** in het profiel is robuust (zelfde principe als `tool-web`/`tool-todo`/`tool-goal` uitschakelen).
- De sterke route (de kooi) is wat overblijft en moet daarom *bruikbaar* zijn: schrijven moet direct en betrouwbaar werken. Dat vraagt om `/tmp` dat de host wél deelt, en een overlay die opgeruimd wordt.
- Dit correerdeert één fout uit ADR 0007/0016 ("shell-writes landen niet op de host") en maakt de keuze expliciet: **de agent schrijft via de shell, in de kooi.**

Wat blijft: de **workspace-guard** blijft bestaan, maar als *defense-in-depth* voor de lees-tools die we niet willen uitschakelen (`read`, `read_image`, `glob`, `grep`) en als vangnet als een toekomstig profiel writes weer aanzet. Ze is niet meer de enige muur; `make check` bewijst dat ze nooit de énige muur was.

## Scope

- **In:**
  - profiel (`install-lab.sh` + `cordis.patch.yml`): writes uit, `approval: never`, workspace uit de **repo**, niet uit `process.cwd()`;
  - `cardine-bwrap`: gedeelde `/tmp`, overlay opruimen, geen host-mutatie;
  - trust (`git trust`): wat de agent schrijft is als zodanig herkenbaar en wordt nooit stil gecommit;
  - `make check` als sluis: bewijst elke route en elke richting, met een overkoepelende `make sandbox-check`;
  - docs, ADR, versie.
- **Buiten scope:**
  - Het netwerk van de shell afsluiten. Dat blijft open (ADR 0017).
  - Andere OS'en (`docs/work/specs/lab-macos.md`, `lab-andere-linux.md`).
  - Zed zelf kooien: Zed en `dsh` blijven native processen (ADR 0007).
  - Een net vertrouwen-model per pad ("propose outside, apply outside"): valt af, want "nooit vragen" is de eis en de guard is niet te vertrouwen als enige muur.

## Raakvlakken

| Plek | Wat verandert |
|------|---------------|
| `packages/lab/install-lab.sh` § 6 | profiel-generatie: `danger-full-access`/`auto` → writes uit, `never`, workspace uit `REPO_ROOT` |
| `~/.dsh/profiles/acp/cordis.patch.yml` (host) | idem; `cardine-strict.patch.yml` vervalt of wordt het echte profiel |
| `packages/lab/cardine-bwrap` | `--tmpfs /tmp` → bind van een host-map; `--overlay-src`/`--tmp-overlay` → `--bind` **of** opruimende overlay; fail-closed |
| `packages/lab/cardine-workspace-guard/` (nu `cardine-secrets-guard`) | blijft het padbeleid voor lees-tools; naam en scope verantwoorden |
| `packages/lab/scripts/check-bwrap-secrets.sh` | omdraaien: "host ongewijzigd" → "host **wél** gewijzigd", "gewoon bestand schrijfbaar" echt op host |
| nieuw `packages/lab/scripts/check-sandbox.sh` | overkoepelende bewijsmatrix (route × richting), de sluis in `make check` |
| `Makefile` | `CHECK := sandbox-secrets secrets-check` → `CHECK := sandbox-check` |
| `docs/architecture/security.md` | "twee grenzen, één waarheid" → één schrijfroute + één leesgrens |
| `docs/decisions/` | **ADR 0017** vastleggen (geclaimd in code, bestaat nog niet) |
| `AGENTS.md` | `git trust`-regel, geen "nooit vragen"-uitzondering meer nodig |

Patronen om te volgen: het omdraaien van een eis in een test (`check-bwrap-secrets.sh` heeft dat al voor "probe draaide niet → rood"), de deny-only-plugin in `cardine-secrets-guard/index.test.js`, en de rollback-dag-log in `AGENTS.md` § Afronden.

## Stappen

Elke stap is apart testbaar en eindigt in een **negatieve controle** (de test moet rood kunnen worden) en in de host-terminal — niet vanuit de agent, want de agent kan de host-config niet betrouwbaar aanraken (zie FIXES.md).

### Stap 0 — Vastleggen in een ADR (vóór alle code)

- **Waarom:** de code verwijst al naar "ADR 0017" dat niet bestaat; zonder ADR wordt elke volgende sessie weer verrast door het overlay-gedrag.
- **Wat:** `docs/decisions/0017-de-agent-schrijft-in-de-kooi-en-de-fs-write-tools-staan-uit.md`:
  - de agent vraagt **nooit** een approval in de lab-omgeving (equivalente "sandboxed auto mode");
  - alleen de kooi mag schrijven; de in-process write-tools staan uit;
  - `/tmp` is gedeeld met de host (nodig voor `make`, `node_modules`, wat de kooi moet opleveren);
  - een nieuwe partij (subagent, hook) begint alleen in de kooi, nooit met host-fs;
  - `approval: never` is de *vangnet-instelling* voor deze omgeving; de PR-route naar upstream krijgt later `auto` (goedkeuringen die vanzelf worden toegekend) zodat "nooit vragen" daar zonder fork kan — dat is geen losse afspraak maar een eis van Zed.
- **Klaar als:** de ADR de trade-offs van de drie schrijfmodellen (bind / overlay / snapshot-sync) benoemt en één kiest (advies: **bind + `git trust`**; zie Stap 3).
- **Rollback:** ADR-status terugzetten op *voorgesteld*.

### Stap 1 — Profiel: writes uit, `never`, repo vast

- **Bestanden:** `packages/lab/install-lab.sh` § 6, `~/.dsh/profiles/acp/cordis.patch.yml`, `packages/lab/cardine-strict.patch.yml`.
- **Wat:**
  1. `sandbox-policy`: `workspace-write` met `workspaceRoot` = `${REPO_ROOT}` (geen `!!js process.cwd()`, geen `danger-full-access`).
  2. `approval`: `policy: never` — geen dialoog, deterministisch.
  3. `tool-fs`: alleen `read`; `write`/`edit`/`apply_patch` uit.
     **Open:** of `tool-fs config.applyPatch: false` óók `write`/`edit` uitschakelt verschilt per DSH-versie. Meet het: na herstart moet `read` werken en `write`/`edit` niet in de tool-lijst staan. Zo niet, dan is dat een aparte instelling of een kleine out-of-tree plugin die de tools *unregistreert* (niet een guard die achteraf blokkeert).
  4. `tool-fs-search`: blijft **aan** (`glob`/`grep`) en loopt door de workspace-guard.
  5. `cardine-strict.patch.yml` wordt geen tweede waarheid: óf weg, óf verwijzing naar `install-lab.sh` als enige bron.
- **Klaar als:** in een nieuwe thread vraagt de agent niet bij een edit; een edit buiten de repo is niet mogelijk (*de tool bestaat niet*); `read` van een bestand in de repo werkt; `read` van `../Agent_Engineering` wordt geweigerd.
- **Rollback:** `~/.dsh/profiles/acp/cordis.patch.yml.bak-*` terugzetten en `pkill -f "bin/dsh"`.

### Stap 2 — `cardine-bwrap`: bruikbaar, deterministisch, opgeruimd

- **Bestanden:** `packages/lab/cardine-bwrap`.
- **Wat:**
  1. **Overlay-besluit.** Vóór de keuze tussen bind en overlay: meet of `/tmp` uit de kooi de host mist (zie Stap 4, negatieve test). Als de kooi `make`, `node` of `npm` moet draaien, moet `/tmp` zaken die de kooi aanmaakt aan de host kunnen overhandigen.
  2. **Advies: `--bind`** (één schrijfrechter, geen verdwijn-venster, `git status` is waarheid). De maskers (`.env`, keys) blijven; die zijn acceptabel: een `.env` hoort nooit te bestaan *in* de repo (ADR 0016), dus de maskeerd-find wordt normaal niets. De find draait vóór de kooi, op de host-gasthuidige boom.
  3. **Als overlay blijft:** dan `--overlay-src` + `--overlay` met een **host**-workdir en een expliciete *sync-back* in de `trap` (op het einde van elke shell-call), plus een `git trust`-entry per gewijzigd pad. Effectief "apply autonome workspace". Documenteer de kosten: elke call kopieert; `find` over `node_modules` doet mee; een crash midden in de sync verliest bytes.
  4. **`/tmp`:** `--tmpfs /tmp` → `--bind <host-tmp> <host-tmp>` (een vaste map, `700`, opgeruimd bij kooi-start), anders mislukt de helft van `make`.
  5. **Fail-closed:** een commando dat de host niet haalt moet **rood** zijn, niet stil groen zoals nu (`.probe-tool.txt` was niet te verwijderen terwijl de shell het niet meldde).
  6. **`--unshare-user`:** overwegen; zonder user-namespace draait de kooi als de echte uid en ziet ze via `/proc/<pid>/root` van andere processen meer dan bedoeld. Test: `PROC-ZIET-DSH-ENV` en `ls /proc/*/root/home`.
- **Klaar als:** `echo x > bestand` in de kooi, daarna `cat bestand` **op de host** → `x`; `git status` toont het bestand; `make check` in de kooi slaagt; een schrijfpoging die faalt wordt als fout gemeld.
- **Rollback:** de vorige `cardine-bwrap` terugzetten (alleen mount-vlaggen, geen data).

### Stap 3 — Trust: wat de agent schrijft is als zodanig herkenbaar

- **Waarom:** "de agent kan schrijven zonder te vragen" is pas verantwoord als je een wijziging **van de agent** kunt herkennen in `git status`/`git log`, en als die nooit stil gecommit wordt.
- **Bestanden:** `AGENTS.md`, `Makefile` (`make sandbox-check`), `.git/info/exclude` als nodig, `docs/architecture/security.md`.
- **Wat:**
  1. De agent voert **geen** `git commit`/`git push` uit (al in `AGENTS.md` § Nooit); de kooi mag `git` draaien (status/diff/read-only), commits zijn van de gebruiker.
  2. `git config` in de kooi: `user.name`/`user.email` van de host blijven, maar een pre-commit-schema (`core.hooksPath`) dat een commit met een agent-marker blokkeert — of simpeler: omdat de agent niet commit, is `git status` de grens; een sessie-beginsnapshot (`git stash list`/tag `agent-start`) maakt het verschil zichtbaar.
  3. In de dag-log (`make finish`) komt standaard "geschreven via de kooi" in de regel — dat is nu de herkomst-as.
- **Klaar als:** na een agent-edit toont `git status` het bestand op de host, en `git log` bevat geen agent-commit.
- **Rollback:** hooksPath terugzetten; het is geen data-verandering.

### Stap 4 — `make check` als sluis: de bewijsmatrix

- **Bestanden:** nieuw `packages/lab/scripts/check-sandbox.sh`; aanpassen `check-bwrap-secrets.sh`, `check-secrets.sh` (guard-unit-tests); `Makefile`; `packages/lab/cardine-status.sh`.
- **Wat:** één script dat de matrix afdrukt. Elke cel is een assert én een tegenproef (een commando dat het *wel* moet kunnen moet óók echt draaien; "niets gevonden" is anders geen bewijs — die les staat al in `check-bwrap-secrets.sh`).

| Route | In de workspace | Buiten de workspace |
|-------|-----------------|---------------------|
| shell lezen (`cat`, `rg`) | **moet** | **mag niet** (`~/.ssh`, `~/.secrets`, `~/.dsh/.env`, `/etc/shadow`, `../Agent_Engineering`) |
| shell schrijven | **moet**, en **op host zichtbaar** | **mag niet**, host ongewijzigd |
| `read`/`read_image` | **moet** | **mag niet** (guard) |
| `write`/`edit`/`apply_patch` | **tool bestaat niet** | **tool bestaat niet** |
| `glob`/`grep` | **moet** | **mag niet** (guard) |
| `make check` in de kooi | **moet slagen** | n.v.t. |
| approval-dialoog | **komt nooit** | **komt nooit** |

  - `Makefile`: `CHECK := sandbox-check` (één ingang; `sandbox-secrets` en `secrets-check` blijven eventueel als alias).
  - `cardine-status.sh`: toont de kooi-status (PID 1, overlay of bind, profiel-versie) zodat je na een herstart direct ziet of je in de juiste omgeving zit.
- **Klaar als:** elke cel groen op de host én in de kooi, en met één bewust doorbroken muur (bijv. `--bind /` tijdelijk) wordt de matrix rood.
- **Rollback:** `CHECK` terugzetten; de check-scripts zijn read-only.

### Stap 5 — Rollout, herstart en meting

- **Vanaf de host** (FIXES.md probleem 3 — dit is niet optioneel):
  ```
  pkill -f "bin/dsh" || true
  # alle Zed-vensters dicht, één nieuw venster, nieuwe thread (+)
  git pull            # of: commit de wijzigingen in cardine eerst
  make check          # of: bash packages/lab/scripts/check-sandbox.sh
  ```
- **Daarna, meet in een nieuwe thread:** "zit ik in de kooi?" → PID 1, profiel, overlay/bind; en "schrijf een bestand en cat het op de host."
- **Opschonen na afloop:** `.probe-tool.txt` en andere restjes van de vorige sessie verwijderen **vanaf de host** (de agent kan ze niet wegkrijgen).
- **Klaar als:** één sessie zet het project om (edits + `make check`) zonder één approval-dialoog, en de gebruiker ziet alles op schijf.

### Stap 6 — Docs en release

- `docs/architecture/security.md`: "twee grenzen" herschrijven naar "één schrijfroute (de kooi), één leesgrens (guard voor de tools die blijven)".
- `docs/product/tools.md` § Stand van zaken: T2/T3 bijwerken (approval = nooit; sandbox = de kooi schrijft).
- `docs/decisions/0016`: een notitie "geraakt door 0017" toevoegen (niet herschrijven).
- `AGENTS.md`: `git trust`/commit-verbod (als Stap 3 dat vraagt), geen "guard is de muur"-formulering meer.
- `CHANGELOG.md` + versie `@lennaertds/cardine-lab` (patch/minor), en `install-lab.sh` is de enige bron van het profiel.
- **Klaar als:** `git diff` na Stap 5 alleen docs + de besproken code toont, en een verse `install-lab.sh`-run een identiek profiel oplevert.

## Acceptatie (eindbewijs)

1. **Geen dialoog:** in een sessie met 5+ edits en `make check` komt geen approval-vraag.
2. **Schrijven werkt:** `echo`/`make` in de kooi landt op de host; `git status` toont het; niets "verdwnt".
3. **Geen lek:** `~/.ssh`, `~/.secrets`, `~/.dsh/.env`, `/etc/shadow`, `../Agent_Engineering` zijn onzichtbaar via shell **en** via de tools.
4. **Geen host-mutatie:** een probe die buiten de workspace schrijft laat de gashaard-host byte-voor-byte gelijk (`md5`).
5. **Niet stil:** een gemiste write of een mislukte mount is rood in `make check`, nooit "ok".
6. **Herkenbaar:** `git log` heeft geen agent-commit; de dag-log noemt de kooi als schrijfroute.

## Risico's en alternatieven

| Risico | Mitigatie |
|--------|-----------|
| `write`/`edit` zijn niet uit te zetten via het profiel | Meten (Stap 1.3); zo nodig een kleine plugin die de tools unregistreert, of upstream-PR voor een `tool-fs`-schakelaar |
| De kooi breekt `make`/`npm` (ontbrekende `/tmp`, cache) | Stap 2.4: gedeelde `/tmp`; daarna de foutiefail-closed laten zien: mislukt → rood, nooit stil groen |
| Bind i.p.v. overlay is riskanter bij een buggy agent | De maskers voor `.env`/keys blijven (verdediging in de diepte), ein `git trust` uit Stap 3 |
| Overlay blijft en er is weer een "verdwijneffect" | Dan alleen met expliciete `sync-back` + trust, nooit "half" |
| "Nooit vragen" is een policy-keuze, geen technische | Dit is de lab-omgeving met auto-sandbox; ADR 0017 legt het vast en begrenst het tot deze omgeving |

**Alternatieven overwogen:** (a) alleen de guard verscherpen — verworpen: in-process tools zijn per definitie niet te kooien; (b) alles in Docker — verworpen: ADR 0007, te zwaar; (c) "ask" behouden en domeinen verfijnen — verworpen: je wilt juist nooit vragen; (d) DSH-sandbox gebruiken — verworpen: default ongemeten, ADR 0007.

## Besluiten (2026-11-23)

1. **Bind** voor de workspace. Vastgelegd in ADR 0017.
2. **`/tmp` gedeeld** met de host (mode 700, per aanroep).
3. **Netwerk open.** Vast in ADR 0017. Een afsluiting op 2026-11-23 is teruggedraaid.
4. **`approval: never`** in dit lab, tot upstream `auto` zonder fork kan.

## Sessionsverwijzing

Gegenereerd uit de metingen in [docs/work/logs/2026-11-22.md](../logs/2026-11-22.md). Eerdere sessiecode verwijst naar ADR 0016 en naar "ADR 0017"; die laatste staat in Stap 0.
