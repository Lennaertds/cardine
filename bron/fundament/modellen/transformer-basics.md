# Transformer-basics

> **Rol:** Ingang tot decoder-transformer-begrippen; wijst naar de chronologische doorloop.
> **Niet hier:** het volledige schema met bronnen per stap — dat is [llm-doorloop.md](llm-doorloop.md).

## Lees dit eerst

**[llm-doorloop.md](llm-doorloop.md)** — tekst → tokens → embedding → attention/FFN × L → LM-head → sampling → KV-cache/decode, met overzichtsbronnen en bronnen per onderdeel (§36).

## Kernbegrippen (checklist)

- Tokenisatie (BPE / SentencePiece) en vocabulaire-trade-off
- Embedding + positie (learned vs RoPE)
- Causal multi-head self-attention + residual/norm
- FFN of MoE
- LM-head, weight tying, sampling
- Prefill vs decode; waar de KV-cache vandaan komt (serving-detail → [../inference/caching.md](../inference/caching.md))

## Verwijzingen

- §36 (bronnenbundel), §29 (engines)
- [../efficientie/drie-hefbomen.md](../efficientie/drie-hefbomen.md)

## Geen actie

Geen kit-wijziging.
