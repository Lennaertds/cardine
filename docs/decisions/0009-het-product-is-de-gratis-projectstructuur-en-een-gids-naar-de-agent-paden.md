# 0009 — Het product is de gratis projectstructuur en een gids naar de agent-paden

- **Status:** aanvaard
- **Datum:** 2026-11-17
- **Raakt:** [PRODUCT.md](../product/PRODUCT.md), [README.md](../../README.md), [CONTEXT.md](../context/CONTEXT.md), [totaalproduct.md](../product/totaalproduct.md). Verpakking: [0010](0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md). Dag 0: [0011](0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md).

## Samenvatting

In de context van een lab dat Zed en DeepSeek Harness al als upstream had gekozen, geconfronteerd met een plan om een editor of een verplichte bundel te verspreiden, kozen we voor de projectstructuur als het gratis product en een gids als de ingang naar de agent-paden en tegen een eigen IDE en tegen een verplichte Zed-installatie, om de opstart van een project te vergemakkelijken voor wie al een editor en een abonnement heeft, en we aanvaarden dat de gids en de packages nog niet gepubliceerd zijn en dat het lab zelf op het pad Zed plus API-key blijft meten.

## Context

- Mensen zoeken op een combinatie die ze al hebben: Claude en Zed, ChatGPT en Zed, of een API-key met een harness. Een projecttekst typen ze zelden zelf.
- Een eigen editor is al afgewezen ([0002](0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)). De loop op het API-pad is upstream DeepSeek Harness ([0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)).
- [RULES.md](../rules/RULES.md) houdt een publieke release uit de labfase en sluit een betalende SaaS uit. Dit besluit legt de vorm vast. Publiceren volgt later.
- De structuur die een nieuw project neerzet en een bestaand project herschikt, leeft als kit en bootstrap in Agent_Engineering. Cardine verspreidt die en kopieert de standaard niet.

## Besluit

- Het product dat iemand meeneemt is de projectstructuur, gratis. Voor een leeg project staat de boom er meteen. Voor een bestaand project herschikt dezelfde structuur docs en bestanden, zoals bootstrap dat nu doet.
- De gids is de voorkant. Wie zoekt op een IDE met een harness en een abonnement, landt op de gids en kan de structuur meenemen.
- We bouwen geen editor. Zed is een pad in de gids, geen plicht.
- [0002](0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) tot [0008](0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) blijven gelden voor het pad waar ze over gaan. Het lab meet op Zed plus DeepSeek Harness met een API-key.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Eigen IDE of een `cardine-core`-binary als product | De editor is upstream Zed. Een eigen loop-binary is het werk dat [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) al weigert |
| Alleen het persoonlijke Zed-plus-DSH-pad verspreiden | Wie op VS Code of op een abonnement zit, heeft dan geen ingang |
| Een gids zonder de structuur | Dan blijft de opstart het werk van de gebruiker |

## Gevolgen

- **Makkelijker:** één ding om uit te leggen. Zoekverkeer op Claude plus Zed hoort bij de gids, en de structuur gaat mee.
- **Moeilijker of risico:** de gids moet de paden uitleggen zonder de standaard een tweede keer op te schrijven. Publiceren wacht tot de labfase-regel dat toelaat.
- **Te doen:** de gids-tekst en de packages bestaan nog niet. De verpakking staat in [0010](0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md). Het invullen op dag 0 staat in [0011](0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md).
