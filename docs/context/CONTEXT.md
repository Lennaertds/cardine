# Context

> **Rol:** Waarom dit project bestaat (**Cardine**), voor wie, en wat succes is.
> **Niet hier:** techniek ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), inhoudelijke grenzen ([RULES.md](../rules/RULES.md)).

## Naam & Filosofie (Cardine)

- **Herkomst:** *Cardine* is de Latijnse ablatief van *cardo* (de spil, het scharnier, de hoofdas waar een stad of constructie omheen is gebouwd). De ablatief drukt het middel en uitgangspunt uit: *"waarmee en vanuit waar alles scharniert"*.
- **Filosofie:** Cardine bouwt geen editor. Het scharnier is de projectstructuur, met een gids naar de editor en de agent die iemand al heeft. Vorm: [PRODUCT.md](../product/PRODUCT.md), [ADR 0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md).
- **Ontwerpprincipe:** De structuur is gratis en apart te installeren. Zed en DeepSeek Harness blijven upstream op het lab-pad ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)). Dat pad staat in [totaalproduct.md](../product/totaalproduct.md).

## Gebruiker of klant

**Nu:** solo-ontwikkelaar (Ventje) — lokaal lab, plus later een thesis-lezer die metingen en keuzes moet kunnen volgen.

**Later:** dezelfde structuur, gratis, voor wie een project start of een bestaand project herschikt. De gids wijst naar Claude in Zed, ChatGPT in Zed, of Zed met een API-key. Geen betalende SaaS. Publiceren wacht tot de labfase dat toelaat ([RULES.md](../rules/RULES.md)).

## Probleem

Een nieuw project begint leeg, en een bestaand project heeft zijn docs en mappen niet op een plek waar mens en agent ze allebei vinden. Mensen schrijven die tekst zelden zelf, en een model kiest dan de populairste stack. De ontbrekende laag is een structuur die al klaarstaat, plus een gids naar de editor en het abonnement die iemand al heeft.

## Doel en wat succes is

- **Lab (nu):** de persoonlijke applicatie werkend op Arch Linux Hyprland: Zed + DeepSeek Harness + indexing + de structure uit Agent_Engineering ([ADR 0012](../decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md)). Kaart: [totaalproduct.md](../product/totaalproduct.md).
- **Thesis:** later toetsbaar doel op hetzelfde lab.
- **Product:** Cardine als publiek uithangbord — packages en guides — dat de structure uit Agent_Engineering pullt ([ADR 0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)). De vorm is [ADR 0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md). Publiceren pas nadat de persoonlijke stapel werkt.
- Geen stack-generator tot de gebruiker een voorstel uit de catalogus goedkeurt ([ADR 0011](../decisions/0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md)). [0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft voor eigen app-code.

## Scope

- Domeinen: `harness`, `structure`, `indexing` (en hun scharnierwerking met `ide-shell` Zed, `fs-events`, `tools`, `llm`, `agent-ui` en `session-spine` — zie [GLOSSARY.md](GLOSSARY.md) en [PRODUCT.md](../product/PRODUCT.md)).
- Spoor 3 in het drie-sporenmodel: nu de persoonlijke stapel op Arch Linux Hyprland; later het uithangbord dat packages en guides samenbrengt en de structure uit Agent_Engineering pullt ([ADR 0012](../decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md), [ADR 0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)). Kennis en standaard blijven in Agent_Engineering.
- **Talen:** stack-talen staan in [ARCHITECTURE.md](../architecture/ARCHITECTURE.md) — daar nog open tot ADR-keuze (met sterke voorkeur voor native compilation naar één static binary zoals Rust/Go). Extra systemstalen voor hot paths: toegestaan na meting + ADR — zie [polyglot.md](../architecture/polyglot.md).

## Bewust niet

Zie [PRODUCT.md](../product/PRODUCT.md) § Bewust niet en [RULES.md](../rules/RULES.md): nu geen productrelease/prod-hosting; geen feature-bloat; geen eigen Zed-fork onderhouden; geen zware Docker-vereiste voor de runtime zelf; geen duplicatie of overname van data/secrets uit andere projecten; lessen eerst als § in Agent_Engineering `bron/`.