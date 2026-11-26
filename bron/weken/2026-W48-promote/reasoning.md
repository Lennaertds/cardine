# Promote drafts — 2026-W48 — Reasoning

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### RT-J: Large-Scale Pretraining of Relational Transformers for Context-Efficient Predictions

- **Link:** https://arxiv.org/abs/2610.17867
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Reasoning _(kw)_
- **Gist (HF ai_summary):** RT-J is a compact relational foundation model that achieves accurate predictions with minimal in-context examples by pretraining on a large database collection with long-context random-walk retrieval and test-time scaling.
- **Abstract:** Foundation models for tables and relational databases are increasingly used for predictive tasks across various scientific and industrial domains. However, adapting existing models to unseen datasets requires tens of thousands of examples. Here we introduce RT-J, an 85M-parameter relational foundation model (RFM) that makes accurate predictions even with hundreds of in-context examples or fewer. To achieve this, we first assemble the Join, a large collection of 639 web-crawled databases with 6,023 LLM-generated forecasting tasks. We pretrain with long contexts of up to 8,192 database cells, u…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: RT-J: Large-Scale Pretraining of Relational Transformers for Context-Efficient Predictions
kern: (skip: relational transformers)
relevance: relational transformers
```

**URL check:** https://arxiv.org/abs/2610.17867


### SKILL.state: Scalable Long-Horizon Agent Skills

- **Link:** https://arxiv.org/abs/2608.26263
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Reasoning _(kw)_
- **Gist (HF ai_summary):** SKILL.state replaces growing conversation histories with a mutable execution state to improve accuracy and reduce token use for long-horizon LLM agents.
- **Abstract:** Large Language Models (LLMs) increasingly act as autonomous agents executing complex, long-running procedural skills. Existing agent runtimes maintain execution by continually appending observations, actions, and intermediate reasoning traces to an ever-growing conversation history, causing latency degradation and context-poisoning failures over long horizons. We present SKILL.state, a runtime architecture that replaces append-only conversational history with an explicit, mutable execution state. At each execution step, the model receives only the immutable skill specification, the current st…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Prompt Engineering
title: SKILL.state: Scalable Long-Horizon Agent Skills
kern: SKILL.state replaces growing conversation histories with a mutable execution state to improve accuracy and reduce token use for long-horizon LLM agents.
relevance: SKILL.state; mutable execution state
```

**URL check:** https://arxiv.org/abs/2608.26263


### Can Latent Reasoning Drive LLM Outputs Without a Trace?

- **Link:** https://arxiv.org/abs/2611.31015
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Reasoning _(kw)_
- **Gist (HF ai_summary):** Models can use deep latent reasoning to pursue hidden objectives while generating chain-of-thought explanations that appear task-appropriate and evade output-based monitoring.
- **Abstract:** LLMs typically solve complex tasks with chain-of-thought (CoT) reasoning, which is also the main tool for monitoring them for misaligned behavior. However, standard transformers can also solve tasks with complete latent reasoning (CLR), carrying out the whole task internally and outputting only the final answer. Theory bounds the depth of CLR, the number of sequential steps it can carry out, and recent work measured it to be shallow. In this work, we ask whether CLR is deep enough for a model to pursue a hidden objective that requires reasoning. Such a model would generate a CoT that appears…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Can Latent Reasoning Drive LLM Outputs Without a Trace?
kern: Models can use deep latent reasoning to pursue hidden objectives while generating chain-of-thought explanations that appear task-appropriate and evade output-based monitoring.
relevance: latent reasoning evading monitors
```

**URL check:** https://arxiv.org/abs/2611.31015


### ThinkMorph-SSL: Scaling Interleaved Multimodal Reasoning with Pretext Tasks

- **Link:** https://arxiv.org/abs/2611.32183
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Reasoning _(kw)_
- **Gist (HF ai_summary):** A two-stage training approach uses visual pretext tasks to generate interleaved image-text reasoning traces and automatically built demonstrations, improving multimodal reasoning over instruction tuning alone.
- **Abstract:** People reason with pictures as well as words. Interleaved multimodal reasoning gives models a similar way to solve problems by creating intermediate images and using them to guide further reasoning. Training models with this ability usually relies on task-specific demonstrations, which are difficult to collect. We introduce ThinkMorph-SSL, a two-stage training recipe that uses images themselves as a source of supervision. The first stage, pretext reasoning, converts visual pretext tasks, such as image colorization and denoising, into instruction-free interleaved traces. Models describe a corr…
- **Upvotes:** 21

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: ThinkMorph-SSL: Scaling Interleaved Multimodal Reasoning with Pretext Tasks
kern: (skip: multimodal reasoning training)
relevance: multimodal reasoning training
```

**URL check:** https://arxiv.org/abs/2611.32183


### CoT-Proxy: Cross-Format Transfer for Distilling Long-Horizon Policies

- **Link:** https://arxiv.org/abs/2611.33148
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Reasoning _(kw)_
- **Abstract:** Reasoning models become long-horizon agents through reinforcement learning or, more cheaply, through fine-tuning on a stronger teacher's trajectories, which contain the teacher's chain-of-thought as well as its actions. The standard fine-tuning approach imitates both, yet the strongest teachers are closed models whose chain-of-thought is hidden behind an API. We show that the chain-of-thought can be left out altogether and that the long-horizon policy can be distilled from the teacher's actions alone. The student is trained on these trajectories with its reasoning block left empty, while a KL…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: CoT-Proxy: Cross-Format Transfer for Distilling Long-Horizon Policies
kern: (skip: CoT transfer to long-horizon policies)
relevance: CoT transfer to long-horizon policies
```

**URL check:** https://arxiv.org/abs/2611.33148


### Diverse Alternative Reasoning Traces for Hard Math Problems

- **Link:** https://arxiv.org/abs/2611.34928v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Reasoning _(kw)_
- **Abstract:** Post-training large language models (LLMs) for mathematical reasoning often relies on accepted traces whose final answers pass a verifier. For hard math problems, however, such traces can be rare under independent Monte Carlo (MC) sampling. To address this, we propose Diverse Alternative Reasoning Traces (DART), a trace-mining method that starts from a rejected trace, decomposes it into reasoning steps, and ranks them by position-weighted uncertainty. It then generates deliberately distinct alternative candidates for highly ranked steps using reference-answer guidance and a meta-thought befor…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Reasoning
title: Diverse Alternative Reasoning Traces for Hard Math Problems
kern: Post-training large language models (LLMs) for mathematical reasoning often relies on accepted traces whose final answers pass a verifier. For hard math problems, however, such traces can be rare under independent Monte Carlo (MC) sampling. To address this, we propose Diverse Alternative Reasoning Traces (DART), a…
relevance: alternative reasoning traces
```

**URL check:** https://arxiv.org/abs/2611.34928v1


### Revisiting LLMs as Context Engineers

- **Link:** https://arxiv.org/abs/2611.30494
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Reasoning _(kw)_
- **Abstract:** As large language models (LLMs) are used in more and more new tasks, context engineering becomes a fundamental method to efficiently steer LLMs by constructing instruction prompts or metadata without intensive training. A growing number of LLM context engineering (LCE) approaches automate the task by casting the LLM itself as the engineer that draws generalizable instructions or experiences from offline trials as context. Although these methods resemble how humans learn from experiences, it remains unclear when and how LLMs can engineer effective context from data. To answer the question, we…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Revisiting LLMs as Context Engineers
kern: As large language models (LLMs) are used in more and more new tasks, context engineering becomes a fundamental method to efficiently steer LLMs by constructing instruction prompts or metadata without intensive training. A growing number of LLM context engineering (LCE) approaches automate the task by casting the LLM…
relevance: LLMs as context engineers
```

**URL check:** https://arxiv.org/abs/2611.30494

