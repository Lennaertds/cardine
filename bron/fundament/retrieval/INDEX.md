# Retrieval — embeddings en RAG

> **Rol:** Externe kennis ophalen en in de context brengen zonder alles in gewichten te stoppen.
> **Niet hier:** prompt-/KV-cache ([../inference/caching.md](../inference/caching.md)); agent-memory-protocollen ([../agents](../agents/INDEX.md)).

## Scope

| Wel | Niet |
|-----|------|
| Embeddings, similarity, chunking | Modeltraining van scratch |
| RAG-pipelines, rerankers, evaluatie | “Just dump de hele repo in context” als best practice |
| Vector stores (conceptueel) | Vendor sales sheets |

## Bestanden

| Bestand | Status | Over |
|---------|--------|------|
| [embeddings.md](embeddings.md) | stub | Wat een embedding is; maten; modelkeuze |
| [rag.md](rag.md) | stub | Retrieve → augment → generate; failure modes |

## Leesvolgorde

embeddings → rag → contrast met JIT-docs in Agent Engineering (P2, §10).
