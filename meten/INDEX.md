# Meten — werkt het echt?

> **Rol:** Een herhaalbare manier om te testen of een wijziging aan structuur of docs agents beter laat werken. Ook de pilot voor een bachelorproef.
> **Niet hier:** wat je verandert ([nieuw-project](../nieuw-project/INDEX.md), [bestaand-project](../bestaand-project/INDEX.md)), waarom meten ([P21](../bron/principes.md)).

Methode naar het voorbeeld van SWE-agent (bron §19) en de AGENTS.md-evaluatie van ETH (bron §20).

## Wat je kopieert

[kit/tasks.yaml](kit/tasks.yaml) en [kit/results.csv](kit/results.csv) naar een map `eval/` **naast** het project, nooit erin: de agent mag de orakels niet zien.

```bash
mkdir -p ~/code/eval-<project> && cp meten/kit/* ~/code/eval-<project>/
```

## Wat je meet

**Vraag:** maakt variant B van structuur en docs een agent beter, sneller of goedkoper dan variant A, op taken uit je eigen project?

| Meting | Hoe | Waarom |
|--------|-----|--------|
| **Slaagkans** (hoofdmeting) | Slaagt de acceptatietest van de taak, en is `make check` groen? Ja of nee | Objectief, zoals SWE-bench (§19, §20) |
| **Reviewscore** | Jouw score van 1 tot 5 met de [rubriek](4-review-en-analyse.md#reviewrubriek-blind), **blind** gegeven | Tests vangen geen slechte architectuur (§6) |
| **Kosten** | Input- en outputtokens, of de prijs per run | De ETH-studie vond +20% kosten door contextbestanden (§20) |
| **Stappen** | Aantal toolcalls | Meer verkennen is niet altijd beter (§20) |
| **Eerste relevante bestand** | Na hoeveel stappen opent de agent voor het eerst een bestand dat ook in de echte oplossing wijzigde? | Meet of de kaart en structuur helpen navigeren (§20) |
| **Regelschendingen** | Aantal overtredingen van "Nooit"-regels, ASK-bestanden of scope | Meet of de guardrails werken (P17) |
| **Tijd** | Wandkloktijd per run | Praktisch |

## Stappen

| Stap | Klaar als |
|------|-----------|
| [1. Taken samenstellen](1-taken.md) | 10 taken in `tasks.yaml`, met orakel, gekozen vóór je de nieuwe structuur bouwt |
| [2. Condities kiezen](2-condities.md) | minstens C0, C1, C2 |
| [3. Protocol](3-protocol.md) | elke combinatie van taak en conditie minstens 3 keer gedraaid, in willekeurige volgorde; alles in `results.csv` |
| [4. Review en analyse](4-review-en-analyse.md) | blinde scores; tabel per taak en per conditie; traces bekeken waar condities verschillen |
| [5. Validiteit](5-validiteit.md) | elk risico uit de tabel nagelopen en in het verslag vermeld |

Verder: [van deze set naar een bachelorproef](bachelorproef.md).

## Minimale versie (een namiddag)

1. Vijf taken uit de git-geschiedenis van één project.
2. Twee condities: C1 (huidig) en C2 (nieuw).
3. Twee runs per combinatie: 20 runs.
4. Meet: geslaagd ja of nee, tokens, en een snelle reviewscore.
5. Schrijf in één alinea op wat je zag. Dat is genoeg om te weten of de herordening de goede kant op gaat.

## TODO — sporen vergelijken (okt 2026)

Nog niet gestart; wel afgesproken:

- [ ] Na bootstrap/herordening van GymFreak (of Caddie): minimale eval — helpt de standaard-navigeren (eerste relevante bestand, slaagkans)?
- [ ] Later: conditie **Cursor + kit** vs **Cardine (spoor 3)** op dezelfde taken (`eval-` naast het doelproject). Kennis blijft in `bron/`; dit lab is geen tweede SSOT.
