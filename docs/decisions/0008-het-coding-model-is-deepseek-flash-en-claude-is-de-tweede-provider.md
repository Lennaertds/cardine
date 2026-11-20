# 0008 — Het coding-model is deepseek-flash en Claude is de tweede provider

- **Status:** aanvaard
- **Datum:** 2026-11-16
- **Raakt:** [llm.md](../product/llm.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). Spec `onderdeel-llm` verwijderd — product-doc volstaat. Sluit L2 en L3 uit [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md). Geldt voor het API-key-pad; de abonnement-paden kiezen hun model zelf ([0010](0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md)).

## Samenvatting

In de context van een coding-agent op DeepSeek, geconfronteerd met een frontier-id dat vanzelf in prijs en gedrag schuift, kozen we voor `deepseek-flash` als model-id en Claude als tweede provider en tegen “de recentste frontier” en tegen Kimi als die tweede, om dagelijks het goedkopere model te draaien en Claude alleen te pakken als de kwaliteit tekortschiet, en we aanvaarden dat een nieuwer id later via de radar komt.

## Context

- L1 en L4 staan in [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md): DeepSeek is de default, geen lokale inference. De key staat alleen in `.env`.
- §93 noemt het API-id `deepseek-flash`. Het oude `deepseek-v4-pro` werd daarheen doorgestuurd. Kimi (§142) was de vergelijking in het onderzoek, niet de kwaliteitsuitweg.
- Het totaalproduct noemt DeepSeek voor prijs/kwaliteit en Claude voor de hogere kwaliteit.

## Besluit

- **L3.** Het coding-model is `deepseek-flash`, gekozen in DeepSeek Harness, niet in Zed’s modelkiezer. Geen alias “latest”.
- **L2.** Claude is de tweede provider, met een eigen key. Kimi blijft een onderzoekspeer en is geen product-fallback.

Een nieuwer DeepSeek-id vervangt `deepseek-flash` pas na een radar-notitie, niet doordat de API vanzelf het duurste model pakt.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Recentste frontier als default | Dat is het dure model; de default is DeepSeek juist om de prijs |
| Geen tweede provider | Dan zit je vast aan één vendor zonder uitweg |
| Kimi als tweede | Peer uit de benches, niet de kwaliteitsuitweg die het product al noemt |

## Gevolgen

- **Makkelijker:** één id om mee te starten. Claude staat klaar zonder de dagelijkse rekening te zijn.
- **Moeilijker of risico:** `deepseek-flash` kan verouderd raken tot de radar hem vervangt. Twee keys, allebei alleen in `.env`.
- **Te doen:** `.env.example` pas met de applicatie. [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft. Geen `apps/`.
