# Bron — waarom het zo is

> **Rol:** De onderbouwing van de hele standaard: principes, de bronnen waar ze op steunen, en momentopnames van projecten die als voorbeeld dienen.
> **Niet hier:** wat je doet. Dat staat in [standaard](../standard/INDEX.md), [nieuw-project](../new-project/INDEX.md) en [bestaand-project](../existing-project/INDEX.md).

**Nooit kopiëren naar een project.** Deze map lees je om te begrijpen of te verantwoorden waarom iets zo moet.

| Bestand / map | Wat erin staat | Wanneer openen |
|---------------|----------------|----------------|
| [tour.md](tour.md) | Eén doorlopend verhaal: LLM → agent → AE-schil → IDE-lab → kit; “waar hoort X?”-tabel | Eerst hier als het geheel versnipperd voelt. Daarna catalogi/diepte JIT |
| [principes.md](principes.md) | 28 principes (P1–P28) van één of twee zinnen, elk met bronverwijzing, plus "twee lezers, één waarheid" en een snelle toets voor elke regel documentatie | Eén keer helemaal lezen (bij voorkeur ná de tour). Daarna bij twijfel *waarom* iets zo moet |
| [inbox.md](inbox.md) | Ruwe signalen (Reels, claims, tools): 1 regel + rating 1–5; nog geen `§` | Zodra je iets tegenkomt en niet wilt verliezen; vóór opzoeken |
| [weken/](weken/README.md) | Wekelijkse inbound-brieven (arXiv via digest); geen SSOT | Na `make digest-day` of `make digest-week` in deze repo; cureren → `§` |
| [bronnen-index.md](bronnen-index.md) | Inhoudsopgave per thema: vierlagen-stack, kernpraktijk, fundament-spiegel | Eerst hier kijken; alleen naar `bronnen.md` als je de samenvatting nodig hebt |
| [bronnen.md](bronnen.md) | Samenvattingen (§1–§161) per thema + Type/URL per § + totaaloverzicht | Om een principe na te kijken of te citeren. Agents: begin bij de index |
| [fundament/](fundament/INDEX.md) | Curriculum in 8 thema’s (modellen → ecosysteem): stubs + diepe stukken + [kenniskaart](fundament/kenniskaart.md). Opt-in; nooit always-on | Bachelor, LLM/agent-theorie, of wanneer een § te kort is. Agents: alleen JIT |
| [stand-dep2.md](stand-dep2.md) | Momentopname van de structuur van Data_Engineering_Project_2 (oktober 2026), zoals het team ze beschreef | Alleen als bron voor [het DEP2-voorbeeld](../existing-project/examples/dep2.md) |

## Drie sporen

- **Spoor 1 (omgeving):** in deze repo — `standaard/`, `kit/`, `sjablonen/`, plannen, `meten/` — wat je *doet* in projecten via bootstrap.
- **Spoor 2 (kennis):** deze map — waarom / hoe het zit. Fundament wijzigt de kit niet rechtstreeks; elk leerstuk eindigt met brugkandidaten of “geen actie”.
- **Spoor 3 (IDE-lab):** sibling-repo `cardine/` — runtime/experiment. Leest deze map JIT; schrijft lessen terug als § hier. Samen in Cursor: `Agent+Cardine.code-workspace` (naast deze repo).

**Werkvolgorde bij een nieuw idee:** eerst [inbox.md](inbox.md) (niet kwijtraken + rating); bij promote een § in [bronnen.md](bronnen.md) (feiten + “Wat ik meeneem”); desnoods diepte in [fundament/](fundament/INDEX.md); dan via [brug.md](fundament/brug.md) beslissen of iets naar standaard/kit/sjabloon (spoor 1) of alleen het lab (spoor 3) gaat. De repo-README beschrijft dezelfde keten.

**Wekelijkse papers:** `make digest-day` (systemd in deze repo) → [weken/](weken/README.md) → gekozen hits → `§` in [bronnen.md](bronnen.md). Geen auto-dump (P5).

## Hoe verwijzen

- Principes: `P1` tot `P28`, altijd met dezelfde nummers. Een principe dat wijzigt, krijgt geen nieuw nummer; een nieuw principe krijgt het volgende vrije nummer.
- Bronnen: `§n` (bv. `bron §12`). Nieuwe bronnen krijgen het volgende vrije nummer in `bronnen.md` (nu: na §161), onder het juiste thema, en een rij in [bronnen-index.md](bronnen-index.md) plus het [totaaloverzicht](bronnen.md#totaaloverzicht). Diepte hoort in [fundament/](fundament/INDEX.md); de § verwijst ernaar.
- Een momentopname van een ander project (zoals `stand-dep2.md`) wordt niet bijgewerkt. Verandert het project, dan voeg je een nieuwe momentopname met datum toe.

## Herzien

Herzie de principes wanneer een meting uit [meten](../measurement/INDEX.md) iets anders toont, of na een nieuwe generatie modellen of tools. Stand: oktober 2026.
