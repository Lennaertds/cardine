# Standaard — hoe elk project eruitziet

> **Rol:** De vaste afspraken: waar elk bestand staat, wat erin hoort, hoe het heet. Eén antwoord per vraag.
> **Niet hier:** waarom ([bron](../bron/INDEX.md)), de bestanden zelf ([kit](../kit/README.md)), de volgorde van werken ([nieuw-project](../nieuw-project/INDEX.md), [bestaand-project](../bestaand-project/INDEX.md)).

**Niet kopiëren naar een project.** Een project volgt de standaard; het kopieert de kit. Zo staat de boom maar op één plaats (P5, P7).

## Opzoeken

| Vraag | Bestand |
|-------|---------|
| Welke mappen en ingangsbestanden heeft een project, en waarom? | [skelet.md](skelet.md) |
| Wie leest elk bestand, wat staat erin, wat niet? | [bestanden.md](bestanden.md) |
| Ik wil iets noteren of bewaren: waar? | [waar-hoort-dit.md](waar-hoort-dit.md) |
| Hoe ziet een app vanbinnen uit (Next, Nest, Python, SQL)? | [stacks.md](stacks.md) |
| Welke make-targets zijn er, en hoe voegt een app de zijne toe? | [makefile.md](makefile.md) |
| Welke profielen zijn er voor verschillende projectsoorten? | [profielen.md](profielen.md) |
| Hoe hou ik een status-log bij (onderwerpen, wat is open/afgerond)? | [loggen.md](loggen.md) |
| Welke datalaag voor welk bestand? | [data.md](data.md) |
| Wat staat in git, wat niet? | [git.md](git.md) |
| Hoe noem ik een bestand, ADR, test of sjabloon? | [naamgeving.md](naamgeving.md) |
| Wat verschilt er tussen solo en team? | [solo-team.md](solo-team.md) |
| Welke agent-rol bij welke opdracht, en wanneer subagents? | [agent-rollen.md](agent-rollen.md) |

## Volgorde om te leren

Eén keer, in deze volgorde: skelet, bestanden, waar-hoort-dit, stacks, makefile. De rest open je bij een concrete vraag. Principes P22–P28 (intent, seams, isolatie, harness tax, modelkeuze, loop-spine, bewust later) zitten vooral in [bestanden](bestanden.md), [waar-hoort-dit](waar-hoort-dit.md), [agent-rollen](agent-rollen.md) en [stacks](stacks.md).

## De standaard veranderen

Past iets nergens, dan pas je de standaard aan, niet het project alleen:

1. Een rij in [waar-hoort-dit.md](waar-hoort-dit.md) en, als het een nieuwe plaats is, een regel in de boom van [skelet.md](skelet.md).
2. Hoort er een bestand bij, dan komt het in de [kit](../kit/README.md) (in de kern als elk project het nodig heeft, anders als module) en krijgt het een gids in [sjablonen](../sjablonen/INDEX.md).
3. `make check` in de root van deze repo.
