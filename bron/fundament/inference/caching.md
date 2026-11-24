# Caching bij prompts en decode

> **Rol:** Wanneer berekening of KV **hergebruikt** wordt i.p.v. opnieuw geprefilld.
> **Niet hier:** RAG-index ([../retrieval/rag.md](../retrieval/rag.md)); documentatie-JIT (P2).

## Te schrijven

- **KV-cache:** wat er per decode-stap bewaard wordt; VRAM-druk
- **Prefix / prompt cache:** gedeelde system prompts & harness-preambles (SGLang RadixAttention, API prompt caching, DeepSeek cache-hit verhalen)
- Multi-turn agents: waarom hoge cache-hit = lagere prefill-kost
- Verschil: *cache* (engine) vs *context engineering* (wat je überhaupt meestuurt)
- Trade-offs: invalidatie, privacy, sticky routing

## Wat kan naar de standaard

Indirect: stabiele, korte always-on prefix in AGENTS.md maximaliseert cachebaarheid (P2, P25). Geen aparte cache-config in de kit.
