# 0012 — De eerstvolgende voltooiing is de persoonlijke stack op Arch Linux Hyprland

- **Status:** aanvaard
- **Datum:** 2026-11-17
- **Raakt:** [PRODUCT.md](../product/PRODUCT.md), [CONTEXT.md](../context/CONTEXT.md), [README.md](../../README.md), [totaalproduct.md](../product/totaalproduct.md), [BACKLOG.md](../work/BACKLOG.md). Publieke repo daarna: [0013](0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md). Vorm blijft [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md).

## Samenvatting

In de context van een lab waarvan de productvorm al vaststaat, geconfronteerd met de neiging om de publieke gids en de packages eerder te schrijven dan de eigen stapel, kozen we voor eerst de persoonlijke applicatie op Arch Linux Hyprland — Zed, DeepSeek Harness, indexing en de structure uit Agent_Engineering — en tegen de gids en de package-manifesten als eerstvolgende werk, om zelf een werkende stapel te hebben vóór er iets publiek komt, en we aanvaarden dat de publieke repo daardoor later komt.

## Context

- [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) tot [0011](0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md) leggen de vorm vast. De gids, de vragen en de manifesten bestaan nog niet.
- De gebruiker werkt op Arch Linux met Hyprland, laptop en desktop. Mac en Windows komen later ([totaalproduct_naar_MAC_en_Win.md](../product/totaalproduct_naar_MAC_en_Win.md)).
- “De applicatie” is hier niet een eigen editor en niet een eigen loop. Het is de stapel die hij zelf dagelijks gebruikt: upstream Zed, upstream DeepSeek Harness, indexing, en de structure uit Agent_Engineering.
- [RULES.md](../rules/RULES.md) houdt een publieke release uit de labfase. Dit besluit zet de volgorde binnen die fase: eerst die stapel werkend, daarna het uithangbord.

## Besluit

- De eerstvolgende voltooiing is de persoonlijke applicatie op Arch Linux Hyprland.
- Die applicatie is Zed + DeepSeek Harness + indexing + de structure uit Agent_Engineering. Niet een eigen editor. Niet een eigen agent-loop.
- Packages, gids-tekst en een publieke release wachten tot die stapel voor deze gebruiker werkt.
- [0002](0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) tot [0011](0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md) blijven gelden. Dit besluit verandert de volgorde, niet de vorm. De publieke rol staat in [0013](0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md).

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Eerst de publieke gids en de packages schrijven | Dan staat er uitleg zonder een stapel die je zelf dagelijks gebruikt |
| De persoonlijke stack meteen op Mac en Windows | Die hosts wachten tot Arch Linux Hyprland dagelijks bruikbaar is |
| Een eigen binary als “de applicatie” | De editor is upstream Zed en de loop is upstream DeepSeek Harness |

## Gevolgen

- **Makkelijker:** één voltooiingsdoel. Open werk blijft wat de backlog al noemt: Zed zelf proberen, indexing aansluiten, de structure uit Agent_Engineering laten meelopen, de key.
- **Moeilijker of risico:** de gids en de manifesten blijven leeg terwijl de vorm al beslist is. Dat is de bedoeling tot de stapel werkt.
- **Te doen:** geen nieuwe spec. De open stukken staan al op de backlog.
