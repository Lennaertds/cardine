# Promote drafts — 2026-W48 — Product / tooling-rand

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### HarnessSecurity-Bench: Do Security Mechanisms Really Protect Coding Agent Harnesses?

- **Link:** https://arxiv.org/abs/2610.07639
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** HarnessSecurity benchmarks coding agent harness security mechanisms, finding that auto-approve sharply increases attack success while isolation and allowlisting reduce harm with varying utility trade-offs.
- **Abstract:** Coding agent harnesses mediate tool use and authorize actions, yet their security mechanisms and runtime effects remain incompletely characterized. We present HarnessSecurity, the first systematic empirical study and benchmark of open- and closed-source coding agent harnesses. First, we derive a ten-mechanism taxonomy and then assess 400 harness-mechanism cells using independent ratings by researchers and large language model (LLM) judges. We find that about half of confirmed mechanism implementations are opt-in, while closed-source harnesses exhibit substantial evidence gaps. Second, we intr…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: HarnessSecurity-Bench: Do Security Mechanisms Really Protect Coding Agent Harnesses?
kern: HarnessSecurity benchmarks coding agent harness security mechanisms, finding that auto-approve sharply increases attack success while isolation and allowlisting reduce harm with varying utility trade-offs.
relevance: do harness security mechanisms work
```

**URL check:** https://arxiv.org/abs/2610.07639


### EMHO: EMbodied Agent Harness Optimization via Experience Traces

- **Link:** https://arxiv.org/abs/2610.08432
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** EMHO is a self-evolving framework that improves embodied agent harnesses directly from experience traces by revising monitoring, tool use, and failure responses while keeping the underlying model frozen.
- **Abstract:** Improving embodied agents often focuses on optimizing the underlying model through training, while the surrounding agent harness that controls planning, context, and tool use is typically engineered. We ask whether this harness can instead improve itself directly from experience traces under sparse environmental feedback. We propose EMbodied Agent Harness Optimization (EMHO), a self-evolving framework that keeps the embodied model frozen and iteratively revises its harness by analyzing execution trajectories and prior harness history. EMHO optimizes beyond skills or recovery prompts, modifyin…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: EMHO: EMbodied Agent Harness Optimization via Experience Traces
kern: EMHO is a self-evolving framework that improves embodied agent harnesses directly from experience traces by revising monitoring, tool use, and failure responses while keeping the underlying model frozen.
relevance: embodied harness optimization from traces
```

**URL check:** https://arxiv.org/abs/2610.08432


### RRSI: Regularized Recursive Self-Improvement of Agent Harnesses

- **Link:** https://arxiv.org/abs/2609.24972
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** Regularized recursive self-improvement of agent harnesses improves out-of-distribution performance by constraining edit proposals and selections to favor reusable mechanisms over benchmark-specific memorization.
- **Abstract:** An LLM agent's capability is largely magnified by its harness, namely the prompts, control flow, tooling, memory, and context management surrounding the frozen backbone model. Recent methods increasingly automate this process by iteratively proposing and selecting component-wise edits of an agent harness, practically establishing a form of recursive self-improvement (RSI) at the agent-system level. However, such recursive evolution may overfit by memorizing the training tasks, showing large in-distribution gains that shrink or even vanish on out-of-distribution benchmarks. We introduce Regula…
- **Upvotes:** 163

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: RRSI: Regularized Recursive Self-Improvement of Agent Harnesses
kern: Regularized recursive self-improvement of agent harnesses improves out-of-distribution performance by constraining edit proposals and selections to favor reusable mechanisms over benchmark-specific memorization.
relevance: regularized recursive harness improvement
```

**URL check:** https://arxiv.org/abs/2609.24972


### EGI-BENCH: An Enterprise General Intelligence Benchmark Suite

- **Link:** https://arxiv.org/abs/2610.27234
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** EGI-BENCH unifies eight enterprise agent benchmarks into a single suite with budgeted execution modes and defines a six-dimensional EGI Score to compare frontier LLMs across diverse agentic capabilities.
- **Abstract:** Enterprise adoption of LLMs in agentic workflows is gated by evaluations that span a wide arc of abilities: CRM operations, heterogeneous-document retrieval, personal data understanding, multi-turn planning, tool use, function calling, long-horizon research, and long-context software engineering. These evaluations live today in separate repositories with divergent runners, dependencies, and scoring conventions, which makes cross-benchmark comparison difficult and obscures what a single aggregate number actually represents. We release EGI-BENCH, a unified LLM agent benchmark suite that consoli…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: EGI-BENCH: An Enterprise General Intelligence Benchmark Suite
kern: EGI-BENCH unifies eight enterprise agent benchmarks into a single suite with budgeted execution modes and defines a six-dimensional EGI Score to compare frontier LLMs across diverse agentic capabilities.
relevance: enterprise agent benchmark suite
```

**URL check:** https://arxiv.org/abs/2610.27234


### GameDojo: Benchmarking Real-Time Interactive Agents in Video Games

- **Link:** https://arxiv.org/abs/2611.30771
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** GameDojo is a controllable benchmark of 120 boss encounters across 20 games with 600 hours of gameplay trajectories, showing frontier models struggle in real-time interaction while training GameDojo-4B achieves frontier performance and policy transfer across bosses.
- **Abstract:** Interactive intelligence requires agents to act on observations and adapt to the consequences of actions. Studying these abilities calls for diverse, challenging tasks under controlled conditions. We introduce GameDojo, a controllable interactive gameplay benchmark of 120 boss encounters across 20 games for evaluating model capabilities, learning algorithms, and agent harnesses. Coding agents reconstruct the environments and write gameplay scripts, producing GameDojo-Data with 600 hours of gameplay trajectories. Experiments reveal substantial challenges for frontier models, especially in real…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: GameDojo: Benchmarking Real-Time Interactive Agents in Video Games
kern: GameDojo is a controllable benchmark of 120 boss encounters across 20 games with 600 hours of gameplay trajectories, showing frontier models struggle in real-time interaction while training GameDojo-4B achieves frontier performance and policy transfer across bosses.
relevance: real-time agents in games benchmark
```

**URL check:** https://arxiv.org/abs/2611.30771


### Real2SimLab: A Unified Platform for Real-to-Simulation Transfer

- **Link:** https://arxiv.org/abs/2611.34849
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Abstract:** Real-to-simulation transfer, which builds simulations from real-world observations, has long been studied in research and industry. Recently, coding agents have become capable of generating simulation programs from video recordings, and several benchmarks have been proposed to evaluate them. However, each individual benchmark defines its own inputs, deliverables, and scoring pipeline. This leads to N times M integrations when evaluating N methods on M benchmarks. To this end, we present Real2SimLab, a unified platform for real-to-simulation transfer. It evaluates a method by running its writt…
- **Upvotes:** 27

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Real2SimLab: A Unified Platform for Real-to-Simulation Transfer
kern: Real-to-simulation transfer, which builds simulations from real-world observations, has long been studied in research and industry. Recently, coding agents have become capable of generating simulation programs from video recordings, and several benchmarks have been proposed to evaluate them. However, each individual…
relevance: real2sim transfer
```

**URL check:** https://arxiv.org/abs/2611.34849


### Puzzling-Bench: Evaluating Language Models on 23,777 Human-Written Puzzles with Community-Verified Answers

- **Link:** https://arxiv.org/abs/2611.34331
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Abstract:** We introduce Puzzling-Bench, a benchmark of 23,777 puzzles with community-verified answers drawn from the Puzzling Stack Exchange archive (2014-2026): riddles, ciphers, logic grids, lateral-thinking problems, wordplay and recreational mathematics, a third of them with images. Every puzzle carries the answer accepted by its author, a short reference answer taken from it (LLM-extracted for the evaluation sets and checked on a 50-puzzle human review), the author's own hints, community tags and a creation date, so that the benchmark supports hint ablations, category analysis and a rolling post-cu…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Puzzling-Bench: Evaluating Language Models on 23,777 Human-Written Puzzles with Community-Verified Answers
kern: (skip: puzzle benchmark)
relevance: puzzle benchmark
```

**URL check:** https://arxiv.org/abs/2611.34331


### WeMM-Video: Pushing the Frontiers of Open-Source Omni-Modal Video Understanding

- **Link:** https://arxiv.org/abs/2611.26409
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** WeMM-Video is a family of Chinese-English bilingual omni-modal foundation models that unify text, image, audio, and video processing for joint audio-visual perception and reasoning, using hybrid thinking modes and large-scale training to achieve strong open-source video understanding results.
- **Abstract:** Video understanding, particularly with accompanying audio, remains a central challenge in multimodal intelligence. In this report, we introduce WeMM-Video, a family of Chinese-English bilingual omni-modal foundation models spanning 2B, 4B, 9B, and 35B-A3B variants. Centering on joint audio-visual perception and reasoning, WeMM-Video unifies text, image, audio, and video processing within a hybrid-thinking paradigm, seamlessly supporting both a non-thinking instruct mode for fast, direct responses and a thinking mode for explicit step-by-step reasoning. The models are trained on a large-scale…
- **Upvotes:** 49

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: WeMM-Video: Pushing the Frontiers of Open-Source Omni-Modal Video Understanding
kern: (skip: omni-modal video)
relevance: omni-modal video
```

**URL check:** https://arxiv.org/abs/2611.26409


### WideSWE: Can Coding Agents Coordinate Changes Across Repositories?

- **Link:** https://arxiv.org/abs/2609.33382
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** WideSWE introduces a benchmark for evaluating coding agents on cross-repository software tasks, finding that joint execution across repositories improves implementation and verification compared to independent sequential work.
- **Abstract:** Coding-agent evaluation has progressed from resolving individual issues to carrying out long-horizon development, yet task completion is still largely assessed within a single codebase. In software ecosystems, many features and bug fixes require coordinated changes across multiple repositories. We introduce WideSWE to evaluate coding agents on such cross-repository tasks. Mining and reviewing changes across 103 software ecosystems yields 120 real-world tasks, balanced between 60 bug fixes and 60 features. We derive prompts from related issues and pull requests. We systematically review and ad…
- **Upvotes:** 19

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: WideSWE: Can Coding Agents Coordinate Changes Across Repositories?
kern: WideSWE introduces a benchmark for evaluating coding agents on cross-repository software tasks, finding that joint execution across repositories improves implementation and verification compared to independent sequential work.
relevance: cross-repository coordination
```

**URL check:** https://arxiv.org/abs/2609.33382


### Automating ML for Science: Can Frontier Agents Climb Scientific Hills in the Wild?

- **Link:** https://arxiv.org/abs/2610.28763
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Gist (HF ai_summary):** Agent4Sci evaluates frontier coding agents on scientific ML benchmarks, finding they improve results mainly through engineering tricks rather than domain insight, with targeted skills significantly boosting performance.
- **Abstract:** Frontier coding agents are increasingly framed as end-to-end automated researchers, and ML for science offers a demanding test of that promise: improving a scientific model often requires domain insight beyond routine ML engineering. We introduce Agent4Sci, a long-horizon testbed for measuring how far today's agents can improve the published best models on scientific ML benchmarks, spanning 20 benchmarks across 11 domains. Rather than ranking agents on a leaderboard, Agent4Sci asks what kinds of progress agents can make on these tasks under in-the-wild conditions, and where they fall short. E…
- **Upvotes:** 19

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Automating ML for Science: Can Frontier Agents Climb Scientific Hills in the Wild?
kern: Agent4Sci evaluates frontier coding agents on scientific ML benchmarks, finding they improve results mainly through engineering tricks rather than domain insight, with targeted skills significantly boosting performance.
relevance: agents on scientific ML benchmarks
```

**URL check:** https://arxiv.org/abs/2610.28763


### SmartLens: Turning AI Agent Changes into Learning, Review, and Risk Signals in the IDE

- **Link:** https://arxiv.org/abs/2611.34377
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** Product / tooling-rand _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: SmartLens: Turning AI Agent Changes into Learning, Review, and Risk Signals in the IDE
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34377

