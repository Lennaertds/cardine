# Alternatieven voor klassieke autoregressive LLMs

> **Rol:** Families die niet (alleen) next-token AR zijn, of op een ander abstractieniveau werken.
> **Niet hier:** Hybrid training/HybridLink-detail ([../redeneneren/hybrid-agents.md](../redeneneren/hybrid-agents.md)).

## Te schrijven

| Familie | Kernidee | Plaats in dit curriculum |
|---------|----------|---------------------------|
| **NCM** (Next-Concept Modeling) | Coarse-to-fine discrete “concepts”; parallel binnen een niveau; Stanford Scaling Intelligence / Hazy (2026) | Video-naslag **§38**; hier later paper-diepte |
| **LCM** (Large Concept Models) | Redeneren in sentence-/concept-embeddingruimte (o.a. Meta SONAR) | Hier; niet verwarren met NCM |
| **Diffusion language models** | Iteratief verfijning van de hele sequentie | Hier kort; contrast met NCM |
| **SSM / Mamba e.d.** | Lineaire-state alternatieven voor attention | Hier |
| **Hybrid Reasoning Agents** | Latent ↔ text binnen één generatie | Pointer → [hybrid-agents](../redeneneren/hybrid-agents.md) |
| **World models** | Simulatie: vision → dynamics → action (Ha); Cosmos/Marble/Genie | Video-naslag **§42**; §43 voor LLM-limits frame |
| **Byte-level LM** | Vocab ≈256 bytes i.p.v. BPE; distillatie van token-teacher | Diepte: [byte-models.md](byte-models.md); **§53** |

## Geen actie

Geen kit-default “vervang LLM door NCM” of “vervang tokens door bytes”.
