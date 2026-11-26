# Promote drafts — 2026-W48 — Software design (AI-tijdperk)

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### Agent Lightning v1.0: Towards Harnessed Agentic RL

- **Link:** https://arxiv.org/abs/2608.17528
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Gist (HF ai_summary):** Agent Lightning v1.0 enables reproducible reinforcement learning for arbitrary agent harnesses, substantially improving coding-agent performance with minimal data and compute.
- **Abstract:** Modern agents operate inside agent harnesses that manage tools, context, and control flow, making the harness a critical part of the agent system. Our original Agent Lightning introduced a disaggregated architecture that connects arbitrary agents to RL training through an LLM endpoint proxy, an approach later adopted by frameworks such as verl Uni-Agent, AReaL 2.0, slime, and Polar. We refer to this paradigm as harnessed agentic RL, where the deploy-time harness directly participates in model post-training. Harnessed agentic RL differs fundamentally from traditional agentic RL: the harness, r…
- **Upvotes:** 35

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Agent Lightning v1.0: Towards Harnessed Agentic RL
kern: Agent Lightning v1.0 enables reproducible reinforcement learning for arbitrary agent harnesses, substantially improving coding-agent performance with minimal data and compute.
relevance: agentic RL on arbitrary harnesses
```

**URL check:** https://arxiv.org/abs/2608.17528


### Trial by Trace: Benchmarking AI Agent Harnesses for Reliability and Failure Attribution

- **Link:** https://arxiv.org/abs/2610.32285
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Gist (HF ai_summary):** TraceTrial-Bench evaluates agent harness reliability across seven components using mechanism-oriented tasks, trajectory tracing, and failure attribution to compare harness designs and diagnose failures.
- **Abstract:** LLM agents are increasingly used to solve real-world problems, and their effectiveness depends on both the underlying models and the harnesses that support their operation. However, most existing benchmarks focus on model capabilities and overall agent performance, with limited attention to the evaluation of agent harnesses. To address this gap, we introduce TraceTrial-Bench, which organizes harness reliability into seven components covering context, execution, governance, lifecycle, observability, tools, and verification. We construct 95 expert-level, mechanism-oriented tasks with executable…
- **Upvotes:** 35

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Trial by Trace: Benchmarking AI Agent Harnesses for Reliability and Failure Attribution
kern: TraceTrial-Bench evaluates agent harness reliability across seven components using mechanism-oriented tasks, trajectory tracing, and failure attribution to compare harness designs and diagnose failures.
relevance: harness reliability and failure attribution
```

**URL check:** https://arxiv.org/abs/2610.32285


### The Price of Intelligence: A Quality-Adjusted Price Index for AI Services

- **Link:** https://arxiv.org/abs/2608.29843
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Gist (HF ai_summary):** Quality-adjusted price indices reveal that AI inference costs have fallen far faster than standard methods capture, with reasoning models causing buyer prices to stagnate despite lower token rates.
- **Abstract:** Posted prices for AI inference have fallen steadily since 2024, yet the measured speed of that fall depends almost entirely on the method of measurement. This paper constructs quality-adjusted price indices for the AI inference market from public data. The panel assembles 21,024 posted-price observations across 3,208 models and 86 providers and joins them to 4,605 benchmark scores through a latent quality index estimated from benchmark response patterns, so the quality ladder of the hedonic tradition is built here from evaluations in place of product characteristics. Measured by the matched-m…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Industrie
title: The Price of Intelligence: A Quality-Adjusted Price Index for AI Services
kern: Quality-adjusted price indices reveal that AI inference costs have fallen far faster than standard methods capture, with reasoning models causing buyer prices to stagnate despite lower token rates.
relevance: quality-adjusted AI price index
```

**URL check:** https://arxiv.org/abs/2608.29843


### Moving Generality from Model to Modeler: LLM Agents for PHM on a Deployment-Style Benchmark

- **Link:** https://arxiv.org/abs/2611.25252
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Abstract:** Coding agents built on large language models (LLMs) now help develop many models published as general solutions. Should generality instead reside in the agent that builds a model for each new task? We examine this question in prognostics and health management (PHM), where every model must work on unseen equipment. Our deployment-style benchmark, NextUnit-Bench, covers 24 public datasets split into 58 folds that hold out units or operating conditions; each agent has two hours to deliver an executable predictor, then run on the hidden units. First, frontier agents outperform AutoML, which reach…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Moving Generality from Model to Modeler: LLM Agents for PHM on a Deployment-Style Benchmark
kern: Coding agents built on large language models (LLMs) now help develop many models published as general solutions. Should generality instead reside in the agent that builds a model for each new task? We examine this question in prognostics and health management (PHM), where every model must work on unseen equipment.…
relevance: generality in the modeler
```

**URL check:** https://arxiv.org/abs/2611.25252


### The Linguistic Knowledge Benchmark: Do Language Models Know the Foundations of Early-Grade Literacy?

- **Link:** https://arxiv.org/abs/2611.34823v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Abstract:** Many languages of instruction in low- and middle-income countries (LMICs) are poorly represented in the data used to train language models. Before these models can support early-grade literacy in such languages, we need to know whether they hold the linguistic knowledge of each language that literacy teaching relies on. To test this, we present the Linguistic Knowledge Benchmark and the reproducible, largely automated pipeline that turns curriculum documents, teacher guides and pupil books into a vetted question set organised on a fixed grid of nine linguistic domains and seven grade levels.…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: The Linguistic Knowledge Benchmark: Do Language Models Know the Foundations of Early-Grade Literacy?
kern: (skip: linguistic knowledge benchmark)
relevance: linguistic knowledge benchmark
```

**URL check:** https://arxiv.org/abs/2611.34823v1


### K2-Horizon: A Frontier Fleet of Open Source Language Models

- **Link:** https://arxiv.org/abs/2611.21003
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Abstract:** We present K2-Horizon, a fleet of six fully open language models, from a 0.9B dense model to a 375B-A23B MoE, built for general-purpose reasoning and agentic work across math and science, software engineering, deep research, office automation, and beyond. The models lead or are competitive with strong open models of their size on agentic and coding benchmarks. On the modeling side, to strengthen reasoning, we introduce Mixture-of-Value Attention (MoVA), applying MoE to attention value projections, and softplus attention gating, a more flexible, theoretically motivated gate. Our 36B-A4B model…
- **Upvotes:** 94

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Industrie
title: K2-Horizon: A Frontier Fleet of Open Source Language Models
kern: We present K2-Horizon, a fleet of six fully open language models, from a 0.9B dense model to a 375B-A23B MoE, built for general-purpose reasoning and agentic work across math and science, software engineering, deep research, office automation, and beyond. The models lead or are competitive with strong open models of…
relevance: open model fleet
```

**URL check:** https://arxiv.org/abs/2611.21003


### Do Coding Agents Catch Their Own Bugs? (They Don't.)

- **Link:** https://arxiv.org/abs/2611.01181
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Gist (HF ai_summary):** Foresight-SWE is a benchmark that evaluates whether coding agents can anticipate and prevent unstated defects introduced by code changes, revealing that current models perform poorly on this foresight task.
- **Abstract:** In software development, engineers need to foresee and fix potential problems with their code that are not explicitly specified in requirements---such as pre-emptively considering vulnerabilities or other bugs from a code change. But current benchmarks often do not measure these future-looking consequences. We introduce Foresight-SWE, a benchmark for measuring whether coding agents can anticipate and address unstated problems during software engineering tasks. Foresight-SWE consists of 212 samples spanning 4 languages and 35 popular open-source repositories. Each sample contains two pull requ…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Do Coding Agents Catch Their Own Bugs? (They Don't.)
kern: Foresight-SWE is a benchmark that evaluates whether coding agents can anticipate and prevent unstated defects introduced by code changes, revealing that current models perform poorly on this foresight task.
relevance: agents anticipating their own defects
```

**URL check:** https://arxiv.org/abs/2611.01181


### Doing More with Less Tokens: Hierarchical Reinforcement Learning for Efficient Coding Agents

- **Link:** https://arxiv.org/abs/2609.38885
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Gist (HF ai_summary):** HERO is a reinforcement learning framework that trains coding agents to resolve software engineering tasks with high success rates while reducing token usage by promoting efficient reasoning patterns.
- **Abstract:** Recently, coding agents have emerged as a dominant paradigm for real-world software engineering (SWE) scenarios, which solve complex tasks through multi-turn interactions with development environments. However, frequent interactions with environments would inevitably introduce substantial token overhead, leading to high usage costs and latency. Although recent studies have explored reducing token usage by context manipulation and interaction limits at inference time, these approaches focus on improving token efficiency while overlooking the risk of discarding task-relevant information, thus s…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Doing More with Less Tokens: Hierarchical Reinforcement Learning for Efficient Coding Agents
kern: HERO is a reinforcement learning framework that trains coding agents to resolve software engineering tasks with high success rates while reducing token usage by promoting efficient reasoning patterns.
relevance: token-efficient coding-agent RL
```

**URL check:** https://arxiv.org/abs/2609.38885


### Zero2Repo: Can Coding Agents Build Repositories from Scratch?

- **Link:** https://arxiv.org/abs/2609.38269
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Gist (HF ai_summary):** Zero2Repo is a language-agnostic benchmark that evaluates coding agents on building complete repositories from specifications, using hidden execution-based tests and adversarial validation across multiple programming ecosystems.
- **Abstract:** Coding agents are increasingly asked to build software rather than patch it, yet benchmarks for from-scratch repository construction are mostly limited to a single language and depend on manually curated tasks. We introduce Zero2Repo, a benchmark in which an agent receives a product requirements document, an interface contract, and an empty workspace, and must deliver a complete repository in the project's native ecosystem. Tasks are produced by a language-agnostic authoring pipeline that converts real, version-pinned open-source projects into behavioral specifications, reproducible environme…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: Zero2Repo: Can Coding Agents Build Repositories from Scratch?
kern: Zero2Repo is a language-agnostic benchmark that evaluates coding agents on building complete repositories from specifications, using hidden execution-based tests and adversarial validation across multiple programming ecosystems.
relevance: repositories from scratch
```

**URL check:** https://arxiv.org/abs/2609.38269


### AdaPRA: Process Reward Agents with Adaptive Rubrics for Data Science

- **Link:** https://arxiv.org/abs/2610.33245
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Software design (AI-tijdperk) _(kw)_
- **Gist (HF ai_summary):** AdaPRA improves data science agents via persistent knowledge accumulation and adaptive rubric-guided process supervision, reducing errors and boosting leaderboard performance.
- **Abstract:** Data science agents can automate end-to-end machine learning workflows, yet they remain far from competitive on human leaderboards. Agents make process errors such as insufficient exploration, unsound validation, coding bugs, and poor use of a fixed budget (re-running the same exploratory data analysis and baseline models in every attempt). We propose AdaPRA to address these issues: a persistent coding agent harness that accumulates knowledge across attempts on the same task, with rubric-guided process supervision that identifies and corrects errors. Our process reward agent audits the agent'…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: AdaPRA: Process Reward Agents with Adaptive Rubrics for Data Science
kern: AdaPRA improves data science agents via persistent knowledge accumulation and adaptive rubric-guided process supervision, reducing errors and boosting leaderboard performance.
relevance: data-science agents; rubric supervision
```

**URL check:** https://arxiv.org/abs/2610.33245

