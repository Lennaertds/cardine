# Fundament — diepe technische kennis

> **Rol:** Curriculum over LLMs, agents en AI Engineering: mechanisme → trade-off → link naar Agent Engineering. Opt-in; nooit always-on.
> **Niet hier:** samenvattingen van bronnen ([bronnen.md](../bronnen.md)), afgeleide regels ([principes.md](../principes.md)), of wat je in een project *doet* ([standaard](../../standard/INDEX.md)).

**Nooit kopiëren naar een project.** Agents: begin bij [bron/INDEX.md](../INDEX.md); open hier alleen wat de taak vraagt (P25).

## Dual-track

| Spoor | Waar | Mag kit/standaard wijzigen? |
|-------|------|-----------------------------|
| **1 — Omgeving** | `standaard/`, `kit/`, `sjablonen/`, plannen, `meten/` | ja, via drieplaats-regel of principe |
| **2 — Kennis** | deze map + `bronnen.md` / `principes.md` | nee; alleen via brugparagraaf → kandidaten |

Elk leerstuk eindigt met **Wat kan naar de standaard** (0–N kandidaten) of **Geen actie**. Interessant ≠ kit-wijziging.

## Kaart van het vakgebied

Acht thema’s (binnenkant → buitenkant). Elk thema heeft een `INDEX.md` met scope en stubs.

```
fundament/
├── INDEX.md              ← jij bent hier
├── kenniskaart.md        ← diepte + randen; mind map-boom in kenniskaart-outline.md
├── kenniskaart-outline.md← Markmap-hiërarchie (`make mindmap` → exports/)
├── brug.md               ← spoor 2 → spoor 1
├── modellen/             ← architecturen & families (transformer, NCM, LCM, …)
├── redeneneren/          ← hoe het model “denkt” (CoT, latent, hybrid, HRM/TRM)
├── retrieval/            ← embeddings, RAG, vector stores
├── inference/            ← engines, KV/prompt-cache, lokaal hardwareprofiel
├── efficientie/          ← hefbomen, quantisatie, optimalisatie-overzicht
├── open-modellen/        ← open weights vs open source, modificatie (Heretic)
├── agents/               ← tool-use, protocollen (MCP/A2A/ACP/ANP), skills, orchestratie
└── ecosysteem/           ← aangrenzende tools (Fooocus, AppFlowy, …) — geen kern-LLM-theorie
```

| # | Thema | Vraag die het beantwoordt |
|---|--------|---------------------------|
| 1 | [modellen](modellen/INDEX.md) | Wat *is* het model? Welke families bestaan er? |
| 2 | [redeneneren](redeneneren/INDEX.md) | Hoe produceert het tussenstappen / “gedachten”? |
| 3 | [retrieval](retrieval/INDEX.md) | Hoe krijgt het externe kennis (embeddings, RAG)? |
| 4 | [inference](inference/INDEX.md) | Hoe draait het snel/goedkoop (engines, caches, hardware)? |
| 5 | [efficientie](efficientie/INDEX.md) | Welke hefbomen en optimalisaties bestaan er? |
| 6 | [open-modellen](open-modellen/INDEX.md) | Wat mag je downloaden, wijzigen, herdistribueren? |
| 7 | [agents](agents/INDEX.md) | Hoe worden modellen agents (tools, protocols, skills)? |
| 8 | [ecosysteem](ecosysteem/INDEX.md) | Welke producttools grenzen aan, zonder kern te zijn? |

Navigatie tussen thema’s: [kenniskaart.md](kenniskaart.md). Besluit of iets de kit raakt: [brug.md](brug.md).

## Jouw onderwerpen → plek

| Onderwerp | Map / bestand |
|-----------|----------------|
| Transformer / chronologische LLM-doorloop | [modellen/llm-doorloop](modellen/llm-doorloop.md) (§36) |
| Attention, MoE, superposition | [modellen](modellen/INDEX.md); §40 |
| NCM (Next-Concept Modeling), LCM, hybrid als *familie* | [modellen/alternatieven](modellen/alternatieven.md); §38 |
| Byte-level models / token ceiling | [modellen/byte-models](modellen/byte-models.md); **§53** |
| Colibrì / MoE expert-streaming (les, niet default runtime) | §49; [inference/lokaal-hardware](inference/lokaal-hardware.md) |
| MemPalace / externe agent-memory | §52; [agents/tool-use-en-memory](agents/tool-use-en-memory.md) |
| Strix / observability (bootstrap-kandidaten) | §47, §48; brug = later |
| Spec → Verifier → Environment / agentic engineering | §37, §41 in [bronnen](../bronnen.md) |
| World models / limits of LLMs | §42, §43 |
| Generative UI (Open UI) | §44; [ecosysteem](ecosysteem/INDEX.md) |
| Kit-dekking / horizon (perf, polyglot, radar) | [ecosysteem/kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) — D-reeks + live digest A3 in kit; license/SBOM/load nog horizon |
| Hybrid Reasoning Agents (diep) | [redeneneren/hybrid-agents](redeneneren/hybrid-agents.md) |
| HRM / TRM (tiny recursive) | [redeneneren/hrm-trm](redeneneren/hrm-trm.md); **§46** |
| Embeddings, RAG | [retrieval](retrieval/INDEX.md) |
| Inference engines, DeepInfer | [inference/engines](inference/engines.md) |
| KV-cache, prompt-/prefix-cache | [inference/caching](inference/caching.md) |
| Lokaal: 64 GB RAM + ~20 GB VRAM + sterke CPU | [inference/lokaal-hardware](inference/lokaal-hardware.md) |
| LLM-optimalisatie, quantisatie, BitNet/1-bit | [efficientie](efficientie/INDEX.md); **§45** |
| Drie hefbomen (thesis) | [efficientie/drie-hefbomen](efficientie/drie-hefbomen.md) |
| Open weights vs open source | [open-modellen/licenties](open-modellen/licenties.md) |
| Heretic (abliteration) | [open-modellen/heretic](open-modellen/heretic.md) |
| MCP, A2A, ACP (+ ANP) | [agents/protocollen](agents/protocollen.md) |
| SkillSpector (NVIDIA; Microsoft APM koppelt hem) | [agents/skills-veiligheid](agents/skills-veiligheid.md) |
| n8n | [agents/orchestratie](agents/orchestratie.md) |

## Leesroutes

| Doel | Start |
|------|--------|
| Eén verhaal LLM → agent → AE → lab | [../tour.md](../tour.md) |
| Hele vakgebied scannen | deze INDEX → thema-INDEX |
| Hoe een LLM chronologisch werkt | [modellen/llm-doorloop.md](modellen/llm-doorloop.md) |
| Bachelor / efficiëntie-as | [efficientie/drie-hefbomen.md](efficientie/drie-hefbomen.md) |
| Lokaal draaien op jouw machine | [inference/lokaal-hardware.md](inference/lokaal-hardware.md) |
| Agents & interoperabiliteit | [agents/protocollen.md](agents/protocollen.md) |
| Wat mag naar de standaard? | [brug.md](brug.md) |
| YouTube → dichte § | [prompts/youtube-samenvatting.md](prompts/youtube-samenvatting.md) |

## Relatie tot § en P

- Nieuwe paper/video → eerst een **§** in [bronnen.md](../bronnen.md).
- Diepte → hier; de § verwijst naar het fundament-bestand.
- Fundament citeert `§n` en `Pn`; geen feit dubbel uitschrijven (P7).

## Herzien

Stand: oktober 2026. Nieuw thema of pagina: rij in deze INDEX + thema-INDEX; knoop op [kenniskaart.md](kenniskaart.md) **en** tak in [kenniskaart-outline.md](kenniskaart-outline.md).
