# Lokaal draaien — profiel 64 GB RAM + ~20 GB VRAM

> **Rol:** Welke modelklassen en optimalisaties realistisch zijn op een sterke desktop (veel RAM, ~20 GB VRAM, goede CPU).
> **Niet hier:** cloud-only engines zoals DeepInfer-op-SM100 als “jouw default”; kit-installers.

## Hardware-aanname (jouw setup)

| Resource | Orde | Gevolg |
|----------|------|--------|
| VRAM | ~20 GB | Comfortabel ~7B–14B Q4/Q5; krap voor 32B+ full; MoE “actief” vs totaal tellen |
| Systeem-RAM | ~64 GB | Ruim voor llama.cpp offload, embeddings-index, parallelle tools |
| CPU | sterk | CPU-offload / llama.cpp layers; trager dan GPU-decode |

Cijfers zijn **vuistregels**; altijd meten (tokens/s, VRAM-peak).

## Te schrijven

- Vuistregels GB ≈ parameters × bytes/gewicht (Q2–Q8, FP16)
- Stack-opties: llama.cpp / Ollama / vLLM-single-GPU / LM Studio-achtig
- Optimalisaties die wél helpen lokaal: quantisatie (en BitNet-lijn, **§45**), flash-attn waar beschikbaar, contextlengte beperken, draft-modellen, prefix-cache
- Wat *niet* past: frontier 70B+ dense unquantized; DeepInfer productie-HW; **Colibrì-schaal MoE-op-disk** als interactieve agent (**§49** — leerzaam, meestal ≪1 tok/s)
- Agent-workload: harness tax op lokale tokens (P25) — kleiner model + betere omgeving vaak slimmer
- Verwijs naar [../efficientie/optimalisatie.md](../efficientie/optimalisatie.md) en [../open-modellen](../open-modellen/INDEX.md)

## Geen actie

Geen harde modelkeuze in de kit; wel later bruikbaar voor persoonlijke notes / bachelor-context.
