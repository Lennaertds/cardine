# Promote drafts — 2026-W48 — Harness Engineering

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### Hearsay: Can an Auditor Trust the Record a Deployed Agent Harness Writes?

- **Link:** https://arxiv.org/abs/2609.32495
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Agent harness records lack evidentiary reliability because they are self-written, but an external append-only log of harness-model interactions can independently verify omissions and fabrications.
- **Abstract:** An agent harness, the code that turns a model into an agent, writes its own record of each run, and that record is all a later reader gets when a run is disputed, investigated or audited. We call a record evidentiary when a reader who was not there can check it without trusting the writer. Across sixteen deployed frameworks, none writes one in full. Hearsay examines the record, not the task: five harnesses run fourteen tasks, three blinded LLM examiners and a human panel read the records, and every excerpt an examiner quotes is checked mechanically for who wrote it. First, the record lets a r…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: Hearsay: Can an Auditor Trust the Record a Deployed Agent Harness Writes?
kern: Agent harness records lack evidentiary reliability because they are self-written, but an external append-only log of harness-model interactions can independently verify omissions and fabrications.
relevance: auditor trust in harness records
```

**URL check:** https://arxiv.org/abs/2609.32495


### ClawGym II: Exploring Black-Box RL on Agent Harness

- **Link:** https://arxiv.org/abs/2608.16798
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A unified black-box reinforcement learning framework enables stable, scalable optimization of general agents through complex harnesses via sandbox execution, trajectory reconstruction, and mix-harness training.
- **Abstract:** Agent harnesses have substantially improved performance on long-horizon tasks by coordinating agent interactions with the environment. However, reinforcement learning through complex harnesses remains largely unexplored, as scaling such training to long-horizon agent tasks introduces fundamental challenges. In this work, we present a unified black-box RL framework for stable and scalable optimization of general agents through complex harnesses. Concretely, we first build a sandbox-based execution infrastructure that isolates task environments and harnesses within temporary sandboxes for large…
- **Upvotes:** 41

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: ClawGym II: Exploring Black-Box RL on Agent Harness
kern: A unified black-box reinforcement learning framework enables stable, scalable optimization of general agents through complex harnesses via sandbox execution, trajectory reconstruction, and mix-harness training.
relevance: black-box RL on harness
```

**URL check:** https://arxiv.org/abs/2608.16798


### Harness-Zero: Harness Distillation via Agent-as-Harness

- **Link:** https://arxiv.org/abs/2609.24974
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Harness-Zero distills specialized agent harness behaviors into model weights via agent-as-harness correction, enabling deployment without the optimized harness while improving task success.
- **Abstract:** Agent harnesses, the external systems that mediate model-environment interaction, can substantially improve agent performance, but their gains remain tied to the harness at deployment. Because the best harness varies across domains, instances, and models, a general-purpose agent must either settle for a suboptimal shared harness or route among an ever-growing set of specialized ones. We therefore study agent harness distillation: using a domain- or instance-optimized harness as training-time guidance and transferring the behaviors it induces into model weights, so that its gains survive under…
- **Upvotes:** 22

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Harness-Zero: Harness Distillation via Agent-as-Harness
kern: Harness-Zero distills specialized agent harness behaviors into model weights via agent-as-harness correction, enabling deployment without the optimized harness while improving task success.
relevance: harness distillation into weights
```

**URL check:** https://arxiv.org/abs/2609.24974


### How Do Agent Harnesses Create Value? Planning Information and Release Control in Stateful LLM Agents

- **Link:** https://arxiv.org/abs/2609.20474
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** In τ²-bench, structured planning guidance improves task success over sham controls, while a terminal verifier reduces false passes with minimal cost, with the dominant component depending on liability for erroneous acceptance.
- **Abstract:** Agent harnesses supply planning guidance, organize execution, and check completion. We study how these components affect success, erroneous acceptance, and cost in two Retail experiments and an Airline pilot in τ^2-bench. The primary comparison pairs prewritten task-specific plans (Fixed) with shuffled policy text matched in word count (Sham), isolating the contribution of guidance content. Across 265 matched cells, Fixed improves oracle-verified success by 7.17 percentage points (90\% task-clustered bootstrap interval, 1.15--13.36 points), with gains concentrated in higher-complexity tasks.…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: How Do Agent Harnesses Create Value? Planning Information and Release Control in Stateful LLM Agents
kern: In τ²-bench, structured planning guidance improves task success over sham controls, while a terminal verifier reduces false passes with minimal cost, with the dominant component depending on liability for erroneous acceptance.
relevance: planning + release control value
```

**URL check:** https://arxiv.org/abs/2609.20474


### PluginRSI: Recursive Improvement of Agent Harnesses with Reusable Plugins

- **Link:** https://arxiv.org/abs/2609.32423
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** PluginRSI improves language model harnesses by evolving reusable, composable plugins that accelerate optimization and transfer across tasks and models.
- **Abstract:** The harness surrounding a language model is a central determinant of agent performance. Recent methods optimize harnesses by searching over complete programs, where individual mechanisms are difficult to isolate and reuse. We introduce PluginRSI, which represents a harness as a composition of atomized plugins and organizes harness evolution around these plugins. Individual plugins are improved independently and accumulated in a shared library, then recombined into new harnesses at each iteration. PluginRSI improves over existing harness optimization methods across software engineering, comman…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: PluginRSI: Recursive Improvement of Agent Harnesses with Reusable Plugins
kern: PluginRSI improves language model harnesses by evolving reusable, composable plugins that accelerate optimization and transfer across tasks and models.
relevance: recursive improvement with plugins
```

**URL check:** https://arxiv.org/abs/2609.32423


### ActiveSaddler: Automated Curriculum Learning for Agent Harness Optimization

- **Link:** https://arxiv.org/abs/2610.00906
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** ActiveSaddler treats harness optimization as adaptive curriculum learning by modeling training scenarios as a non-stationary bandit that dynamically targets evolving failure patterns, improving agent performance over fixed curricula.
- **Abstract:** Automated harness optimization can substantially improve LLM agents by iteratively updating their prompts, tool interfaces, and control logic from execution feedback. However, existing methods primarily optimize how the harness is updated while largely fixing which training scenarios generate the feedback that drives those updates. As the harness evolves, the scenarios most useful for further optimization can change, suggesting that the training curriculum itself should adapt alongside the harness. We formulate this missing dimension of harness optimization as an automated curriculum learning…
- **Upvotes:** 53

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: ActiveSaddler: Automated Curriculum Learning for Agent Harness Optimization
kern: ActiveSaddler treats harness optimization as adaptive curriculum learning by modeling training scenarios as a non-stationary bandit that dynamically targets evolving failure patterns, improving agent performance over fixed curricula.
relevance: saddler: harness optimization
```

**URL check:** https://arxiv.org/abs/2610.00906


### VideoEvolve: Evolving Agent Harnesses for Video Temporal Grounding

- **Link:** https://arxiv.org/abs/2610.01766
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** VideoEvolve automates the evolution of agent harnesses for video temporal grounding by refining instructions and code branches through execution feedback, improving localization across benchmarks.
- **Abstract:** Video temporal grounding aims to localize events in videos from natural-language queries. For agents built around frozen video-language models, the harness determines how queries guide temporal predictions and how those predictions are refined. Manually refining these harnesses requires diagnosing grounding failures and coordinating changes to both agent workflows and instructions. We introduce VideoEvolve, a framework that automatically evolves agent harnesses for video temporal grounding. VideoEvolve uses a Cloze-Structured Harness Representation that preserves stage interfaces while leavin…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: VideoEvolve: Evolving Agent Harnesses for Video Temporal Grounding
kern: VideoEvolve automates the evolution of agent harnesses for video temporal grounding by refining instructions and code branches through execution feedback, improving localization across benchmarks.
relevance: harness evolution for video grounding
```

**URL check:** https://arxiv.org/abs/2610.01766


### Harness^2: Recursive Agent Harnessing for an Open World

- **Link:** https://arxiv.org/abs/2610.14224
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Harness² improves agent execution harnesses through recursive task-level refinement and continual harness-level learning, boosting performance across benchmarks without ground-truth verifiers.
- **Abstract:** LLM agents' capabilities depend not only on their underlying models but also on their execution harnesses. Recursive self-improvement (RSI) offers a promising approach to automatically evolve these harnesses. However, deploying RSI in open-world settings still faces two critical challenges. First, open-world tasks are typically unseen during the harness design phase and novel at test time, leaving no ground-truth verifiers to reliably guide online harness edits. Second, the RSI process remains highly task-specific and fails to generalize to novel scenarios. We introduce Harness^2, a plug-and-…
- **Upvotes:** 72

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Harness^2: Recursive Agent Harnessing for an Open World
kern: Harness² improves agent execution harnesses through recursive task-level refinement and continual harness-level learning, boosting performance across benchmarks without ground-truth verifiers.
relevance: recursive agent harnessing
```

**URL check:** https://arxiv.org/abs/2610.14224


### Your Policy Is Secretly a Harness: The Decision Geometry of Agent Interfaces

- **Link:** https://arxiv.org/abs/2610.37255
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Under KL-regularized control, a policy encodes its harness preferences, so deployed performance equals harness potential minus policy mismatch, and harness comparisons must separate these terms to predict training gains.
- **Abstract:** Language model agents are post-trained and deployed through a harness, the prompts, tools, and control logic that present a task to the model and execute its outputs. Harnesses are often revised and judged by how an already trained model performs under them, which assumes that what the model learned under one harness carries over to the next. We ask what a policy learns from its harness and what survives when the harness changes. Under KL-regularized control, we show that the log odds of an optimal policy recover how strongly its harness favors each action over the others, so a trained policy…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Your Policy Is Secretly a Harness: The Decision Geometry of Agent Interfaces
kern: Under KL-regularized control, a policy encodes its harness preferences, so deployed performance equals harness potential minus policy mismatch, and harness comparisons must separate these terms to predict training gains.
relevance: policy-harness mismatch; decision geometry
```

**URL check:** https://arxiv.org/abs/2610.37255


### ParetoSaddler: Pareto-Guided Optimization of Agent Harnesses for Quality and Cost

- **Link:** https://arxiv.org/abs/2611.02079
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** ParetoSaddler improves LLM agent harnesses by separately promoting intermediate candidates via Bayesian bootstrap Pareto support and selecting final deployments, boosting quality while reducing cost.
- **Abstract:** Harness optimization can substantially improve LLM agents without modifying model weights, but existing methods primarily optimize response quality. Extending them to joint quality--cost optimization introduces a challenge: applying the deployment preference during intermediate updates can prematurely reject candidates that are valuable for later improvements. We introduce ParetoSaddler, which addresses this mismatch by separating intermediate candidate promotion from final deployment selection. At each iteration, an optimizer updates a parent harness to produce a candidate, and then compares…
- **Upvotes:** 21

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: ParetoSaddler: Pareto-Guided Optimization of Agent Harnesses for Quality and Cost
kern: ParetoSaddler improves LLM agent harnesses by separately promoting intermediate candidates via Bayesian bootstrap Pareto support and selecting final deployments, boosting quality while reducing cost.
relevance: Pareto harness optimization quality/cost
```

**URL check:** https://arxiv.org/abs/2611.02079


### Elicitation or Expansion? Demystifying Gains from Agent Harness Optimization

- **Link:** https://arxiv.org/abs/2610.27889
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Harness optimization improves language model agents by altering task coverage and reliability differently than scaling or inference-time compute, with gains varying by difficulty and attempt budget.
- **Abstract:** Recent studies in harness optimization have shown substantial performance gains in language model agents without updating model weights. A well-designed harness more effectively leverages the underlying model's capabilities by shaping context, tool use, and execution workflows. However, naïve success rates alone do not fully characterize whether optimized harness yields more reliable success on tasks already within reach (elicitation) or a broader range of solvable tasks (expansion). This distinction is crucial for recursive self-improvement and evolutionary search, as expansion may provide a…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Elicitation or Expansion? Demystifying Gains from Agent Harness Optimization
kern: Harness optimization improves language model agents by altering task coverage and reliability differently than scaling or inference-time compute, with gains varying by difficulty and attempt budget.
relevance: what harness optimization gains come from
```

**URL check:** https://arxiv.org/abs/2610.27889


### The Agentic Scientist: Orchestrating Coding Agents for Automated Scientific (Co-)Discovery

- **Link:** https://arxiv.org/abs/2610.18933
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** The Agentic Scientist is a distributed pipeline that integrates coding agents with human researchers to automate computational research stages from ideation to reporting, using meta-controlled orchestration and self-verification.
- **Abstract:** Modern coding agents are fundamentally reshaping the role of human input for computational research: they write code, launch in silico experiments, analyze their results, and autonomously operate with ever-increasing time horizons. Despite these developments, fully autonomous research agents suffer from a limited ideation radius and myopic hill-climbing search dynamics. To bridge this gap, we introduce The Agentic Scientist, an end-to-end distributed pipeline for human researchers to conduct computational research alongside modern coding agents. Building on its predecessor, our system decompo…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: The Agentic Scientist: Orchestrating Coding Agents for Automated Scientific (Co-)Discovery
kern: The Agentic Scientist is a distributed pipeline that integrates coding agents with human researchers to automate computational research stages from ideation to reporting, using meta-controlled orchestration and self-verification.
relevance: orchestrating coding agents for discovery
```

**URL check:** https://arxiv.org/abs/2610.18933


### Video-Coder: Reinforcing Agentic Coding for Video Generation

- **Link:** https://arxiv.org/abs/2611.09894
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Video-Coder is a code-driven video generation agent that writes and executes code to build structured 3D draft videos, then uses supervised fine-tuning and reinforcement learning with execution and video rewards to improve controllable video generation.
- **Abstract:** Recent years have witnessed remarkable progress in video generation in terms of visual quality and temporal consistency. However, generating videos with precise spatial structure, coherent motion dynamics, and controllable scene composition remains challenging. In this paper, we introduce Video-Coder, the first attempt to train a code-driven video generation agent, which autonomously writes and executes code to construct a dynamic 3D scene (Draft Video) that provides structure and motion signals to downstream video generators. To support this paradigm, we design a dedicated data pipeline and…
- **Upvotes:** 22

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Video-Coder: Reinforcing Agentic Coding for Video Generation
kern: (skip: video generation coding)
relevance: video generation coding
```

**URL check:** https://arxiv.org/abs/2611.09894


### MTAC-IFBench: Benchmarking Instruction-Following in Multi-Turn Agentic Coding

- **Link:** https://arxiv.org/abs/2609.14992
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A new benchmark evaluates multi-turn instruction adherence for autonomous coding agents across complex, constraint-rich development sessions.
- **Abstract:** Recently, the rapid development of large language models (LLMs) has reshaped software engineering by enabling autonomous code agents that plan, execute, and utilize external tools iteratively to tackle complex tasks. Beyond achieving functional correctness, these agents must faithfully follow process instructions and constraints throughout the development lifecycle. However, existing benchmarks typically focus on final functional correctness or confine instruction-following evaluation to single-turn, general chat or simple code generation scenarios, leaving instruction-following in multi-turn…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: MTAC-IFBench: Benchmarking Instruction-Following in Multi-Turn Agentic Coding
kern: A new benchmark evaluates multi-turn instruction adherence for autonomous coding agents across complex, constraint-rich development sessions.
relevance: multi-turn instruction following
```

**URL check:** https://arxiv.org/abs/2609.14992


### Adversarial Speculative Reasoning Improves Long Horizon Agents

- **Link:** https://arxiv.org/abs/2611.05345
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Speculative decoding can be trained to reject critical reasoning tokens so they are verified by the target model, reducing numerical noise and improving long-horizon agent accuracy without altering the target model.
- **Abstract:** Speculative decoding has been treated purely as a systems optimization that speeds up large language model decoding without changing the model behavior. Under this view, the growing effort to train better draft models has been focused solely on acceptance rate. We argue that this view does not hold true for long-horizon agent reasoning. Measuring frontier open-weight models on complex agentic tasks with different speculative decoding approaches, we found that numerical noise grows within verification windows, and the draft acceptance results of the thinking process can change the output distr…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Reasoning
title: Adversarial Speculative Reasoning Improves Long Horizon Agents
kern: Speculative decoding can be trained to reject critical reasoning tokens so they are verified by the target model, reducing numerical noise and improving long-horizon agent accuracy without altering the target model.
relevance: speculative decoding / reasoning tokens
```

**URL check:** https://arxiv.org/abs/2611.05345


### AgentSWE: Can Coding Agents Build the Agent You Actually Want?

- **Link:** https://arxiv.org/abs/2610.13361
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** AgentSWE evaluates whether coding agents build software that truly meets user requirements across creation, editing, and optimization stages, revealing widespread failures to deliver faithful behavior.
- **Abstract:** As the production of software passes into the hands of software itself, coding agents are increasingly commissioned to build agents fitted to their users' own workflows. This delegation carries a quiet assumption, that the delivered agent will faithfully serve the requirement it was built for, rather than merely appear to. No existing benchmark tests that assumption. We introduce AgentSWE, a benchmark for agent software engineering spanning three stages of the agent development lifecycle: Creation of a complete agent from a natural-language requirement, Editing of production agent codebases,…
- **Upvotes:** 53

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: AgentSWE: Can Coding Agents Build the Agent You Actually Want?
kern: AgentSWE evaluates whether coding agents build software that truly meets user requirements across creation, editing, and optimization stages, revealing widespread failures to deliver faithful behavior.
relevance: coding agents meeting user requirements
```

**URL check:** https://arxiv.org/abs/2610.13361


### AsynCodeBench: Benchmarking Collaboration of Asynchronous Multi-Agent Systems in Software Engineering

- **Link:** https://arxiv.org/abs/2609.32662
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** AsynCodeBench introduces dependency-level metrics to evaluate cross-agent collaboration in multi-agent coding, revealing that coordination improves in concentrated bursts rather than gradually.
- **Abstract:** Multi-agent coding has emerged as an increasingly active direction in software engineering, where complex development tasks are decomposed across multiple specialized agents working on different parts of the problem. Despite the shift from individual problem solving to distributed collaboration, multi-agent systems still lack a direct measure of collaboration and are largely evaluated through task-level outcomes inherited from single-agent coding, conflating individual coding capability with cross-agent coordination. We introduce AsynCodeBench, a dependency-centric benchmark for asynchronous…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Graph Engineering
title: AsynCodeBench: Benchmarking Collaboration of Asynchronous Multi-Agent Systems in Software Engineering
kern: AsynCodeBench introduces dependency-level metrics to evaluate cross-agent collaboration in multi-agent coding, revealing that coordination improves in concentrated bursts rather than gradually.
relevance: async multi-agent collaboration benchmark
```

**URL check:** https://arxiv.org/abs/2609.32662


### Duopra: From Full-Duplex Conversation to Full-Duplex Agency

- **Link:** https://arxiv.org/abs/2611.25773
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Full-duplex interaction models exhibit strong conversational agency, enabling natural, low-latency turn-taking, backchannels, and interruptions. However, completing tasks further requires task agency: timely tool invocation and argument revision following user corrections. Frontend-backend agents separate initiation from execution: the frontend decides whether and what to request, while the backend determines how. Execution can be offloaded, but unsent requests cannot be executed, and incomplete ones can misdirect the backend. On Full-Duplex-Bench v3 (FDB v3), most failures of Realtime-Venus-…
- **Upvotes:** 17

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Duopra: From Full-Duplex Conversation to Full-Duplex Agency
kern: (skip: full-duplex conversation)
relevance: full-duplex conversation
```

**URL check:** https://arxiv.org/abs/2611.25773


### Lost in the Hallway: Benchmarking Persistent Spatial Memory Across Revisits

- **Link:** https://arxiv.org/abs/2611.21485
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Persistent spatial understanding is essential for embodied agents to operate reliably in environments they repeatedly encounter. It requires recognizing revisited places despite viewpoint changes, distinguishing them from similar-looking rooms, and updating memories as environments change. Yet existing evaluations often leave physical place identity across separated visits implicit. We introduce ReSpaceBench, a benchmark comprising 3,244 questions across 590 synthetic and real-home scenes, organized into 9 tasks spanning room association, persistent state tracking, and downstream reasoning. C…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Lost in the Hallway: Benchmarking Persistent Spatial Memory Across Revisits
kern: Persistent spatial understanding is essential for embodied agents to operate reliably in environments they repeatedly encounter. It requires recognizing revisited places despite viewpoint changes, distinguishing them from similar-looking rooms, and updating memories as environments change. Yet existing evaluations…
relevance: spatial memory across revisits
```

**URL check:** https://arxiv.org/abs/2611.21485


### AgentRoboCritic: Understanding the Capability of Frontier Agents on Direct Robot Control

- **Link:** https://arxiv.org/abs/2611.26613
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Frontier multimodal language agents such as GPT-6 Astra have demonstrated strong capabilities in controlling robots directly via low-level numerical actions without high-level primitives. However, existing benchmarks report only episode-level success rates, which show neither how these agents succeed nor where they fail. In this paper, we present a systematic action-level analysis of frontier agents on direct robot control across 12 manipulation benchmarks. We introduce AgentRoboCritic, an intent-grounded critique framework in which the policy agent states a local intent alongside each action…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: AgentRoboCritic: Understanding the Capability of Frontier Agents on Direct Robot Control
kern: Frontier multimodal language agents such as GPT-6 Astra have demonstrated strong capabilities in controlling robots directly via low-level numerical actions without high-level primitives. However, existing benchmarks report only episode-level success rates, which show neither how these agents succeed nor where they…
relevance: frontier agents on direct robot control
```

**URL check:** https://arxiv.org/abs/2611.26613


### Intent Contracts: Taking Tools Away from Agents

- **Link:** https://arxiv.org/abs/2611.24025
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Intent contracts, in which a planner submits logged contracts and a trusted model writes tool calls, do not reduce unauthorized actions and match blind review, but complete more benign over-reach tasks than an intent-visible reviewer.
- **Abstract:** Intent contracts are an authorization interface for tool-using LLM agents in which the planning model holds no tools. For each step it submits a short logged contract: a goal, a verbatim quotation of the user, and scope fields. Code validates the contract, and a small trusted model checks it against the user's words and writes the tool call itself. Provided the validation and dispatch code is correct, every executed call is written by the trusted model, the planner's influence on a call is confined to a contract logged before it, and the trusted side decides how much of a request to carry out…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Intent Contracts: Taking Tools Away from Agents
kern: Intent contracts, in which a planner submits logged contracts and a trusted model writes tool calls, do not reduce unauthorized actions and match blind review, but complete more benign over-reach tasks than an intent-visible reviewer.
relevance: intent contracts; tool authorization
```

**URL check:** https://arxiv.org/abs/2611.24025


### Motion Mamba 2.0: Autoregressive Diffusion Mamba for Long-Horizon Humanoid Control

- **Link:** https://arxiv.org/abs/2611.29897
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Long-horizon, real-time controllable motion generation is essential for interactive animation and humanoid robotics, where an agent must respond to changing instructions and spatial goals while moving. Existing autoregressive diffusion methods generate motion incrementally, but bounded attention caches limit access to distant history, while repeated denoising introduces substantial inference overhead. We present Motion Mamba 2.0, a Mamba-based root-body diffusion architecture that integrates local attention, resumable recurrent states, and persistent content memory (PCM) for long-horizon cont…
- **Upvotes:** 218

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Motion Mamba 2.0: Autoregressive Diffusion Mamba for Long-Horizon Humanoid Control
kern: (skip: humanoid motion generation)
relevance: humanoid motion generation
```

**URL check:** https://arxiv.org/abs/2611.29897


### 3AGameFactory-Motion: Agentic Rigging and Reliable Complex Motion Generation for Diverse 3D Assets

- **Link:** https://arxiv.org/abs/2611.30013
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A new benchmark evaluates rigging and motion generation across six 3D morphology categories, compares specialized, video-based, and agent-driven paradigms, and proposes an agentic framework that writes compact parametric skeleton and motion programs executed deterministically for reliable control.
- **Abstract:** Animating arbitrary 3D assets from instructions requires both structural inference and motion control, yet existing motion benchmarks mostly cover conventional human or animal skeletons with simple instructions. We introduce DivDynBench, which evaluates rigging and motion generation across six morphology categories, with instructions requiring multi-phase part coordination and explicit timing, angle, repetition, and trajectory constraints. With large language models, we systematically compare three common paradigms: specialized motion generation, video generation followed by motion recovery,…
- **Upvotes:** 62

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: 3AGameFactory-Motion: Agentic Rigging and Reliable Complex Motion Generation for Diverse 3D Assets
kern: A new benchmark evaluates rigging and motion generation across six 3D morphology categories, compares specialized, video-based, and agent-driven paradigms, and proposes an agentic framework that writes compact parametric skeleton and motion programs executed deterministically for reliable control.
relevance: agentic 3D rigging/motion
```

**URL check:** https://arxiv.org/abs/2611.30013


### Innata-0: A Native Embodied World System with Model-Agent Co-Design

- **Link:** https://arxiv.org/abs/2611.30254
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Innata-0 is a native embodied world system that co-designs a world-action model and an agent to enable reliable long-horizon physical behaviors through integrated understanding, prediction, action generation, memory, verification, and recovery.
- **Abstract:** The physical world is open-ended, dynamic, and partially observable. While foundation models have advanced embodied intelligence, standalone models struggle with long-horizon execution, and simply integrating models with agents may lead to inconsistencies between planning and physical control. To support reliable and adaptive behaviors in the physical world, we introduce Innata-0, a native embodied world system. Innata-0 jointly designs an embodied world-action model and an agent to combine their complementary strengths. The model, Innata-0-WAM, adopts a tri-tower Mixture-of-Transformers arch…
- **Upvotes:** 44

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Innata-0: A Native Embodied World System with Model-Agent Co-Design
kern: Innata-0 is a native embodied world system that co-designs a world-action model and an agent to enable reliable long-horizon physical behaviors through integrated understanding, prediction, action generation, memory, verification, and recovery.
relevance: embodied world system
```

**URL check:** https://arxiv.org/abs/2611.30254


### AutoPILOT: A Visual Agent Harness for Real-Time Gameplay

- **Link:** https://arxiv.org/abs/2611.28202
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A harness that lets multimodal foundation models emit primitive actions, open-loop macros, or closed-loop controllers improves real-time game performance and reduces API cost.
- **Abstract:** Multimodal foundation models can play video games well when the game waits for them, but often fail when it keeps running. We find that much of this gap lies in the harness, which decides what the model sees, what it remembers, and how its outputs become actions over time. Existing harnesses such as VISTA improve the first two, yet turn each model call into at most one action, so the agent acts only as often as its model thinks. We introduce AutoPILOT, which changes the third: in each model call, the model can send a primitive action, start an open-loop macro, or write a closed-loop controlle…
- **Upvotes:** 34

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: AutoPILOT: A Visual Agent Harness for Real-Time Gameplay
kern: A harness that lets multimodal foundation models emit primitive actions, open-loop macros, or closed-loop controllers improves real-time game performance and reduces API cost.
relevance: visual harness for gameplay
```

**URL check:** https://arxiv.org/abs/2611.28202


### RUIBench: What Makes a Good Robot-Use Interface?

- **Link:** https://arxiv.org/abs/2611.31115
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Foundation models can reason about complex physical tasks, yet translating this intelligence into reliable robot execution remains challenging. We argue that a critical, often overlooked factor is the robot-use interface (RUI), which determines how agents express and execute physical actions. To systematically study its impact, we introduce RUIBench, comprising 30 manipulation tasks across five suites spanning world knowledge, in-context learning, discovery, dynamic interaction, and contact-rich manipulation. We further develop RUIKit, a unified framework that crosses six action abstractions…
- **Upvotes:** 22

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: RUIBench: What Makes a Good Robot-Use Interface?
kern: Foundation models can reason about complex physical tasks, yet translating this intelligence into reliable robot execution remains challenging. We argue that a critical, often overlooked factor is the robot-use interface (RUI), which determines how agents express and execute physical actions. To systematically study…
relevance: robot-use interface benchmark
```

**URL check:** https://arxiv.org/abs/2611.31115


### Embodied-Harness: Towards Recursive Self-Improvement for Robotic Manipulation

- **Link:** https://arxiv.org/abs/2611.27689
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A dual-agent framework with hierarchical memory and recursive self-improvement enables robotic manipulation agents to convert execution evidence into reusable guidance without updating model parameters.
- **Abstract:** Vision-language model (VLM)-based agents offer a promising approach to robotic manipulation, yet remain limited by inadequate memory organization, uncertain failure attribution, and limited reuse of execution experience. We propose Embodied-Harness, a dual-agent framework that improves manipulation by refining the execution harness without updating model parameters. The Actor interacts with the environment through a robot-control interface, while the Reflector converts execution evidence into reusable operational guidance. Hierarchical Memory Architecture maintains short-term execution contex…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Embodied-Harness: Towards Recursive Self-Improvement for Robotic Manipulation
kern: A dual-agent framework with hierarchical memory and recursive self-improvement enables robotic manipulation agents to convert execution evidence into reusable guidance without updating model parameters.
relevance: recursive self-improvement for manipulation
```

**URL check:** https://arxiv.org/abs/2611.27689


### Lazy Agents Answer Against Their Own Beliefs: Reinforcement Learning with Verifiable Beliefs Teaches Them to Act on What They Believe

- **Link:** https://arxiv.org/abs/2611.32884
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A reinforcement learning method rewards agents for delaying commitment until their inferred posterior over answers is sufficiently narrow, improving evidence-based answering across vision-language benchmarks.
- **Abstract:** AI agents working on long tasks often commit to an answer before they have enough evidence, a behavior called laziness. In our evaluations, they frequently commit even while their stated belief still names several possible answers. An outcome reward at the end of the episode scores only the final answer, so it cannot teach the agent when to commit, because a lucky guess receives the same reward as an answer backed by evidence. During training, however, the simulator can compute the exact posterior over the answer at every step and tell whether the evidence is already enough. We propose Reinfo…
- **Upvotes:** 98

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Reasoning
title: Lazy Agents Answer Against Their Own Beliefs: Reinforcement Learning with Verifiable Beliefs Teaches Them to Act on What They Believe
kern: A reinforcement learning method rewards agents for delaying commitment until their inferred posterior over answers is sufficiently narrow, improving evidence-based answering across vision-language benchmarks.
relevance: belief-based RL for agents
```

**URL check:** https://arxiv.org/abs/2611.32884


### ACAP: Asynchronous Coding Agents for Efficient Robot Control

- **Link:** https://arxiv.org/abs/2611.31205
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Coding agents can construct and revise robot behavior during execution, but using one agent for the whole robot can delay otherwise independent work. We introduce Asynchronous Coding Agents as Policy (ACAP), an asynchronous framework that organizes one robot as a team of persistent agents. Each member reasons and acts for a configurable control group, such as an arm with its gripper or the torso and chassis, enabling asynchronous reasoning and execution. However, different robot components often have physical dependencies that require coordination. To address this challenge, ACAP introduces a…
- **Upvotes:** 63

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: ACAP: Asynchronous Coding Agents for Efficient Robot Control
kern: Coding agents can construct and revise robot behavior during execution, but using one agent for the whole robot can delay otherwise independent work. We introduce Asynchronous Coding Agents as Policy (ACAP), an asynchronous framework that organizes one robot as a team of persistent agents. Each member reasons and…
relevance: async coding agents for robot control
```

**URL check:** https://arxiv.org/abs/2611.31205


### Self-Evolving Evaluation Environments for Computer-Use Agents

- **Link:** https://arxiv.org/abs/2611.30962
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** CUA-SEE is a closed-loop evaluation environment that co-evolves tasks and executable verifiers to adaptively measure computer-use agents’ capabilities, boundaries, and progress reliability.
- **Abstract:** Computer-use agents (CUAs) are rapidly improving, yet their evaluation remains largely static. Existing benchmarks provide a strong foundation, but fixed difficulty ceilings, limited feature coverage, and coarse aggregate scores progressively weaken their discriminative and diagnostic value. We introduce CUA-SEE, a closed-loop evaluation environment that co-evolves tasks and executable verifiers from rollout evidence. It disentangles three objectives: benchmark evolution expands evaluation scope through cohort-calibrated difficulty and coverage growth; diagnostic evolution increases resolutio…
- **Upvotes:** 49

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: Self-Evolving Evaluation Environments for Computer-Use Agents
kern: CUA-SEE is a closed-loop evaluation environment that co-evolves tasks and executable verifiers to adaptively measure computer-use agents’ capabilities, boundaries, and progress reliability.
relevance: self-evolving evaluation environments
```

**URL check:** https://arxiv.org/abs/2611.30962


### S-Mind: Internalizing Multi-View Geometry for Spatial Intelligence

- **Link:** https://arxiv.org/abs/2611.28649
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Spatial intelligence, the ability to reason about 3D space from visual observations, becomes essential as multimodal large language models (MLLMs) move into the physical world. Beyond perceiving each view, it rests on two cornerstones of human cognition: fusing multiple views into one coherent 3D scene and mentally transforming that scene to new viewpoints as reasoning unfolds. Yet our spatial probes reveal that MLLMs largely lack both capabilities, even after spatial fine-tuning. We therefore present S-Mind, which internalizes multi-view geometry within the MLLM through a compact set of spat…
- **Upvotes:** 41

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: S-Mind: Internalizing Multi-View Geometry for Spatial Intelligence
kern: Spatial intelligence, the ability to reason about 3D space from visual observations, becomes essential as multimodal large language models (MLLMs) move into the physical world. Beyond perceiving each view, it rests on two cornerstones of human cognition: fusing multiple views into one coherent 3D scene and mentally…
relevance: spatial intelligence geometry
```

**URL check:** https://arxiv.org/abs/2611.28649


### PartAgent: Agentic 3D Part Segmentation via Expert Integration and Closed-Loop Refinement

- **Link:** https://arxiv.org/abs/2611.32554
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A training-free agentic framework integrates pretrained 3D and 2D experts with closed-loop refinement to achieve state-of-the-art 3D part segmentation across multiple benchmarks.
- **Abstract:** Segmenting a 3D object into semantically meaningful parts requires joint reasoning about geometric structure and semantic context. Pretrained 3D experts provide spatially grounded region proposals, while 2D experts provide semantic cues for identifying object parts. The challenge is to integrate these complementary capabilities into a framework that can both produce meaningful part segmentations and progressively refine them. We present PartAgent, a training-free agentic framework for 3D part segmentation built upon two complementary modules: (i) Structural-Semantic Expert Integration combine…
- **Upvotes:** 34

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: PartAgent: Agentic 3D Part Segmentation via Expert Integration and Closed-Loop Refinement
kern: (skip: 3D part segmentation)
relevance: 3D part segmentation
```

**URL check:** https://arxiv.org/abs/2611.32554


### ICLWorld: Benchmarking In-Context Learning of Agents from Digital to Physical Worlds

- **Link:** https://arxiv.org/abs/2611.32649
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** An online benchmark evaluates in-context learning across computer-use and robot-use agent tasks, revealing large gaps between digital and physical performance and between recognizing rules and acting on them.
- **Abstract:** In-context learning (ICL) lets agents acquire new rules from context and adapt to user-specific requirements at inference time. The same frontier agents now operate both computers and robots, yet their ICL remains insufficiently assessed: existing benchmarks are largely offline, rely on text or static images, and risk training-data contamination, while robot evaluations are limited to method-level ablations. We present ICLWorld, an online benchmark that evaluates the ICL of agents from digital to physical worlds, covering computer use and robot use, together with UIverse, a unified harness th…
- **Upvotes:** 18

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: ICLWorld: Benchmarking In-Context Learning of Agents from Digital to Physical Worlds
kern: An online benchmark evaluates in-context learning across computer-use and robot-use agent tasks, revealing large gaps between digital and physical performance and between recognizing rules and acting on them.
relevance: in-context learning digital vs physical
```

**URL check:** https://arxiv.org/abs/2611.32649


### PhyCoVE: Benchmarking Physical Counterfactual Video Editing across Diverse Material Dynamics

- **Link:** https://arxiv.org/abs/2611.29184
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** PhyCoVE, a 533-case benchmark, and counterfactual fidelity evaluate video editing models on physical counterfactual edits involving rigid, elastic, and fluid dynamics, showing that even the best model reproduces only about one seventh of the physical change.
- **Abstract:** Physical counterfactual video editing turns a source video and a language-specified physical edit at a given execution frame into a counterfactual video that shows how the scene would evolve after the edit. Existing evaluations with counterfactual target videos mainly cover object removal or specific rigid-body motions, although real scenes also involve elastic deformation, fluid flow, and interactions among rigid bodies, elastic solids, and fluids. We introduce PhyCoVE, a benchmark of 533 cases on 110 source videos that covers rigid, elastic, and fluid dynamics in five interaction patterns,…
- **Upvotes:** 15

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: PhyCoVE: Benchmarking Physical Counterfactual Video Editing across Diverse Material Dynamics
kern: (skip: physical video editing benchmark)
relevance: physical video editing benchmark
```

**URL check:** https://arxiv.org/abs/2611.29184


### MAGPIE: Agentic Multi-Reference Image Generation via Executable Scene Construction

- **Link:** https://arxiv.org/abs/2611.32462
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Multi-reference image generation requires a model to preserve the appearance of selected subjects while arranging them according to an instruction. Despite recent progress in reference-based generation and compositional control, reliably organizing selected subjects into the intended scene remains challenging. Although existing methods provide various forms of compositional guidance, the planned relationships are not always explicitly instantiated for inspection and refinement before image synthesis. To address this limitation, we introduce MAGPIE, which represents the intended composition as…
- **Upvotes:** 13

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: MAGPIE: Agentic Multi-Reference Image Generation via Executable Scene Construction
kern: (skip: multi-reference image generation)
relevance: multi-reference image generation
```

**URL check:** https://arxiv.org/abs/2611.32462


### Coding4Games: Can Modern Coding Agents Play Modern Video Games?

- **Link:** https://arxiv.org/abs/2611.31974
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Games, especially modern AAA games, challenge language models to perceive complex scenes, control actions, and make decisions over long horizons. Existing game benchmarks primarily test language models as computer-use agents that query a language model throughout play, incurring repeated inference cost and, in real-time games, acting while the environment continues to evolve. We ask whether coding agents can learn from game interaction to develop standalone game-playing programs that run without language model inference. We thus introduce Coding4Games, a benchmark for evaluating whether codin…
- **Upvotes:** 13

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Coding4Games: Can Modern Coding Agents Play Modern Video Games?
kern: Games, especially modern AAA games, challenge language models to perceive complex scenes, control actions, and make decisions over long horizons. Existing game benchmarks primarily test language models as computer-use agents that query a language model throughout play, incurring repeated inference cost and, in…
relevance: coding agents playing video games
```

**URL check:** https://arxiv.org/abs/2611.31974


### Nemotron-Labs-VisualCreation: Pixel as Code for Agentic Visual Creation

- **Link:** https://arxiv.org/abs/2611.31358
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Visual creation demands expressive imagery together with precise control over text, layout, and structure. We introduce Nemotron-Labs-VisualCreation, an agentic framework that connects these capabilities through Pixel as Code. Raster images are represented by learned discrete visual tokens, while structured artifacts use explicit programs. A shared generation-and-rendering interface connects these representations to visual feedback across images, vector graphics, webpages, and documents. A Nemotron-native harness coordinates planning and raster candidate selection, with targeted repair for ed…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Nemotron-Labs-VisualCreation: Pixel as Code for Agentic Visual Creation
kern: (skip: agentic visual creation)
relevance: agentic visual creation
```

**URL check:** https://arxiv.org/abs/2611.31358


### AdProducer: Towards Agentic Advertising Video Generation

- **Link:** https://arxiv.org/abs/2611.31466
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** An end-to-end multimodal agent framework autonomously researches products and creates selling-point-driven storyboards to guide a frozen video generator, trained via supervised fine-tuning and reinforcement learning to produce effective advertising videos.
- **Abstract:** Recent advances in video generation have made automated advertising production increasingly feasible. However, an effective advertisement must faithfully represent the product and communicate its selling points through compelling visual storytelling, which requires more than visual synthesis: it calls for deeper product understanding and strategic decisions about how to present product value. Crucially, product research and creative design are closely intertwined, as the information gathered about a product determines which features can be faithfully demonstrated and how they should be presen…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: AdProducer: Towards Agentic Advertising Video Generation
kern: (skip: advertising video generation)
relevance: advertising video generation
```

**URL check:** https://arxiv.org/abs/2611.31466


### $μ$-Bench: Benchmarking Multi-User Task Completion in Shared Interaction Voice Agents

- **Link:** https://arxiv.org/abs/2611.34920v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Voice agents in shared spaces must satisfy interdependent multi-user requests while upholding per-user authority, privacy, and task constraints. Existing evaluations offer limited coverage when participants react throughout a session. We introduce $μ$-Bench, a benchmark for joint task completion in closed-loop, full-duplex multi-user voice interaction. Simulated participants act from isolated profiles of goals, knowledge, and permissions, adapting to the agent's speech and tool outcomes. Across 20 domains, 100 scenarios vary group size, acoustics, and follow-up demands to form 800 cases (408…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: $μ$-Bench: Benchmarking Multi-User Task Completion in Shared Interaction Voice Agents
kern: (skip: voice-agent product UX)
relevance: voice-agent product UX
```

**URL check:** https://arxiv.org/abs/2611.34920v1


### Shape-Aware Three-Way Merge for RDF Knowledge Graphs: The schema defines the conflict: an implementation and evaluation

- **Link:** https://arxiv.org/abs/2611.34870v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Merging RDF serializations creates ordering conflicts and misses semantic ones. We describe and evaluate a three-way merge in which the schema defines a conflict: set algebra combines canonical triples, and a slot is contended only where a SHACL shape bounds its cardinality and both sides' changes cannot stand within that bound. Unbounded predicates union; contended slots go to a person. The same shapes graph validates the result. We do not claim the first three-way merge for RDF. Our contribution is an implementation in a production multi-agent store and an evaluation against a reimplementat…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Shape-Aware Three-Way Merge for RDF Knowledge Graphs: The schema defines the conflict: an implementation and evaluation
kern: (skip: RDF merge)
relevance: RDF merge
```

**URL check:** https://arxiv.org/abs/2611.34870v1


### DRBench Pro: A Knowledge-Centric Benchmark for Professional Deep Research Agents

- **Link:** https://arxiv.org/abs/2611.34852v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Deep research agents gather information from multiple sources and synthesize it into reports on complex, open-ended questions. Existing benchmarks assess report quality along several dimensions, but lack a dedicated knowledge-centric evaluation of which research directions a report covers and how deeply it explores them. We introduce DRBench Pro, a benchmark that makes structured knowledge coverage the primary evaluation target. Our automated pipeline builds local knowledge trees from Wikipedia and uses sampled subgraphs to generate research queries and evidence-grounded rubrics. Each rubric…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: DRBench Pro: A Knowledge-Centric Benchmark for Professional Deep Research Agents
kern: Deep research agents gather information from multiple sources and synthesize it into reports on complex, open-ended questions. Existing benchmarks assess report quality along several dimensions, but lack a dedicated knowledge-centric evaluation of which research directions a report covers and how deeply it explores…
relevance: deep research agent benchmark
```

**URL check:** https://arxiv.org/abs/2611.34852v1


### Playfulness as Feedback for Agentic Game Development

- **Link:** https://arxiv.org/abs/2611.33457
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Play2Evolve uses AI agents to iteratively playtest, diagnose, and improve generated games through initialization, refinement, and evolution stages, enhancing functionality, visuals, and gameplay quality.
- **Abstract:** Coding agents can generate runnable games from natural-language descriptions. However, a runnable game does not guarantee an excellent gameplay experience for players. In our view, a playful game should provide 1) reliable core functionality, 2) appealing visual design and assets, and 3) rich gameplay that supports exploration and progression. How agents can improve these aspects of playfulness remains underexplored. In our work, we propose Play2Evolve, a recursive game development framework with three stages: Initialization, Refinement, and Evolution. Using playfulness as feedback, agents pl…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Playfulness as Feedback for Agentic Game Development
kern: (skip: game development feedback)
relevance: game development feedback
```

**URL check:** https://arxiv.org/abs/2611.33457


### EgoUseBench: Benchmarking Computer-Use Agents under Evolving First-Person Contexts

- **Link:** https://arxiv.org/abs/2611.34466
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** AI wearables, such as smart glasses, extend the context available to agents beyond digital environments to users' physical surroundings. With these devices, computer tasks can originate from users' ongoing activities rather than solely from explicit instructions. Through first-person observations, agents can identify objects and activities relevant to user requests and ground digital tasks in the surrounding context. We call this interaction paradigm Ego Use. However, first-person observations are limited by the wearer's viewpoint and may provide incomplete or ambiguous evidence of ongoing ac…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: EgoUseBench: Benchmarking Computer-Use Agents under Evolving First-Person Contexts
kern: AI wearables, such as smart glasses, extend the context available to agents beyond digital environments to users' physical surroundings. With these devices, computer tasks can originate from users' ongoing activities rather than solely from explicit instructions. Through first-person observations, agents can identify…
relevance: computer-use agents, first-person context
```

**URL check:** https://arxiv.org/abs/2611.34466


### SEEK: Self-Evolution through Execution Knowledge for Agentic Robot Manipulation

- **Link:** https://arxiv.org/abs/2611.33915
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** SEEK retains executable manipulation procedures and measured action effects across attempts, enabling fixed foundation-model robots to improve without retraining.
- **Abstract:** General-purpose multimodal foundation models enable robots to adapt during deployment from observations and execution feedback, without task-specific demonstrations or training. However, the robot retains what it learns only in the model's working context. Once the task ends, it loses this execution knowledge, such as how to carry a bowl between two grippers. On the next attempt at the task, the robot may take just as long and repeat the same mistakes. To avoid this repetition, robots must retain execution knowledge across attempts. Yet replaying past actions is insufficient, because their ef…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: SEEK: Self-Evolution through Execution Knowledge for Agentic Robot Manipulation
kern: SEEK retains executable manipulation procedures and measured action effects across attempts, enabling fixed foundation-model robots to improve without retraining.
relevance: execution knowledge for manipulation
```

**URL check:** https://arxiv.org/abs/2611.33915


### Beyond Code and Pixels: Co-Generating Editable and Visually Rich Presentations

- **Link:** https://arxiv.org/abs/2611.28010
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** SlidesWeaver combines language and vision agents with diffusion-based planning and shared state to generate editable, high-quality PPTX presentations while preserving native text and layout.
- **Abstract:** Generating PPTX presentations is a structured task that requires semantic planning, visual composition, precise layout, and editability, motivating collaboration among specialized agents. However, programmatic methods offer editability but often produce rigid designs, while image-based methods provide visual richness but flatten content into difficult-to-edit pixels. A hybrid system can combine these strengths, but must coordinate interdependent decisions across content, layout, and appearance. To address this challenge, we propose SlidesWeaver, a hybrid multi-agent system that coordinates la…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Beyond Code and Pixels: Co-Generating Editable and Visually Rich Presentations
kern: (skip: presentation generation)
relevance: presentation generation
```

**URL check:** https://arxiv.org/abs/2611.28010


### DemoFoundry: Toward Scalable Photorealistic Robot Data with Coding Agents and Generative Rendering

- **Link:** https://arxiv.org/abs/2611.34671
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Scaling robot learning requires demonstrations that combine realistic visual observations with reliable action supervision. Simulation-based synthesis faces a substantial visual gap relative to real environments, while video-only generation struggles to maintain physically consistent interactions and provide aligned action labels. We present DemoFoundry, an automated framework that couples coding agents with generative rendering to synthesize photorealistic and physically grounded robot demonstrations. Coding agents both construct aligned real--proxy video pairs from existing robot episodes t…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: DemoFoundry: Toward Scalable Photorealistic Robot Data with Coding Agents and Generative Rendering
kern: Scaling robot learning requires demonstrations that combine realistic visual observations with reliable action supervision. Simulation-based synthesis faces a substantial visual gap relative to real environments, while video-only generation struggles to maintain physically consistent interactions and provide aligned…
relevance: robot data synthesis
```

**URL check:** https://arxiv.org/abs/2611.34671


### SOLVE: Sparse, Ordered Keyposes Make LLM Agents Versatile and Efficient Robot Manipulator

- **Link:** https://arxiv.org/abs/2611.34750
- **Source:** HF daily · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** LLM agents have made remarkable progress in robot manipulation, yet they suffer from expensive inference, dense step-by-step control, and tool bottlenecks. We introduce SOLVE, a training-free, versatile and efficient agent policy: a multimodal LLM agent writes a sparse, ordered sequence of 6-DoF end-effector keyposes per call, observes the result, and writes the next, while a motion planner interpolates between them. The agent decides the number and spacing of keyposes for both fast long-range motion and fine-grained manipulation. This granularity matches the sparsity of teleoperated manipula…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: SOLVE: Sparse, Ordered Keyposes Make LLM Agents Versatile and Efficient Robot Manipulator
kern: LLM agents have made remarkable progress in robot manipulation, yet they suffer from expensive inference, dense step-by-step control, and tool bottlenecks. We introduce SOLVE, a training-free, versatile and efficient agent policy: a multimodal LLM agent writes a sparse, ordered sequence of 6-DoF end-effector keyposes…
relevance: sparse keypose manipulation
```

**URL check:** https://arxiv.org/abs/2611.34750


### Has GPT-6-Astra Achieved Embodied Intelligence?

- **Link:** https://arxiv.org/abs/2610.22471
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** GPT-6-Astra achieves high performance across diverse robotic tasks via in-context learning, yet real-world deployment reveals gaps in demonstration cost, execution time, and practical embodied intelligence.
- **Abstract:** GPT-6-Astra demonstrates a level of competence in robotic manipulation and navigation that challenges the conventional paradigm of building specialized models for individual tasks and embodiments. In this report, we ask not only how capable GPT-6-Astra is, but what its capabilities imply for the field. First, we probe the limits of standalone GPT-6-Astra. We conduct a large-scale evaluation across 12 representative benchmarks spanning tabletop manipulation, humanoids, mobile platforms, and dexterous hands. Under a unified protocol that allows in-context learning (ICL) from training-set demons…
- **Upvotes:** 132

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Has GPT-6-Astra Achieved Embodied Intelligence?
kern: GPT-6-Astra achieves high performance across diverse robotic tasks via in-context learning, yet real-world deployment reveals gaps in demonstration cost, execution time, and practical embodied intelligence.
relevance: GPT-6 Astra embodied limits
```

**URL check:** https://arxiv.org/abs/2610.22471


### OmniEdu: Open Foundation Models for Learning and Teaching

- **Link:** https://arxiv.org/abs/2609.23088
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** OmniEdu is a family of instruction-tuned educational foundation models that improve K-12 problem solving, curriculum understanding, and tutoring through capability-balanced training data.
- **Abstract:** Educational foundation models must solve problems, understand curriculum structure, diagnose learner difficulties, and provide appropriate instructional support. Existing educational language models often focus on either problem solving or tutoring, with training mixtures organized by source or task rather than capability. We present OmniEdu, an open family of foundation models for K-12 learning and teaching. Its instruction-tuning corpus combines over 100 educational resources and general instruction sources, organized around four capabilities: subject competence, curriculum grounding, diagn…
- **Upvotes:** 56

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: OmniEdu: Open Foundation Models for Learning and Teaching
kern: (skip: education models)
relevance: education models
```

**URL check:** https://arxiv.org/abs/2609.23088


### Learning from Research: Toward Lifelong Agent Harness Evolution

- **Link:** https://arxiv.org/abs/2609.40169
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A framework uses state-of-the-art research and topic modeling to guide modular improvements in a language agent's harness, enabling proactive lifelong evolution and improving task completion on AppWorld and Tau2-Bench without changing the underlying language model.
- **Abstract:** Language agents are expected to solve increasingly complex tasks, creating a growing need for continual improvement. One promising approach is to evolve the agent harness, the software that governs tool use, memory management, and task execution, while keeping the underlying language model fixed. Recent methods automate this process by using a meta coding agent to modify the harness based on execution feedback. However, relying on that agent's existing knowledge and observed failures can restrict exploration and make adaptation reactive. Inspired by how human experts learn from the research l…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Learning from Research: Toward Lifelong Agent Harness Evolution
kern: A framework uses state-of-the-art research and topic modeling to guide modular improvements in a language agent's harness, enabling proactive lifelong evolution and improving task completion on AppWorld and Tau2-Bench without changing the underlying language model.
relevance: lifelong harness evolution from research
```

**URL check:** https://arxiv.org/abs/2609.40169


### Auriga Technical Report: A Task-Agnostic Agent Harness for Zero-Shot Embodied Manipulation

- **Link:** https://arxiv.org/abs/2611.01112
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Auriga, a task-agnostic agent harness, closes most of the planning-execution gap in zero-shot robot manipulation by combining explicit task beliefs, calibrated 3D measurements, dual-arm control, and execution monitoring, achieving state-of-the-art results on RoboDojo and RoboCasa365.
- **Abstract:** Vision-language models can interpret instructions and plan manipulation tasks, yet struggle when acting directly as robot policies. On RoboDojo, a large planning-execution gap separates high-level task decisions from physical execution: removing arm execution raises GPT-6 Astra's success rate from 22.5% under the reference control interface to 76.2%. We present Auriga, a task-agnostic agent harness that closes 68.3% of this gap in zero-shot manipulation without target-task trials or resets. In Auriga, the model makes all task decisions over an explicit task belief and acts through either dire…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Auriga Technical Report: A Task-Agnostic Agent Harness for Zero-Shot Embodied Manipulation
kern: Auriga, a task-agnostic agent harness, closes most of the planning-execution gap in zero-shot robot manipulation by combining explicit task beliefs, calibrated 3D measurements, dual-arm control, and execution monitoring, achieving state-of-the-art results on RoboDojo and RoboCasa365.
relevance: embodied manipulation harness
```

**URL check:** https://arxiv.org/abs/2611.01112


### Beneath the Surface: What We Overlook When We Talk About Agent Evolution

- **Link:** https://arxiv.org/abs/2611.07624
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Agent harness evolution can improve benchmark performance without weight updates, but gains are unreliable, costly, and transfer inconsistently, motivating preservation-aware evaluation and EvoAudit revisions.
- **Abstract:** Agent harness evolution enables recursive self-improvement (RSI) without updating model weights. We examine whether higher benchmark scores yield reliable, efficient, and transferable improvement. We evaluate four methods across harnesses, general and coding tasks. Repeated evaluations, controlled agent expansion, component interventions, and admission replays reveal recurring patterns. All sixteen evolved agents gain previously uncovered tasks while losing previously covered ones. In one general-task case, reliability rises by 5.2 points despite losing ten previously covered tasks. Most reli…
- **Upvotes:** 25

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Beneath the Surface: What We Overlook When We Talk About Agent Evolution
kern: Agent harness evolution can improve benchmark performance without weight updates, but gains are unreliable, costly, and transfer inconsistently, motivating preservation-aware evaluation and EvoAudit revisions.
relevance: harness evolution gains unreliable
```

**URL check:** https://arxiv.org/abs/2611.07624


### Harness Scaling for Generalizable Agentic Reinforcement Learning

- **Link:** https://arxiv.org/abs/2610.29458
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Harness Scaling improves agentic reinforcement learning by training across diverse execution configurations, boosting generalization to unseen harnesses.
- **Abstract:** Agent harnesses have become a central component of modern agentic systems, shaping how models use tools, manage context, and coordinate long-horizon interaction. Realizing the benefits of these harnesses depends on how effectively the underlying model can make use of them, motivating reinforcement learning directly through the harness. However, existing approaches typically train through a single fixed harness, which can lead to specialization and limited transfer across harness configurations. To address this, we introduce Harness Scaling, a new scaling dimension for agentic RL that extends…
- **Upvotes:** 17

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Harness Scaling for Generalizable Agentic Reinforcement Learning
kern: Harness Scaling improves agentic reinforcement learning by training across diverse execution configurations, boosting generalization to unseen harnesses.
relevance: harness scaling for agentic RL
```

**URL check:** https://arxiv.org/abs/2610.29458


### Vision-as-a-Tool: Visual Harness for Multimodal Agentic Coding

- **Link:** https://arxiv.org/abs/2611.17797
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A new Vision-as-a-Tool paradigm enables text-only and multimodal coding agents to offload or augment visual reasoning by treating multimodal large language models as callable utilities, improving image-to-code and image-to-3D generation.
- **Abstract:** Multimodal agentic coding requires robust visual reasoning to analyze observations and evaluate generated artifacts. Current frameworks largely rely on a Thinking-with-Images paradigm, where agents depend on their intrinsic vision to execute visually grounded tasks. However, this architectural coupling introduces a fundamental bottleneck. Agent performance remains strictly bounded by internal perceptual limitations. Furthermore, text-only agents lack native perception. Without specialized tools, they cannot perform visual reasoning. To overcome these constraints, we introduce the Vision-as-a-…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Prompt Engineering
title: Vision-as-a-Tool: Visual Harness for Multimodal Agentic Coding
kern: A new Vision-as-a-Tool paradigm enables text-only and multimodal coding agents to offload or augment visual reasoning by treating multimodal large language models as callable utilities, improving image-to-code and image-to-3D generation.
relevance: vision-as-a-tool for coding agents
```

**URL check:** https://arxiv.org/abs/2611.17797


### VibePrevisBench: Evaluating Agentic Coding for 4D Scene Generation in Blender

- **Link:** https://arxiv.org/abs/2611.15789
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Controllable real-world video generation models can condition on a rendered graybox proxy video, which fixes layout, motion and camera. Coding agents can build such videos by reconstructing a 4D scene in Blender, yet no benchmark checks both these videos and the long, multi-shot scenes behind them. We introduce VibePrevisBench, a benchmark for 4D scene reconstruction: an agent turns a brief into an executable 4D scene and renders its proxy video. Its 242 tasks span four input kinds, including scripts, photos, continuations, and reference videos. Each delivery is scored along two evaluation di…
- **Upvotes:** 89

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: VibePrevisBench: Evaluating Agentic Coding for 4D Scene Generation in Blender
kern: (skip: Blender scene generation)
relevance: Blender scene generation
```

**URL check:** https://arxiv.org/abs/2611.15789


### AgentDiscover: Autonomous Discovery with Minimal Search Scaffolding

- **Link:** https://arxiv.org/abs/2610.05334
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** AgentDiscover enables a coding agent to plan and remember its own scientific search through a structured idea database, achieving better results at lower cost than fixed human-designed discovery frameworks across multiple domains.
- **Abstract:** Frameworks that use large language models for scientific discovery typically rely on a fixed, human-designed algorithm that decides what the model sees at each step, leaving the model only the role of proposer. The model knows nothing of the search beyond what it is shown. As models grow more capable, a question arises: does a search strategy chosen by a human before the run scale better than promoting the model from proposer to planner and letting it own the search? The Bitter Lesson suggests that choosing the strategy in advance is the kind of hand-designed structure that general methods ev…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: AgentDiscover: Autonomous Discovery with Minimal Search Scaffolding
kern: AgentDiscover enables a coding agent to plan and remember its own scientific search through a structured idea database, achieving better results at lower cost than fixed human-designed discovery frameworks across multiple domains.
relevance: autonomous scientific discovery loop
```

**URL check:** https://arxiv.org/abs/2610.05334


### CliffCompaction: Cost-Efficient Compaction for Long-Horizon Coding Agents

- **Link:** https://arxiv.org/abs/2609.26779
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** CliffCompaction reduces multi-session agent costs by up to 50% through faithful truncation of original context, improving test-time scaling efficiency and sustaining long-horizon learning.
- **Abstract:** Agents often work on complex problems that require millions of tokens of context, which necessitates compacting across sessions due to limited context windows. We develop CliffCompaction, an autocompaction technique that reduces cost by up to 50% under a bounded context while maintaining or improving performance on Terminal-Bench and achieving new levels of efficiency for test-time scaling and state-of-the-art results on KernelBench. The per-rollout savings of CliffCompaction make the performance--cost trade-off of test-time scaling more efficient, adding over 10 percentage points on Terminal…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: CliffCompaction: Cost-Efficient Compaction for Long-Horizon Coding Agents
kern: CliffCompaction reduces multi-session agent costs by up to 50% through faithful truncation of original context, improving test-time scaling efficiency and sustaining long-horizon learning.
relevance: context compaction cost reduction
```

**URL check:** https://arxiv.org/abs/2609.26779


### On the Generalization Limitation of On-Policy Distillation for Post-RL Consolidation

- **Link:** https://arxiv.org/abs/2611.05609
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Multi-teacher on-policy distillation can match in-distribution teacher performance while degrading out-of-distribution generalization, and geometry-based patching plus base-preserving replay can improve retention with limited in-distribution loss.
- **Abstract:** Multi-teacher on-policy distillation (MOPD) extends on-policy distillation (OPD) to consolidate capabilities from multiple teachers. Although prior work reports near-perfect in-distribution (IND) distillation performance, we find that this can mask incomplete capability consolidation beyond the supervised distribution. A preliminary study on synthetic reasoning shows that OPD does not fully transfer teachers' generalization capabilities. We then extend this investigation to real-world tasks, evaluating extrapolative and compositional generalization across mathematical reasoning, coding, agent…
- **Upvotes:** 23

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: On the Generalization Limitation of On-Policy Distillation for Post-RL Consolidation
kern: (skip: on-policy distillation generalization)
relevance: on-policy distillation generalization
```

**URL check:** https://arxiv.org/abs/2611.05609


### What Coding Agents Leave Unsaid: Measuring Task-State Gaps Between Execution and Reports

- **Link:** https://arxiv.org/abs/2610.20003
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** Human supervisors rely on coding agents' reports to assess progress, verify repairs, and decide when to intervene. But a supervisor cannot investigate a failure they were never told occurred. Failed attempts, workarounds, and unresolved risks may disappear from routine reports, leaving supervisors unaware of issues that warrant scrutiny. We conduct CTXGAP, a measurement study quantifying the gap in task-state recoverability between agents' accumulated user-facing reports and their full recorded execution contexts. Across 37 coding tasks and 4,799 valid probes, agents answer 93.6% of task-stat…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: What Coding Agents Leave Unsaid: Measuring Task-State Gaps Between Execution and Reports
kern: Human supervisors rely on coding agents' reports to assess progress, verify repairs, and decide when to intervene. But a supervisor cannot investigate a failure they were never told occurred. Failed attempts, workarounds, and unresolved risks may disappear from routine reports, leaving supervisors unaware of issues…
relevance: task-state gaps in agent reports
```

**URL check:** https://arxiv.org/abs/2610.20003


### ProgramDistill: From Interactive Web Apps to Verifiable Reference-Guided SWE Tasks

- **Link:** https://arxiv.org/abs/2609.18805
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** ProgramDistill introduces a scalable benchmark that evaluates coding agents by requiring them to infer and implement features discovered through interaction with fully functional reference applications.
- **Abstract:** Coding agents are typically evaluated with desired behavior specified through issues or instructions. In practical web development, however, agents may need to infer behavior from working software and implement it in an incomplete application. We introduce ProgramDistill, a benchmark evaluating coding agents on features discovered through interaction with fully functional reference applications. We build ProgramDistill by factorizing applications into features of different granularities, each associated with replayable behaviors executable via its gold patch. Our pipeline, mine-craft-patch, d…
- **Upvotes:** 39

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: ProgramDistill: From Interactive Web Apps to Verifiable Reference-Guided SWE Tasks
kern: ProgramDistill introduces a scalable benchmark that evaluates coding agents by requiring them to infer and implement features discovered through interaction with fully functional reference applications.
relevance: reference-guided SWE tasks
```

**URL check:** https://arxiv.org/abs/2609.18805


### SAIL: Scientific Agentic Intelligence via a Science-Aware Loop

- **Link:** https://arxiv.org/abs/2610.11451
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** SAIL is a 35B-parameter open model for scientific research and coding that improves via agent-driven failure analysis and multi-stage training, achieving strong results with far fewer active parameters.
- **Abstract:** We introduce SAIL, an open model with 35B total and 3B active parameters for literature research, scientific coding, and multi-step research workflows. SAIL is developed through a science-aware improvement loop: agents built on frontier AI models analyze its task failures and construct training tasks that address the underlying capability gaps. The diagnosis examines search and evidence selection in literature tasks, scientific assumptions and reasoning in coding, and planning and revision in longer investigations. The agents draw on paper collections and scientific code repositories to build…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: SAIL: Scientific Agentic Intelligence via a Science-Aware Loop
kern: SAIL is a 35B-parameter open model for scientific research and coding that improves via agent-driven failure analysis and multi-stage training, achieving strong results with far fewer active parameters.
relevance: science-aware agent loop
```

**URL check:** https://arxiv.org/abs/2610.11451


### 3DCodeVerse: Exploring 3D Worlds as Code

- **Link:** https://arxiv.org/abs/2610.22341
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** 3DCodeVerse is a research ecosystem that provides datasets, automated verification harnesses, and empirical guidance to enable scalable, editable, and verifiable 3D content generation via executable code.
- **Abstract:** We introduce 3DCodeVerse, a research ecosystem that enables coding agents to create editable and verifiable 3D content at scale. 3DCodeVerse comprises large-scale, high-quality datasets of executable 3D code, a coding harness for spatial reasoning and automated verification, and practical guidance for 3D coding. First, we construct 3DCodeVerse-2M, a large-scale curated dataset of standalone 3D executable code. We build this corpus by collecting open-source data, converting specialized representations, and generating new programs with coding agents. Each program is packaged with the source fil…
- **Upvotes:** 57

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: 3DCodeVerse: Exploring 3D Worlds as Code
kern: 3DCodeVerse is a research ecosystem that provides datasets, automated verification harnesses, and empirical guidance to enable scalable, editable, and verifiable 3D content generation via executable code.
relevance: agentic 3D-as-code ecosystem
```

**URL check:** https://arxiv.org/abs/2610.22341


### SWEeper-Bench: Can Agents Discover Bugs in Interactive Software?

- **Link:** https://arxiv.org/abs/2610.14096
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** SWEeper-Bench evaluates coding agents on finding and fixing interaction-dependent bugs in web applications through interactive testing and browser-based verification.
- **Abstract:** Coding agents increasingly interact with users by generating interactive software on the fly rather than replying in text, yet many bugs in such software reveal themselves only after multi-step interactions. Today, users must discover these bugs and wait for fixes, making the development loop slow and expensive. Existing benchmarks typically assume the bugs have already been identified, leaving agents' ability to find interaction-dependent failures largely unevaluated. We introduce SWEeper-Bench, 200 tasks built from real bug fixes in 200 widely used open-source web applications. Each task gi…
- **Upvotes:** 6

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: SWEeper-Bench: Can Agents Discover Bugs in Interactive Software?
kern: SWEeper-Bench evaluates coding agents on finding and fixing interaction-dependent bugs in web applications through interactive testing and browser-based verification.
relevance: interactive bug discovery benchmark
```

**URL check:** https://arxiv.org/abs/2610.14096


### PyRUA-DataFarm: LLM Agent as a Cost-Efficient Teleoperator for Real-Ready Robot Data

- **Link:** https://arxiv.org/abs/2611.05320
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** A coding agent automates robot demonstration generation by simulating tasks, rendering photorealistic videos, and producing deployable training data at lower cost than teleoperation.
- **Abstract:** Teleoperation remains the default way to collect robot demonstrations, but every episode costs robot and operator time, and every new task starts from scratch. We ask whether a coding agent can take over the teleoperator's job. In our DataFarm, the agent receives a data request and one calibration episode of the robot in the target scene and rebuilds the task in simulation: it writes the scene, an expert controller, and a success judge. The simulator supplies exact actions, and a video model conditioned on real images renders each rollout as photographic video, generating all camera views tog…
- **Upvotes:** 28

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: PyRUA-DataFarm: LLM Agent as a Cost-Efficient Teleoperator for Real-Ready Robot Data
kern: A coding agent automates robot demonstration generation by simulating tasks, rendering photorealistic videos, and producing deployable training data at lower cost than teleoperation.
relevance: agent as teleoperator
```

**URL check:** https://arxiv.org/abs/2611.05320


### τ^τ-Bench: An Environment for End-To-End, Realistic Agent Construction

- **Link:** https://arxiv.org/abs/2609.04611
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** The τ^τ-bench benchmark evaluates coding agents on building real-world customer-service agents from business records, client requirements, and production APIs, revealing substantial gaps versus expert performance.
- **Abstract:** LLM agents are rapidly becoming production software, deployed to handle customer service, adjudicate disputes, and operate internal systems. Notably, the work of building them is increasingly handed to coding agents, yet existing benchmarks say little about whether an AI system can deliver one under the conditions of a real client engagement. We introduce τ^τ-bench (pronounced hyper-tau-bench), a benchmark that makes agent construction the task. A developer agent is given the records a business actually keeps, a client who holds requirements, a production API that operations must run through,…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: τ^τ-Bench: An Environment for End-To-End, Realistic Agent Construction
kern: The τ^τ-bench benchmark evaluates coding agents on building real-world customer-service agents from business records, client requirements, and production APIs, revealing substantial gaps versus expert performance.
relevance: end-to-end agent construction benchmark
```

**URL check:** https://arxiv.org/abs/2609.04611


### SWE-Critix: Post-Training Generalist Verifiers for Assessing Coding-Agent Trajectories

- **Link:** https://arxiv.org/abs/2610.13356
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** SWE-Critix trains generalist verifiers via supervised fine-tuning and reinforcement learning to classify and explain coding-agent execution outcomes, improving accuracy substantially over base reasoning models.
- **Abstract:** Coding agents are increasingly deployed for end-to-end software engineering tasks, where a readily available oracle evaluator that defines the success criteria is often absent. This motivates verifications for coding agents that can reliably judge and explain their behavior. However, verification is non-trivial as coding agents are increasingly capable of solving long-horizon software engineering tasks. Their execution trajectories can be extremely long, containing hundreds of iterative interactions with code repositories and external tools. Existing verifiers either rely on general-purpose L…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: SWE-Critix: Post-Training Generalist Verifiers for Assessing Coding-Agent Trajectories
kern: SWE-Critix trains generalist verifiers via supervised fine-tuning and reinforcement learning to classify and explain coding-agent execution outcomes, improving accuracy substantially over base reasoning models.
relevance: generalist verifiers for agent trajectories
```

**URL check:** https://arxiv.org/abs/2610.13356


### Make Code as Policy Great Again: Frontier Agents Write, Call, and Evolve Robot Tools

- **Link:** https://arxiv.org/abs/2609.39018
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** URAI improves robot manipulation by having agents build reusable motion tools that execute locally while retaining model-level decisions between steps, boosting success rates and reducing token use.
- **Abstract:** Frontier models can control robots, but reasoning through every reach, grasp, and retreat makes manipulation slow and token-intensive. We revisit code as policy with a different division of labor: models build executable tools, code handles multi-phase motions, and models decide what to do next. We introduce URAI (Universal Robot-Agent Interface), which couples a programming agent that constructs robot tools with an execution agent that uses them in a feedback loop. The programming agent writes reusable and task-specific tools from task intent and refines them through execution feedback and h…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Make Code as Policy Great Again: Frontier Agents Write, Call, and Evolve Robot Tools
kern: URAI improves robot manipulation by having agents build reusable motion tools that execute locally while retaining model-level decisions between steps, boosting success rates and reducing token use.
relevance: agents write and evolve robot tools
```

**URL check:** https://arxiv.org/abs/2609.39018


### SWE-VERIFIER: Selective Verification for Cost-Efficient Coding Agents

- **Link:** https://arxiv.org/abs/2610.30284
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** SWE-Verifier selectively verifies coding-agent actions to improve resolution with minimal overhead.
- **Abstract:** Coding agents spend substantial computation generating actions and processing long interaction histories. Poor action choices can steer agents into low-value states, wasting computation and increasing API costs. Sampling and verifying alternative actions can improve the agent's decisions, but applying this procedure at every step adds substantial overhead. We introduce SWE-Verifier, a lightweight generative model that selectively triggers candidate sampling and verification. It scores the coding agent's proposed action to determine when additional candidate sampling is needed, then ranks the…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: SWE-VERIFIER: Selective Verification for Cost-Efficient Coding Agents
kern: SWE-Verifier selectively verifies coding-agent actions to improve resolution with minimal overhead.
relevance: selective verification cost
```

**URL check:** https://arxiv.org/abs/2610.30284


### TSFLab: A Self-Improving Agent-Agnostic Workbench for Time Series Forecasting Research

- **Link:** https://arxiv.org/abs/2610.40901
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** TSFLab is a self-improving agent-agnostic workbench that equips coding agents with shared resources to reduce costs and automate maintenance for time series forecasting research and benchmarking.
- **Abstract:** As publications and products on time series forecasting (TSF) proliferate, researchers face a growing burden of analyzing existing work. First, not all publications release code. For instance, only about 20% of arXiv TSF papers have a code link in the surveyed period. Second, released code also requires manual maintenance. Thus, TSF researchers must constantly adapt or implement existing works. However, independent implementations can differ in experimental settings and are difficult to maintain. We therefore propose to use AI agents for benchmarking TSF research and even supporting autoresea…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Loop Engineering
title: TSFLab: A Self-Improving Agent-Agnostic Workbench for Time Series Forecasting Research
kern: TSFLab is a self-improving agent-agnostic workbench that equips coding agents with shared resources to reduce costs and automate maintenance for time series forecasting research and benchmarking.
relevance: self-improving workbench for forecasting
```

**URL check:** https://arxiv.org/abs/2610.40901


### WeVisCut: The Whole Editing Room in One Agent From Narration to Long-Form Video

- **Link:** https://arxiv.org/abs/2610.38352
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** WeVisCut is a script-to-video system that trains a compact policy to coordinate video editing tools, recover from failures, and reduce token usage while maintaining quality.
- **Abstract:** Producing long-form videos from narration requires interdependent decisions that remain coherent across shots. Existing agentic editors often use multi-stage workflows driven by general models, leaving the quality-cost trade-off of compact, task-adapted policies unclear. We address this gap with WeVisCut, a long-form script-to-video system that connects tool execution with policy learning. Its agent harness maintains shared production state so that tool feedback informs subsequent decisions and repairs. Because finished videos do not expose these decisions, our four-stage data pipeline combin…
- **Upvotes:** 24

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: WeVisCut: The Whole Editing Room in One Agent From Narration to Long-Form Video
kern: (skip: video editing agent)
relevance: video editing agent
```

**URL check:** https://arxiv.org/abs/2610.38352


### ToolSpace: Scaling Tool-Centric Environment Synthesis for Long-Horizon Agents

- **Link:** https://arxiv.org/abs/2611.05036
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** ToolSpace constructs realistic multi-environment tool-use benchmarks by mining execution traces, clustering tool compositions, and validating tasks through replayable state-aware random walks.
- **Abstract:** Large language models are deployed as long-horizon agents that compose diverse tools across MCP services into executable workflows. Existing MCP environment-scaling methods are data-centric: they first synthesize a database and scenario, then derive tools and tasks from them. As a result, tool interfaces may not match real ones, tool compositions are not grounded in execution, and tasks rarely span more than one environment. We propose ToolSpace, a tool-centric framework that reverses this order. ToolSpace mines data, state, and retry dependencies from adjacent calls in execution traces of re…
- **Upvotes:** 45

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: ToolSpace: Scaling Tool-Centric Environment Synthesis for Long-Horizon Agents
kern: ToolSpace constructs realistic multi-environment tool-use benchmarks by mining execution traces, clustering tool compositions, and validating tasks through replayable state-aware random walks.
relevance: tool-centric environment synthesis
```

**URL check:** https://arxiv.org/abs/2611.05036


### ToolLoop: Closed-Loop Tool-Use Data Synthesis via Decomposed Generation and Dynamic Self-Feedback

- **Link:** https://arxiv.org/abs/2609.09072
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** ToolLoop uses iterative self-feedback across three synthesis stages to generate high-quality tool-use training data, improving model accuracy while reducing data requirements.
- **Abstract:** High-quality tool-use data is critical for training language models to interact effectively with external tools. However, existing synthetic approaches typically follow a generate-then-filter paradigm with static post-hoc verification, often yielding inefficient data with imbalanced feature distributions. We propose ToolLoop, a closed-loop framework that decomposes synthesis into three progressive stages: (1) sampling function name combinations as ground truth; (2) backward derivation of user queries; and (3) forward derivation of tool calls. At each stage, dynamic self-feedback iteratively g…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: ToolLoop: Closed-Loop Tool-Use Data Synthesis via Decomposed Generation and Dynamic Self-Feedback
kern: (skip: tool-use data synthesis)
relevance: tool-use data synthesis
```

**URL check:** https://arxiv.org/abs/2609.09072


### How Do Agentic LLMs Decide to Call Tools? A Tool-Call Vector Shaped by Suppression

- **Link:** https://arxiv.org/abs/2610.09624
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Gist (HF ai_summary):** Researchers identify a compact internal vector controlling tool-use decisions in agentic LLMs by contrasting execution and analysis verbs, tracing causality through attention and MLP components across multiple model families.
- **Abstract:** Tool calling, invoking external tools on demand, is central to agentic LLMs, yet the mechanism that decides whether a model calls a tool or responds directly remains poorly understood. Agentic prompts are long and heavily scaffolded, combining role instructions, tool schemas, format templates, and the user's request across hundreds of tokens, creating a noisy, highly entangled context in which no single controllable variable for mechanistic analysis is obvious. To obtain such a variable, we propose a method that converts complex agentic prompts into minimal contrastive pairs in which a single…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: How Do Agentic LLMs Decide to Call Tools? A Tool-Call Vector Shaped by Suppression
kern: Researchers identify a compact internal vector controlling tool-use decisions in agentic LLMs by contrasting execution and analysis verbs, tracing causality through attention and MLP components across multiple model families.
relevance: internal vector for tool-call decisions
```

**URL check:** https://arxiv.org/abs/2610.09624


### An Indic Voice Agent with CUGA

- **Link:** https://huggingface.co/blog/ibm-research/an-indic-voice-agent-with-cuga
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: An Indic Voice Agent with CUGA
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/ibm-research/an-indic-voice-agent-with-cuga


### Introducing harness adapters: adapt your favorite model to your harness to improve performance and cost

- **Link:** https://huggingface.co/blog/harness-adapters-at-scale
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Introducing harness adapters: adapt your favorite model to your harness to improve performance and cost
kern: (no abstract in dumps; harness adapters)
relevance: harness adapters
```

**URL check:** https://huggingface.co/blog/harness-adapters-at-scale


### MGMem: An Efficient, Deterministic, and Provenance-Preserving Framework for Long-Horizon Agent Memory

- **Link:** https://arxiv.org/abs/2611.33174
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: MGMem: An Efficient, Deterministic, and Provenance-Preserving Framework for Long-Horizon Agent Memory
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33174


### Semantic Density Does Not Predict Agent-Memory Collapse

- **Link:** https://arxiv.org/abs/2611.33184
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Semantic Density Does Not Predict Agent-Memory Collapse
kern: (skip: agent-memory collapse)
relevance: agent-memory collapse
```

**URL check:** https://arxiv.org/abs/2611.33184


### CypherMAS: Benchmarking Routing Reliability in LLM-Based Multi-Agent Systems

- **Link:** https://arxiv.org/abs/2611.33242
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: CypherMAS: Benchmarking Routing Reliability in LLM-Based Multi-Agent Systems
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33242


### Welfare-Enhancing Mechanism Design for Agent Ecosystems

- **Link:** https://arxiv.org/abs/2611.33627
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Welfare-Enhancing Mechanism Design for Agent Ecosystems
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33627


### Post-Training Policy Replication for Strategy-Following Multi-Agent Deep Reinforcement Learning across Team Sizes

- **Link:** https://arxiv.org/abs/2611.34035
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Post-Training Policy Replication for Strategy-Following Multi-Agent Deep Reinforcement Learning across Team Sizes
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34035


### Strategic and Robust Task Allocation for Combat Objectives in Adversarial Multi-Agent Environments

- **Link:** https://arxiv.org/abs/2611.34158
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Strategic and Robust Task Allocation for Combat Objectives in Adversarial Multi-Agent Environments
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34158


### From Conversations to Commitments: A Design Study of Shared Records for Agent-to-Business Coordination

- **Link:** https://arxiv.org/abs/2611.33373
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: From Conversations to Commitments: A Design Study of Shared Records for Agent-to-Business Coordination
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33373


### LSRP*-LA: Scalable and Anytime Multi-Agent Path Finding for Large Agents with Asynchronous Actions

- **Link:** https://arxiv.org/abs/2611.33793
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: LSRP*-LA: Scalable and Anytime Multi-Agent Path Finding for Large Agents with Asynchronous Actions
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33793


### Not Every Input Needs Everything: Unifying Expert Gating, Model Cascades, and Agent Orchestration

- **Link:** https://arxiv.org/abs/2611.34112
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Graph Engineering
title: Not Every Input Needs Everything: Unifying Expert Gating, Model Cascades, and Agent Orchestration
kern: (no abstract in dumps; expert gating / cascades)
relevance: expert gating / cascades
```

**URL check:** https://arxiv.org/abs/2611.34112


### MeterRouter: Budget-Aware Dynamic Routing for Multi-Agent Systems

- **Link:** https://arxiv.org/abs/2611.34327
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Graph Engineering
title: MeterRouter: Budget-Aware Dynamic Routing for Multi-Agent Systems
kern: (no abstract in dumps; budget-aware routing for multi-agent)
relevance: budget-aware routing for multi-agent
```

**URL check:** https://arxiv.org/abs/2611.34327


### AutoRSP: An AI Agent for Radar Sensing Pipeline Design

- **Link:** https://arxiv.org/abs/2611.34754
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: AutoRSP: An AI Agent for Radar Sensing Pipeline Design
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34754


### Mechanism-Based Intelligence: Differentiable Incentives for Rational Coordination and Equilibrium Alignment in Multi-Agent Systems

- **Link:** https://arxiv.org/abs/2512.20688
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Mechanism-Based Intelligence: Differentiable Incentives for Rational Coordination and Equilibrium Alignment in Multi-Agent Systems
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2512.20688


### From Per-Frame Search to Practical Attacks: Investigating Adversarial Robustness of Multi-Agent Heterogeneous Cooperative Perception

- **Link:** https://arxiv.org/abs/2609.17856
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: From Per-Frame Search to Practical Attacks: Investigating Adversarial Robustness of Multi-Agent Heterogeneous Cooperative Perception
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2609.17856


### Agent Calibration under Deployment Change: Acceptance Contracts, Trajectory Repair, and Adaptation Costs

- **Link:** https://arxiv.org/abs/2609.35149
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Agent Calibration under Deployment Change: Acceptance Contracts, Trajectory Repair, and Adaptation Costs
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2609.35149


### AgentDRC: Multi-Agent Algorithms for Spatially-Aware Automated DRC Correction

- **Link:** https://arxiv.org/abs/2611.31876
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: AgentDRC: Multi-Agent Algorithms for Spatially-Aware Automated DRC Correction
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.31876


### Designing an Integrated Learning Ecosystem for Introductory Python Programming: Scaffolded Problem Solving, Tablet-Inspired Navigation, and AI-Enhanced Instruction

- **Link:** https://arxiv.org/abs/2611.33471
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Designing an Integrated Learning Ecosystem for Introductory Python Programming: Scaffolded Problem Solving, Tablet-Inspired Navigation, and AI-Enhanced Instruction
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33471


### Fixed or Deleted? External Feedback Lets Cheaper AI Coding Agents Repair Rule Violations

- **Link:** https://arxiv.org/abs/2611.29162
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Fixed or Deleted? External Feedback Lets Cheaper AI Coding Agents Repair Rule Violations
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.29162


### Multi-Agent Coordinated Method-Level Refactoring of Rust Code

- **Link:** https://arxiv.org/abs/2611.29321
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** Harness Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Multi-Agent Coordinated Method-Level Refactoring of Rust Code
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.29321

