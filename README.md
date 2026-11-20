# Cardine

> **Het scharnier voor mens en AI-agent in elk project.**
>
> Cardine is een projectstructuur én een reproduceerbaar AI-agent-werkstation.
> Geen nieuwe editor, geen lock-in — alleen de standaard en de tools om er meteen
> te werken, met de agent die je al hebt.

## Waarom Cardine?

*Cardine* is de Latijnse ablatief van *cardo* (de spil, het scharnier). *"Waarmee en vanuit waar alles scharniert."*

AI-assistenten werken het best met een vaste projectstructuur. Zonder worden ze
richtingloos; met te veel gereedschap raak je verstrikt. Cardine geeft **de
structuur** (een bewezen boom voor mens én agent) en **de toolchain** (sandbox,
indexering, status-checks) — en laat jou kiezen welke editor en welk model je
gebruikt.

## Architectuur

```mermaid
graph TD
    M[cardine — meta]<br>README, docs, gidsen] --> L[cardine-lab<br>Arch/Hyprland werkstation]
    M --> S[cardine-structure<br>Projectstandaard]
    L --> D[DSH + Jarvis + bwrap<br>Sandbox, indexering, status]
    S --> K[Agent_Engineering/kit/<br>Bewezen structuur]
    style M fill:#4a90d9,color:#fff
    style L fill:#50b86c,color:#fff
    style S fill:#e8a838,color:#fff
```

| Package | Wat | Voor wie |
|---------|-----|----------|
| **[cardine-lab]** ⚙️ | Reproduceerbaar AI-agent-werkstation voor Arch Linux / Hyprland. Installeert DSH, Jarvis, bwrap-sandbox en Zed-config in één script. | Wie Zed + DeepSeek Harness op Arch wil draaien |
| **[cardine-structure]** 📁 | Projectstandaard voor ieder project, ongeacht editor of abonnement. `npx cardine-structure mijn-project` begint met een bewezen structuur. | Iedereen met een project |

## Installatie-paden

### Alleen de projectstructuur

```bash
npx cardine-structure mijn-project --profile app --modules research,agent
```

### Volledig AI-agent-werkstation (Arch Linux / Hyprland)

```bash
# 1. Installeer de toolchain
bash <(curl -fsSL https://raw.githubusercontent.com/ventje/cardine/main/packages/lab/install-lab.sh)

# 2. Voeg de projectstandaard toe
npx cardine-structure mijn-project --profile full
```

## Docs

| Waar | Wat |
|------|-----|
| [docs/INDEX.md](docs/INDEX.md) | Volledige docs-kaart |
| [docs/product/PRODUCT.md](docs/product/PRODUCT.md) | Productoverzicht |
| [docs/decisions/](docs/decisions/) | Architectuurbesluiten (ADR's) |
| [docs/packages/VERSIONING.md](docs/packages/VERSIONING.md) | Versiebeheer |

## Ontwikkeling

Deze repo is het publieke uithangbord. De **projectstandaard** en
**kennissamenvattingen** leven in de sibling-repo
[**Agent_Engineering**](https://github.com/ventje/Agent_Engineering) (privé,
SSOT). Cardine pullt daaruit.

Zie [AGENTS.md](AGENTS.md) voor agent-instructies en [docs/INDEX.md](docs/INDEX.md)
voor de volledige documentatie-kaart.

[cardine-lab]: packages/lab/README.md
[cardine-structure]: packages/structure/README.md