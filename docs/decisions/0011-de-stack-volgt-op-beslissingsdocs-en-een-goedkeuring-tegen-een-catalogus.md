# 0011 — De stack volgt op beslissingsdocs en een goedkeuring tegen een catalogus

- **Status:** aanvaard
- **Datum:** 2026-11-17
- **Raakt:** [PRODUCT.md](../product/PRODUCT.md), [structure.md](../product/structure.md), [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md), [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md).

## Samenvatting

In de context van een lege projectstart, geconfronteerd met gebruikers die de projecttekst niet zelf willen schrijven en met modellen die naar de populairste stack grijpen, kozen we voor vragen die beslissingsdocs vullen en een catalogus waaruit de agent twee of drie opties voorstelt en tegen een stille stackkeuze en tegen een verplichte zelfgeschreven tekst, om de gebruiker te laten goedkeuren wat er komt te staan, en we aanvaarden dat de catalogus bijgehouden moet worden en dat een generator pas na die goedkeuring draait.

## Context

- De structuurpackage ([0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md)) zet de boom neer. Wat het project *is*, staat dan nog leeg.
- Een model dat zelf een taal kiest, noemt meestal de populaire optie. Een catalogus met alleen “wanneer wel” versterkt dat.
- [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) houdt stack-generators tegen tot er een keuze is. Die keuze is de goedkeuring hier, niet een default in de catalogus.
- [0004](0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) blijft de afdwinging daarna: dunne `AGENTS.md`, harde `make check`.

## Besluit

- Op dag 0 staan er twee soorten bestanden. Vragen sturen het gesprek. Beslissingen leggen de uitkomst vast: `PRODUCT.md`, `BUSINESSMODEL.md`, `GOALS.md` en de docs die een latere keuze moeten kunnen uitleggen.
- De gebruiker vult die zelf in, of loopt ze leeg met de agent af. Een zin belandt in een beslissingsbestand als de gebruiker die goedkeurt.
- Daarna noemt de agent twee of drie opties uit een catalogus van talen en software. Elk voorstel noemt wat het doet, wanneer het past, wanneer het een slechte keuze is, en een zin uit `PRODUCT.md` waar het op steunt.
- De gebruiker vraagt door, keurt goed of wijst af. Een generator draait pas na die goedkeuring.
- De catalogus is naslag voor die voorstellen. Hij kiest niet zelf.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| De agent kiest de stack uit `PRODUCT.md` zonder catalogus | Dan wint de populaire default |
| De gebruiker moet het essay alleen schrijven | Dat is het werk dat mensen overslaan |
| Een lang menu zonder voorstel | Er is dan geen koppeling aan het doel, en de eerste regel wint alsnog |

## Gevolgen

- **Makkelijker:** de opstart is een gesprek met een uitkomst die later terug te lezen is.
- **Moeilijker of risico:** elke kaart in de catalogus moet een “wanneer niet” hebben, anders blijft het een populariteitslijst. De drie agent-paden uit [0010](0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md) moeten dezelfde docs kunnen lezen.
- **Te doen:** de vragen, de beslissingsdocs in de structuurpackage, en de catalogus. Nog niet in de kit. Kit-wijziging wacht op een brug en een ja in Agent_Engineering.
