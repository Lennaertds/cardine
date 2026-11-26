# Promote drafts — 2026-W48 — Context Engineering

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### HarnessDev: Can LLMs Create and Evolve Their Own Agent Harness?

- **Link:** https://arxiv.org/abs/2609.01437
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** HarnessDev evaluates agents by measuring their ability to build and iteratively improve execution infrastructure rather than final task outputs, revealing that self-built harnesses vary widely in capability and efficiency and transfer poorly across models.
- **Abstract:** As agents move from research prototypes to deployed tools, their capability increasingly depends on model-external execution infrastructure, commonly termed the agent harness. Changing this harness while holding model weights fixed can substantially alter task performance. Current agent evaluations typically report downstream performance under a chosen harness, leaving a model's ability to develop the harness itself comparatively underexplored. We introduce HarnessDev, a benchmark that shifts the unit of evaluation from task outputs to runnable infrastructure. HarnessDev covers two stages. In…
- **Upvotes:** 87

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: HarnessDev: Can LLMs Create and Evolve Their Own Agent Harness?
kern: HarnessDev evaluates agents by measuring their ability to build and iteratively improve execution infrastructure rather than final task outputs, revealing that self-built harnesses vary widely in capability and efficiency and transfer poorly across models.
relevance: agents build their own harness (benchmark)
```

**URL check:** https://arxiv.org/abs/2609.01437


### Harness-RL: Black-Box Reinforcement Learning with Action-Args Decoupling for Central-Agent Multi-Agent Harnesses

- **Link:** https://arxiv.org/abs/2608.29641
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Harness-RL improves multi-agent coordination by separating action and argument optimization and modeling dynamic session structures via interface-level trajectory trees.
- **Abstract:** Large language model agents increasingly solve long-horizon tasks through multi-agent harnesses in which a central agent coordinates specialized sub-agents, tools, and environments. Training the central policy in such a harness raises two challenges. First, an action label is a low-cardinality decision, whereas its args form a high-dimensional conditional sequence; optimizing both with a shared sequence-level signal can produce conflicting gradients. Second, dynamic scheduling creates interdependent sessions with branches, parallel calls, and rewritten contexts, which cannot be faithfully red…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Harness-RL: Black-Box Reinforcement Learning with Action-Args Decoupling for Central-Agent Multi-Agent Harnesses
kern: Harness-RL improves multi-agent coordination by separating action and argument optimization and modeling dynamic session structures via interface-level trajectory trees.
relevance: black-box RL, action-args decoupling
```

**URL check:** https://arxiv.org/abs/2608.29641


### HarnessVLN: Unifying Training-Free Embodied Navigation through an Agent Harness

- **Link:** https://arxiv.org/abs/2609.15195
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** HarnessVLN is a zero-shot framework that validates navigation plans against spatial evidence and maintains hierarchical memory to improve embodied navigation without training.
- **Abstract:** Embodied navigation requires agents to interpret visual observations, accumulate spatial knowledge, and execute actions to follow instructions or locate objects. Training-based methods face generalization challenges, while training-free methods exploit multimodal large language models (MLLMs) but often lack mechanisms to reconcile proposed actions with spatial evidence, task progress, and execution failures. We present HarnessVLN, a zero-shot, training-free framework whose Agent Harness coordinates perception, retrieval, grounding, navigation, recovery, and termination through a unified tool…
- **Upvotes:** 20

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: HarnessVLN: Unifying Training-Free Embodied Navigation through an Agent Harness
kern: HarnessVLN is a zero-shot framework that validates navigation plans against spatial evidence and maintains hierarchical memory to improve embodied navigation without training.
relevance: embodied navigation harness
```

**URL check:** https://arxiv.org/abs/2609.15195


### Omni-IO Skills: Harnessing Your Agent Omni-Native

- **Link:** https://arxiv.org/abs/2609.31847
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Omni-IO Skills is a plug-and-play harness that enables general agents to coordinate multimodal workflows across diverse artifacts via hierarchical skills, dependency-aware orchestration, and a persistent asset registry.
- **Abstract:** General-purpose agents can plan, reason, and act over long horizons, yet their production capabilities remain fragmented across text, images, audio, video, documents, 3D assets, and code. Extending a foundation model to additional modalities ties capability growth to costly model updates, while assembling specialist models and tools leaves unresolved how procedures, dependencies, intermediate assets, and cross-turn revisions should be coordinated. We present Omni-IO Skills, a plug-and-play Agent Harness that makes existing agents omni-native through hierarchical Skills, a standardized multimo…
- **Upvotes:** 35

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Omni-IO Skills: Harnessing Your Agent Omni-Native
kern: Omni-IO Skills is a plug-and-play harness that enables general agents to coordinate multimodal workflows across diverse artifacts via hierarchical skills, dependency-aware orchestration, and a persistent asset registry.
relevance: omni-native harness skills
```

**URL check:** https://arxiv.org/abs/2609.31847


### Profiling a Frontier Agent with EBench: From Direct Control to Harness with Policy

- **Link:** https://arxiv.org/abs/2610.35832
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A frontier multimodal language model controls robots directly and via post-trained vision-language-action or world action model policies, showing complementary strengths but suboptimal integration on complex manipulation tasks.
- **Abstract:** Frontier multimodal large language models (MLLMs) can control robots without robot-specific training, but how their capabilities compare and interact with post-trained vision-language-action (VLA) and world action model (WAM) policies across manipulation demands remains to be thoroughly evaluated. In this report, we evaluate GPT-6-Astra on EBench as the core of an agent that controls a robot through an agent harness under the same visual and proprioceptive observation protocol as post-trained policies. We study two agent configurations: direct control, in which the agent generates waypoint co…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Profiling a Frontier Agent with EBench: From Direct Control to Harness with Policy
kern: A frontier multimodal language model controls robots directly and via post-trained vision-language-action or world action model policies, showing complementary strengths but suboptimal integration on complex manipulation tasks.
relevance: direct control vs harness with policy
```

**URL check:** https://arxiv.org/abs/2610.35832


### SoL-Pi: Recursively Scaling Auto-Research Loops for Efficient Agent Harness

- **Link:** https://arxiv.org/abs/2609.20519
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** SoL-Pi improves token efficiency in autonomous coding agents through recursive self-improvement mechanisms, reducing costs by about one third while maintaining performance.
- **Abstract:** As coding agents move from supervised code completion to unattended, around-the-clock exploration, their work expands from isolated predictions into long trajectories of reasoning, tool use, and feedback. Token efficiency therefore becomes important for scaling recursive self-improvement. We take an RSI-inspired approach at the harness layer, scaling auto-research loops across increasingly numerous and diverse environments for harness rollouts. At this scale, the process yields reusable improvements that transfer beyond their development setting, moving automated harness discovery toward prod…
- **Upvotes:** 89

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: SoL-Pi: Recursively Scaling Auto-Research Loops for Efficient Agent Harness
kern: SoL-Pi improves token efficiency in autonomous coding agents through recursive self-improvement mechanisms, reducing costs by about one third while maintaining performance.
relevance: token efficiency in auto-research loops
```

**URL check:** https://arxiv.org/abs/2609.20519


### When the harness decides success: state that cannot be re-observed

- **Link:** https://arxiv.org/abs/2610.26632
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Agent harness choices for managing context across turns significantly affect success depending on whether lost facts can be re-observed, with summarization and reasoning replay recovering most performance gaps on reasoning benchmarks.
- **Abstract:** Agent harnesses decide what a language model sees across turns: they drop old turns, summarize them, or replay the model's own earlier reasoning. We ask when these choices change whether an agent succeeds, not only what it costs, and report three findings. First, in a pre-registered synthetic probe, truncating the context window costs a low-cost reasoning model nothing in success when a needed fact can be looked up again (it looks the fact up instead), but drops its success to chance when the fact cannot be re-observed: the two penalties differ by 92.5 percentage points (90% CI [89.5, 95.5]).…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: When the harness decides success: state that cannot be re-observed
kern: Agent harness choices for managing context across turns significantly affect success depending on whether lost facts can be re-observed, with summarization and reasoning replay recovering most performance gaps on reasoning benchmarks.
relevance: harness decisions on re-observable state
```

**URL check:** https://arxiv.org/abs/2610.26632


### MUSE: A Theory-Harnessed Story Engine for Vibe Narrativizing

- **Link:** https://arxiv.org/abs/2609.15188
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** MUSE is a theory-driven story engine that converts natural-language writing requirements into coherent narratives by organizing story knowledge as structured guidance and preserving decisions across planning, drafting, and revision.
- **Abstract:** LLMs can generate fluent prose. Story quality depends on how decisions about plot, character, and language work together across planning, drafting, and revision. Guiding these decisions presents two bottlenecks: the quality of story guidance and its sustained use. We formulate Vibe Narrativizing as the task of turning natural-language writing requirements into a finished story and present MUSE, a Theory-Harnessed Story Engine. MUSE organizes story knowledge as guidance for specific decisions and carries those decisions into subsequent creative work. Knowledge engineering develops Robert McKee…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: MUSE: A Theory-Harnessed Story Engine for Vibe Narrativizing
kern: (skip: story generation)
relevance: story generation
```

**URL check:** https://arxiv.org/abs/2609.15188


### GenRec: An LLM-Backed Recommendation Ranker at Netflix

- **Link:** https://arxiv.org/abs/2608.10257
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Netflix's GenRec replaces engineered feature-based ranking with an LLM-driven ranker using verbalized histories and context engineering, achieving significant gains with fewer labeled examples via post-training and prefill-only serving.
- **Abstract:** Large language models (LLMs) are reshaping recommender systems by enabling richer modeling of users, content, and context directly in natural language. At Netflix, we are exploring this direction through GenRec, an LLM-backed recommendation ranker built on top of an in-house foundational LLM. GenRec follows a two-phase framework: Phase 1 adapts an open-source LLM to Netflix data, developing deep understanding of the catalog and member behavior while balancing capabilities such as content understanding and instruction following. Phase 2 post-trains this foundation model with recommendation-ran…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: GenRec: An LLM-Backed Recommendation Ranker at Netflix
kern: Netflix's GenRec replaces engineered feature-based ranking with an LLM-driven ranker using verbalized histories and context engineering, achieving significant gains with fewer labeled examples via post-training and prefill-only serving.
relevance: LLM ranker; verbalized histories
```

**URL check:** https://arxiv.org/abs/2608.10257


### StreamScout: Learning When to Look Deeper for Streaming Video Understanding

- **Link:** https://arxiv.org/abs/2609.00291
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** StreamScout adaptively escalates visual evidence retrieval for streaming video queries, reducing token use and latency while improving accuracy via distilled and reinforcement-learned stopping policies.
- **Abstract:** Streaming video understanding requires answering questions that arrive at arbitrary moments over an unbounded video stream. Existing systems primarily focus on what to retain in a bounded memory, yet access that memory using the same fixed-cost procedure for every query, despite substantial variation in the evidence required. We argue that deciding how deeply to access memory for each query is as important as deciding what the memory should store. To this end, we introduce StreamScout, an adaptive inference framework that maintains only a lightweight textual timeline in context as the stream…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: StreamScout: Learning When to Look Deeper for Streaming Video Understanding
kern: StreamScout adaptively escalates visual evidence retrieval for streaming video queries, reducing token use and latency while improving accuracy via distilled and reinforcement-learned stopping policies.
relevance: when to look deeper; token use
```

**URL check:** https://arxiv.org/abs/2609.00291


### Skill-based Agentic Evaluation for Real-time Data Science Tasks

- **Link:** https://arxiv.org/abs/2609.16487
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** The framework evaluates data-science agents on live data by encoding ground truth as executable reference functions and scoring responses via format-agnostic atomic claim comparison.
- **Abstract:** We present a framework for evaluating data-science agents on live, continuously updated data using executable ground truth and format-agnostic factoid scoring. Consider this example query: "what were last week's audience sizes"---the reference answer changes as the underlying data changes, so static references become outdated and standard LLM-as-a-judge pipelines cannot verify responses against a fixed ground truth. Our central contribution, ground-truth-as-code, encodes each expected answer as an executable reference function that recomputes the answer directly from live data at evaluation t…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: Skill-based Agentic Evaluation for Real-time Data Science Tasks
kern: The framework evaluates data-science agents on live data by encoding ground truth as executable reference functions and scoring responses via format-agnostic atomic claim comparison.
relevance: data-science agent evaluation
```

**URL check:** https://arxiv.org/abs/2609.16487


### DAREBench: Deployment-Aware and Reliable Evaluation of Models as Agents

- **Link:** https://arxiv.org/abs/2609.06059
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** DAREBench evaluates large language models as agents across diverse multimodal workloads using a unified execution environment and contract-based scoring to reveal workload-specific accuracy-cost trade-offs.
- **Abstract:** As large language models evolve from question-answering systems into general-purpose agents, evaluation must move beyond static answer correctness to assess multimodal perception, multi-step execution, tool use, and artifact delivery. However, existing benchmarks are often tied to specific task types, execution environments, or scoring protocols, limiting their comparability, interpretability, and reliability for deployment decisions. We introduce DAREBench (Deployment-Aware and Reliable Evaluation of Models as Agents), a benchmark designed to capture workload variation and support reliable a…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: DAREBench: Deployment-Aware and Reliable Evaluation of Models as Agents
kern: DAREBench evaluates large language models as agents across diverse multimodal workloads using a unified execution environment and contract-based scoring to reveal workload-specific accuracy-cost trade-offs.
relevance: deployment-aware agent evaluation
```

**URL check:** https://arxiv.org/abs/2609.06059


### From Points to Trajectories: Rethinking Multimodal Alignment for Physical Events

- **Link:** https://arxiv.org/abs/2611.24249
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Advancing physical artificial intelligence (Physical AI) requires moving beyond static object recognition to ground how real-world mechanics (e.g., impact, friction, and force transfer) unfold over time. While multimodal aligners seek to capture these interactions by matching multi-sensor streams, prevailing architectures compress each temporal sequence into a single pooled embedding. We show that this paradigm fails on twin events: distinct physical executions recorded under identical task conditions. Collapsing the temporal dimension averages out transient cross-modal dynamics, effectively…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: From Points to Trajectories: Rethinking Multimodal Alignment for Physical Events
kern: Advancing physical artificial intelligence (Physical AI) requires moving beyond static object recognition to ground how real-world mechanics (e.g., impact, friction, and force transfer) unfold over time. While multimodal aligners seek to capture these interactions by matching multi-sensor streams, prevailing…
relevance: physical-event grounding
```

**URL check:** https://arxiv.org/abs/2611.24249


### Search From the Start: Search-Native Pretraining for Language Models

- **Link:** https://arxiv.org/abs/2611.26809
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Modern language models (LMs) are increasingly deployed with access to search tools at inference. Yet pretraining remains predominantly focused on predicting static text, with search capabilities typically introduced during post-training. We propose Search-Native Pretraining as a practical route to teach search capability during pretraining from ordinary text corpora. Specifically, we augment pretraining corpus at scale with web-search queries and retrieve web response using a local index. Training on this augmented corpus teaches models to generate search calls and incorporate retrieved evide…
- **Upvotes:** 6

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Search From the Start: Search-Native Pretraining for Language Models
kern: Modern language models (LMs) are increasingly deployed with access to search tools at inference. Yet pretraining remains predominantly focused on predicting static text, with search capabilities typically introduced during post-training. We propose Search-Native Pretraining as a practical route to teach search…
relevance: search-native pretraining
```

**URL check:** https://arxiv.org/abs/2611.26809


### Explicit Style Extraction for Personalized Long-Form Text Generation

- **Link:** https://arxiv.org/abs/2611.27211
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A method that explicitly extracts a user's stylistic profile and uses it to guide drafting and revision improves personalized long-form text generation over retrieval-augmented baselines.
- **Abstract:** Personalized long-form generation asks a language model to write new text the way a specific user would. The standard recipe, retrieval-augmented generation, places a few of the user's past texts in the prompt but leaves the model to decide what to take from them. We introduce StylePrism, a taxonomy of 28 stylistic aspects in seven categories, and SP-Refine, an inference-time method that makes style extraction an explicit step: the model first fills StylePrism with the user's patterns, quoted evidence, and habits to avoid, then drafts from the user's samples and revises the draft twice agains…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Explicit Style Extraction for Personalized Long-Form Text Generation
kern: (skip: personalized style extraction)
relevance: personalized style extraction
```

**URL check:** https://arxiv.org/abs/2611.27211


### Autoregressive View Model

- **Link:** https://arxiv.org/abs/2611.23417
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** We present the Autoregressive View Model (AVM), which generates a scene as a stream of views without constructing an explicit 3D representation. Through a unified in-context interface, AVM conditions on images or videos to generate short clips along a requested camera path. Visual context grounds reconstruction and interpolation, while a learned prior enables extrapolation into unseen regions. AVM retrieves relevant views from inputs and generated history to form a bounded active context. We fine-tune a pretrained bidirectional video diffusion transformer with flow matching in an N-in-1-out f…
- **Upvotes:** 3

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Autoregressive View Model
kern: We present the Autoregressive View Model (AVM), which generates a scene as a stream of views without constructing an explicit 3D representation. Through a unified in-context interface, AVM conditions on images or videos to generate short clips along a requested camera path. Visual context grounds reconstruction and…
relevance: autoregressive view model
```

**URL check:** https://arxiv.org/abs/2611.23417


### Which Dwarf Is This? Doppeldwarf-306 and Near-Identical Instance Retrieval

- **Link:** https://arxiv.org/abs/2611.27490
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Most established instance-retrieval benchmarks emphasise landmarks; small sculptures from visually similar series offer a complementary challenge. We introduce Doppeldwarf-306: 1,691 openly licensed photographs of 306 bronze dwarf statues in Wrocław, Poland, many made in themed series that share one style, with the photographer of each image recorded. With no training, nearest-neighbour search over frozen DINOv2 features names the right statue first for 93.1% of leave-one-out queries, and the best of thirteen backbones from seven pretraining paradigms reaches 94.7%. Accuracy falls slowly as c…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Which Dwarf Is This? Doppeldwarf-306 and Near-Identical Instance Retrieval
kern: (skip: instance retrieval)
relevance: instance retrieval
```

**URL check:** https://arxiv.org/abs/2611.27490


### DiLE: Discrimination-Aware Latent-Space Learning for Universal Multimodal Embeddings

- **Link:** https://arxiv.org/abs/2611.25419
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A discrimination-aware latent-space learning framework combines task guidance with on-policy retrieval feedback to preserve discriminative evidence in multimodal embeddings and improve retrieval across modalities and tasks.
- **Abstract:** Multimodal large language models have greatly improved input understanding in universal multimodal embedding models. However, this understanding does not ensure that their embeddings preserve the evidence needed to distinguish relevant items from confusable alternatives. To preserve essential discriminative evidence in embeddings, this paper proposes DiLE, a discrimination-aware latent-space learning framework that combines task guidance with on-policy retrieval feedback. Specifically, a few learnable queries are used to encode task-relevant information in a compact latent space. Reasoning in…
- **Upvotes:** 19

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: DiLE: Discrimination-Aware Latent-Space Learning for Universal Multimodal Embeddings
kern: A discrimination-aware latent-space learning framework combines task guidance with on-policy retrieval feedback to preserve discriminative evidence in multimodal embeddings and improve retrieval across modalities and tasks.
relevance: multimodal embeddings; retrieval
```

**URL check:** https://arxiv.org/abs/2611.25419


### MMMem: Self-Improving Agents with Task-Aware Multimodal Experience Consolidation

- **Link:** https://arxiv.org/abs/2611.30287
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A task-aware multimodal memory framework consolidates experience from completed tasks using source-linked multi-view memory, source-generated tasks, distillation, and task-aware retrieval, yielding consistent gains across memory benchmarks.
- **Abstract:** AI agents accumulate conversations, images, and documents through long-term interactions with users. Answering later questions often requires connecting evidence across these records, yet the resulting understanding is rarely retained, allowing mistakes to recur on related questions. Existing multimodal memory methods largely focus on storing and retrieving records, with limited mechanisms for learning from completed tasks and consolidating task-specific experience. We therefore propose MMMem, a task-aware multimodal memory framework that extracts and consolidates experience from completed ta…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: MMMem: Self-Improving Agents with Task-Aware Multimodal Experience Consolidation
kern: A task-aware multimodal memory framework consolidates experience from completed tasks using source-linked multi-view memory, source-generated tasks, distillation, and task-aware retrieval, yielding consistent gains across memory benchmarks.
relevance: multimodal experience consolidation
```

**URL check:** https://arxiv.org/abs/2611.30287


### VideoJSON: A Minimal Harness Beats Purpose-Built Memory for Ultra-Long Video Understanding

- **Link:** https://arxiv.org/abs/2611.28167
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Answering questions over days or weeks of video requires searching for scattered clues across long timelines. Existing video agents rely on complex memory graphs and fixed retrieval pipelines, which restrict how the agent can search. We propose VideoJSON, a minimal harness for ultra-long video understanding that keeps the memory simple and lets a coding agent write its own search programs. During indexing, a vision-language model turns each minute of video into a single JSON record containing a dense caption and structured fields such as events, entities, places, and speech transcripts. At qu…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: VideoJSON: A Minimal Harness Beats Purpose-Built Memory for Ultra-Long Video Understanding
kern: Answering questions over days or weeks of video requires searching for scattered clues across long timelines. Existing video agents rely on complex memory graphs and fixed retrieval pipelines, which restrict how the agent can search. We propose VideoJSON, a minimal harness for ultra-long video understanding that…
relevance: minimal harness beats purpose-built memory
```

**URL check:** https://arxiv.org/abs/2611.28167


### SynthDCB: World Distillation for Scalable Device Control Benchmarking

- **Link:** https://arxiv.org/abs/2611.18639
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Scaling device-control evaluation requires scaling both interactive worlds and the tasks agents must solve. We introduce SynthDCB, a benchmark for environment awareness and device control built through world distillation (WD). World distillation transforms knowledge of device behaviors, constraints, and environmental effects into modular executable components. A unified capability representation connects tool discovery, world execution, and task synthesis. SynthDCB instantiates Home, Car, and Phone with 114 device classes, 1,166 functions, and 95 events, supporting five task families with 32…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: SynthDCB: World Distillation for Scalable Device Control Benchmarking
kern: Scaling device-control evaluation requires scaling both interactive worlds and the tasks agents must solve. We introduce SynthDCB, a benchmark for environment awareness and device control built through world distillation (WD). World distillation transforms knowledge of device behaviors, constraints, and environmental…
relevance: device-control benchmark synthesis
```

**URL check:** https://arxiv.org/abs/2611.18639


### Rewirable Circuits in Transformers with Loom Attention

- **Link:** https://arxiv.org/abs/2611.30634
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** We propose loom attention, which allows a Transformer to dynamically rewire its circuits at every token by interweaving a head's vertical attention over the outputs of earlier heads (to obtain its query, key and value) with its horizontal attention over tokens. We instantiate vertical attention efficiently with normalized and gated linear attention over a per-token matrix memory, which stores the compressed head outputs and serves as a second residual stream. This yields LoomFormer, a dual-stream architecture that splits control and content between the vector and matrix streams. Across model…
- **Upvotes:** 90

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Rewirable Circuits in Transformers with Loom Attention
kern: We propose loom attention, which allows a Transformer to dynamically rewire its circuits at every token by interweaving a head's vertical attention over the outputs of earlier heads (to obtain its query, key and value) with its horizontal attention over tokens. We instantiate vertical attention efficiently with…
relevance: loom attention; rewirable circuits
```

**URL check:** https://arxiv.org/abs/2611.30634


### A gene informed benchmark for BioScoring of pathology foundation models

- **Link:** https://arxiv.org/abs/2611.34930v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Pathology foundation models are usually compared by their performance on downstream tasks such as classification and retrieval. While such benchmarks measure how useful a model is, they provide no insight into the biology it represents. We introduce BioScore, a benchmark that quantifies how well an image encoder captures cell identities, with spatial transcriptomics of the same tissue as the reference. A sparse autoencoder splits the encoder's patch embeddings into sparse features, which we cluster into a fixed number of groups. BioScore then measures, for each of 52 cell identities defined b…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: A gene informed benchmark for BioScoring of pathology foundation models
kern: (skip: pathology benchmark)
relevance: pathology benchmark
```

**URL check:** https://arxiv.org/abs/2611.34930v1


### Routeability Before Routing: Routeability Audit Protocol (RAP) and RouteabilityBench for Audited LLM Model Selection

- **Link:** https://arxiv.org/abs/2611.34825v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** LLM routing aims to choose, for each prompt, which model in a portfolio is most likely to answer correctly. This only makes sense when the benchmark contains enough prompt-specific variation for different models to be best on different inputs. On coarse-scored LLM benchmarks, however, many models often tie for the best score, and the single best model may already leave little room for improvement. We therefore propose a routeability-first audit, instantiated as RAP and RouteabilityBench, a runnable claim-verification package. The audit is retrospective: it runs once the benchmark-portfolio sc…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Routeability Before Routing: Routeability Audit Protocol (RAP) and RouteabilityBench for Audited LLM Model Selection
kern: (skip: routing audit protocol)
relevance: routing audit protocol
```

**URL check:** https://arxiv.org/abs/2611.34825v1


### High-Fidelity Image Matting with Pixel-Space Diffusion Transformers

- **Link:** https://arxiv.org/abs/2611.34929
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Diffusion models have shown strong potential for image matting by transferring generative priors learned from large-scale pretraining. However, existing approaches largely rely on latent diffusion models, whose compressed representations and VAE-based reconstruction introduce a mismatch with the high-frequency precision required for matting. We present PixelMatte, a framework that adapts pretrained pixel-space diffusion transformers for high-fidelity image matting. We show that strong image-conditioned matting capabilities can be acquired even from a pure text-to-image model without paired im…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: High-Fidelity Image Matting with Pixel-Space Diffusion Transformers
kern: (skip: image matting)
relevance: image matting
```

**URL check:** https://arxiv.org/abs/2611.34929


### 3D CoCa v3: Contrastive Learners with Scene Graphs for Urban Scene Understanding

- **Link:** https://arxiv.org/abs/2611.33835
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Understanding large-scale 3D urban scenes requires representations that capture both multi-scale geometric structures and complex spatial relationships. However, existing 3D vision-language methods primarily emphasize global semantic alignment or object-level representations, leaving structured relational modeling underexplored within unified contrastive and generative frameworks. In this paper, we present 3D CoCa v3, a scene-graph-enhanced contrastive and generative framework for urban 3D scene understanding. Our framework features a Pyramid Vision Encoder for multi-scale geometric represent…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: 3D CoCa v3: Contrastive Learners with Scene Graphs for Urban Scene Understanding
kern: Understanding large-scale 3D urban scenes requires representations that capture both multi-scale geometric structures and complex spatial relationships. However, existing 3D vision-language methods primarily emphasize global semantic alignment or object-level representations, leaving structured relational modeling…
relevance: 3D urban scene representation
```

**URL check:** https://arxiv.org/abs/2611.33835


### SIA: Selective Image Analogy

- **Link:** https://arxiv.org/abs/2611.33894
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A new selective image analogy setting and model let users choose which of multiple demonstrated edits to transfer to a query image by suppressing unwanted edit tokens during denoising.
- **Abstract:** Image analogy transfers a demonstrated transformation from a before/after pair (A, A') to a new query image B. Existing methods assume all changes in (A, A') should be fully transferred, limiting flexibility when users want only a subset of the demonstrated edits. We introduce Selective Image Analogy (SIA), a new setting where a single demonstration pair encodes multiple edits, and the user selects at inference time which edits to apply to B. To support this, we curate a multi-edit analogy dataset with full-edit and partial-edit targets. We then train a model that first learns to transfer the…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: SIA: Selective Image Analogy
kern: (skip: image analogy)
relevance: image analogy
```

**URL check:** https://arxiv.org/abs/2611.33894


### SPARC: Geometry-Guided Attention Pruning for Long-Horizon Camera-Controlled Video Generation

- **Link:** https://arxiv.org/abs/2611.34064
- **Source:** HF daily · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** SPARC uses geometry-guided pruning of self-attention in pretrained video diffusion transformers to unify camera control and persistent scene memory, improving camera adherence and revisit consistency while greatly reducing computation.
- **Abstract:** We present SPARC, a geometry-guided attention pruning framework that turns the native self-attention of pretrained video diffusion transformers into a unified mechanism for camera control and persistent scene memory. Our key insight is that attention connectivity can simultaneously serve as geometric conditioning for camera control and spatial addressing for historical memory retrieval. Motivated by the asymmetric contextual requirements of reconstructing observed content and synthesizing novel regions, SPARC restricts observed tokens to geometrically corresponding historical tokens and local…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: SPARC: Geometry-Guided Attention Pruning for Long-Horizon Camera-Controlled Video Generation
kern: (skip: camera-controlled video generation)
relevance: camera-controlled video generation
```

**URL check:** https://arxiv.org/abs/2611.34064


### ExecRetrieval: Measuring the Functional-Correctness Gap in Code-Embedding Retrieval

- **Link:** https://arxiv.org/abs/2609.01865
- **Source:** HF q:index · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** ExecRetrieval evaluates whether code embeddings can distinguish correct implementations from near-identical buggy variants, revealing that leading retrievers frequently rank incorrect near-clones above canonical solutions.
- **Abstract:** Embedding-based code retrieval is a core component of coding agents and retrieval-augmented code generation, where retrieving correct code matters more than retrieving lexically similar code. Existing code-retrieval benchmarks do not plant controlled, execution-verified single-edit variants of each query's canonical implementation in the search pool, leaving the question of whether embeddings can functionally discriminate correct from near-clone-but-incorrect code unanswered in a retrieval setting. Resolving this requires a benchmark whose search pool itself contains the relevant counterfactu…
- **Upvotes:** 5

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: ExecRetrieval: Measuring the Functional-Correctness Gap in Code-Embedding Retrieval
kern: ExecRetrieval evaluates whether code embeddings can distinguish correct implementations from near-identical buggy variants, revealing that leading retrievers frequently rank incorrect near-clones above canonical solutions.
relevance: code-embedding functional-correctness gap
```

**URL check:** https://arxiv.org/abs/2609.01865


### Decoupling Memory from Context: Structured Memory for Token-Efficient Test-Time Continual Learning

- **Link:** https://arxiv.org/abs/2610.02687
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** GraphMemory is a lightweight graph-based memory system that optimizes context by retrieving only relevant subgraphs, achieving competitive results with far fewer memory-construction tokens.
- **Abstract:** Large language models (LLMs) are increasingly deployed in enterprise, scientific, and medical applications, where agents must incorporate domain-specific knowledge and adapt from experience. Context engineering offers a practical alternative to weight updates by improving model behavior through instructions, strategies, and evidence supplied at inference time. However, adapting context online typically requires a costly trial-and-error process, while queries are often processed independently, preventing useful experience from carrying forward. Memory systems address this limitation by retaini…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Decoupling Memory from Context: Structured Memory for Token-Efficient Test-Time Continual Learning
kern: GraphMemory is a lightweight graph-based memory system that optimizes context by retrieving only relevant subgraphs, achieving competitive results with far fewer memory-construction tokens.
relevance: structured memory decoupled from context
```

**URL check:** https://arxiv.org/abs/2610.02687


### Experience-Handoff Reinforcement Learning for Recursive Self-Improvement

- **Link:** https://arxiv.org/abs/2611.16409
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Language-model agents trained with reinforcement learning can improve by learning to create and curate experience artifacts that help future rollouts, not just by optimizing actions from scalar rewards.
- **Abstract:** It is common to train Large Language Models (LLMs) for agentic tasks with Reinforcement Learning (RL) from scalar rewards. However, this throws away the fine-grained information about the environment that the agent experienced during the trial (e.g., error logs). To utilize this rich information, recent works wrap the agent in a harness that refines its own inputs through reflection or compaction and hands past experience to future rollouts, but the construction of the handed-off artifacts (e.g., a playbook) is itself not learned. We want the best of both worlds: gradient updates from a scala…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Loop Engineering
title: Experience-Handoff Reinforcement Learning for Recursive Self-Improvement
kern: Language-model agents trained with reinforcement learning can improve by learning to create and curate experience artifacts that help future rollouts, not just by optimizing actions from scalar rewards.
relevance: experience handoff; RSI
```

**URL check:** https://arxiv.org/abs/2611.16409


### ConTra: A Training Framework for Effective Contextual Retrieval via Prefix Generation

- **Link:** https://arxiv.org/abs/2611.34366
- **Source:** HF q:repocontext · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Data management systems organize large text collections for tasks such as finding relevant studies and extracting contract clauses. Systems make long documents searchable by splitting them into independently indexed chunks. Chunking can separate text from its identifying details. The indexing challenge is to keep each chunk independently searchable while preserving the context needed to find and rank it. Existing methods either encode that context in chunk vectors or attach it as a text prefix. Context encoded only in vectors is unavailable to text rerankers. Prompted prefixes serve both vect…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: ConTra: A Training Framework for Effective Contextual Retrieval via Prefix Generation
kern: (skip: contextual retrieval prefix training)
relevance: contextual retrieval prefix training
```

**URL check:** https://arxiv.org/abs/2611.34366


### RPTune: Learned Context Curation for LLM Catalog Search

- **Link:** https://arxiv.org/abs/2610.00964
- **Source:** HF q:repocontext · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** RPTune improves small-business product search by combining learned catalog curation with LLM post-training guided by catalog-specific feedback.
- **Abstract:** For small merchant businesses (SMBs) whose catalogs fit within a long-context LLM, full-catalog prompting offers a compelling alternative to multi-stage retrieval designed primarily for large marketplaces with millions of items. However, fitting the full catalog into the context window does not ensure that the model can use it effectively, since LLMs do not exploit long contexts uniformly. We therefore study in-context catalog search through two complementary questions: (1) how to curate and present catalogs to the LLM, and (2) how to adapt the LLM for product selection on curated contexts. W…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: RPTune: Learned Context Curation for LLM Catalog Search
kern: (skip: catalog search)
relevance: catalog search
```

**URL check:** https://arxiv.org/abs/2610.00964


### "PRISM" Is Not All You Need: Cross-Topic Name Collisions and Scientific Paper Retrieval

- **Link:** https://arxiv.org/abs/2611.01362
- **Source:** HF q:repocontext · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Cross-topic name collisions in AI papers have risen sharply, and shared-name papers remain harder to identify even with research clues, though language-model ranking improves matching.
- **Abstract:** Scientific names increasingly connect papers from different research topics, leaving readers to recover a paper's identity from context. We study this convergence in 564,861 AI-related arXiv records. Cross-topic name collision grows 4.33-fold from a pooled 2020-2022 reference to 2026, compared with 1.12-fold within topics. A second sentence encoder reproduces the pattern, and name-group resampling quantifies its uncertainty. Fixed word-frequency bands locate the main increase in an intermediate-frequency vocabulary shared by many research areas. We then measure the ambiguity that remains afte…
- **Upvotes:** 6

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: "PRISM" Is Not All You Need: Cross-Topic Name Collisions and Scientific Paper Retrieval
kern: Cross-topic name collisions in AI papers have risen sharply, and shared-name papers remain harder to identify even with research clues, though language-model ranking improves matching.
relevance: paper retrieval; cross-topic name collisions
```

**URL check:** https://arxiv.org/abs/2611.01362


### Interpreting Coding Agents Through Their Behavioral Trajectories

- **Link:** https://arxiv.org/abs/2611.17440
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Standard coding-agent benchmarks primarily evaluate binary task success, treating execution as a black box and obscuring the behaviors that produce those outcomes. We analyze a large corpus of 143,209 execution trajectories from 125 agent configurations spanning 117 unique models. To enable comparisons across heterogeneous agent interfaces, we develop a rule-based parser that maps raw execution traces to high-level actions such as repository search, file editing, and test execution, and audit its predictions against a six-model consensus reference on 500 events. We find that agents with simil…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Interpreting Coding Agents Through Their Behavioral Trajectories
kern: Standard coding-agent benchmarks primarily evaluate binary task success, treating execution as a black box and obscuring the behaviors that produce those outcomes. We analyze a large corpus of 143,209 execution trajectories from 125 agent configurations spanning 117 unique models. To enable comparisons across…
relevance: behavioural trajectories of coding agents
```

**URL check:** https://arxiv.org/abs/2611.17440


### Tools Need Not Speak in Text: Latent Context Compression for Agents

- **Link:** https://arxiv.org/abs/2611.06500
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A continuous latent context compression model for LLM agents compresses tool observations into latent tokens and uses action-preserving training to reduce token consumption and runtime while improving task performance.
- **Abstract:** Large language model (LLM) agents typically append raw tool outputs to their context. Over multi-step interactions, long and noisy observations incur substantial context overhead and dilute the agent's attention to task-relevant information. Existing token pruning and summarization methods remain constrained by discrete text representations, limiting the achievable compression ratios. In this work, we challenge the prevailing assumption that agents must consume tool observations as explicit text tokens. To this end, we propose Coca-Cola, a continuous latent context compression model for LLM a…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Tools Need Not Speak in Text: Latent Context Compression for Agents
kern: A continuous latent context compression model for LLM agents compresses tool observations into latent tokens and uses action-preserving training to reduce token consumption and runtime while improving task performance.
relevance: latent compression of tool observations
```

**URL check:** https://arxiv.org/abs/2611.06500


### HiVe-Mem: Interleaving Horizontal Memory Expansion and Vertical Evidence Composition for Multimodal Agents

- **Link:** https://arxiv.org/abs/2611.12872
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A novel multimodal memory framework enhances long-term interaction by combining relational graph expansion of semantic seeds with query-adaptive composition of heterogeneous evidence forms.
- **Abstract:** As multimodal agents accumulate increasingly long interaction histories, effectively retrieving and utilizing past information becomes critical for long-term interaction. Existing memory systems typically rely on semantic retrieval over compressed memories and expose predefined representations, which may miss relevant memories and overlook heterogeneous evidence needs across queries. We introduce \hivemem, a multimodal memory framework that interleaves \textsc{H}or\textsc{i}zontal Memory Expansion with \textsc{Ve}rtical Evidence Composition. For horizontal memory expansion, \hivemem organizes…
- **Upvotes:** 5

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: HiVe-Mem: Interleaving Horizontal Memory Expansion and Vertical Evidence Composition for Multimodal Agents
kern: A novel multimodal memory framework enhances long-term interaction by combining relational graph expansion of semantic seeds with query-adaptive composition of heterogeneous evidence forms.
relevance: multimodal memory composition
```

**URL check:** https://arxiv.org/abs/2611.12872


### The reach of a verification tool decides its value: A controlled study of verification surface, artifact quality, and cost in AI coding agents

- **Link:** https://arxiv.org/abs/2608.28795
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** Modern artificial-intelligence coding agents can be equipped with tools for checking their own work e.g. a linter, a boot probe, a shell, a screenshot tool. We call this set the agent's verification surface. This study asks whether increasing only that surface, with everything else held fixed, produces a matching growth in the quality of the software the agent ships. We built a minimal coding agent whose tool list is the single controlled variable and used it to implement 1,116 web applications across six models and eight tool configurations. A condition-blind human graded every application a…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: The reach of a verification tool decides its value: A controlled study of verification surface, artifact quality, and cost in AI coding agents
kern: Modern artificial-intelligence coding agents can be equipped with tools for checking their own work e.g. a linter, a boot probe, a shell, a screenshot tool. We call this set the agent's verification surface. This study asks whether increasing only that surface, with everything else held fixed, produces a matching…
relevance: reach of a verification tool
```

**URL check:** https://arxiv.org/abs/2608.28795


### How Do AI Agents Waste Your Money?

- **Link:** https://arxiv.org/abs/2611.07238
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A framework measures and validates unnecessary token use in AI agents by normalizing trajectories, identifying removable spans with an LLM judge, and pruning them to improve efficiency while preserving task performance.
- **Abstract:** AI agents may consume massive tokens across a wide range of tasks, but how many of those tokens are really necessary? Although prior work has shown that agents can incur unexpectedly high token costs, we still lack a systematic way to identify and measure token waste. In this work, we introduce a unified framework for measuring token waste across heterogeneous agent systems. Our framework records and normalizes complete agent trajectories, identifies removable spans using an LLM-as-a-Judge (LLMaJ), and maps the identified text spans back to the original trajectory for token-level measurement.…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: How Do AI Agents Waste Your Money?
kern: A framework measures and validates unnecessary token use in AI agents by normalizing trajectories, identifying removable spans with an LLM judge, and pruning them to improve efficiency while preserving task performance.
relevance: wasted token measurement
```

**URL check:** https://arxiv.org/abs/2611.07238


### Evolving Agent Teams

- **Link:** https://arxiv.org/abs/2610.36848
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Evolving Agent Teams uses a supervisor and persistent memory to restructure agent teams, escaping local optima and outperforming baselines in GPU kernel optimization and related tasks.
- **Abstract:** The rapid progress of software engineering agents drives interest in applying them to open-ended problems such as GPU kernel optimization. However, we find that existing coding agents converge to local optima on real-world, expert-written kernels (e.g., FlashInfer). We introduce Evolving Agent Teams, a multi-agent framework that escapes such local optima. It features (1) a central supervisor that diagnoses each local optimum and restructures a team of agents; and (2) a persistent file system that comprises a learning document, an evolution history, and per-team artifacts, grounding restructur…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Graph Engineering
title: Evolving Agent Teams
kern: Evolving Agent Teams uses a supervisor and persistent memory to restructure agent teams, escaping local optima and outperforming baselines in GPU kernel optimization and related tasks.
relevance: evolving agent teams
```

**URL check:** https://arxiv.org/abs/2610.36848


### Keyword Harnesses Fail Open: A Cheap Diagnostic Ladder for Tool-Use Claims in Small Language Models

- **Link:** https://arxiv.org/abs/2610.02142
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** A diagnostic ladder reveals false tool-use positives in small language models and shows targeted supervised fine-tuning can repair missing tool-call priors with minimal compute.
- **Abstract:** Keyword-matching benchmarks can credit small models for tool use they never perform. We document such a false positive in a matched-architecture pair of Spanish security language models and propose a ladder of strict, cheap diagnostics. A 661.6M parameter model (approx. 65% code/technical text; no dedicated SFT) and a 1,109M model (web-heavy multi-phase curriculum; 6B-token tool-SFT) share decoder, tokenizer, and special tokens, scoring almost identically on lenient tool-use metrics (B4: 0.660 vs. 0.650). Verbatim-reproduction checks on training examples separate them completely: the 600M emi…
- **Upvotes:** 3

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: Keyword Harnesses Fail Open: A Cheap Diagnostic Ladder for Tool-Use Claims in Small Language Models
kern: A diagnostic ladder reveals false tool-use positives in small language models and shows targeted supervised fine-tuning can repair missing tool-call priors with minimal compute.
relevance: diagnostic ladder for tool-use claims
```

**URL check:** https://arxiv.org/abs/2610.02142


### Harness Engineering in LLM Tool Use via Agent-Native Reusable Tool Primitives

- **Link:** https://arxiv.org/abs/2609.01736
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** Tool Primitives and ToolFace enable robust multi-turn tool use via natural language interfaces and dynamic retrieval, while the HEART framework improves planning, routing, and verification to outperform frontier models with lower cost.
- **Abstract:** Large language models (LLMs) augmented with external tools have demonstrated remarkable capability in solving complex real-world tasks. However, existing approaches suffer from two key challenges: brittle multi-step and multi-turn reasoning caused by incompatible tool output types and API schemas, and performance degradation under large tool catalogues. To address these, we introduce Tool Primitives, a design that replaces rigid API schema-based invocation with natural language as the interface for tool calling, where each tool is wrapped with an LLM interface that handles schema resolution a…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Prompt Engineering
title: Harness Engineering in LLM Tool Use via Agent-Native Reusable Tool Primitives
kern: Tool Primitives and ToolFace enable robust multi-turn tool use via natural language interfaces and dynamic retrieval, while the HEART framework improves planning, routing, and verification to outperform frontier models with lower cost.
relevance: agent-native tool primitives
```

**URL check:** https://arxiv.org/abs/2609.01736


### ContextRender: From Execution Dependencies to Agent Context

- **Link:** https://arxiv.org/abs/2609.37743
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Gist (HF ai_summary):** ContextRender uses an execution-dependency graph and Tool-Flow Analysis to select tool results under a fixed history budget, improving LLM agent task performance while reducing inference cost.
- **Abstract:** LLM agents performing long-horizon tasks accumulate tool results that later steps may need. Passing the full history to every invocation is costly even when it fits within the context window, while reducing it risks omitting needed information. Existing context management methods can overlook how earlier tool results are used in subsequent execution, leaving needed information out of context. We introduce ContextRender, which manages context through a persistent graph of execution dependencies. We develop Tool-Flow Analysis to track how later operations reuse information from earlier tool res…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: ContextRender: From Execution Dependencies to Agent Context
kern: ContextRender uses an execution-dependency graph and Tool-Flow Analysis to select tool results under a fixed history budget, improving LLM agent task performance while reducing inference cost.
relevance: tool-result selection by execution graph
```

**URL check:** https://arxiv.org/abs/2609.37743


### Token Pooling-Aware Training for Multi-Vector Embedding Models

- **Link:** https://huggingface.co/blog/token-pooling
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Token Pooling-Aware Training for Multi-Vector Embedding Models
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/token-pooling


### Focus On Facts: Stylistically Invariant and Factually Sensitive Text Embeddings

- **Link:** https://arxiv.org/abs/2611.33250
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** Context Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Focus On Facts: Stylistically Invariant and Factually Sensitive Text Embeddings
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33250

