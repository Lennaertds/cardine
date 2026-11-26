# Digest — bronnen (live)

> **Rol:** Feeds die `make digest-fetch` / `digest-day` ophaalt. RSS/Atom **of** HF JSON-API (`/api/…`).
> **Niet hier:** curatie (`proposals/`, `../weken/`, `../bronnen.md` §).

| Bron | Soort | Frequentie | Notitie |
|------|-------|------------|---------|
| `<https://rss.arxiv.org/rss/cs.AI+cs.LG+cs.CL>` | papers | daily | AI + ML + NLP — RSS vaak leeg in weekend |
| `<https://rss.arxiv.org/rss/cs.SE>` | papers | daily | Software engineering / agentic coding |
| `<https://rss.arxiv.org/rss/cs.MA>` | papers | daily | Multi-agent |
| `<https://export.arxiv.org/api/query?search_query=cat:cs.AI+OR+cat:cs.LG+OR+cat:cs.CL+OR+cat:cs.SE+OR+cat:cs.MA&sortBy=submittedDate&sortOrder=descending&max_results=50>` | papers | buffer | Atom-API recente 50 (ook weekend) |
| `<https://huggingface.co/api/daily_papers?limit=50>` | papers | daily | HF Daily Papers (curated) |
| `<https://huggingface.co/api/daily_papers?sort=trending&limit=50>` | papers | daily | HF **Trending** (UI: huggingface.co/papers/trending) |
| `<https://huggingface.co/api/papers/search?q=token%20consumption>` | papers | daily | BP hoofdeffect: tokenverbruik |
| `<https://huggingface.co/api/papers/search?q=agent%20harness>` | papers | daily | Topic: agent harness |
| `<https://huggingface.co/api/papers/search?q=context%20engineering>` | papers | daily | Topic: context engineering |
| `<https://huggingface.co/api/papers/search?q=agentic%20coding>` | papers | daily | Topic: agentic coding |
| `<https://huggingface.co/api/papers/search?q=codebase%20indexing>` | papers | daily | BP zoeklaag I2: codebase-index (exact/regex) |
| `<https://huggingface.co/api/papers/search?q=lexical%20retrieval%20code>` | papers | daily | BP zoeklaag I1: grep/lexical vs retrieval |
| `<https://huggingface.co/api/papers/search?q=semantic%20code%20search>` | papers | daily | BP zoeklaag I3: retrieval-alternatief (semantic/embedding) |
| `<https://huggingface.co/api/papers/search?q=repository%20context%20retrieval>` | papers | daily | BP zoeklaag: repo-context voor een coding agent |
| `<https://huggingface.co/api/papers/search?q=coding%20agent%20context>` | papers | daily | BP deelvraag: tokenverdeling (prompt, geschiedenis, file-reads) |
| `<https://huggingface.co/api/papers/search?q=tool%20output%20tokens>` | papers | daily | BP deelvraag: zoek-uitvoer en omvang per toolcall |
| `<https://huggingface.co/api/papers/search?q=repository%20exploration%20coding%20agent>` | papers | daily | BP deelvraag: waar zoeken op loopt (bestanden, stappen) |
| `<https://huggingface.co/api/papers/search?q=token%20cost%20coding%20agent>` | papers | daily | BP deelvraag: tokens per taak; slaagkans als controle |
| `<https://huggingface.co/blog/feed.xml>` | blog | daily | HF blog (tooling / open science) |
| `<https://huggingface.co/api/papers/search?q=sandbox%20coding%20agent>` | papers | daily | Focus: sandboxing van coding agents; **smalle query** — `q=sandbox` alleen levert ook SandboxAQ-reclame |
| `<https://huggingface.co/api/papers/search?q=agent%20safety>` | papers | daily | Focus: agent-safety (runtime-contracten, risico, guardrails) |
| `<https://huggingface.co/api/papers/search?q=prompt%20injection>` | papers | daily | Focus: prompt-injectie / aanvallen op de agent |
| `<https://huggingface.co/api/papers/search?q=document%20parsing>` | papers | daily | Focus: vision & docs — documentparsing, OCR-lagen |
| `<https://huggingface.co/api/papers/search?q=computer%20use%20agent>` | papers | daily | Focus: computer-use agents (perceptie → actie) |

> **Let op — topic-feeds rankeren op relevantie, niet op datum.** `papers/search?q=…`
> geeft 120 treffers van 2017 tot nu; met de standaard `DIGEST_JSON_DAYS=90` blijven er
> daardoor 0–3 per dag over. Een **smalle** query werkt hier beter dan een brede
> (`sandbox coding agent` i.p.v. `sandbox`). Weekbrief: `DIGEST_JSON_DAYS=365 make digest-week`
> haalt oudere relevantie-hits mee.

**Ritueel:** dagelijks `make digest-day` (systemd) → catch-up gemiste HF-dagen → weekbrief in `bron/weken/` → gekozen hits → `bronnen.md` § (geen auto-dump).

YouTube / overig: [`../inbox.md`](../inbox.md) of meteen §.
