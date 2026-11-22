# cardine-lab

> **Een reproduceerbaar AI-agent-werkstation voor Arch Linux / Hyprland.**

Installeert toolchain, sandbox, indexering en editor-koppeling in één
idempotent script. Geen handmatige stappen, geen verdwaalde configuratie —
draai het en je hebt een werkend agent-werkstation.

---

## Wat het installeert

| Onderdeel | Wat | Waarom? (research) |
|-----------|-----|---------------------|
| **DeepSeek Harness** | Agent-loop: tool-use, bestand-editen, sessie-beheer | Waarom DSH: [packages-context.md](../../docs/decisions/packages-context.md#waarom-dsh-en-niet-een-eigen-loop) · ADR [0003](../../docs/decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| **Jarvis MCP-server** | Code-index voor de agent — zoeken, definitie, referenties | Waarom Jarvis: [packages-context.md](../../docs/decisions/packages-context.md) · ADR [0006](../../docs/decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md) |
| **bwrap-sandbox** | Strakke kooi voor de agent-shell | Waarom sandbox: [packages-context.md](../../docs/decisions/packages-context.md#waarom-een-sandbox-bwrap) · ADR [0007](../../docs/decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| **Zed-config** | ACP-profiel zodat DSH als agent-paneel in Zed draait | Waarom Zed: [packages-context.md](../../docs/decisions/packages-context.md#waarom-is-zed-de-ide-op-het-lab-pad) · ADR [0002](../../docs/decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |

Zie [docs/cardine-lab.md](docs/cardine-lab.md) voor de volledige uitleg per
onderdeel en hoe ze samenhangen, en
[docs/decisions/packages-context.md](../../docs/decisions/packages-context.md)
voor de context bij alle keuzes.

---

## Installatie

### Vereisten

- **Arch Linux** (of afgeleide zoals EndeavourOS)
- **Hyprland** (of een andere Wayland-compositor)
- **Git** geïnstalleerd
- Optioneel: **Node.js** (voor `cardine-slice-check`)

### Stap 1 — Installeer de toolchain

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Lennaertds/cardine/main/packages/lab/install-lab.sh)
```

of, als je de repo al hebt:

```bash
bash packages/lab/install-lab.sh
```

Het script is **idempotent**: je kunt het meerdere keren draaien zonder
schade. Het installeert wat ontbreekt en slaat over wat er al is.

### Stap 2 — Voeg de projectstructuur toe

```bash
npx @lennaertds/cardine-structure mijn-project --profile full
```

Zie [cardine-structure](../structure/README.md) voor alle opties.

### Stap 3 — Status controleren

```bash
bash packages/lab/cardine-status.sh
```

of via make (als je de repo hebt):

```bash
make env-status
```

Zie [docs/how-to/status-jarvis-dsh.md](../../docs/how-to/status-jarvis-dsh.md)
voor wat de status-check je vertelt en hoe je problemen oplost.

### Optionele tooling

Naast de kern installeert `install-lab.sh` ook scripts voor:

- **Security scanning** — [docs/how-to/security-scan.md](../../docs/how-to/security-scan.md)
- **Dependencies audit** — [docs/how-to/deps-audit.md](../../docs/how-to/deps-audit.md)
- **Tech-radar** — [docs/how-to/radar.md](../../docs/how-to/radar.md)
- **Digest (RSS/Atom feeds)** — [docs/how-to/digest.md](../../docs/how-to/digest.md)
- **Performance budgets** — [docs/architecture/performance.md](../../docs/architecture/performance.md)
- **Polyglot checks** — [docs/architecture/polyglot.md](../../docs/architecture/polyglot.md)

Deze scripts zijn **optioneel** — ze worden geïnstalleerd maar je hoeft ze
niet te gebruiken.

---

## Inhoud van dit package

```
packages/lab/
├── CHANGELOG.md              ← Versiegeschiedenis
├── README.md                 ← Dit bestand
├── install-lab.sh            ← Hoofdscript — idempotent
├── cardine-bwrap             ← Strakkere bwrap-kooi (ADR 0007)
├── cardine-status.sh         ← Status-check voor DSH, Jarvis, tools
├── cardine-slice-check/      ← Node-module voor make check na een turn
├── scripts/                  ← Optionele tool-scripts
│   ├── check-links.sh
│   ├── deps-audit.sh
│   ├── security-scan.sh
│   ├── perf-check.sh
│   ├── polyglot-check.sh
│   ├── radar-check.sh / radar-reminder.sh
│   ├── native-ffi.sh
│   ├── digest-*.sh / digest-rss.py
│   └── install-digest-timers.sh
└── systemd/                  ← Timer-units (digest-fetch, digest-week)
    ├── digest-fetch.service / digest-fetch.timer
    └── digest-week.service / digest-week.timer
```

### Belangrijkste bestanden

| Bestand | Rol |
|---------|-----|
| `install-lab.sh` | Hoofdscript — idempotent, installeert DSH + Jarvis + bwrap + Zed-config |
| `cardine-bwrap` | Strakkere bwrap-kooi voor de agent-shell. Zie [ADR 0007](https://github.com/ventje/cardine/blob/main/docs/decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| `cardine-status.sh` | Status-check voor DSH, Jarvis en tools. Zie [docs/how-to/status-jarvis-dsh.md](../../docs/how-to/status-jarvis-dsh.md) |
| `cardine-slice-check/` | Node-module voor `make check` na een turn — valideert of een slice compleet is |
| `scripts/` | Extra tool-scripts (security, radar, audit, digest, …) — optioneel |
| `systemd/` | Timer-units voor digest-fetch — optioneel |

---

## Hoe het werkt

1. **`install-lab.sh`** downloadt en installeert DSH, Jarvis, bwrap en
   Zed-config. Het genereert een ACP-profiel in `~/.dsh/profiles/` dat DSH als
   agent-paneel in Zed koppelt.
2. **`cardine-bwrap`** vervangt de standaard bwrap-config door een strakkere
   kooi die de agent-shell isoleert — geen netwerk, geen onbevoegde
   bestandstoegang.
3. **`cardine-status.sh`** controleert of alle onderdelen werken: DSH-versie,
   Jarvis-index, sandbox, omgevingsvariabelen. Handig na installatie en bij
   problemen.
4. **`cardine-slice-check`** is een Node-module die `make check` gebruikt om
   na elke turn te valideren of links kloppen, of er geen secrets gelekt zijn,
   en of de docs consistent zijn.

Zie [docs/product/totaalproduct.md](../../docs/product/totaalproduct.md) voor
hoe deze onderdelen samenhangen met de rest van het product.

---

## Werking achter de schermen — waarom deze keuzes?

| Vraag | Antwoord | Meer lezen |
|-------|----------|------------|
| Waarom DSH en geen eigen loop? | Upstream DeepSeek Harness is stabiel en actief. Een fork is onderhoud zonder meerwaarde. | Context: [packages-context.md](../../docs/decisions/packages-context.md#waarom-dsh-en-niet-een-eigen-loop) · ADR: [0003](../../docs/decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Waarom bwrap? | Lichtgewicht, geen root-dienst, werkt op Arch zonder extra kernel-modules. | Context: [packages-context.md](../../docs/decisions/packages-context.md#waarom-een-sandbox-bwrap) · ADR: [0007](../../docs/decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| Waarom Zed? | Upstream, geen fork. Het lab-pad gebruikt Zed, maar het product dwingt geen editor af. | Context: [packages-context.md](../../docs/decisions/packages-context.md#waarom-is-zed-de-ide-op-het-lab-pad) · ADR: [0002](../../docs/decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| Waarom deepseek-flash? | Goedkoop en snel voor het lab. Claude is de tweede provider voor wie een eigen key heeft. | Context: [packages-context.md](../../docs/decisions/packages-context.md#waarom-deepseek-flash-als-model) · ADR: [0008](../../docs/decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| Waarom geen eigen editor? | De editor is upstream Zed. Een eigen IDE is werk dat geen meerwaarde biedt. | Context: [packages-context.md](../../docs/decisions/packages-context.md#waarom-een-gratis-product) · ADR: [0009](../../docs/decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) |

Zie [docs/decisions/packages-context.md](../../docs/decisions/packages-context.md)
voor een overzicht van alle context en de bijbehorende bronnen.

---

## Versiebeheer

Dit package heeft een **eigen versie**, onafhankelijk van `cardine-structure`
en de meta-package. SemVer — `major.minor.patch`.

| Actie | Versie |
|-------|--------|
| Huidige versie | [0.3.0](CHANGELOG.md) |
| Git-tag | `lab-v<semver>` |
| CHANGELOG | [CHANGELOG.md](CHANGELOG.md) |

Zie [docs/packages/VERSIONING.md](../../docs/packages/VERSIONING.md) voor het
volledige schema.

---

## Meer lezen

| Waar | Wat |
|------|-----|
| [docs/cardine-lab.md](docs/cardine-lab.md) | Volledige documentatie van dit package |
| [docs/how-to/zed-dsh.md](../../docs/how-to/zed-dsh.md) | Zed + DSH configureren |
| [docs/how-to/status-jarvis-dsh.md](../../docs/how-to/status-jarvis-dsh.md) | Status-check uitlezen |
| [docs/how-to/sandbox-troubleshoot.md](../../docs/how-to/sandbox-troubleshoot.md) | bwrap-problemen oplossen |
| [docs/product/totaalproduct.md](../../docs/product/totaalproduct.md) | Hoe de 9 onderdelen samenhangen |
| [docs/architecture/ARCHITECTURE.md](../../docs/architecture/ARCHITECTURE.md) | Containers, stack, dataflow |
| [README.md](../../README.md) | Meta-package — overzicht van alles |