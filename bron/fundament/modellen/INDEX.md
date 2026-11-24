# Modellen — architecturen en families

> **Rol:** Wat een model *is*: bouwstenen, families, en niet-klassieke LLM-alternatieven.
> **Niet hier:** serving/engines ([inference](../inference/INDEX.md)), RAG ([retrieval](../retrieval/INDEX.md)), agent-protocollen ([agents](../agents/INDEX.md)).

## Scope

| Wel | Niet |
|-----|------|
| Transformer, attention, posities, MoE, SSM/Mamba | Hoe je vLLM configureert |
| Alternatieven: NCM, LCM, diffusion LM, hybrid als *architectuurfamilie* | Hybrid training/detail → [redeneneren](../redeneneren/INDEX.md) |
| Mechanistic interpretability: superposition, features | Product-UIs (Fooocus, …) |

## Bestanden

| Bestand | Status | Over |
|---------|--------|------|
| [llm-doorloop.md](llm-doorloop.md) | diep (schema + bronnen) | Chronologische LLM-doorloop; bronnen per stap + overzicht (§36) |
| [transformer-basics.md](transformer-basics.md) | checklist | Korte ingang; verwijst naar doorloop |
| [alternatieven.md](alternatieven.md) | stub | NCM, LCM, diffusion LM, HybridAgents (pointer), SSM |
| [byte-models.md](byte-models.md) | diep (kort) | Byte-level vs tokens; distillatie Marginalize-It / End-Of-Token (**§53**) |
| [superposition.md](superposition.md) | stub | Feature superposition / interpretability |

## Leesvolgorde

1. [llm-doorloop](llm-doorloop.md) → 2. alternatieven / [byte-models](byte-models.md) → 3. superposition (optioneel) → hybrid in redeneneren.
