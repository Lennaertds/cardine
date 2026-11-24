# Tool-use en memory

> **Rol:** Hoe agents externe acties doen en toestand bewaren over beurten.
> **Niet hier:** MCP-draadprotocol ([protocollen.md](protocollen.md)); RAG als kennisbron ([../retrieval/rag.md](../retrieval/rag.md)).

## Te schrijven

- Function/tool calling vs free-form “doe maar een shell”
- Short-term (context window) vs long-term (files, DB, vector)
- Working memory bij multi-turn hybrid/agentic checkpoints (pointer §35)
- SWE-agent / ACI-ideeën (§19): interface-design > rauwe tools
- Relatie tot harness tax (§30): elke toolroundtrip kost
- **Externe verbatim memory (les):** MemPalace — wings/rooms/drawers, BM25+vector, hooks vóór compaction (**§52**). Contrast: kit-SSOT blijft curated docs/ADR’s, niet chat-dumps

## Geen actie

Gedekt door bestaande kit-patronen (tools via de IDE-agent); geen MemPalace-default zonder meting.
