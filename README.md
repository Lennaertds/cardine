# Cardine

> **Rol:** Lab-eerst. Nu de persoonlijke stapel op Arch Linux Hyprland: Zed + DeepSeek Harness + indexing + de structure uit Agent_Engineering ([ADR 0012](docs/decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md)). Later is deze repo het publieke uithangbord: packages en guides, met de structure gepullt uit Agent_Engineering ([ADR 0013](docs/decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)). Vorm: [ADR 0009](docs/decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md), [ADR 0010](docs/decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md).
> **Niet hier:** de projectstandaard of de kennissamenvattingen. Die leven in de sibling-repo **Agent_Engineering**.

## Naam & Filosofie

- **Waarom *Cardine*:** *Cardine* is de Latijnse ablatief van *cardo* (de spil, het scharnier, de hoofdas waar een stad of constructie omheen is gebouwd). De ablatief drukt het middel en uitgangspunt uit: *"waarmee en vanuit waar alles scharniert"*.
- **Filosofie:** Cardine bouwt geen editor. Het scharnier is de projectstructuur: een boom waarin mens en agent meteen werken, met een gids naar de editor en de agent die iemand al heeft.

## Drie sporen

| Spoor | Repo | Wat |
|-------|------|-----|
| 1 Omgeving | [Agent_Engineering](../Agent_Engineering/) (`kit/`, bootstrap) | Standaard voor GymFreak e.d. |
| 2 Kennis | [Agent_Engineering/bron](../Agent_Engineering/bron/) | Principes, §, fundament — SSOT, niet kopiëren |
| 3 Dit lab | **deze repo (`cardine`)** | Nu de persoonlijke stapel. Later het uithangbord: packages, guides, structure gepullt uit spoor 1 |

## Architectuur & Distributie (kort)

De verpakking staat in [PRODUCT.md](docs/product/PRODUCT.md). Eén meta-package wijst naar losse packages: de structuur, Claude in Zed, ChatGPT in Zed, en Zed + DeepSeek Harness met een API-key. Geen van die vier is verplicht. Op het lab-pad draait de agent-shell onder `bwrap`.

## Werken met agents + bronnen

Open de multi-root workspace (alle roots tegelijk):

`../Agent+Cardine.code-workspace`

Dan ziet de agent `cardine`, `Agent_Engineering/bron` én `Studeren` (voor planning en overkoepelende project-todos). Nieuwe lessen uit dit lab → eerst een § in Agent_Engineering `bron/bronnen.md`, pas daarna eventueel brug naar de kit (nooit rechtstreeks).

## Start

Kit staat (solo; modules agent, research, product; nog geen stacks). Context: [docs/context/CONTEXT.md](docs/context/CONTEXT.md) · Product: [docs/product/PRODUCT.md](docs/product/PRODUCT.md) · Lab-pad: [docs/product/totaalproduct.md](docs/product/totaalproduct.md). Eigen app-code pas na een runtime-ADR. Daarna BOOTSTRAP-stap 3 (apps).