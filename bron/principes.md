# Principes

> **Rol:** De regels waar elk ander bestand in dit plan op steunt. Eén of twee zinnen per principe, met een verwijzing naar het bronbestand.
> **Bron:** `§n` = hoofdstuk n in [bronnen.md](bronnen.md) (inhoudsopgave: [bronnen-index.md](bronnen-index.md)). §1–§9 en §25–§33, §37–§50, §52 zijn o.a. video/tooling; §10–§24, §34–§36, §51, §53 geschreven/paper/bundels; §46 outline (HRM/TRM, te verdichten). Diepte (opt-in): [fundament/](fundament/INDEX.md).
> **Niet hier:** hoe je het toepast. Dat staat in [standaard](../standard/INDEX.md), [nieuw-project](../new-project/INDEX.md), [bestaand-project](../existing-project/INDEX.md) en [meten](../measurement/INDEX.md).

---

## Uitgangspunt: twee lezers, één waarheid

Documentatie heeft twee lezers met verschillende behoeften:

| Lezer | Heeft nodig | Krijgt |
|-------|-------------|--------|
| **Mens** (jij over drie maanden, een teamgenoot, een recruiter) | Begrip, waarom, overzicht, onboarding | `README.md` en `docs/`, volledig en goed geschreven |
| **Agent** (elke nieuwe sessie begint zonder geheugen) | Wat het niet zelf kan afleiden, en waar het de rest vindt | Een kleine `AGENTS.md` die vooraf geladen wordt, en `docs/` op aanvraag |

De agent leest dus **dezelfde** `docs/` als de mens, maar alleen het bestand dat de taak vraagt. Het contextbestand dat altijd geladen wordt, blijft klein, omdat elke regel daarin bij elke taak meeweegt (§12, §20). De rest van de documentatie mag uitgebreid zijn: die kost alleen iets wanneer ze gelezen wordt.

---

## A. Context

**P1 — Context is eindig: één taak per schone sessie.**
Meer tokens maken een model niet beter, maar minder precies, ook ruim binnen het contextvenster. Snij werk zo dat één taak in één frisse sessie past, en begin opnieuw in plaats van eindeloos te corrigeren. (bron §1, §7, §8, §10, §12, §17, §18, §28)

**P2 — Kleine router vooraf, details just-in-time.**
Eén klein bestand wordt altijd geladen en verwijst naar een index. De index verwijst per vraag naar één bestand. De agent opent alleen wat de taak nodig heeft. (bron §3, §9, §10, §12, §13, §14, §15, §26)

**P3 — Het belangrijkste staat vooraan.**
Modellen gebruiken informatie aan het begin en einde van de context het best. Zet harde grenzen en commando's bovenaan het routerbestand, niet halverwege. Benadruk hooguit een paar regels: als alles benadrukt is, valt niets meer op. (bron §12, §17)

**P4 — Relevant lezen is belangrijker dan minimaal lezen.**
Context rot komt door irrelevante en misleidende tokens, niet door tokens op zich. Een agent die te weinig mag lezen, gaat gokken. Laat hem dus vrij lezen wat relevant is, maar verbied het blind inladen van hele mappen. (bron §10, §18)

---

## B. Inhoud van documentatie

**P5 — Documenteer niet wat afleidbaar is.**
Mappenbomen, opsommingen per bestand en lijsten van configs of tests vindt een agent zelf met `ls` en `rg`. Een overzicht van de repo in een contextbestand hielp agents aantoonbaar niet om sneller de juiste bestanden te vinden, en zulke lijsten verouderen bij elke commit. (bron §12, §13, §16, §20, §24)

**P6 — Documenteer wél wat niet afleidbaar is.**
Commando's die het model niet kan raden, specifieke tooling, valkuilen, harde grenzen, wat er bewust níet gebeurt, en vooral het waarom van keuzes. Dat is precies wat agents volgen en wat mensen nergens anders vinden. (bron §12, §14, §20, §23, §26)

**P7 — Eén feit staat op één plaats.**
Een dubbel beschreven feit loopt uit elkaar, en bijna-correcte informatie schaadt een model meer dan irrelevante ruis. Verwijs naar de bron in plaats van ze te kopiëren. Maak geen YAML- of JSON-spiegel van Markdown. (bron §3, §8, §12, §13, §18)

**P8 — Scheid stabiele waarheid van vluchtige status.**
Architectuur, regels en besluiten veranderen zelden. Backlog, sprintstatus en logs veranderen dagelijks. Ze horen in aparte bestanden, of bij een team in de issue tracker. Specs zijn tijdelijk: na de implementatie zijn de code en de tests de waarheid. (bron §4, §9, §10, §12, §26)

**P9 — Het waarom staat in besluiten die je nooit herschrijft.**
Leg elke betekenisvolle keuze vast als ADR: context, beslissing, gevolgen. Verandert de keuze, dan schrijf je een nieuwe ADR die de oude vervangt. Zo staan er nooit twee "geldende" waarheden naast elkaar. (bron §1, §4, §8, §23)

**P10 — Eén taal in code, docs en gesprek.**
Gebruik voor elk domeinbegrip één term, overal dezelfde, en leg ze vast in een glossarium. Dat bespaart tokens, voorkomt verkeerde interpretaties en maakt grep-zoekopdrachten raak. Vermijd onverklaarde afkortingen. (bron §2, §15, §18)

**P11 — Eén document dient één behoefte.**
Meng geen tutorial, how-to, referentie en uitleg in één bestand. Een agent die een taak uitvoert, heeft vooral how-to en referentie nodig. Het waarom hoort in uitleg of een ADR. (bron §22)

**P12 — Architectuur op containerniveau, niet op codeniveau.**
Het nuttigste overzicht toont welke apps, databases en services er zijn, hoe ze praten en waar de data staat (C4-niveau 1 en 2). Op codeniveau documenteer je niets met de hand: dat leidt een agent zelf af. Schrijf diagrammen als Mermaid, zodat ze doorzoekbare tekst blijven. (bron §16, §24)

---

## C. Omgeving en code

**P13 — Verifieerbare feedback is de grootste hefboom.**
Een agent stopt wanneer het werk "af lijkt". Tests, typechecks en linters die hij zelf kan draaien, maken van "lijkt af" een "is af". Voorzie **één commando** dat alles controleert. Een autonome loop heeft bovendien een meetbare stopconditie, geen vaag "maak het beter". (bron §2, §5, §7, §11, §12, §19, §26)

**P14 — Wat altijd moet, regel je deterministisch.**
Een instructie in Markdown is maar een advies. Wat zonder uitzondering moet gebeuren (linten, geen commits naar `main`, geen schrijfacties in `migrations/`), regel je met een hook, test, linter of CI-check. Trust, budgetten en scoped permissions horen in die schil, niet alleen in een prompt. (bron §5, §12, §13, §25)

**P15 — Regels staan dicht bij de code waarvoor ze gelden.**
Frontendregels laden alleen bij frontendwerk: via een geneste `AGENTS.md` per app of een path-scoped rule. De globale router bevat alleen wat overal geldt. (bron §13, §14)

**P16 — Codestructuur is ook context.**
Duidelijke map- en bestandsnamen, diepe modules met een kleine interface en bestanden van beheersbare grootte vertellen een agent meer dan uitleg. Geen versienummers in bestandsnamen (`_v3`, `_v4`): die zijn afleiders. AI neigt naar ondiepe, versnipperde modules; stuur bewust op deep modules en lokaliteit. (bron §2, §7, §10, §16, §18, §19, §32)

**P17 — Expliciete guardrails voor security en destructieve acties.**
De meeste contextbestanden zeggen niets over security of performance. Noem secrets, persoonsgegevens en commando's die data wissen expliciet, en blokkeer ze waar mogelijk deterministisch. Dat blijft nodig ook als coding-intelligentie in het model zelf landt. (bron §5, §21, §25)

---

## D. Werkwijze

**P18 — Eerst afstemmen en plannen, dan bouwen, in verticale slices.**
Bij een onzekere aanpak of wijzigingen over meerdere bestanden: eerst verkennen en vragen stellen, dan plannen, dan bouwen. Elke slice gaat dun door de hele stack en is meteen testbaar. Als je de diff in één zin kan beschrijven, sla je het plan over. (bron §1, §4, §6, §7, §12, §32)

**P19 — De mens is eindverantwoordelijke, en review gebeurt met een frisse context.**
Agents optimaliseren om tests te laten slagen, niet voor onderhoudbaarheid op lange termijn. Review de code zelf, en laat een agent-review in een nieuwe sessie gebeuren, niet in de sessie die de code schreef. De mens blijft de strategische programmeur; de agent de tactische. (bron §1, §6, §7, §9, §12, §26, §32)

**P20 — Groei op fouten, snoei op schema.**
Voeg pas een regel toe als de agent dezelfde fout herhaalt. Contextbestanden en harness-hacks groeien vanzelf aan ("nog één regel"), dus snoei ze periodiek met de deletion test: verandert het gedrag als je deze regel weghaalt? Zo niet, schrappen — vooral als het model de vaardigheid intussen natively heeft. (bron §3, §12, §13, §21, §25)

**P21 — Meet in plaats van aan te nemen.**
Wat werkt, verschuift met elke modelgeneratie, en wat vendors aanraden is niet altijd bewezen. Test een structuurwijziging op een vaste set taken voor je ze als verbetering beschouwt. (bron §11, §20, §25, en [meten](../measurement/INDEX.md))

---

## E. Autonomie, kosten en schaal

**P22 — Voed intent; voorkom begripsschuld.**
Groene tests bewijzen niet de juiste intentie. Houd zakelijke intentie expliciet in docs en `AGENTS.md`, en zorg dat mensen de code nog kunnen uitleggen. Blind accepteren van loop-output (cognitieve overgave) vergroot comprehension debt tot niemand een incident meer kan herstellen. (bron §26)

**P23 — Architectuur en seams vóór AI-volume.**
Laat agents geen volume schrijven in een *big ball of mud*. Eerst deep modules en testbare seams (naden waar adapters en tests aansluiten); dan pas tactische AI-wijzigingen. Zonder die harness rond de code versnelt AI software-entropie. (bron §2, §32)

**P24 — Isoleer context via subtaken of sub-agents.**
Eén vervuild window voor alles faalt sneller dan meerdere smalle contexten. Splits complex werk in gespecialiseerde stappen of agents met elk een klein venster; combineer pas bij de synthese. (bron §1, §28)

**P25 — Tel de harness tax mee.**
Zelfde benchmarkscore, andere prijs: system prompts en roundtrips maken agent-workflows vaak tientallen keren duurder dan directe chat. Kies tooling en loops op kwaliteit én tokenkosten; snoei harness-overhead die het model al natively aankan. (bron §25, §30)

**P26 — Het juiste model voor de taak.**
Frontier-modellen voor open redeneren en codewerk; snelle of deterministische automatisering (routering, filtering, scoring) hoort bij een smalle, goedkope laag. Één generiek model voor alles is meestal de dure fout. (bron §31)

**P27 — Loop: verifieerbaar doel en persistente spine.**
Een autonome loop heeft een meetbare stopconditie en status buiten de chat (bestanden of tracker) waarin staat wat geprobeerd is en wat werkte. Self-prompting zonder spine en zonder menselijke safeties bouwt intent- en begripsschuld op. (bron §26, §27; A9 sessions/spine §117, §128–§132)

**P28 — Bewuste weglatingen zijn zichtbaar en vraagbaar.**
Lever je een standaard of feature bewust incompleet op, dan staat wat ontbreekt in de relevante architecture-doc onder vaste kop `## Bewust later` (wat, waarom later, wanneer ernaar vragen). Stil overslaan mag niet: agents en mensen moeten die uitbreiding kunnen vragen zonder gissen. (P6, P8)

---

## Snelle toets voor elke regel documentatie

```
Kan de agent dit zelf afleiden uit code, git of ls/rg?   → ja  → niet opschrijven (P5)
Staat dit al ergens anders?                              → ja  → verwijzen, niet kopiëren (P7)
Verandert dit wekelijks?                                 → ja  → status: backlog/logs/tracker (P8)
Is dit een keuze met een waarom?                         → ja  → ADR (P9)
Moet dit zonder uitzondering gebeuren?                   → ja  → hook/test/CI, eventueel + één regel (P14)
Geldt dit maar voor één deel van de repo?                → ja  → geneste AGENTS.md of path-scoped rule (P15)
Is dit intentie of een valkuil die tests missen?         → ja  → docs/AGENTS.md, niet alleen een test (P6, P22)
Gaat dit over seams of modulegrenzen vóór AI-werk?      → ja  → architectuur + tests op naden (P23)
Sla je bewust een deel van de feature over?              → ja  → ## Bewust later in die doc (P28)
Anders                                                   →        het juiste bestand volgens standaard/waar-hoort-dit.md
```
