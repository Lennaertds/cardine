# Packages — context

> **Rol:** Waarom Cardine uit packages bestaat, hoe de meta, lab en structure
> samenhangen, en welke besluiten (ADRs) daaraan ten grondslag liggen.
>
> Dit document geeft de achtergrond bij de README's. De README's verwijzen
> hiernaartoe voor de onderbouwing. De feitelijke research (bronnen,
> experimenten, §-nummers) staat in Agent_Engineering (privé, SSOT) — dit
> document vat alleen de voor deze repo relevante synthese samen.

---

## Waarom een projectstructuur?

AI-agenten werken het best met een vaste projectboom. Zonder worden ze
richtingloos: ze raden mappen, missen conventies, en elke nieuwe sessie begint
opnieuw. De conclusie is **dual**: een korte AGENTS.md voor intent, en harde
checks in `make check`/hooks voor afdwingbare regels. Zie
[ADR 0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md).

## Waarom een gratis product?

Het product is de projectstructuur, gratis. De gids is de voorkant.
Het besluit is vastgelegd in
[ADR 0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md).

## Waarom packages in plaats van één bundel?

Niet iedereen heeft dezelfde editor, hetzelfde abonnement, of dezelfde
behoeften. Het besluit staat in
[ADR 0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md).

## Waarom is Zed de IDE op het lab-pad?

Het lab-pad gebruikt Zed — upstream, geen fork. Zie
[ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md).
Het product dwingt geen editor af — Zed is een pad in de gids, geen plicht
([ADR 0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md)).

## Waarom DeepSeek Harness en niet een eigen loop?

DSH is upstream, geen fork. Zie
[ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md).

## Waarom een sandbox (bwrap)?

De agent-shell draait onder een strakke bwrap-kooi. Zie
[ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md).

## Waarom deepseek-flash als model?

Goedkoop en snel voor het lab. Claude is de tweede provider voor wie een eigen
key heeft. Zie
[ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md).

## Waarom wordt de structuur uit Agent_Engineering gepulled?

De projectstandaard leeft in Agent_Engineering (privé, SSOT) en wordt op pinned
commits naar Cardine gepulled. Dat voorkomt twee bronnen en houdt de SSOT op
één plek. Zie
[ADR 0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md).

## Waarom SemVer en aparte versies per package?

Elk package heeft een eigen versie, onafhankelijk van de andere. De meta
krijgt alleen een nieuwe versie als de structuur van de meta wijzigt — niet bij
elke package-update. Dit past bij het losse-packages model uit
[ADR 0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md).
Zie [VERSIONING.md](../packages/VERSIONING.md) voor het volledige schema.

---

## Overzichtstabel

| Vraag | ADR |
|-------|-----|
| Waarom dual (docs + code)? | [0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) |
| Waarom een gratis product? | [0009](../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) |
| Waarom losse packages? | [0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md) |
| Waarom Zed? | [0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| Waarom DSH? | [0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Waarom bwrap-sandbox? | [0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| Waarom deepseek-flash? | [0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| Waarom pullen uit Agent_Engineering? | [0013](../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md) |
| Waarom SemVer per package? | [0010](../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md) + [VERSIONING.md](../packages/VERSIONING.md) |