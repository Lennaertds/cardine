# Byte-level models — tokenizerloos (of bijna)

> **Rol:** Wat byte-modellen zijn, waarom ze een hoger plafond kunnen hebben dan token-modellen bij genoeg compute, en wat dat (niet) betekent voor Agent Engineering vandaag.
> **Niet hier:** serving-engines ([../inference](../inference/INDEX.md)); volledige papersamenvatting (→ **§53**).

Naslag: **§53** ([Breaking the Token Ceiling](https://arxiv.org/abs/2609.12303), Meta FAIR / UW, sep 2026).

## Kernidee

Klassieke LLM's lezen **tokens** (BPE/…, vocab ~30k–130k). Een **byte-model** leest ruwe bytes (vocab ≈ 256 + speciale tokens). Per “woord” zijn er meer stappen, maar:

- geen tokenizer-mismatch tussen talen/code/rare strings;
- kleinere output-head → goedkoper opslaan van teacher-logits bij distillatie;
- bij **overtraining** (veel data/FLOPs op een klein model) kunnen byte-modellen token-modellen **inhalen en voorbijstreven** op downstream-taken (claim §53).

```
  token-pad:   "Tiramisu" → [Tir, am, isu, …]     (~1–few steps)
  byte-pad:    "Tiramisu" → T i r a m i s u       (~8 steps + evt. <eot>)
```

## Distillatie: token-teacher → byte-student

Probleem: de teacher geeft **token-logits**; de student heeft **byte-logits** nodig. §53 introduceert twee **single-pass** conversies (geen herhaalde teacher-forwards):

| Methode | Exact? | Idee |
|---------|--------|------|
| **Marginalize-It** | nee (na 1e byte approx.) | Marginaliseer over tokens die de byte-prefix delen; herverdeel restkans |
| **End-Of-Token (`<eot>`)** | ja | Extra vocab-token markeert einde van elk BPE-token; restkans landt op `<eot>` |

`<eot>` kost ~31% meer FLOPs per data-eenheid, maar verhoogt het asymptotische plafond t.o.v. de approx-methode.

## Schaling (orde van claims uit §53)

- Modellen ~**1B layer-params**, tot **1T bytes** data; teacher o.a. Llama 3-8B.
- **Laag compute:** Token-1B wint.
- **Meer compute:** Bytes / End-Of-Token blijven stijgen; Token plateau’t sneller.
- Extrapolatie: distilled **End-Of-Token-1B** tot ~**4%** beter dan distilled Token-1B op gemiddelde downstream; **~⅙ data** om Token-niveau te evenaren; logit-opslag ~**⅕**.
- Vergelijking met open 1B–2B (Llama 3.2-1B, Gemma-3-1B, Gemma 2B): asymptotisch voorspelde winsten tot enkele procenten — **paper-extrapolatie**, geen productieclaim.

## Trade-offs (praktisch)

| Voordeel | Nadeel |
|----------|--------|
| Geen BPE-grenzen / rare UTF-8 | Langere sequenties → meer decode-stappen, latency |
| Exacte teacher-distillatie mogelijk | Ecosystem (tooling, chat-templates) is token-first |
| Goedkoop logit-dumpen (256-way) | Vandaag: papers/research; geen drop-in Cursor-default |

## Wat kan naar de standaard

**Geen actie** voor kit/bootstrap (2026). Wel:

- kenniskaart-knoop + §53 als horizon;
- bij bachelor/efficiëntie: contrast met quant/BitNet (§45) en “hefboom Model” ([../efficientie/drie-hefbomen.md](../efficientie/drie-hefbomen.md)).

## Open

- Of asymptoten standhouden buiten de 8 benchmarks van de paper.
- Serving-latency van byte-decode vs token bij gelijke quality.
- Of coding-agents profiteren (code = veel bytes; tokenizer is daar juist sterk).
