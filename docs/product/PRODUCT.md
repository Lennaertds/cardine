# Product

> **Rol:** Wat het product doet, gezien vanuit de gebruiker.
> **Niet hier:** hoe het gebouwd is ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), het lab-pad in detail ([totaalproduct.md](totaalproduct.md)).

## Wat iemand meeneemt

Het product is de **projectstructuur**, gratis. Een gids is de voorkant: wie zoekt op een IDE met een harness en een abonnement, landt daar en kan de structuur meenemen. Besluit: [ADR 0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md).

Eén meta-package legt uit wat je installeert en wat je weglaat. De packages eronder zijn elk apart te installeren. Besluit: [ADR 0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md).

| Package | Voor wie |
|---------|----------|
| Structuur | Iedereen. Ook VS Code en elke andere editor. Leeg project: de boom staat er. Bestaand project: dezelfde structuur herschikt docs en bestanden. |
| Claude in Zed | Claude Pro of Max, via Claude Code in het Zed-paneel |
| ChatGPT in Zed | ChatGPT Plus of Pro, via Codex of Zed’s ChatGPT-login |
| Zed + DeepSeek Harness | Wie een API-key wil. Dit is het pad waarop het lab meet |

De chat op claude.ai of chatgpt.com wijzigt de map niet. Het abonnement dat bestanden aanpast is Claude Code of Codex.

## Dag 0

De structuur zet de boom neer. Wat het project is, vult een gesprek. Besluit: [ADR 0011](../decisions/0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md).

- Vragen sturen het gesprek. Beslissingen leggen de uitkomst vast: `PRODUCT.md`, `BUSINESSMODEL.md`, `GOALS.md` en de docs die een latere keuze moeten kunnen uitleggen.
- De gebruiker vult die zelf in, of loopt ze met de agent af. Een zin belandt in een beslissingsbestand als hij die goedkeurt.
- Daarna noemt de agent twee of drie opties uit een catalogus van talen en software, elk gekoppeld aan een zin uit `PRODUCT.md`. De gebruiker keurt goed of wijst af. Een generator draait pas daarna.

## Fasen

| Fase | Wat | Status |
|------|-----|--------|
| Lab | De persoonlijke stapel werkend: Zed + DeepSeek Harness + indexing + de structure uit `kit/`, op Arch Linux Hyprland | nu — [0012](../decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md) |
| Thesis | Hetzelfde lab, leesbaar voor een beoordelaar | later |
| Product | Publieke repo als uithangbord: packages, guides, structure gepullt uit `kit/` | vorm beslist ([0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md), [0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)); pas nadat de persoonlijke stapel werkt |

## Lab-pad

Het pad Zed + DeepSeek Harness blijft het pad waarop je meet. Samenhang: [totaalproduct.md](totaalproduct.md). Per onderdeel één bestand hieronder.

| # | Onderdeel | Productdoc | Spec |
|---|-----------|------------|------|
| 1 | IDE-shell | [ide-shell.md](ide-shell.md) | afgerond — [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| 2 | FS/events | [fs-events.md](fs-events.md) | afgerond — Zed-boom, geen eigen watcher (geen ADR) |
| 8 | Agent-UI | [agent-ui.md](agent-ui.md) | afgerond — Zed Agent Panel via ACP (geen ADR) |
| 5 | Harness | [harness.md](harness.md) | beslist — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| 4 | Tools | [tools.md](tools.md) | beslist — [ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| 6 | LLM | [llm.md](llm.md) | beslist voor dit pad — [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| 3 | Indexing | [indexing.md](indexing.md) | beslist, agent-pad — [ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md) |
| 7 | Structure | [structure.md](structure.md) | beslist — [ADR 0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) |
| 9 | Session/spine | [session-spine.md](session-spine.md) | overgeslagen — [ADR 0005](../decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md) |

Op dit pad: shell, FS en Agent-UI = Zed. Harness = DeepSeek Harness. Het model is `deepseek-flash`, met Claude als tweede provider via een eigen key ([0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md)). De abonnement-paden kiezen hun model zelf ([0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md)).

## Bewust niet

- Geen eigen editor en geen verplichte Zed-installatie ([0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md)).
- Geen IDE-fork: als het pad Zed is, blijft Zed upstream ([0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)).
- Geen stille stackkeuze door de agent ([0011](../decisions/0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md)).
- Geen betalende SaaS. Abonnementen zijn die van Claude of ChatGPT. API-keys blijven van de gebruiker.
- Geen publieke release tijdens de labfase ([RULES.md](../rules/RULES.md)).
- Geen overname of duplicatie van data, secrets of broninhoud uit andere projecten of uit `kit/`.
- Geen eigen inference-serving.

## Bewust later

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Gids-tekst en één pagina per pad | De vorm staat in [0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) en [0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md); de pagina’s wachten tot de persoonlijke stapel werkt ([0012](../decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md)) | de gids geschreven moet worden |
| Vragen, beslissingsdocs en de taalcatalogus in de structuurpackage | [0011](../decisions/0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md); de kit wijzigt pas na een brug en een ja | die bestanden in de kit horen |
| Package-manifesten en de pull van de structure | Publiceren wacht tot de persoonlijke stapel werkt ([0012](../decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md), [0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)) | de packages echt geïnstalleerd moeten kunnen worden |
