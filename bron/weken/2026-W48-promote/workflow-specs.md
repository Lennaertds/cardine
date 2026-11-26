# Promote drafts — 2026-W48 — Workflow & Specs

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### Dynamic Harness Search: Building Multi-Agent Systems Per-Query via Prediction

- **Link:** https://arxiv.org/abs/2610.04137
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** SHIFT learns to build task-specific agent harnesses via a local LLM policy and value function, achieving higher accuracy and lower execution cost than baseline methods across diverse benchmarks.
- **Abstract:** Agent harnesses specify the roles, instructions, tools, and communication structure used to solve a task, and the right harness depends on the query. Because the value of each design choice is observable only through execution, tailoring a harness to each query has required either executing alternatives at inference time or costly manual design. We introduce SHIFT, which moves execution out of the per-query search loop. A local LLM architect learns a policy over harness-building actions from search, and a value function that predicts, from measured executions, a utility balancing accuracy aga…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Dynamic Harness Search: Building Multi-Agent Systems Per-Query via Prediction
kern: SHIFT learns to build task-specific agent harnesses via a local LLM policy and value function, achieving higher accuracy and lower execution cost than baseline methods across diverse benchmarks.
relevance: per-query harness construction
```

**URL check:** https://arxiv.org/abs/2610.04137


### Rethinking Verification in Agent Harnesses

- **Link:** https://arxiv.org/abs/2610.34577
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Verification strategies for agent harnesses—spanning instructions, reminders, gates, and independent review—show that independent critic review improves accuracy with minimal cost increases, guiding practical test-time scaling design.
- **Abstract:** Agent harnesses enable large language models to act through tools, observe the results, and iteratively work toward a task goal. Verification checks and revises agents' work to improve output quality. Yet there is limited guidance on how harnesses should organize this effort. We study verification as an axis of test-time scaling by examining when to intervene, who checks the work, and how checking leads to revision. Our framework spans four layers of the agent lifecycle: initial instructions, mid-turn reminders, completion gates, and independent review. We compare 17 designs across seven fron…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Rethinking Verification in Agent Harnesses
kern: Verification strategies for agent harnesses—spanning instructions, reminders, gates, and independent review—show that independent critic review improves accuracy with minimal cost increases, guiding practical test-time scaling design.
relevance: verification strategies in harnesses
```

**URL check:** https://arxiv.org/abs/2610.34577


### AutoSaddler: Automatic Harness Optimization with Durable Updates from Agent Execution Traces

- **Link:** https://arxiv.org/abs/2608.23041
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** AutoSaddler automatically improves LLM agent harnesses via offline failure-driven optimization, boosting performance on long-horizon benchmarks.
- **Abstract:** LLM agents remain unreliable on long-horizon tasks, where small local failures can compound over extended interactions and lead to overall task failure. Although external harnesses can substantially improve robustness, harness design remains a manual and expensive process that requires searching over a large space of prompts, tool configurations, and control logic. We propose AutoSaddler, an automatic harness optimization framework that formulates harness improvement as an offline learning problem and iteratively updates the harness using failure signals from mini-batches. AutoSaddler combine…
- **Upvotes:** 67

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: AutoSaddler: Automatic Harness Optimization with Durable Updates from Agent Execution Traces
kern: AutoSaddler automatically improves LLM agent harnesses via offline failure-driven optimization, boosting performance on long-horizon benchmarks.
relevance: harness optimization from traces
```

**URL check:** https://arxiv.org/abs/2608.23041


### Self-Evolving Agent Harness

- **Link:** https://arxiv.org/abs/2610.18813
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** A framework for self-evolving agent harnesses uses feedback-driven revisions and evolutionary optimization with theoretical generalization guarantees while keeping model weights fixed.
- **Abstract:** Harness self-evolution revises an agent's software scaffolding, including prompts, memory, workflows, and executable components, while keeping model weights fixed. We formalize a feedback-driven process in which accepted revisions persist across runs. The framework separates update targets from proposal and admission mechanisms. It distinguishes changes to interpreted state from revisions to tools and code, repository-level control logic, and plugin composition. We characterize search through evolutionary optimization and examine its reliability through continual PAC-learning. Under explicit…
- **Upvotes:** 56

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Self-Evolving Agent Harness
kern: A framework for self-evolving agent harnesses uses feedback-driven revisions and evolutionary optimization with theoretical generalization guarantees while keeping model weights fixed.
relevance: self-evolving harness framework
```

**URL check:** https://arxiv.org/abs/2610.18813


### VERSE: Verified Self-Evolving Optimizer for Agent Harnesses

- **Link:** https://arxiv.org/abs/2610.02616
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** VERSE enables an optimizer to self-evolve its diagnostic and verification tools, improving agent harness performance on software engineering tasks without changing model weights.
- **Abstract:** Harness evolution improves an LLM agent's prompts, tools, and workflow, while the optimizer's own tools and procedures often remain fixed. We study whether an optimizer can improve another agent more effectively by also improving how it diagnoses failures, develops edits, and tests their effects. Two observations guide our design. In a controlled study, optimizer self-evolution fails to improve performance without execution-based verification, but achieves the best result of that study when verification is available. Across five executors, self-evolving optimizers build their own tools for fa…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: VERSE: Verified Self-Evolving Optimizer for Agent Harnesses
kern: VERSE enables an optimizer to self-evolve its diagnostic and verification tools, improving agent harness performance on software engineering tasks without changing model weights.
relevance: verified self-evolving optimizer
```

**URL check:** https://arxiv.org/abs/2610.02616


### Mixture of Self-Improving Branches For Agent Harness Optimization

- **Link:** https://arxiv.org/abs/2609.37834
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Adaptive branching with evolving development subsets and proposal policies improves recursive self-improvement by generating complementary harnesses routed by development data.
- **Abstract:** Harness optimization provides a practical setting for recursive self-improvement (RSI), where agent-generated modifications inform subsequent changes through execution feedback. Recent work such as Meta-Harness implements this process through iterative code generation and evaluation, but retains a fixed development set and proposal policy. These constraints channel evolution along a single search trajectory, increasing the risk of converging to a local optimum. We make the improvement process itself adaptive by organizing search into branches with evolving development subsets and proposal pol…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Mixture of Self-Improving Branches For Agent Harness Optimization
kern: Adaptive branching with evolving development subsets and proposal policies improves recursive self-improvement by generating complementary harnesses routed by development data.
relevance: self-improving branches for harness optimization
```

**URL check:** https://arxiv.org/abs/2609.37834


### Stellar Colosseum: A Many-Agent Harness for Long-Horizon Research in Mathematics and Theoretical Computer Science

- **Link:** https://arxiv.org/abs/2609.15983
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Stellar Colosseum is a model-agnostic inference harness that improves long-horizon mathematical and theoretical computer science research by exploring proof strategies, decomposing interdependent subproblems, and integrating verification feedback through parallel candidate generation and tree aggregation.
- **Abstract:** Language models can produce plausible short proofs, but may still be unreliable on long-horizon research problems, where progress depends on a sequence of uncertain and interdependent decisions. We introduce Stellar Colosseum, a model-agnostic harness for allocating inference across research in mathematics and theoretical computer science. Colosseum explores alternative strategies before proof construction, uses a readiness gate to decide when a route is mature enough to decompose, represents the proof plan as interdependent section-level subproblems, and routes verifier findings back to the…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Stellar Colosseum: A Many-Agent Harness for Long-Horizon Research in Mathematics and Theoretical Computer Science
kern: Stellar Colosseum is a model-agnostic inference harness that improves long-horizon mathematical and theoretical computer science research by exploring proof strategies, decomposing interdependent subproblems, and integrating verification feedback through parallel candidate generation and tree aggregation.
relevance: many-agent research harness
```

**URL check:** https://arxiv.org/abs/2609.15983


### SemaPLC: A Project-Grounded, Verification-Gated Agent Harness for PLC Code Generation

- **Link:** https://arxiv.org/abs/2608.18565
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** SemaPLC is a verification-gated agent harness that validates generated PLC logic through external compilation and live runtime execution, achieving higher verified pass rates than baseline methods.
- **Abstract:** Programmable logic controllers (PLCs) run industrial plants, and large language models can already generate independent program organization units (POUs) for them. Whether such logic integrates into an existing PLC project and then runs correctly has been checked only in limited tests. We present SemaPLC, a project-grounded and verification-gated agent harness assembled from conventional tools but governed by a strict completion rule. Rather than stopping when the model judges its own output adequate, SemaPLC declares a task complete only when logged external checks confirm it. Those checks c…
- **Upvotes:** 19

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: SemaPLC: A Project-Grounded, Verification-Gated Agent Harness for PLC Code Generation
kern: SemaPLC is a verification-gated agent harness that validates generated PLC logic through external compilation and live runtime execution, achieving higher verified pass rates than baseline methods.
relevance: verification-gated PLC harness
```

**URL check:** https://arxiv.org/abs/2608.18565


### CodeMidas: Scaling Agentic Coding RL Environments from Code Itself

- **Link:** https://arxiv.org/abs/2609.22068
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** CodeMidas converts existing source code into executable reinforcement learning tasks for training coding agents, improving performance across repair, construction, and terminal benchmarks.
- **Abstract:** Training capable coding agents via reinforcement learning (RL) requires diverse tasks with reliable verifiers. Open-source codebases offer a rich source of such tasks, while existing methods typically rely on development artifacts such as issues and commits, limiting the range of tasks that can be extracted. To better scale RL environments, we present CodeMidas, an agentic pipeline that turns implemented functionality in existing codebases into executable RL environments using source code as its only task-specific input. CodeMidas allocates agentic compute to every stage of environment constr…
- **Upvotes:** 116

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: CodeMidas: Scaling Agentic Coding RL Environments from Code Itself
kern: CodeMidas converts existing source code into executable reinforcement learning tasks for training coding agents, improving performance across repair, construction, and terminal benchmarks.
relevance: RL environments from code
```

**URL check:** https://arxiv.org/abs/2609.22068


### Engineering Signals of Human-AI Collaboration in the Agentic Coding Era: A Longitudinal Analysis of 33,228 Pull Requests from vLLM and SGLang with Implications for Biomedical AI Agents and Bioinformatics Pipeline Developmen

- **Link:** https://arxiv.org/abs/2608.13884
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Longitudinal analysis of vLLM and SGLang shows AI-assisted development correlates with sharply increased human-driven pull request throughput, faster cycle times, broader contributor participation, and greater collaboration signals.
- **Abstract:** The rapid adoption of AI coding assistants and autonomous agentic development systems has coincided with major changes in the pace and structure of open-source software engineering. Yet empirical longitudinal evidence of these changes at the team level remains limited. We present a descriptive longitudinal analysis of seven engineering metrics: pull request (PR) throughput, cycle time, contributor diversity, PR comment density, merge rate, new-author participation, and PR size. Metrics were computed from all merged PRs in two high-velocity AI infrastructure repositories, vLLM (February 2023-J…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Engineering Signals of Human-AI Collaboration in the Agentic Coding Era: A Longitudinal Analysis of 33,228 Pull Requests from vLLM and SGLang with Implications for Biomedical AI Agents and Bioinformatics Pipeline Developmen
kern: Longitudinal analysis of vLLM and SGLang shows AI-assisted development correlates with sharply increased human-driven pull request throughput, faster cycle times, broader contributor participation, and greater collaboration signals.
relevance: human-AI collaboration signals in OSS
```

**URL check:** https://arxiv.org/abs/2608.13884


### OpenCollab: A Multi-Agent Coding Framework with Programmable Collaboration and Controllable Runtime

- **Link:** https://arxiv.org/abs/2609.38345
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Multi-agent coding systems are designed to tackle complex software engineering tasks through collaboration. However, existing evaluations typically assume configured organizations are followed faithfully, whereas reality differs. This behavioral gap, combined with differences in underlying system components, prevents clear attribution of observed gains. To this end, we introduce OpenCollab, a multi-agent coding framework that provides a unified infrastructure for programmable collaboration and controllable runtime. Specifically, OpenCollab unifies organization design, enforces experimental co…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Graph Engineering
title: OpenCollab: A Multi-Agent Coding Framework with Programmable Collaboration and Controllable Runtime
kern: Multi-agent coding systems are designed to tackle complex software engineering tasks through collaboration. However, existing evaluations typically assume configured organizations are followed faithfully, whereas reality differs. This behavioral gap, combined with differences in underlying system components, prevents…
relevance: programmable multi-agent collaboration
```

**URL check:** https://arxiv.org/abs/2609.38345


### RAPID: Robot Agentic Programming from Demonstrations

- **Link:** https://arxiv.org/abs/2609.30249
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** RAPID automatically generates reusable robot programs from a single visual demonstration by inferring task specifications, action primitives, and an interactive verification loop, achieving strong generalization across manipulation tasks.
- **Abstract:** Coding agents have demonstrated enormous success in solving complex programming problems. To leverage their potential for robot systems, this work introduces Robot Agentic Programming from Demonstrations (RAPID), which automatically generates, verifies, and refines robot programs, given a single visual human demonstration. The iterative agentic loop of code refinement requires several key ingredients: (i) a testable task specification, (ii) action primitives for robot execution, and (iii) an interactive environment for program execution and verification. RAPID infers all three from the demons…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: RAPID: Robot Agentic Programming from Demonstrations
kern: RAPID automatically generates reusable robot programs from a single visual demonstration by inferring task specifications, action primitives, and an interactive verification loop, achieving strong generalization across manipulation tasks.
relevance: robot programs from demonstrations
```

**URL check:** https://arxiv.org/abs/2609.30249


### RLE-Bench: A Qualifying Exam for Coding Agents as Robot Learning Engineers

- **Link:** https://arxiv.org/abs/2609.34210
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** RLE-Bench evaluates coding agents across robot-learning workflows including control, policy learning, perception, and mechanical design using task-specific metrics aggregated into an overall RLE Index.
- **Abstract:** Coding agents are beginning to move beyond purely digital tasks to tackle physical-world challenges, particularly in robotics. Existing robotics benchmarks, however, primarily focus on the performance of individual artifacts, such as policies or controllers, offering limited coverage of coding agents' broader engineering capabilities. Real-world robotics extends beyond control: agents must build, integrate, diagnose, and improve heterogeneous artifacts under resource constraints and reason from multimodal feedback. To evaluate these broader capabilities, we introduce RLE-Bench, a benchmark of…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: RLE-Bench: A Qualifying Exam for Coding Agents as Robot Learning Engineers
kern: RLE-Bench evaluates coding agents across robot-learning workflows including control, policy learning, perception, and mechanical design using task-specific metrics aggregated into an overall RLE Index.
relevance: coding agents as robot learning engineers
```

**URL check:** https://arxiv.org/abs/2609.34210


### Priming Base Models for Agentic Post-Training: An Open Midtraining Recipe

- **Link:** https://arxiv.org/abs/2610.22019
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Midtraining on long-context software-engineering data improves agentic post-training performance and RL trainability for frontier models.
- **Abstract:** Frontier models, general-purpose and domain-specific alike, now include a midtraining stage between pretraining and post-training, but little has been published about how this stage is built. We present an open midtraining recipe that primes base models for agentic post-training, and we show its effectiveness on two Nemotron models of different sizes. Pretraining typically runs at short context and sees almost no agent interactions, while SFT data is mostly synthetic, and very long SFT stages can hurt the model's later RL trainability. Our midtraining stage sits between the two. It trains at…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Priming Base Models for Agentic Post-Training: An Open Midtraining Recipe
kern: Midtraining on long-context software-engineering data improves agentic post-training performance and RL trainability for frontier models.
relevance: midtraining recipe for agentic post-training
```

**URL check:** https://arxiv.org/abs/2610.22019


### Compress What You See, Not What You Say: Anchored Context Distillation for Latent-Observation Software Engineering Agents

- **Link:** https://arxiv.org/abs/2609.31430
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** LOHA and ACD compress agent interaction histories by encoding older observations as soft tokens while preserving recent text and original behavior, reducing context length and improving throughput with minimal performance loss.
- **Abstract:** Tool observations dominate the context of software-engineering agents, making long interaction histories costly to maintain. Existing context compression methods can discard information needed by later actions, while adapting agents to soft-token representations can compromise their original behavior. To reduce context while preserving action-critical information and agent behavior, we combine Latent Observations, Hard Actions (LOHA), a context layout that separates compressed history from text needed for exact reference, with Anchored Context Distillation (ACD), a training method that enable…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Compress What You See, Not What You Say: Anchored Context Distillation for Latent-Observation Software Engineering Agents
kern: LOHA and ACD compress agent interaction histories by encoding older observations as soft tokens while preserving recent text and original behavior, reducing context length and improving throughput with minimal performance loss.
relevance: observation compression as soft tokens
```

**URL check:** https://arxiv.org/abs/2609.31430


### AutoCompact: Learning When to Compact Context in Long-Horizon Coding Agents

- **Link:** https://arxiv.org/abs/2610.02163
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** AutoCompact trains coding agents to manage long-horizon context via supervised fine-tuning and reinforcement learning, improving task success rates across varying context budgets.
- **Abstract:** Coding agents solve repository-level software engineering tasks through long trajectories of code inspection, search, editing, and testing. As a task progresses, earlier exploration becomes stale, so managing context is more than avoiding overflow: an agent must decide when to compact, what working state to preserve, and how to continue from it. We introduce AutoCompact, which trains a coding agent to make these decisions as part of its policy. To collect training data, we run the base agent on coding tasks and use a judge to review its compaction decisions, summaries, and actions after compa…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: AutoCompact: Learning When to Compact Context in Long-Horizon Coding Agents
kern: AutoCompact trains coding agents to manage long-horizon context via supervised fine-tuning and reinforcement learning, improving task success rates across varying context budgets.
relevance: compaction policy for long-horizon agents
```

**URL check:** https://arxiv.org/abs/2610.02163


### LongWoF-Bench: Evaluating EvoMap Genes for Verifiable Long-Workflow Tasks

- **Link:** https://arxiv.org/abs/2608.23200
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** EvoMap externalizes verified execution experience into reusable structured Gene, improving long-workflow task completion and reducing token costs across diverse models.
- **Abstract:** Large language models are increasingly expected to execute complex workflows whose success depends on maintaining interdependent constraints and producing artifacts that satisfy strict end-to-end verification. Yet successful execution experience is typically lost after a single run, forcing subsequent models to rediscover strategies and failure modes from scratch. We study whether such experience can instead be externalized and reused through EvoMap, where verifier-confirmed execution trajectories are consolidated into structured Gene. To evaluate this setting, we introduce the Long-Workflow…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Loop Engineering
title: LongWoF-Bench: Evaluating EvoMap Genes for Verifiable Long-Workflow Tasks
kern: EvoMap externalizes verified execution experience into reusable structured Gene, improving long-workflow task completion and reducing token costs across diverse models.
relevance: externalized verified experience
```

**URL check:** https://arxiv.org/abs/2608.23200


### Clover-35B-A3B-Preview Technical Report

- **Link:** https://arxiv.org/abs/2611.24636
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** We introduce Clover-35B-A3B-Preview (Clover), a mixture-of-experts diffusion language model with 35 billion total parameters and 3 billion activated parameters, supporting thinking-mode generation. Clover adapts Gated Delta Networks to block diffusion by combining recurrent memory of previously generated context with bidirectional softmax attention inside the current block. Historical memory readout competes with current-block tokens in a shared softmax, with learnable block-size calibration and a separate, zero-initialized right-context convolution branch. Clover leads the seven evaluated ag…
- **Upvotes:** 45

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Clover-35B-A3B-Preview Technical Report
kern: (skip: MoE diffusion LM)
relevance: MoE diffusion LM
```

**URL check:** https://arxiv.org/abs/2611.24636


### Let the Fixer Decide: Training a Code Localizer from the Fixer's Likelihood

- **Link:** https://arxiv.org/abs/2611.12164
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** A code localizer is trained with scores from a frozen fixer via weighted supervised fine-tuning, improving bug localization and patch success for a small coding agent without tests or reinforcement learning.
- **Abstract:** Code localizers are usually trained to predict the files a reference patch edits, but the code a fixer needs to read is not the same as the code it changes. We propose Fixer-Guided Localization (FGL): the localizer proposes several localizations, a frozen fixer scores each by how likely it makes a verified patch, and the localizer is trained on these scores with weighted supervised fine-tuning, without running tests and without reinforcement learning. We build the full pipeline on Gemma 4 E4B for the Kaggle Gemma-4 Developer Agent competition, from 1,629 test-verified Kimi K3 trajectories. Th…
- **Upvotes:** 59

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Let the Fixer Decide: Training a Code Localizer from the Fixer's Likelihood
kern: A code localizer is trained with scores from a frozen fixer via weighted supervised fine-tuning, improving bug localization and patch success for a small coding agent without tests or reinforcement learning.
relevance: code localization from fixer likelihood
```

**URL check:** https://arxiv.org/abs/2611.12164


### What Makes Good Data for Training Coding Agents? A Systematic Study on SWE-Gym

- **Link:** https://arxiv.org/abs/2611.30207
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Auditing reward labels in coding-agent reinforcement learning tasks shows many unsolved tasks are mislabeled, and training on corrected tasks improves policy performance on SWE-bench benchmarks.
- **Abstract:** Reinforcement learning (RL) trains coding agents on software tasks whose hidden tests decide the reward, yet task collections check these tests only against the reference fix. We ask what makes a task good training data, focusing on the correctness of its reward labels. We audit SWE-Gym with two LLM families, and a suspected error counts only if execution reproduces it. We find that unsolved often means mislabelled: 74% of the tasks that a 9B base model never solves have a test that rejects correct fixes (a false negative), versus 20% of those it sometimes solves. We repair or remove such tas…
- **Upvotes:** 19

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: What Makes Good Data for Training Coding Agents? A Systematic Study on SWE-Gym
kern: Auditing reward labels in coding-agent reinforcement learning tasks shows many unsolved tasks are mislabeled, and training on corrected tasks improves policy performance on SWE-bench benchmarks.
relevance: training data quality for coding agents
```

**URL check:** https://arxiv.org/abs/2611.30207


### Open Vision Banana: An Open Framework for Unified Visual Perception through Generation in RGB Space

- **Link:** https://arxiv.org/abs/2611.28489
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Vision Banana showed that a closed image generator, instruction-tuned to paint perception outputs as RGB images, becomes a generalist vision model. Does this carry over to open generators, and if not, what fails? We answer with Open Vision Banana (OVB), an open framework that adapts the 7B diffusion generator of Qwen-Image-2.1 into one instruction-driven model for metric depth, semantic, instance, and referring segmentation, using a single shared low-rank adapter and public data. Each task is a task contract whose RGB encoder, instruction, and decoder share one specification and are checked b…
- **Upvotes:** 18

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Open Vision Banana: An Open Framework for Unified Visual Perception through Generation in RGB Space
kern: (skip: visual perception via generation)
relevance: visual perception via generation
```

**URL check:** https://arxiv.org/abs/2611.28489


### GameAnything: From Any Inspirations to Playable Game Worlds

- **Link:** https://arxiv.org/abs/2611.29238
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** An open-source agentic platform and benchmark enable iterative transformation of multimodal inspirations into playable game extensions, revealing that coding agents can adapt reference content but still struggle with playable interactions and precise modifications.
- **Abstract:** AI-driven game development holds the potential to transform diverse human inspirations into interactive experiences. However, existing systems and benchmarks primarily focus on explicit development specifications, with limited support for adapting multimodal references and evaluating actual gameplay experiences. We introduce GameAnything, an open-source agentic platform that transforms multimodal inspirations into playable extensions of existing games through iterative development. GameAnything integrates coding agents with an independent playtesting critic, persistent development state, and…
- **Upvotes:** 15

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: GameAnything: From Any Inspirations to Playable Game Worlds
kern: An open-source agentic platform and benchmark enable iterative transformation of multimodal inspirations into playable game extensions, revealing that coding agents can adapt reference content but still struggle with playable interactions and precise modifications.
relevance: agentic game worlds
```

**URL check:** https://arxiv.org/abs/2611.29238


### SpecEngineeringBench: Evaluating Coding Agents as Autonomous Specification Engineers

- **Link:** https://arxiv.org/abs/2611.32973
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Autonomous specification engineering requires coding agents to translate functional requirements into executable tests and use the results to discover and validate defects. However, existing benchmarks evaluate coding agents on explicitly specified test generation tasks, commonly providing an issue description, a designated test entry point, or files to inspect, leaving the ability to determine what to test and where to investigate insufficiently evaluated. Relying on such clues bypasses the challenge of mapping requirements to implementations and proactively uncovering unknown defects. We pr…
- **Upvotes:** 13

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: SpecEngineeringBench: Evaluating Coding Agents as Autonomous Specification Engineers
kern: Autonomous specification engineering requires coding agents to translate functional requirements into executable tests and use the results to discover and validate defects. However, existing benchmarks evaluate coding agents on explicitly specified test generation tasks, commonly providing an issue description, a…
relevance: autonomous specification engineering
```

**URL check:** https://arxiv.org/abs/2611.32973


### How Much Do Coding Agents Over-Edit, and Why? An Empirical Study of Unneeded Edits in Repository-Level Agent Patches

- **Link:** https://arxiv.org/abs/2611.34875v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Agent patches are larger than developers', which is widely read as over-editing. But patch size does not say whether the extra edits are needed, what they are, or where they come from. We introduce Delta Residue Attribution (DRA), which replays agent trajectories, traces every block (unit) of the final patch to the step that wrote it, reverts each unit, and reruns the task tests to decide whether the unit is needed. We apply DRA to 7,660 resolved GitHub Copilot CLI trajectories from 18 frontier models on SWE-bench Verified (6,728) and DeepSWE (932), and grade developer patches using the same…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: How Much Do Coding Agents Over-Edit, and Why? An Empirical Study of Unneeded Edits in Repository-Level Agent Patches
kern: Agent patches are larger than developers', which is widely read as over-editing. But patch size does not say whether the extra edits are needed, what they are, or where they come from. We introduce Delta Residue Attribution (DRA), which replays agent trajectories, traces every block (unit) of the final patch to the…
relevance: coding agents over-edit; causes
```

**URL check:** https://arxiv.org/abs/2611.34875v1


### Solve Vision with Code: Coding Agents Are Stronger Visual Reasoners Than Video Models

- **Link:** https://arxiv.org/abs/2611.34813v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Video generation models are increasingly evaluated as visual reasoners: given a first frame and a natural-language prompt, can the model produce the video in which the specified task is carried out? The paradigm is considered advantageous because the reasoning is native to the visual medium, unfolding directly in the frames rather than through language or code. Whether this native route is in fact the more reliable path to visual reasoning has not been tested against a symbolic alternative under the same conditions. We therefore pose the same tasks, with identical inputs, output specification…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Reasoning
title: Solve Vision with Code: Coding Agents Are Stronger Visual Reasoners Than Video Models
kern: Video generation models are increasingly evaluated as visual reasoners: given a first frame and a natural-language prompt, can the model produce the video in which the specified task is carried out? The paradigm is considered advantageous because the reasoning is native to the visual medium, unfolding directly in the…
relevance: coding agents as visual reasoners
```

**URL check:** https://arxiv.org/abs/2611.34813v1


### Loupe: Reinforcing Knowledge-Intensive Video Generation Agents

- **Link:** https://arxiv.org/abs/2611.31895
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Knowledge-intensive video generation remains challenging because prompts often omit the facts, appearances, and temporal relationships required for accurate generation. While search-based workflows can retrieve missing evidence, manually designed strategies limit adaptive planning, and conventional training suffers from costly video-level feedback and coarse trajectory-level credit assignment. In this paper, we present Loupe, a video generation agent that retrieves and verifies textual and visual evidence to construct evidence-grounded temporal video prompts with reference images. We further…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Loupe: Reinforcing Knowledge-Intensive Video Generation Agents
kern: (skip: knowledge-intensive video generation)
relevance: knowledge-intensive video generation
```

**URL check:** https://arxiv.org/abs/2611.31895


### When Every Rollout Fails: Splicing Learner-Conditioned Options into Long-Horizon Agent RL

- **Link:** https://arxiv.org/abs/2611.34777
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** SPLICE improves reinforcement learning on long-horizon agent tasks by constructing local training targets from failed trajectories using a proposal model to select splice points and generate bounded options, outperforming GRPO and full-trajectory guidance baselines.
- **Abstract:** Group-based reinforcement learning with verifiable rewards often yields all-fail groups on long-horizon agent tasks: every sampled trajectory receives zero reward, leaving group-relative methods without a reward-based policy gradient. A common remedy supplies complete solutions from a stronger model, but full trajectories are expensive and expose the learner to long off-policy histories. We introduce SPLICE, which constructs local training targets from failed current-policy trajectories online. For each all-fail group, a proposal model selects a splice point in a current-policy trajectory and…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: When Every Rollout Fails: Splicing Learner-Conditioned Options into Long-Horizon Agent RL
kern: (skip: long-horizon agent RL)
relevance: long-horizon agent RL
```

**URL check:** https://arxiv.org/abs/2611.34777


### Collect for Coverage, Replay with Evidence: Adaptive and Efficient On-Policy Distillation for Long-Horizon Agents

- **Link:** https://arxiv.org/abs/2611.34756
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Fully online on-policy distillation (OPD) is costly for long-horizon agents because each update depends on fresh environment rollouts. Prefix replay offers an efficient alternative by sampling current-student responses from stored histories, reducing idle time for long-tail rollouts and allowing each collected trajectory to support multiple updates. However, our analysis of the complete prefix replay pipeline identifies two limitations in long-horizon settings. In trajectory collection, teacher-only trajectories miss student-induced histories, while broader history coverage can reduce teacher…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Reasoning
title: Collect for Coverage, Replay with Evidence: Adaptive and Efficient On-Policy Distillation for Long-Horizon Agents
kern: Fully online on-policy distillation (OPD) is costly for long-horizon agents because each update depends on fresh environment rollouts. Prefix replay offers an efficient alternative by sampling current-student responses from stored histories, reducing idle time for long-tail rollouts and allowing each collected…
relevance: on-policy distillation cost
```

**URL check:** https://arxiv.org/abs/2611.34756


### Harnesses That Improve Themselves: A Unifying Framework for Self-Improving Agent Harnesses

- **Link:** https://arxiv.org/abs/2611.22299
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Self-improving agent harnesses can be built by modularly editing four runtime components through a diagnose-patch-validate-deploy loop, with validation gates and safety defenses, yielding better generalization and lower token cost than prompt reflection or full rewrites.
- **Abstract:** Whether a foundation model succeeds as an autonomous agent depends as much on its runtime software as on its weights. This runtime, the agent harness, manages context and memory, steers multi-turn control, executes tool actions in sandboxes, and verifies work before stopping. Because models differ in how they use tools and how they fail, a static harness tuned for one model or task often stalls, wastes tokens, or regresses on another. This bottleneck has driven a shift from prompt tuning to self-improving agent harnesses: systems that inspect their own execution traces, separate runtime bugs…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Harnesses That Improve Themselves: A Unifying Framework for Self-Improving Agent Harnesses
kern: Self-improving agent harnesses can be built by modularly editing four runtime components through a diagnose-patch-validate-deploy loop, with validation gates and safety defenses, yielding better generalization and lower token cost than prompt reflection or full rewrites.
relevance: self-improving harness framework
```

**URL check:** https://arxiv.org/abs/2611.22299


### Cross-Benchmark Transfer from RL on Agentic Coding Tasks

- **Link:** https://arxiv.org/abs/2610.00890
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Coding agents often fail in the last mile: they build most of a feature but drop a requirement, test only the cases their implementation already handles, break behavior that was supposed to stay intact, or validate against an unchecked assumption. We ask whether reinforcement learning (RL) on expert-built agentic coding tasks closes this gap, and whether what the agent learns transfers beyond the training distribution. We post-train Kimi K2.7 Code, a 1T-parameter (32B active) open-weight mixture-of-experts model, with RL alone on 1,700 tasks: 1,000 repository tasks graded by hidden fail-to-pa…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Cross-Benchmark Transfer from RL on Agentic Coding Tasks
kern: (skip: RL cross-benchmark transfer)
relevance: RL cross-benchmark transfer
```

**URL check:** https://arxiv.org/abs/2610.00890


### SWE-OPD: On-Policy Distillation for Agentic Coding

- **Link:** https://arxiv.org/abs/2611.21020
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** In this work, we study on-policy distillation (OPD) for transferring agentic coding capabilities from a large teacher model to a smaller student model. Prior work has focused primarily on reasoning and short-horizon agentic tasks. We present SWE-OPD, a minimal OPD study for software engineering, where the student interacts with executable repositories and the teacher supervises the prefixes visited by the student. Across three teacher--student pairs, two training sources, and three SWE benchmarks, we find that on-policy supervision transfers coding capability: supervision from Qwen3.6-27B inc…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: SWE-OPD: On-Policy Distillation for Agentic Coding
kern: (skip: coding distillation)
relevance: coding distillation
```

**URL check:** https://arxiv.org/abs/2611.21020


### From Repositories to Training Environments: Scaling Long-Horizon Coding Agents with Environment Evolution Loop

- **Link:** https://arxiv.org/abs/2611.21152
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** RepoFactory converts real repositories into verifiable coding environments and optimizes them via an Environment Evolution Loop using proxy feedback, enabling trained coding agents to achieve strong gains on long-horizon coding and agentic benchmarks.
- **Abstract:** Training coding agents for long-horizon tasks requires environments with verifiable feedback. Existing pipelines often follow a linear process that ends with validation, establishing usability but providing little guidance on improving training value. Recursive self-improvement (RSI) often requires model rollouts or model training followed by downstream evaluation, with costs and feedback delays amplified on long-horizon tasks. How can we use timely, reliable proxy signals to improve training value and synthesize environments at scale? We present RepoFactory, an automated pipeline that conver…
- **Upvotes:** 15

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: From Repositories to Training Environments: Scaling Long-Horizon Coding Agents with Environment Evolution Loop
kern: RepoFactory converts real repositories into verifiable coding environments and optimizes them via an Environment Evolution Loop using proxy feedback, enabling trained coding agents to achieve strong gains on long-horizon coding and agentic benchmarks.
relevance: repos as training environments
```

**URL check:** https://arxiv.org/abs/2611.21152


### Embeddings vs. Grep: Rethinking the Dense Advantage in Code Search

- **Link:** https://arxiv.org/abs/2611.20455
- **Source:** HF q:index · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Code-search benchmarks show dense encoders well ahead of BM25, yet coding agents do well with grep. What does this dense advantage measure? Existing benchmarks cannot tell: they use curated queries, old code and a handicapped BM25. To find out, we build Repo-Premium, a realistic repository-level code-search benchmark. It ranks files in real repositories, with curated and raw queries in Python, JavaScript, TypeScript, Go, Rust and Java, pull requests from 2022 to 2026, and a preregistered test pool over 91 repositories. Our experiments trace the advantage to two sources: evaluation choices tha…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Embeddings vs. Grep: Rethinking the Dense Advantage in Code Search
kern: Code-search benchmarks show dense encoders well ahead of BM25, yet coding agents do well with grep. What does this dense advantage measure? Existing benchmarks cannot tell: they use curated queries, old code and a handicapped BM25. To find out, we build Repo-Premium, a realistic repository-level code-search…
relevance: embeddings vs grep in code search
```

**URL check:** https://arxiv.org/abs/2611.20455


### FeatLens: Feature-Guided Dependency Retrieval for Repository-Level Code Generation

- **Link:** https://arxiv.org/abs/2609.26480
- **Source:** HF q:index · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** FeatLens improves repository-level code generation by using feature-guided indexing and graph expansion to retrieve precise, dispersed code dependencies without online LLM calls.
- **Abstract:** Retrieving task-relevant code dependencies is critical for repository-level code generation. Existing approaches obtain dependency context through similarity-based retrieval, repository graphs, or LLM-driven exploration. A central challenge is to identify the dispersed dependencies needed to implement a functional requirement, rather than merely retrieve broadly related code. This paper presents FeatLens, a feature-guided dependency retrieval approach for repository-level code generation. FeatLens first builds an offline index linking natural-language feature descriptions to function-level co…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: FeatLens: Feature-Guided Dependency Retrieval for Repository-Level Code Generation
kern: FeatLens improves repository-level code generation by using feature-guided indexing and graph expansion to retrieve precise, dispersed code dependencies without online LLM calls.
relevance: feature-guided dependency retrieval
```

**URL check:** https://arxiv.org/abs/2609.26480


### Coding Agent Memory Post-Training II: Unlocking the Memory Potential of Pre-trained File Operations for Long-Horizon Tasks via On-Policy Distillation

- **Link:** https://arxiv.org/abs/2611.14009
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** A single policy trained with asynchronous on-policy distillation across five long-horizon agentic environments learns file-based memory management, outperforming prior OPD baselines and generalizing to external coding benchmarks.
- **Abstract:** Language-model agents increasingly tackle long-horizon tasks whose interaction histories exceed the model's active context. They must therefore decide what to write down and what to read back, and when to do either. Recent work has begun to use on-policy distillation (OPD) to make memory control part of the policy, relying on memory tools and compaction protocols that lie outside either model's pre-training. However, this weakens the distillation on both sides: the teacher cannot give useful guidance on an interface it has never used, and the student samples too few meaningful memory actions…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Coding Agent Memory Post-Training II: Unlocking the Memory Potential of Pre-trained File Operations for Long-Horizon Tasks via On-Policy Distillation
kern: A single policy trained with asynchronous on-policy distillation across five long-horizon agentic environments learns file-based memory management, outperforming prior OPD baselines and generalizing to external coding benchmarks.
relevance: file-based memory training
```

**URL check:** https://arxiv.org/abs/2611.14009


### Coding Agent Memory Post-training: Unlocking the Memory Potential of Pre-trained File Operations for Long-Horizon Tasks via Reinforcement Learning

- **Link:** https://arxiv.org/abs/2609.34422
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Language-model agents increasingly tackle long-horizon tasks whose interaction histories exceed the model's active context. Recent work has begun to use reinforcement learning to make memory control part of the policy, often relying on predefined memory tools within domain-specific training environments of relatively short horizons. This setup ties learned memory behavior to environment-specific interfaces that lie outside the base model's pre-training and must be learned from scratch, so even after post-training, agents struggle to use memory in long-horizon tasks. To address these limitatio…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Coding Agent Memory Post-training: Unlocking the Memory Potential of Pre-trained File Operations for Long-Horizon Tasks via Reinforcement Learning
kern: Language-model agents increasingly tackle long-horizon tasks whose interaction histories exceed the model's active context. Recent work has begun to use reinforcement learning to make memory control part of the policy, often relying on predefined memory tools within domain-specific training environments of relatively…
relevance: file-based memory; context overflow
```

**URL check:** https://arxiv.org/abs/2609.34422


### SWE-Trail: History-Guided Trajectory Collection for Coding Agent Training

- **Link:** https://arxiv.org/abs/2611.02074
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** SWE-Trail improves trajectory collection for coding agents by using past rollouts to guide exploration without exposing history to the agent, yielding better-trained student models.
- **Abstract:** Coding agents solve repository issues through long sequences of exploration, editing, and validation. These trajectories are increasingly used as post-training data, so how they are collected shapes what the trained model learns. A common approach is to sample multiple trajectories independently for each issue and then select or curate them. However, as more trajectories are sampled independently, later trajectories become increasingly redundant, even though earlier trajectories could guide where subsequent collection effort should be spent. A natural way to use this history is to expose it t…
- **Upvotes:** 40

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: SWE-Trail: History-Guided Trajectory Collection for Coding Agent Training
kern: (skip: trajectory collection)
relevance: trajectory collection
```

**URL check:** https://arxiv.org/abs/2611.02074


### Skip the Compressor: Coding Agents Fix More Issues When They Pick Whole Files

- **Link:** https://arxiv.org/abs/2610.21073
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** CQ2-CARE improves software issue resolution by selecting exact files to include verbatim within a token budget, outperforming compression and retrieval methods.
- **Abstract:** A coding agent works on repositories that can be far larger than its context window can hold. Prompt compressors and retrievers offer solutions to this problem, but patching an issue needs two things at once: the files that must change, and their code exactly as written, since the model must reproduce the lines it edits. Retrievers rank code by its similarity to the issue rather than by whether it must change, and compressors delete text to fit the budget. We show that at an equal token budget, an agent resolves more issues when the budget goes to choosing which files to show verbatim, as our…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Skip the Compressor: Coding Agents Fix More Issues When They Pick Whole Files
kern: CQ2-CARE improves software issue resolution by selecting exact files to include verbatim within a token budget, outperforming compression and retrieval methods.
relevance: whole-file selection beats compression
```

**URL check:** https://arxiv.org/abs/2610.21073


### WitnessGym: Benchmarking Coding Agents on the Construction of Bug Witnesses

- **Link:** https://arxiv.org/abs/2609.36635
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** WitnessGym automates benchmark construction for bug validation by injecting bugs into real project paths and preserving executable witnesses, revealing that coding agents still struggle to construct valid bug evidence.
- **Abstract:** Bug validation asks a coding agent to produce an executable witness for a reported bug. The witness combines a concrete input with a testing harness and exposes faulty behavior during execution. Such evidence makes audit findings actionable, yet benchmark evaluation is difficult when cases reuse public historical bugs and witnesses or require manual construction. We present WitnessGym, an automated framework for constructing bug-validation benchmarks through bug injection. It injects bugs into test-reached paths of real projects, rebuilds each project, and retains cases exposed by a construct…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: WitnessGym: Benchmarking Coding Agents on the Construction of Bug Witnesses
kern: WitnessGym automates benchmark construction for bug validation by injecting bugs into real project paths and preserving executable witnesses, revealing that coding agents still struggle to construct valid bug evidence.
relevance: bug witnesses benchmark
```

**URL check:** https://arxiv.org/abs/2609.36635


### What Does a Harness Buy? Tokens, Mostly

- **Link:** https://arxiv.org/abs/2610.04433
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Harness choice changes cost up to 3x and causes score variance comparable to reruns, with only minor consistent performance differences across production coding agents.
- **Abstract:** A coding agent is a language model wrapped in a harness: the system prompt, the tool set, and the context management that turn a chat model into something that can work inside a repository. Production harnesses ship releases daily, vendors advertise pass-rate gains from harness changes, and leaderboards mix harnesses freely. What is rarely measured is how much the harness itself moves the score when the model is held fixed. We run five models through three production harnesses, Claude Code, mini-SWE-agent, and OpenCode, on SWE-bench Verified, and rerun the same configurations to calibrate how…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: What Does a Harness Buy? Tokens, Mostly
kern: Harness choice changes cost up to 3x and causes score variance comparable to reruns, with only minor consistent performance differences across production coding agents.
relevance: harness choice changes cost up to 3x
```

**URL check:** https://arxiv.org/abs/2610.04433


### An Empirical Study of Harness Design for Coding Agents

- **Link:** https://arxiv.org/abs/2609.20804
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Component-level analysis of a coding harness reveals that context management prevents overflow failures, planning saves costs for stronger models, and predefined tools help weaker bash users, guiding modular harness design.
- **Abstract:** Coding harnesses shape how autonomous coding agents translate model capabilities into long-horizon software-engineering performance, yet existing work typically evaluates harnesses as monolithic systems, leaving the effectiveness of individual components unclear. To enable component-level comparisons, we study this question with a lightweight coding harness whose execution loop is fixed while three components are varied: planning, action space, and context management. Across four models evaluated on SWE-Bench Verified and Terminal-Bench 2.1, we evaluate 176 matched settings spanning five cont…
- **Upvotes:** 60

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: An Empirical Study of Harness Design for Coding Agents
kern: Component-level analysis of a coding harness reveals that context management prevents overflow failures, planning saves costs for stronger models, and predefined tools help weaker bash users, guiding modular harness design.
relevance: component-level harness design study
```

**URL check:** https://arxiv.org/abs/2609.20804


### RepoAtlas: Guiding Coding Agents via Evolving Multimodal Repository Views

- **Link:** https://arxiv.org/abs/2609.16936
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** RepoAtlas improves repository-level issue resolution by maintaining focused, evolving multimodal views of code graphs through a selective projection and refresh loop.
- **Abstract:** Large language model (LLM)-powered coding agents have made rapid progress in automating software engineering tasks, yet repository-level issue resolution remains challenging. Beyond generating a plausible patch, an agent must localize relevant code across interdependent files and maintain repository context that is both sufficient and focused. Code graphs expose non-local relations, but linear text interfaces obscure their topology; rendering the full repository graph yields visual representations that are too dense to perceive reliably, whereas a one-shot local view becomes stale as explorat…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: RepoAtlas: Guiding Coding Agents via Evolving Multimodal Repository Views
kern: RepoAtlas improves repository-level issue resolution by maintaining focused, evolving multimodal views of code graphs through a selective projection and refresh loop.
relevance: evolving repository views
```

**URL check:** https://arxiv.org/abs/2609.16936


### SWE-Duel: Towards a Self-Scaling Arena for Coding Agents

- **Link:** https://arxiv.org/abs/2610.12569
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** SWE-Duel is a self-scaling coding benchmark where agents alternately author and review repository tasks to dynamically adjust difficulty and prevent data leakage.
- **Abstract:** Static coding benchmarks are fixed at release. Over time their tasks leak into training data, and stronger agents eventually saturate them. We argue that a benchmark should instead aim to be self-scaling: its tasks and oracles are created at evaluation time, so no content exists in advance to leak, and its difficulty is set by the participating agents rather than fixed at release. We introduce SWE-Duel, an arena in which two coding agents evaluate each other over mirrored Red-Blue turns. In each turn, the Red agent works on a real repository across three context-isolated sessions. It proposes…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: SWE-Duel: Towards a Self-Scaling Arena for Coding Agents
kern: SWE-Duel is a self-scaling coding benchmark where agents alternately author and review repository tasks to dynamically adjust difficulty and prevent data leakage.
relevance: self-scaling arena
```

**URL check:** https://arxiv.org/abs/2610.12569


### Switch-SWE: Do Coding Agents Hold Focus When Switching Between Unfinished Tasks?

- **Link:** https://arxiv.org/abs/2611.02017
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** A benchmark for resuming interrupted software tasks reveals performance drops from interleaved work, and a context-management module improves recovery.
- **Abstract:** Software development sessions often involve several unfinished tasks rather than one issue carried through to completion. As coding agents take on repository-level development, they need to recover an earlier task's requirements and partial progress after intervening work. Existing repository-level benchmarks typically score one issue-to-patch episode and do not directly measure whether an agent can resume a task after advancing other unfinished work in the same repository. We introduce \ourmethod, a benchmark for focus-task resumption in sessions that interleave unfinished tasks drawn from t…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Switch-SWE: Do Coding Agents Hold Focus When Switching Between Unfinished Tasks?
kern: A benchmark for resuming interrupted software tasks reveals performance drops from interleaved work, and a context-management module improves recovery.
relevance: focus when switching tasks; recovery
```

**URL check:** https://arxiv.org/abs/2611.02017


### ChainSWE: Benchmarking Coding Agents on Multi-Bug Software Maintenance

- **Link:** https://arxiv.org/abs/2607.02606
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** ChainSWE introduces a benchmark for sequential, dependent bug fixes in shared codebases, revealing substantial performance declines as repair chains lengthen.
- **Abstract:** Language model (LM) agents are increasingly deployed to maintain codebases over extended periods, fixing streams of related defects while carrying context from one fix to the next. Yet existing software engineering (SWE) benchmarks evaluate models one bug at a time: the repository is reset, the codebase is re-read, and a single self-contained issue is graded in isolation. This setting collapses a continuous maintenance workflow into a series of independent sessions, ignoring the cumulative dependencies that make real-world bug fixing challenging. To bridge this gap, we introduce ChainSWE, the…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: ChainSWE: Benchmarking Coding Agents on Multi-Bug Software Maintenance
kern: ChainSWE introduces a benchmark for sequential, dependent bug fixes in shared codebases, revealing substantial performance declines as repair chains lengthen.
relevance: multi-bug maintenance benchmark
```

**URL check:** https://arxiv.org/abs/2607.02606


### RealSWE: A Compositional Evaluation of Coding Agents under Realistic User Requests

- **Link:** https://arxiv.org/abs/2608.27831
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Real-world coding requests are shorter and more casual than benchmark tasks, and explicitly stating desired behavior and motivation improves LLM software engineering performance.
- **Abstract:** Coding agents are now commonly evaluated on the SWE-bench family of benchmarks, whose tasks are built from curated GitHub issues: long, structured, and information-rich. Real user requests, however, are typically far shorter and less structured. To characterize this gap, we define a six-category information taxonomy and four dimensions of linguistic style, and apply them to real user prompts from SWE-chat and problem statements from SWE-bench Verified and Pro. We find that requests carrying only a problem statement, alone or with limited additional context, account for 88% of real prompts but…
- **Upvotes:** 20

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: RealSWE: A Compositional Evaluation of Coding Agents under Realistic User Requests
kern: Real-world coding requests are shorter and more casual than benchmark tasks, and explicitly stating desired behavior and motivation improves LLM software engineering performance.
relevance: realistic user requests
```

**URL check:** https://arxiv.org/abs/2608.27831


### Learning When and How to Intervene: A Hindsight-Distilled Sentinel for Coding Agents

- **Link:** https://arxiv.org/abs/2609.39957
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** A hindsight-distillation framework trains lightweight sentinels to decide pre-execution interventions and provide feedback, improving coding-agent task completion by preventing error propagation.
- **Abstract:** Coding agents solve repository-level tasks through sequences of actions, where a single erroneous action can misdirect subsequent decisions and increase recovery costs. Existing approaches use execution feedback for recovery or specialized checks to block errors, but deciding before execution whether intervention will benefit eventual task completion remains challenging. To address this challenge, we propose HiSentinel, a hindsight-distillation framework that trains lightweight 0.6B and 1.7B sentinels to select pre-execution interventions aimed at improving task completion rather than correct…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: Learning When and How to Intervene: A Hindsight-Distilled Sentinel for Coding Agents
kern: A hindsight-distillation framework trains lightweight sentinels to decide pre-execution interventions and provide feedback, improving coding-agent task completion by preventing error propagation.
relevance: pre-execution intervention sentinels
```

**URL check:** https://arxiv.org/abs/2609.39957


### RAPO-Sol: Retrieval-Augmented Preference Optimization for Repository-Level Solidity Code Generation

- **Link:** https://arxiv.org/abs/2610.08429
- **Source:** HF q:repocontext · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** RAPO-Sol improves repository-level Solidity generation through retrieval-augmented fine-tuning and preference optimization using semantic perturbations, achieving better accuracy without inference overhead.
- **Abstract:** Smart contracts written in Solidity manage assets, permissions, and irreversible state changes, making code generation both useful and security-critical. Repository-level Solidity generation is challenging because models must synthesize complete contracts or libraries while preserving consistency across state variables, modifiers, events, inheritance, external calls, and access-control logic. We present RAPO-Sol, a two-stage training framework for repository-level Solidity code generation. First, Retrieval-Augmented Fine-Tuning (RAFT) augments each training input with similar Solidity example…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: RAPO-Sol: Retrieval-Augmented Preference Optimization for Repository-Level Solidity Code Generation
kern: (skip: Solidity code generation)
relevance: Solidity code generation
```

**URL check:** https://arxiv.org/abs/2610.08429


### Cost-Effective Repository Exploration for Agentic Issue Localization

- **Link:** https://arxiv.org/abs/2608.29675
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Repository exploration can be delegated to lower-cost models that retain most localization quality while significantly reducing time and token costs, with selection guided by downstream usage.
- **Abstract:** Repository exploration is a distinct and costly stage of coding-agent pipelines: before generating a patch, an agent must identify which repository files are likely to matter. We study whether this stage can be delegated to lower-cost models while retaining useful localization quality. Using our IssueLoc-Bench, we evaluate five explorer models under the same read-only interactive interface on 499 SWE-bench Verified-derived tasks and 500 tasks from 153 additional repositories. We measure early candidate discovery, top-three gold-file coverage, strict file-set recovery, agent time, and token us…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Cost-Effective Repository Exploration for Agentic Issue Localization
kern: Repository exploration can be delegated to lower-cost models that retain most localization quality while significantly reducing time and token costs, with selection guided by downstream usage.
relevance: cost-effective repo exploration
```

**URL check:** https://arxiv.org/abs/2608.29675


### What Open-Source Projects Tell Their Coding Agents: A Census of AGENTS.md and CLAUDE.md

- **Link:** https://arxiv.org/abs/2610.31715
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** Coding agents can be guided with instruction files in a repository. We examine this emerging practice through a census of popular, active GitHub repositories in thirteen languages, treating each repository's root AGENTS.md and CLAUDE.md as one instruction set. Agent instructions appear in of repositories and of the most-starred; where both files exist, CLAUDE.md usually points to AGENTS.md. We analyse statements using model-assisted annotation and human review. The annotations reveal a practical mix of project knowledge and rules about code, building and workflow. Collaboration rules name con…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent-docs & docs-architectuur
title: What Open-Source Projects Tell Their Coding Agents: A Census of AGENTS.md and CLAUDE.md
kern: Coding agents can be guided with instruction files in a repository. We examine this emerging practice through a census of popular, active GitHub repositories in thirteen languages, treating each repository's root AGENTS.md and CLAUDE.md as one instruction set. Agent instructions appear in of repositories and of the…
relevance: AGENTS.md / CLAUDE.md census
```

**URL check:** https://arxiv.org/abs/2610.31715


### E2E-SWE: Benchmarking LLMs on Building Working Codebases from Scratch

- **Link:** https://arxiv.org/abs/2609.38335
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** E2E-SWE is a benchmark assessing whether coding agents can build complete, installable software repositories from natural-language specifications, revealing significant performance differences among frontier models.
- **Abstract:** Coding agents powered by large language models (LLMs) are evolving from making localized code changes to developing complete software repositories. However, evaluating repository-scale generation remains challenging: tasks must demand system-level reasoning while ensuring that all evaluated behaviors are precisely specified and independent of any particular implementation. We introduce E2E-SWE, a benchmark for evaluating whether coding agents can build complete, functional software repositories end to end. E2E-SWE contains 186 whole-repository generation tasks spanning 11 programming language…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: E2E-SWE: Benchmarking LLMs on Building Working Codebases from Scratch
kern: E2E-SWE is a benchmark assessing whether coding agents can build complete, installable software repositories from natural-language specifications, revealing significant performance differences among frontier models.
relevance: codebases from scratch benchmark
```

**URL check:** https://arxiv.org/abs/2609.38335


### ProgramGym: Scaling Training Environments for Long-Horizon Program Reproduction Agents

- **Link:** https://arxiv.org/abs/2610.13395
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** ProgramGym introduces scalable verifiable training environments and a role-isolated agent workflow to improve long-horizon program reproduction from scratch.
- **Abstract:** Coding agents are increasingly used to build programs from scratch as software engineers do rather than to resolve issues within a repository or to generate a repository from a given requirements document. However, scalable verifiable training environments that force agents to discover what is required and to decide how the system should be designed remain scarce. Moreover, existing agent workflows also cannot sustain long-horizon development in which the agent explores the reference program before implementation. To address these challenges, we introduce ProgramGym, a framework consisting of…
- **Upvotes:** 45

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: ProgramGym: Scaling Training Environments for Long-Horizon Program Reproduction Agents
kern: ProgramGym introduces scalable verifiable training environments and a role-isolated agent workflow to improve long-horizon program reproduction from scratch.
relevance: training environments, program reproduction
```

**URL check:** https://arxiv.org/abs/2610.13395


### Teaching Agents to Code Reliably

- **Link:** https://arxiv.org/abs/2610.03984
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Training policies to diversify repair locations and edits, and to verify patches against reverted code, improves autonomous coding agent success and verification accuracy with less compute.
- **Abstract:** Autonomous coding agents solve repository issues by reading code, running commands, editing files, and submitting patches. Extra inference-time compute yields gains only when it produces a useful repair and supplies reliable evidence for choosing one. Three behaviors decide both, and we argue they are teachable rather than byproducts of scale, so a policy can carry them instead of a scaffold. Location diversity remains narrow, since attempts return to the same site and extra samples add no coverage. Edit diversity is left unexploited, since methodologies that differ resolve complementary issu…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Teaching Agents to Code Reliably
kern: Training policies to diversify repair locations and edits, and to verify patches against reverted code, improves autonomous coding agent success and verification accuracy with less compute.
relevance: teaching agents to code reliably
```

**URL check:** https://arxiv.org/abs/2610.03984


### PaperCompiler: Faithful Paper-to-Code Generation via Repository-Level Specification Compilation

- **Link:** https://arxiv.org/abs/2609.02272
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** PaperCompiler converts research papers into structured repository specifications that preserve method logic and cross-file consistency, improving code fidelity and reducing critical errors.
- **Abstract:** Faithfully translating research papers into repository-level implementations remains challenging because papers often describe methods at a high level, leave implementation assumptions implicit, and require generated repositories to preserve method logic, evaluation protocols, and cross-file consistency. Despite recent advances in paper-to-code agents, their intermediate outputs are often presented as free-form plans or summaries that downstream coding agents may ignore, reinterpret, or compress, leading to algorithmic simplification and inconsistent repository structure. To address these cha…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: PaperCompiler: Faithful Paper-to-Code Generation via Repository-Level Specification Compilation
kern: PaperCompiler converts research papers into structured repository specifications that preserve method logic and cross-file consistency, improving code fidelity and reducing critical errors.
relevance: paper-to-code via specifications
```

**URL check:** https://arxiv.org/abs/2609.02272


### LoLBench: Evaluating Coding Agents with Long-Horizon Proposals on Large Software Systems

- **Link:** https://arxiv.org/abs/2609.37143
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** LoLBench evaluates coding agents on large-scale modular development by requiring them to interpret high-level proposals and implement extensive changes across massive multilingual repositories, revealing major bottlenecks in code localization and perception.
- **Abstract:** Modern coding agents can deliver increasingly large repository-level changes, and recent benchmarks reflect this by emphasizing long-horizon tasks with large reference implementations. Many benchmarks evaluate coding agents' implementation capability to produce correct code edits from detailed specifications. However, practical modular development tasks also require the perception capability of grounding user intent and high-level design to derive a specification. We introduce LoLBench to evaluate both capabilities through the entire proposal-to-implementation process on large software system…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: LoLBench: Evaluating Coding Agents with Long-Horizon Proposals on Large Software Systems
kern: LoLBench evaluates coding agents on large-scale modular development by requiring them to interpret high-level proposals and implement extensive changes across massive multilingual repositories, revealing major bottlenecks in code localization and perception.
relevance: long-horizon proposal benchmark
```

**URL check:** https://arxiv.org/abs/2609.37143


### Small Agents with Semantic Search: Efficient Multilingual Code Localization

- **Link:** https://arxiv.org/abs/2610.05099
- **Source:** HF q:semantic · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** Compact specialized agents using local semantic search improve file localization accuracy and efficiency across programming languages while reducing latency and token usage.
- **Abstract:** Locating relevant files from natural-language requests is a core subtask for agents operating over code repositories. We investigate whether this task can be delegated to compact, specialized models to enable on-device search while reducing the token usage, latency, and inference cost of larger agents. We show that semantic search improves file localization, with gains in accuracy, cross-language transfer, and inference efficiency. To study this setting, we introduce a training framework for file-localization agents built around ColGREP, a local semantic search tool based on late-interaction…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Small Agents with Semantic Search: Efficient Multilingual Code Localization
kern: Compact specialized agents using local semantic search improve file localization accuracy and efficiency across programming languages while reducing latency and token usage.
relevance: small agents with semantic search
```

**URL check:** https://arxiv.org/abs/2610.05099


### JevCoder: When Does Decision Delegation Pay Off in Code Repair?

- **Link:** https://arxiv.org/abs/2610.19596
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** A low-cost probabilistic judge guides repair decisions in a coding agent workflow, reducing token use while improving repair rates across three models on SWE-bench tasks.
- **Abstract:** A coding agent repeatedly makes decisions as it repairs code. These decisions shape repair trajectories and affect the token cost of successive model requests. We ask which repair decisions can be delegated to a low-cost probabilistic judge to reduce token use while maintaining repair quality. The judges answer questions with probabilities over predefined answers, without generating explanations. We evaluate judgment quality across repair stages and test how individual interventions change subsequent repair work. We compare these interventions with unguided repair, which uses no judge, and wi…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: JevCoder: When Does Decision Delegation Pay Off in Code Repair?
kern: A low-cost probabilistic judge guides repair decisions in a coding agent workflow, reducing token use while improving repair rates across three models on SWE-bench tasks.
relevance: decision delegation in code repair
```

**URL check:** https://arxiv.org/abs/2610.19596


### AgSpec: Pushing the Limits of Retrieval-Based Speculative Decoding in Coding Agent Pipelines

- **Link:** https://arxiv.org/abs/2610.01108
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** AgSpec improves retrieval-based speculative decoding for coding agents by sourcing session and workspace corpora in emission format and adapting draft lengths via online feedback, significantly boosting throughput.
- **Abstract:** Retrieval-based speculative decoding (SD) drafts tokens by copying continuations from existing text, which suits coding agents that repeatedly reproduce code, logs, and earlier attempts. Yet existing methods fall short in agent pipelines: much of the reusable text is missing from their corpora or stored in a form that differs from what the agent emits, and their draft lengths ignore that accept length varies across agents and drifts over turns. We present AgSpec, a framework that supplies the corpus and draft-length policies that existing retrieval engines lack in coding-agent pipelines. AgSp…
- **Upvotes:** 13

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Inference
title: AgSpec: Pushing the Limits of Retrieval-Based Speculative Decoding in Coding Agent Pipelines
kern: AgSpec improves retrieval-based speculative decoding for coding agents by sourcing session and workspace corpora in emission format and adapting draft lengths via online feedback, significantly boosting throughput.
relevance: retrieval spec decoding in coding pipelines
```

**URL check:** https://arxiv.org/abs/2610.01108


### BabelArena: A Large-Scale Multilingual Benchmark for LLM Agents

- **Link:** https://arxiv.org/abs/2609.23490
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Gist (HF ai_summary):** BabelFlow adapts agent benchmarks to multiple languages via dependency-aware translation and verification, yielding BabelArena to reveal cross-language disparities in tool-use errors, token consumption, and output consistency.
- **Abstract:** Large language model (LLM) agents increasingly execute multi-step workflows through tool use and interaction with users and environments. However, current agent evaluations are largely English-centric, limiting our understanding of agent capabilities in multilingual settings. We introduce BabelFlow, a benchmark-general agentic workflow that adapts existing agent benchmarks to new languages by analyzing runtime dependencies, coordinating structure-preserving translation, and combining multi-layer verification with human review to preserve task and evaluation semantics. Using BabelFlow, we cons…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Evaluation & benchmarks
title: BabelArena: A Large-Scale Multilingual Benchmark for LLM Agents
kern: BabelFlow adapts agent benchmarks to multiple languages via dependency-aware translation and verification, yielding BabelArena to reveal cross-language disparities in tool-use errors, token consumption, and output consistency.
relevance: multilingual agent benchmark
```

**URL check:** https://arxiv.org/abs/2609.23490


### SpecRead: A Benchmark for Measuring Whether Language Models Understand Hardware Specifications

- **Link:** https://arxiv.org/abs/2609.33699
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** Workflow & Specs _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: SpecRead: A Benchmark for Measuring Whether Language Models Understand Hardware Specifications
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2609.33699

