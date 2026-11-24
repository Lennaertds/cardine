# RAG (Retrieval-Augmented Generation)

> **Rol:** Architectuur waarbij opgehaalde passages de prompt vullen vóór generatie.
> **Niet hier:** pure prompt-caching ([../inference/caching.md](../inference/caching.md)).

## Te schrijven

- Classic loop: index → retrieve → (rerank) → generate
- Failure modes: wrong chunk, outdated index, context stuffing
- Agentic RAG / iterative retrieval (kort)
- Wanneer RAG vs fine-tune vs betere docs/JIT (Agent Engineering)
- Evaluatie: faithfulness, citation, latency

## Wat kan naar de standaard

Meestal **geen actie**: projectdocs + JIT dekken code-agents; RAG is apart productpatroon.
