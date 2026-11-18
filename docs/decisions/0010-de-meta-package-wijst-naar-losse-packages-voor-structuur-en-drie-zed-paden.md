# 0010 — De meta-package wijst naar losse packages voor structuur en drie Zed-paden

- **Status:** aanvaard
- **Datum:** 2026-11-17
- **Raakt:** [PRODUCT.md](../product/PRODUCT.md), [llm.md](../product/llm.md), [0008](0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md), [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md). Productvorm: [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md).

## Samenvatting

In de context van gebruikers met een Claude-abonnement, een ChatGPT-abonnement of een API-key, en van gebruikers die op VS Code blijven, kozen we voor één meta-package die naar losse packages wijst en tegen één verplichte bundel van Zed, harness en structuur, om elke combinatie apart te kunnen installeren, en we aanvaarden dat drie Zed-paden naast elkaar moeten kloppen met dezelfde structuur.

## Context

- Zed toont het gesprek. De agent die bestanden wijzigt is een apart proces en regelt de login zelf, via het Agent Client Protocol.
- Claude Pro of Max praat in Zed als Claude Agent, of als het `claude`-commando in een terminal van Zed, met dezelfde login als Claude Code. ChatGPT Plus of Pro praat als Codex, of via “Sign in with ChatGPT” in Zed’s eigen agent. Een API-key praat als DeepSeek Harness ([0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)).
- De chat op claude.ai of chatgpt.com wijzigt de projectmap niet. Het abonnement dat bestanden aanpast is Claude Code of Codex.
- DeepSeek Harness is een tweede agent in hetzelfde paneel. Hij stapelt niet op Claude.
- [0008](0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) (`deepseek-flash`, Claude als tweede provider) geldt voor het API-key-pad. De abonnement-paden kiezen hun model in die agent.

## Besluit

Eén meta-package legt uit wat je installeert en wat je weglaat. Eronder hangen losse packages. Elk is apart te installeren. Geen van de vier is verplicht.

| Package | Voor wie | Login |
|---------|----------|-------|
| Structuur | Iedereen, ook VS Code en elke andere editor | geen |
| Claude in Zed | Claude Pro of Max | Claude Code |
| ChatGPT in Zed | ChatGPT Plus of Pro | ChatGPT-account |
| Zed + DeepSeek Harness | Wie een API-key wil | key in `.env` |

De gids uit [0009](0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) legt deze vier uit. De structuur is het package dat elke lezer kan meenemen.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Eén installer die Zed en DeepSeek Harness altijd meeneemt | Verplicht een editor en een key die veel mensen niet willen |
| Een apart product per abonnement, zonder meta-package | De uitleg versplintert en de structuur zou drie keer bestaan |
| Zed uit het aanbod halen | De drie paden in Zed zijn de reden dat de gids bestaat |

## Gevolgen

- **Makkelijker:** iemand met alleen VS Code installeert alleen de structuur. Iemand met een abonnement hoeft geen API-key te kopen.
- **Moeilijker of risico:** dezelfde docs moeten leesbaar zijn voor Claude Code, Codex en DeepSeek Harness. Twee vensters (Zed om te lezen, Claude Code om te schrijven) blijven mogelijk; het paneel in Zed is het kortere pad, omdat de diff daar al staat.
- **Te doen:** de manifesten en de gids-pagina per pad. Nog niet geschreven. [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft voor eigen app-code.
