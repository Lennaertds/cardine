# Cardine

> **Het scharnier voor mens en AI-agent in elk project.**

AI-assistenten werken het best met een vaste projectstructuur. Zonder worden ze
richtingloos: ze raden mappen, missen conventies, en elke nieuwe sessie begint
opnieuw. Mét een vaste boom — docs, data, besluiten, logs — weet een agent
meteen waar hij iets vindt en waar hij het neerzet.

Cardine geeft die structuur, plus de toolchain om er meteen in te werken.
Geen nieuwe editor, geen verplicht abonnement — alleen de standaard en de
gereedschappen, met de agent die je al hebt.

---

## Waarom Cardine?

*Cardine* is de Latijnse ablatief van *cardo* — de spil, het scharnier waar een
stad of constructie omheen draait. *"Waarmee en vanuit waar alles scharniert."*

Het idee is eenvoudig: als elke sessie dezelfde boom aantreft, hoeft een agent
niet telkens te raden waar docs, data of besluiten staan. De projectstandaard
is het scharnier waar mens én agent omheen werken.

Zie voor de achtergrond:
- [docs/decisions/packages-context.md](docs/decisions/packages-context.md) —
  Volledige context: waarom packages, waarom deze keuzes, met links naar ADRs

---

## De standaard zit ín deze repo

Je hoeft niets te clonen naast elkaar: de projectstandaard (**kit**, **bronnen**,
**sjablonen**, **standaard**) leeft hier, naast het lab en de packages.

| Map | Wat | Naar een project? |
|-----|-----|-------------------|
| [kit/](kit/README.md) | De bestanden zelf, in lagen die een projectroot nabootsen: `kern`, `solo`, `team`, `modules/<naam>`, `stacks/<stack>`. Plus `new-project.sh` | **ja**, via het script |
| [nieuw-project/](nieuw-project/INDEX.md) | Stappenplan van lege map tot werkend project | nee |
| [bestaand-project/](bestaand-project/INDEX.md) | Stappenplan om een lopend project te herordenen | nee |
| [sjablonen/](sjablonen/INDEX.md) | Per kitbestand: wanneer, hoe invullen, voorbeeld, snelle toets | nee |
| [standaard/](standaard/INDEX.md) | De afspraken: boom, bestanden, stacks, Makefile, data, git, naamgeving | nee |
| [bron/](bron/INDEX.md) | Principes P1–P28, bronnen-index + samenvattingen, fundament, kenniskaart | nooit |
| [meten/](meten/INDEX.md) | Herhaalbare evaluatie met taken en condities | alleen `meten/kit/` |

De PDF's onder `bron/pdfs/` staan **buiten git** (samen ~166 MB) en syncen via
Syncthing; zie [bron/pdfs/README.md](bron/pdfs/README.md).

```bash
make new DIR=~/code/demo ARGS="--profile app"   # nieuw project
make trio s=makefile                           # de drie plaatsen van één onderwerp
make test-kit                                  # kit samenstellen en testen
```

De **brug** van kennis naar standaard: wat uit `bron/` de `kit/` mag raken,
staat in [bron/fundament/brug.md](bron/fundament/brug.md). Zonder jouw ja geen
kit-edit.

---

## Packages

Cardine bestaat uit twee packages. De meta-package (`cardine` in de root) is het
uithangbord: README, docs, gidsen. De packages eronder zijn elk apart te
installeren.

```mermaid
graph TD
    M("cardine (meta)") --> L("@lennaertds/cardine-lab")
    M --> S("@lennaertds/cardine-structure")
    L --> D("DSH + Jarvis + bwrap")
    S --> K("`kit/` / kit")
    style M fill:#4a90d9,color:#fff
    style L fill:#50b86c,color:#fff
    style S fill:#e8a838,color:#fff
```

| Package | Wat | Voor wie | Installatie |
|---------|-----|----------|-------------|
| **[@lennaertds/cardine-lab]** ⚙️ | Reproduceerbaar AI-agent-werkstation voor Arch Linux / Hyprland. Installeert DSH, Jarvis, bwrap-sandbox en Zed-config in één idempotent script. | Wie Zed + DeepSeek Harness op Arch wil | `npm i -g @lennaertds/cardine-lab` en dan `cardine-lab install` |
| **[@lennaertds/cardine-structure]** 📁 | Projectstandaard voor ieder project, ongeacht editor of abonnement. Bevat de bewezen `kern/`-`solo/`-`logging/`-boom, modules en stacks, gepulled uit `kit/`. | Iedereen met een project | `npx @lennaertds/cardine-structure <map> --profile app` |

### Hoe de packages samenhangen

```
cardine                    ← Meta: repo-root met README, docs, gidsen
├── cardine-lab            ← Toolchain: scripts, sandbox, status-checks
│   └── genereert          → ~/.dsh/profiles/ (ACP-profiel voor DSH)
│   └── bevat              → scripts/, systemd/ (optionele tooling)
└── cardine-structure      ← Projectstandaard: pulled uit kit/
    └── kit/               → Letterlijke kopie op pinned commit
```

De structuur wordt **in deze repo** onderhouden, in [kit/](kit/README.md).
`packages/structure/kit/` is de publieke distributiekopie die met
`@lennaertds/cardine-structure` meegaat. Vroeger kwam die uit een aparte
privé-repo en werd ze op pinned commits gepulled (zie
[ADR 0013](docs/decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md));
sinds de samenvoeging is `kit/` de enige bron en is een pin of pull-script niet
meer nodig.

---

## Installatie-paden

### 📁 Alleen de projectstructuur (elke editor, elk OS)

```bash
npx cardine mijn-project --profile app
```

Werkt vanaf elke cwd, ook in een lege map zonder clone. Dit zet de volledige
projectboom neer met `kern/`, `solo/`, `logging/`, plus de gekozen modules en
stacks. Geen toolchain, geen sandbox — alleen de structuur. Een tweede run
overschrijft niets. Werkt in VS Code, Zed, Cursor, of een terminal.

```bash
npx cardine mijn-project --profile app --modules research,agent
npx cardine oefeningen --profile schoolwerk --dry-run
```

Zie de [cardine-structure docs](packages/structure/docs/cardine-structure.md)
voor alle opties (profiles, modules, stacks).

### ⚙️ Volledig AI-agent-werkstation (Arch Linux / Hyprland)

```bash
# 1. Installeer de toolchain (DSH, Jarvis, bwrap, Zed-config)
npm i -g @lennaertds/cardine-lab
cardine-lab install

# 2. Voeg de projectstandaard toe
npx cardine mijn-project --profile app
```

Het lab-pad gebruikt Zed als IDE, DeepSeek Harness als agent-loop,
en `deepseek-flash` als model met Claude als tweede provider.
Zie [docs/decisions/packages-context.md](docs/decisions/packages-context.md)
voor de onderbouwing bij elke keuze.

Zie de [cardine-lab docs](packages/lab/docs/cardine-lab.md) voor wat er precies
geïnstalleerd wordt en hoe je sandbox, indexing en status-checks configureert.

---

## Hoe het werkt — in vogelvlucht

1. **Project beginnen**: `cardine-structure` zet een bewezen boom neer.
2. **Structuur leren**: docs/, data/, decisions/ en work/ hebben vaste plekken.
   Een agent navigeert met [docs/INDEX.md](docs/INDEX.md).
3. **Werken met een agent**: Open je editor, start de agent — de structuur
   vertelt hem waar docs, regels en werkitems staan.
4. **Controleren**: `make check` controleert links, lint en tests.
5. **Vastleggen**: `make finish` logt wat je gedaan hebt.
6. **Bijwerken**: Een nieuwe versie van de structuur? `pull_kit.sh` haalt de
   nieuwste pinned commit uit `kit/`.

Zie voor de volledige product-visie en achtergrond:
- [PRODUCT.md](docs/product/PRODUCT.md) — Wat het product doet, per onderdeel
- [totaalproduct.md](docs/product/totaalproduct.md) — Hoe de 9 onderdelen samenhangen
- [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) — Containers, stack, dataflow
- [docs/decisions/packages-context.md](docs/decisions/packages-context.md) — Waarom deze
  keuzes: onderzoeksvragen, bronnen, ADRs

---

## Docs en navigatie

| Waar | Wat |
|------|-----|
| [docs/INDEX.md](docs/INDEX.md) | Volledige docs-kaart — start hier voor elke vraag |
| [docs/product/PRODUCT.md](docs/product/PRODUCT.md) | Productoverzicht: wat het doet, voor wie, fasen |
| [docs/decisions/](docs/decisions/) | Architectuurbesluiten (ADR's) — waarom het zo is |
| [docs/packages/VERSIONING.md](docs/packages/VERSIONING.md) | Versiebeheer: SemVer, changelogs, git-tags |
| [AGENTS.md](AGENTS.md) | Instructies voor agenten die aan deze repo werken |

---

## Versiebeheer

Elk package heeft een **eigen versie**, onafhankelijk van de andere.

| Package | Versie | CHANGELOG | Git-tag |
|---------|--------|-----------|---------|
| `cardine` (meta) | 0.3.0 | [CHANGELOG.md](CHANGELOG.md) | `v0.3.0` |
| `@lennaertds/cardine-lab` | 0.4.0 | [packages/lab/CHANGELOG.md](packages/lab/CHANGELOG.md) | `lab-v0.4.0` |
| `@lennaertds/cardine-structure` | 0.4.0 | [packages/structure/CHANGELOG.md](packages/structure/CHANGELOG.md) | `structure-v0.4.0` |

SemVer: `major.minor.patch`. Een *major* is een breaking change (installer werkt
niet meer, kit-structuur wijzigt incompatibel). Een *minor* is nieuwe
functionaliteit. Een *patch* is een bugfix of documentatie.

Het meta-package krijgt een nieuwe versie alleen als de structuur van de meta
(docs, gidsen) wijzigt — niet bij elke package-update. Zie
[docs/packages/VERSIONING.md](docs/packages/VERSIONING.md) voor het volledige
schema.

---

## Ontwikkeling

Deze repo bevat alles: de projectstandaard ([kit/](kit/README.md)),
de kennis ([bron/](bron/INDEX.md)), de gidsen ([sjablonen/](sjablonen/INDEX.md),
[standaard/](standaard/INDEX.md)) en het lab ([packages/](packages/)).
Er is geen tweede repo meer om mee te synchroniseren.

De PDF's in `bron/pdfs/` staan bewust buiten git (zie
[bron/pdfs/README.md](bron/pdfs/README.md)).

Zie [AGENTS.md](AGENTS.md) voor agent-instructies en
[docs/INDEX.md](docs/INDEX.md) voor de volledige documentatie-kaart.

[@lennaertds/cardine-lab]: packages/lab/README.md
[@lennaertds/cardine-structure]: packages/structure/README.md