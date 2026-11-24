# Inference — runtime, engines, caches, hardware

> **Rol:** Hoe gewichten tokens worden: engines, batching, caches, en wat op *jouw* machine past.
> **Niet hier:** modelarchitectuur ([../modellen](../modellen/INDEX.md)); strategische hefbomen ([../efficientie](../efficientie/INDEX.md)).

## Scope

De laag onder de agent-harness (zie §29-stack). DeepInfer hoort hier naast vLLM/SGLang/llama.cpp.

## Bestanden

| Bestand | Status | Over |
|---------|--------|------|
| [engines.md](engines.md) | stub | llama.cpp, vLLM, SGLang, TensorRT-LLM, **DeepInfer** |
| [caching.md](caching.md) | stub | KV-cache, prefix-/prompt-cache, hergebruik over requests |
| [lokaal-hardware.md](lokaal-hardware.md) | stub | Profiel ~64 GB RAM + ~20 GB VRAM + sterke CPU |

## Leesvolgorde

engines → caching → lokaal-hardware. Bron-samenvatting engines: §29.
