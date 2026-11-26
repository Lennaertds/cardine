# Promote drafts — 2026-W48 — Graph Engineering

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### Humanize: Judgement Engineering for Agentic Coding

- **Link:** https://arxiv.org/abs/2610.08900
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Graph Engineering _(kw)_
- **Gist (HF ai_summary):** Humanize is a multi-agent orchestration framework for agentic coding that uses explicit mechanical gates and independent review to improve reliability, achieving top results in competitive programming and systems benchmarks.
- **Abstract:** Agentic coding makes code generation cheap, but reliable completion remains difficult: the agent that writes the code is a weak judge of whether it is done. We present Humanize, a multi-agent orchestration workflow for agentic coding built around judgement engineering: explicit, mechanically enforced decisions at the boundaries between planning, implementation, review, and learning. A human approves a plan contract, a builder agent implements it in rounds, and a reviewer agent from another vendor decides completion; deterministic hooks, not a model, route work between these roles and enforce…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Humanize: Judgement Engineering for Agentic Coding
kern: Humanize is a multi-agent orchestration framework for agentic coding that uses explicit mechanical gates and independent review to improve reliability, achieving top results in competitive programming and systems benchmarks.
relevance: judgement engineering; mechanical gates
```

**URL check:** https://arxiv.org/abs/2610.08900


### LaFlash: Capacity-Driven Acceleration for Coding Agent Workflows via QLC-HBF

- **Link:** https://arxiv.org/abs/2611.22746
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Graph Engineering _(kw)_
- **Abstract:** As large language models (LLMs) evolve toward agentic AI, coding agents are emerging as memory-intensive workloads that repeatedly reuse persistent states, including contexts and KV caches. Emerging agentic workflows, including Loop/Graph Engineering, cause state amplification through frequent active/dormant transitions, increasing memory pressure. Evicted states incur costly recomputation upon reactivation, particularly under long-context, short-decode workloads. This motivates Capacity-Driven Acceleration (CDA), which explicitly accounts for state amplification to allocate memory capacity b…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Inference
title: LaFlash: Capacity-Driven Acceleration for Coding Agent Workflows via QLC-HBF
kern: As large language models (LLMs) evolve toward agentic AI, coding agents are emerging as memory-intensive workloads that repeatedly reuse persistent states, including contexts and KV caches. Emerging agentic workflows, including Loop/Graph Engineering, cause state amplification through frequent active/dormant…
relevance: KV/state capacity for coding-agent serving
```

**URL check:** https://arxiv.org/abs/2611.22746

