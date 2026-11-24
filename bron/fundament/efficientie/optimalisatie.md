# Optimalisatie van LLMs

> **Rol:** Catalogus van model-/serving-technieken die tokens, latency of geheugen verlagen.
> **Niet hier:** Agent Engineering-docs snoeien (dat is hefboom *omgeving* in [drie-hefbomen.md](drie-hefbomen.md)).

## Te schrijven

| Techniek | Laag | Effect (richting) |
|----------|------|-------------------|
| Quantisatie (GPTQ, AWQ, GGUF, …) | Model/serving | Minder VRAM; kwaliteit-trade-off |
| BitNet / 1–1.58-bit weights (train-from-scratch) | Model | Zie **§45**; ternary + sparse; KV 3-bit (a4.8) |
| Speculative / draft decoding | Serving | Snellere decode |
| Distillatie / smaller students | Model | Goedkoper infereren |
| Pruning / sparsity | Model | Minder compute (hardware-afhankelijk) |
| MoE routing | Model | Meer capaciteit per actieve param |
| MoE expert streaming / weight-JIT (Colibrì) | Serving | Grote MoE op weinig RAM; I/O = latency (**§49**) — les, geen default |
| Byte-level distillatie / kleine vocab | Model | Ander schalingsplafond; langere sequenties (**§53**) |
| Batching / PagedAttention | Serving | Throughput (§29) |
| Prompt/prefix cache | Serving | Minder prefill ([../inference/caching.md](../inference/caching.md)) |
| Kortere CoT / latent | Reasoning | Minder text-tokens (§35) |

## Geen actie

Geen kit-afhankelijkheid op een specifieke quant-stack.
