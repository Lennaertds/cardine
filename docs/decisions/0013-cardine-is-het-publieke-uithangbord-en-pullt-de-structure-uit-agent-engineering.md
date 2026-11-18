# 0013 — Cardine is het publieke uithangbord en pullt de structure uit Agent_Engineering

- **Status:** aanvaard
- **Datum:** 2026-11-17
- **Raakt:** [PRODUCT.md](../product/PRODUCT.md), [structure.md](../product/structure.md), [README.md](../../README.md), [CONTEXT.md](../context/CONTEXT.md), [ARCHITECTURE.md](../architecture/ARCHITECTURE.md). Volgorde: [0012](0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md). Vorm: [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md), [0010](0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md).

## Samenvatting

In de context van drie sporen, geconfronteerd met de vraag waar de structure leeft als Cardine publiek wordt, kozen we voor Cardine als publiek uithangbord dat packages en guides samenbrengt en de structure uit Agent_Engineering pullt, en tegen een tweede kopie van de structure in deze repo, om de structure op één plek te kunnen bijwerken, en we aanvaarden dat de publieke package een pin nodig heeft op wat hij pullt.

## Context

- De structure die een project neerzet leeft als kit en bootstrap in Agent_Engineering. [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) zegt al dat Cardine die verspreidt en de standaard niet kopieert. Het zei nog niet dat Cardine het uithangbord is, en nog niet dat de update in Agent_Engineering blijft.
- De gebruiker wil de structure daar houden en naar behoefte bijwerken. Cardine haalt die versie op. Hij wordt niet de tweede bron.
- [0010](0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md) houdt de vier packages. Dit besluit legt vast welk van die vier een pull is, en wat de publieke repo zelf is.
- [0012](0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md) zet deze publieke repo ná de persoonlijke stapel. Dit besluit legt de vorm vast. Het publiceert nog niets.

## Besluit

- Cardine wordt de publieke repo. Die brengt packages en guides samen. Hij is het uithangbord, niet de bron van de structure.
- De structure blijft in Agent_Engineering. Daar wordt hij bijgewerkt naar behoefte.
- De publieke structure-package pullt die bron. Hij kopieert de standaard niet naar een tweede tekst in deze repo.
- [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) en [0010](0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md) blijven de productvorm. Dit besluit legt de herkomst en de rol van de publieke repo vast.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| De structure-tekst in Cardine onderhouden en terugmergen | Twee plekken. De kit loopt achter op wat je net bijwerkte |
| Alleen Agent_Engineering publiek maken | Dan is er geen uithangbord dat packages en guides samenbrengt |
| De structure forken in de publieke repo | Een update naar behoefte zou twee bomen moeten raken |

## Gevolgen

- **Makkelijker:** één plek om de structure bij te werken. Cardine legt uit en wijst. Hij herschrijft de standaard niet.
- **Moeilijker of risico:** de pull heeft een pin nodig. Zonder pin publiceert Cardine een structure die lokaal al gewijzigd is, of juist niet.
- **Te doen:** het pull-mechanisme en de pin, pas als de publieke repo er komt ([0012](0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md)). Geen kit-edit vanuit dit lab.
