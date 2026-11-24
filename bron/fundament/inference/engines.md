# Inference-engines

> **Rol:** Runtime die prefill/decode, batching en geheugen beheert.
> **Niet hier:** diepe HybridLink ([../redeneneren/hybrid-agents.md](../redeneneren/hybrid-agents.md)); quantisatie-theorie ([../efficientie/optimalisatie.md](../efficientie/optimalisatie.md)).

## Te schrijven

| Engine | Niche |
|--------|--------|
| **llama.cpp** | Lokaal, CPU/Apple/consumer GPU, mmap |
| **vLLM** | Throughput, PagedAttention, continuous batching |
| **SGLang** | RadixAttention / gedeelde prefixes (agent-prompts) |
| **TensorRT-LLM** | NVIDIA vertical stack |
| **DeepInfer** (DeepSeek) | Productie-offline engine voor o.a. DeepSeek-V4.x; kernels, MoE-EP, speculative/DSpark; open release gericht op SM100 / Ascend — **niet** generic consumer-GPU drop-in |

Samenvatting vier klassiekers: §29. DeepInfer: aparte sectie + link naar upstream README.

## Geen actie

Geen engine in de kit.
