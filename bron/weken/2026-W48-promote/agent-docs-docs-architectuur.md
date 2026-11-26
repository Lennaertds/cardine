# Promote drafts — 2026-W48 — Agent-docs & docs-architectuur

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### DocSEAM: Bidirectional Cross-Page Encoding for Multi-Page Document Understanding

- **Link:** https://arxiv.org/abs/2611.34420
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Agent-docs & docs-architectuur _(kw)_
- **Gist (HF ai_summary):** DocSEAM is a lightweight module between a pretrained vision encoder and language model that enriches page visual tokens with neighboring-page context via center-anchored masked self-attention, improving multi-page document VQA and reducing boundary sensitivity.
- **Abstract:** Multi-page document vision-language models encode each page independently, creating a feature-level discontinuity at page boundaries: visual tokens are formed without access to content on adjacent pages, and the language model must reason over these page representations formed in isolation. We introduce DocSEAM (Document Selective Enrichment via Anchored Masking), a lightweight module inserted between a pretrained vision encoder and the language model that injects the inductive bias of local cross-page context into visual representations. For each page, DocSEAM forms a local triplet with its…
- **Upvotes:** 20

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: DocSEAM: Bidirectional Cross-Page Encoding for Multi-Page Document Understanding
kern: DocSEAM is a lightweight module between a pretrained vision encoder and language model that enriches page visual tokens with neighboring-page context via center-anchored masked self-attention, improving multi-page document VQA and reducing boundary sensitivity.
relevance: multi-page document understanding
```

**URL check:** https://arxiv.org/abs/2611.34420

