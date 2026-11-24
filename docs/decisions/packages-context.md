# Packages — context

> **Rol:** Dit document legt uit waarom Cardine uit meerdere packages bestaat, hoe de meta-, lab- en structuur-package samenhangen, en welke architectuurbesluiten (ADRs) daaraan ten grondslag liggen.
>
> Het geeft de achtergrond bij de README's. De README's verwijzen hiernaartoe voor de onderbouwing van de keuzes. De feitelijke research — bronnen, experimenten en paragraafverwijzingen — staat in [`bron/`](../../bron/INDEX.md) (dé Single Source of Truth). Dit document vat alleen de voor deze repo relevante synthese samen.

---

## Waarom een projectstructuur?

AI-agenten werken het best wanneer ze een vaste projectboom hebben om op te varen. Zonder zo'n vaste structuur worden ze richtingloos: ze raden naar mappen, missen conventies, en elke nieuwe sessie begint weer vanaf nul. De oplossing is tweeledig (**duaal**): een korte AGENTS.md legt de intentie uit, en harde controles in `make check` en de git-hooks dwingen de regels af waar nodig. Dat besluit is vastgelegd in [ADR 0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md).

## Waarom een gratis product?

Het product dat Cardine verspreidt, is de projectstructuur zelf — en die is gratis. De gids die uitlegt hoe je die structuur gebruikt met jouw editor en abonnement, is de voorkant. Het is niet de bedoeling om een betalende dienst of een eigen IDE te bouwen. Dit besluit staat in [ADR 0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md).

## Waarom packages in plaats van één bundel?

Niet iedereen gebruikt dezelfde editor, hetzelfde abonnement of dezelfde workflow. Iemand met alleen VS Code heeft geen Zed-package nodig. Iemand met een Claude-abonnement heeft geen API-key-pad nodig. Door losse packages aan te bieden in plaats van één verplichte bundel, kan elke gebruiker alleen datgene installeren wat relevant is. Het besluit staat in [ADR 0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md).

## Waarom is Zed de IDE op het lab-pad?

Het lab-pad — de combinatie waar het team zelf op meet en ontwikkelt — gebruikt Zed, en wel de officiële upstream-versie (geen eigen fork). Maar waarom Zed en niet Cursor, VS Code of iets anders?

De keuze voor Zed is gebaseerd op drie criteria:

1. **Een goed agent-pad met GUI.** Een editor voor AI-gestuurd werk moet een rijk agent-protocol hebben, een ingebouwd gesprekspaneel, en diffs tonen waar de agent wijzigingen voorstelt. Zed levert dat alles uit de doos: een ACP-client (Agent Client Protocol), een gesprekspaneel en ingebouwde diffs. Neovim en Helix vallen af omdat ze geen GUI-edit bieden.

2. **Geen eigen fork willen onderhouden.** Cursor is een fork van VS Code met eigen agent-integraties — maar een fork betekent dat je de hele editor moet blijven bijwerken en syncen met upstream. Zed forken zou hetzelfde probleem geven, met GPL-verplichtingen bovenop. Door ongemodificeerd upstream Zed te gebruiken, vermijden we dat onderhoud volledig. De eigen processen — harness, indexing, structuur en LLM — blijven losse componenten die via ACP koppelen, en hoeven geen deel van de editor te zijn.

3. **Een breed toepasbare gids, geen verplichte editor.** Het product dwingt geen editor af. Zed is een pad in de gids, niet een vereiste. Wie op VS Code of Cursor wil blijven, kan alleen het structuur-package installeren en de agent-paden volgen die bij zijn eigen editor passen. Het lab kiest Zed omdat het op dit moment de beste verhouding biedt tussen een rijk agent-pad en een minimale eigen voetafdruk.

In de praktijk betekent dit dat de meta-package een gepinde upstream-release van Zed rechtstreeks van zed.dev haalt. We forken niet, we hosten de binary niet zelf, en we aanvaarden dat eventuele gaten in Zed's core alleen via ACP, extensies of een latere heroverweging van dit besluit dichtgaan. Zie ook [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md).

## Waarom DeepSeek Harness en niet een eigen loop?

Net als bij Zed gebruiken we ook voor de agent-loop een bestaand, upstream product: DeepSeek Harness (DSH). Het is geen fork en we bouwen geen eigen loop. Zie [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md). DSH wordt als gepind profiel (ACP-profiel) meegeleverd via de meta-package, zodat de versie vastligt en reproduceerbaar is.

## Waarom een sandbox (bwrap)?

De agent-shell draait onder een strakke bwrap-kooi (bubblewrap). Dat betekent dat de agent alleen schrijftoegang heeft tot de projectmap en een goedgekeurde allowlist — niet tot de rest van het systeem. Dit beperkt de schade bij een fout of kwaadwillende instructie. Zie [ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md).

## Waarom deepseek-flash als model?

DeepSeek Flash is de primaire keuze voor het lab-pad: goedkoop en snel genoeg om iteratief te ontwikkelen. Claude fungeert als tweede provider voor wie een eigen API-key heeft en een ander model wil gebruiken. Het is geen exclusieve keuze — de gids legt ook de abonnement-paden uit (Claude in Zed, ChatGPT in Zed), die hun eigen model kiezen via de bijbehorende agent. Voor het API-key-pad geldt dit besluit; zie [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md).

## Waarom zit de structuur in dezelfde repo?

De projectstandaard — de kit, de bootstrap, de regels en de agent-instructies — leeft in **`kit/`** van deze repo. Dat is de Single Source of Truth. `cardine-structure` bevat er een letterlijke kopie van, gemaakt met `sync_kit.sh`, zodat één bron volstaat.

Vroeger stond de standaard in een aparte privé-repo (`Agent_Engineering`) en werd ze op gepinde commits gepulld ([ADR 0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md), **vervallen** op 2026-11-24). De pin liep in de praktijk uit de pas met de gepubliceerde kit; twee repo's bleken meer werk dan winst.

## Waarom SemVer en aparte versies per package?

Elk package krijgt een eigen SemVer-versie, onafhankelijk van de andere packages. De meta-package krijgt alleen een nieuwe versie als de structuur van de meta zelf wijzigt — niet bij elke update van een onderliggend package. Dit past bij het losse-packages-model uit [ADR 0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md): wie alleen de structuur gebruikt, heeft geen last van een versiesprong in het Zed-package. Zie [VERSIONING.md](../packages/VERSIONING.md) voor het volledige schema.

---

## Overzichtstabel

| Vraag | ADR |
|-------|-----|
| Waarom een duale standaard (docs + code)? | [0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) |
| Waarom een gratis product? | [0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) |
| Waarom losse packages in plaats van één bundel? | [0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md) |
| Waarom Zed en niet Cursor of VS Code? | [0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| Waarom DSH en geen eigen loop? | [0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Waarom een bwrap-sandbox? | [0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| Waarom deepseek-flash als model? | [0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| Waarom zit de structuur in dezelfde repo? | [0013 (vervallen)](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md) |
| Waarom SemVer per package? | [0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md) + [VERSIONING.md](../packages/VERSIONING.md) |