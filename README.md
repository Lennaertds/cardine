# Cardine

> **Rol:** Lab-eerst: minimale, native AI-coderingsomgeving (**Zed** + eigen `cardine-core`) met sterke projectstructuur-integratie zonder Electron-bloat (thesis later). Als het lab goed is: portfolio + gratis app voor hobbyisten via een open meta-package met een closed-source core-binary. LLM via eigen keys (BYOK — DeepSeek/Claude).
> **Niet hier:** de projectstandaard of de kennissamenvattingen. Die leven in de sibling-repo **Agent_Engineering**.

## Naam & Filosofie

- **Waarom *Cardine*:** *Cardine* is de Latijnse ablatief van *cardo* (de spil, het scharnier, de hoofdas waar een stad of constructie omheen is gebouwd). De ablatief drukt het middel en uitgangspunt uit: *"waarmee en vanuit waar alles scharniert"*.
- **Filosofie:** Cardine bouwt geen zware alles-in-één editor vanaf nul, maar vormt het snelle, centrale scharnierpunt tussen een bestaande native editor (**Zed**), lokale project-indexing, strikte structuurregels (*Agent Engineering*) en externe LLM's (BYOK) — met minimale overhead en maximale lokale controle.

## Drie sporen

| Spoor | Repo | Wat |
|-------|------|-----|
| 1 Omgeving | [Agent_Engineering](../Agent_Engineering/) (`kit/`, bootstrap) | Standaard voor GymFreak e.d. |
| 2 Kennis | [Agent_Engineering/bron](../Agent_Engineering/bron/) | Principes, §, fundament — SSOT, niet kopiëren |
| 3 Dit lab | **deze repo (`cardine`)** | Runtime/IDE/harness-experiment (Zed + `cardine-core`) |

## Architectuur & Distributie (kort)

- **Meta-package (Open Source):** Geversioneerde installer + manifest (`lockfile`) die externe software (**Zed**) rechtstreeks van de officiële bron haalt en koppelt aan onze eigen core.
- **Core-executable (Closed Source binary):** `indexing`, `fs-events`, `harness`, `tools`, `llm`, `structure` en `session-spine` worden modulair ontwikkeld en gebundeld tot één native binary (`cardine-core`).
- **Native + Sandboxed exec:** Zed en `cardine-core` draaien native op de host (Arch/Hyprland eerst); untrusted agent-shell en package-installs draaien geïsoleerd (`bwrap`).

## Werken met agents + bronnen

Open de multi-root workspace (alle roots tegelijk):

`../Agent+Cardine.code-workspace`

Dan ziet de agent `cardine`, `Agent_Engineering/bron` én `Studeren` (voor planning en overkoepelende project-todos). Nieuwe lessen uit dit lab → eerst een § in Agent_Engineering `bron/bronnen.md`, pas daarna eventueel brug naar de kit (nooit rechtstreeks).

## Start

Kit staat (solo; modules agent, research, product; nog geen stacks). Context/grenzen: [docs/context/CONTEXT.md](docs/context/CONTEXT.md) · Totaalarchitectuur: [docs/product/totaalproduct.md](docs/product/totaalproduct.md). Runtime/stack pas na expliciete ADR-keuzes per onderdeel. Daarna BOOTSTRAP-stap 3 (apps).