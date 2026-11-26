# Promote drafts — 2026-W48 — Prompt Engineering

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### JIT-Agent: Scaling Harness Intelligence via Just-in-Time Harness Evolution

- **Link:** https://arxiv.org/abs/2608.25593
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** JIT-Agent is a trainable model that synthesizes adaptive agent harnesses for off-the-shelf LLMs, improving performance across diverse models and tasks.
- **Abstract:** Agent capability is not determined by the model alone. The agent harness, encompassing memory management, planning strategy, action protocol, and tool/skill orchestration, can dominate the contribution of the underlying foundation model. Yet harness design remains manual, task-specific, and fundamentally unscalable. We present JIT-Agent, a harness intelligence model trained to synthesize task-adaptive agent harnesses on the fly for arbitrary off-the-shelf agentic LLMs. We formalize the agent harness as a composable, machine-generatable artifact governed by a fixed four-module protocol, and tr…
- **Upvotes:** 62

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: JIT-Agent: Scaling Harness Intelligence via Just-in-Time Harness Evolution
kern: JIT-Agent is a trainable model that synthesizes adaptive agent harnesses for off-the-shelf LLMs, improving performance across diverse models and tasks.
relevance: just-in-time harness synthesis
```

**URL check:** https://arxiv.org/abs/2608.25593


### Learning Meta-Skills for Agent Harness Design in Test-Time AI4AI

- **Link:** https://arxiv.org/abs/2609.38143
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Fixed-weight AI agents learn to build reusable execution environments for other agents via meta-skills derived from feedback, improving task performance without model updates.
- **Abstract:** Agent performance depends on both reasoning ability and the environment in which it acts. We study test-time AI-for-AI, asking how a Builder can learn to construct better execution environments for a Target while both models' weights remain fixed. To make the Builder's experience reusable, we introduce Meta-Skill: principles specifying when support is needed and what resources to provide. The Builder learns these principles from Target's execution feedback on the development set, then uses the frozen skill bank to construct harnesses for unseen tasks. Across Harness-Bench and NewtonBench, ful…
- **Upvotes:** 51

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Learning Meta-Skills for Agent Harness Design in Test-Time AI4AI
kern: Fixed-weight AI agents learn to build reusable execution environments for other agents via meta-skills derived from feedback, improving task performance without model updates.
relevance: meta-skills for harness design
```

**URL check:** https://arxiv.org/abs/2609.38143


### MILO: Automated Harness Discovery via Orchestrated Multi-Agent Evolution

- **Link:** https://arxiv.org/abs/2609.38349
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** MILO co-evolves agent harnesses and search strategies via island-based lineage memory and adaptive orchestration, substantially improving long-horizon agent performance across benchmarks.
- **Abstract:** Modern agentic systems combine an AI model with a harness that controls execution and environmental interactions. Harness design strongly affects long-horizon performance, yet its combinatorial search space demands substantial human effort that must be repeated as models change. Existing automated methods explore this space narrowly, optimizing only components such as prompts or skills or becoming trapped by fixed, exploitative search strategies. We introduce MILO (Meta-evolutionary Island Orchestration), a framework that co-evolves agent harnesses and the strategy used to discover them. MILO…
- **Upvotes:** 20

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: MILO: Automated Harness Discovery via Orchestrated Multi-Agent Evolution
kern: MILO co-evolves agent harnesses and search strategies via island-based lineage memory and adaptive orchestration, substantially improving long-horizon agent performance across benchmarks.
relevance: harness discovery via multi-agent evolution
```

**URL check:** https://arxiv.org/abs/2609.38349


### World Action Agent: Harnessing VLMs for Robot Manipulation via World Action Rehearsal

- **Link:** https://arxiv.org/abs/2609.29964
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** World Action Agent enables vision-language models to control robots within a visual workspace featuring contact views, action rehearsal, and in-view correction, achieving state-of-the-art manipulation results and enabling skill evolution and model fine-tuning.
- **Abstract:** General-purpose vision-language models (VLMs) bring broad knowledge and spatial reasoning to robot manipulation, yet existing systems either use them indirectly, to predict constraints or write programs, or give them a view of the scene rather than a world in which to act. We present World Action Agent (WAA), a multi-agent harness through which VLMs pilot robots with basic tools, making every decision within a visual action workspace. The workspace has three properties. Contact views, selected automatically from the scene geometry, present the scene around the current interaction. Action rehe…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: World Action Agent: Harnessing VLMs for Robot Manipulation via World Action Rehearsal
kern: World Action Agent enables vision-language models to control robots within a visual workspace featuring contact views, action rehearsal, and in-view correction, achieving state-of-the-art manipulation results and enabling skill evolution and model fine-tuning.
relevance: world action rehearsal for manipulation
```

**URL check:** https://arxiv.org/abs/2609.29964


### MammoClaw: Towards Skill-Evolving Agent Harness for Breast Cancer Mammography Analysis

- **Link:** https://arxiv.org/abs/2609.31789
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** MammoClaw is a training-free agent framework using frozen multimodal language models and mammography-specific tools to iteratively gather evidence, with self-evolving skills improving tool use and performance on breast imaging tasks.
- **Abstract:** In this work, we explore MammoClaw, a training-free agent framework that leverages frozen MLLMs for mammography analysis. To support agentic investigation, we equip the agent with lightweight mammography-specific tools for targeted image analysis, including ROI, paired-view, and contralateral-breast examination. MammoClaw iteratively gathers evidence through these tools, while skill evolution enables non-parametric adaptation by transforming failed trajectories into reusable guidance for later runs. We evaluate the framework on BI-RADS assessment and breast density estimation tasks. In our ex…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: MammoClaw: Towards Skill-Evolving Agent Harness for Breast Cancer Mammography Analysis
kern: (skip: mammography agent)
relevance: mammography agent
```

**URL check:** https://arxiv.org/abs/2609.31789


### EvoUndo: Recoverability-Constrained Self-Evolution for LLM Agent Harnesses

- **Link:** https://arxiv.org/abs/2608.28363
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** EvoUndo evaluates recoverability of self-modifying LLM agents and shows that reliable recovery requires co-designing verification, state grounding, and recovery-language expressivity.
- **Abstract:** LLM agents increasingly modify their own prompts, tools, middleware, resources, and execution harnesses at runtime. Such self-evolution can improve capability, but a successful mutation may leave persistent effects that cannot be safely reversed in states different from the one in which it was created. We introduce EvoUndo, a framework for representing, synthesizing, diagnosing, and independently verifying recoverability of model-generated self-modifications across counterfactual states. Across 600 unseen one-shot self-evolution tasks, we identify 197 capability-improving mutations that fail…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: EvoUndo: Recoverability-Constrained Self-Evolution for LLM Agent Harnesses
kern: EvoUndo evaluates recoverability of self-modifying LLM agents and shows that reliable recovery requires co-designing verification, state grounding, and recovery-language expressivity.
relevance: recoverability of self-modifying agents
```

**URL check:** https://arxiv.org/abs/2608.28363


### Recursive Experiential-Working Memory Evolution for Long-Horizon Agent Harnesses

- **Link:** https://arxiv.org/abs/2608.24876
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Recuris introduces a recursive memory architecture that tracks progress and guides skill selection to improve long-horizon agent success through localized, validation-gated updates.
- **Abstract:** Recursive self-improvement (RSI) remains hard in long-horizon tasks, where growing histories obscure the task state and misalign skill invocation. We introduce Recuris, a recursive Experiential-Working Memory architecture for long-horizon agent harnesses, in which Working Memory tracks task progress and guides skill selection from Experiential Memory, grounding skill use in current needs rather than the full history. This coupling also turns execution into structured evidence that localizes failures to specific memory components. Across tasks, a fixed Meta-Agent turns that evidence into local…
- **Upvotes:** 32

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Loop Engineering
title: Recursive Experiential-Working Memory Evolution for Long-Horizon Agent Harnesses
kern: Recuris introduces a recursive memory architecture that tracks progress and guides skill selection to improve long-horizon agent success through localized, validation-gated updates.
relevance: validation-gated memory evolution
```

**URL check:** https://arxiv.org/abs/2608.24876


### MOTIO: Agentic Skill Engineering for Reality-Grounded Humanoid Loco-Manipulation

- **Link:** https://arxiv.org/abs/2610.33446
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** MOTIO converts human videos and 3D assets into executable humanoid robot programs via agentic reasoning and physics feedback, then distills them into a shared policy.
- **Abstract:** We present MOTIO, an agentic skill-engineering system that turns ordinary human-action videos, reality-grounded 3D assets, motion references, and reusable robot skills into executable humanoid loco-manipulation programs. Through in-context task and contact reasoning, an agent constructs staged robot-native interactions and improves them using physics execution, multi-frame feedback, and human validation---without task-specific teleoperation or robot demonstration collection. Agentic 3D supplies metric product and environment assets, while existing whole-body, inverse-kinematics, and dexterous…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: MOTIO: Agentic Skill Engineering for Reality-Grounded Humanoid Loco-Manipulation
kern: MOTIO converts human videos and 3D assets into executable humanoid robot programs via agentic reasoning and physics feedback, then distills them into a shared policy.
relevance: agentic humanoid manipulation
```

**URL check:** https://arxiv.org/abs/2610.33446


### How Feedback-Free Self-Evolution Reshapes Agent Skills: A Systematic Study

- **Link:** https://arxiv.org/abs/2611.25534
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** Agent skills are documents in which experts write down procedural knowledge, and models increasingly maintain them by rewriting them without feedback. Such rewriting could adapt a skill to the model that uses it or erode the expert knowledge that makes it useful, yet how skills evolve under this feedback-free self-evolution has not been studied. We let models rewrite expert skills round after round without any task, run or judgment and run agents built on the same models with the rewritten skills. Our experiments show that the skills lose value rather than improve, as every model we test perf…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Prompt Engineering
title: How Feedback-Free Self-Evolution Reshapes Agent Skills: A Systematic Study
kern: Agent skills are documents in which experts write down procedural knowledge, and models increasingly maintain them by rewriting them without feedback. Such rewriting could adapt a skill to the model that uses it or erode the expert knowledge that makes it useful, yet how skills evolve under this feedback-free…
relevance: feedback-free skill self-evolution
```

**URL check:** https://arxiv.org/abs/2611.25534


### Prune to Expand: Training Prompt Enhancers with Less to Imitate

- **Link:** https://arxiv.org/abs/2611.27229
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Prune to Expand (P2E) refines dense-caption supervision by selectively removing redundant sentences under a per-example deletion bound, improving prompt enhancement alignment with human preferences and visual quality over conventional dense-caption supervised fine-tuning.
- **Abstract:** Prompt enhancement (PE) refines concise user prompts into detailed descriptions to improve the compositional aesthetics of generated images while preserving user intent. A common practice constructs supervised fine-tuning (SFT) pairs by deriving short, user-like prompts from dense captions, implicitly assuming that captions that improve image generation also provide effective supervision. In this paper, however, we uncover a counterintuitive finding: PE models trained on caption pairs with substantial generation gains perform comparably to those trained on pairs with only marginal gains. We a…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Prune to Expand: Training Prompt Enhancers with Less to Imitate
kern: (skip: prompt enhancer supervision)
relevance: prompt enhancer supervision
```

**URL check:** https://arxiv.org/abs/2611.27229


### Embo-Harness: Towards Understanding Frontier-Model-as-Policy Harness

- **Link:** https://arxiv.org/abs/2611.31201
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** A systematic framework shows that frontier multimodal models can serve as robot policies when harnessed with interfaces favoring native visual reasoning and tool use, achieving high success in simulated and real manipulation tasks.
- **Abstract:** Frontier multimodal models exhibit extraordinary generalization in generating robot actions from observations and instructions, enabling a new paradigm in which they serve directly as policies within closed-loop robotic harnesses. However, the design principles of such harnesses, and the capabilities underlying their strong performance, remain unclear. We present Embo-Harness, a framework for systematically studying frontier-model-as-policy harnesses. We investigate four components of the robotic agentic loop, namely, prompting, planning, action execution, and tool use, and distill six empiri…
- **Upvotes:** 105

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Embo-Harness: Towards Understanding Frontier-Model-as-Policy Harness
kern: A systematic framework shows that frontier multimodal models can serve as robot policies when harnessed with interfaces favoring native visual reasoning and tool use, achieving high success in simulated and real manipulation tasks.
relevance: frontier model as robot policy harness
```

**URL check:** https://arxiv.org/abs/2611.31201


### A Glimpse of Training VLMs as Foundation Models for Robotic Manipulation

- **Link:** https://arxiv.org/abs/2611.29338
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** nanoAstra combines semantic action modeling with capability-preserving supervised fine-tuning to train vision-language models for generalizable robot manipulation, achieving strong zero-shot success and faster streaming execution.
- **Abstract:** Recently, GPT-6 Astra demonstrates strong generalization in robot control, yet limited disclosure of its training leaves open how such capabilities can be reproduced. We introduce nanoAstra, an approach to training vision-language models (VLMs) for generalizable manipulation that combines semantic action modeling with capability-preserving supervised fine-tuning (CP-SFT). nanoAstra represents robot behavior as semantic steps composed of reusable, parameterized action primitives, guided by explicit progress descriptions. Meanwhile, CP-SFT uses an explicit robot-specific system prompt to constr…
- **Upvotes:** 56

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: A Glimpse of Training VLMs as Foundation Models for Robotic Manipulation
kern: nanoAstra combines semantic action modeling with capability-preserving supervised fine-tuning to train vision-language models for generalizable robot manipulation, achieving strong zero-shot success and faster streaming execution.
relevance: VLM robot manipulation
```

**URL check:** https://arxiv.org/abs/2611.29338


### Composable Soft-Prompt Distillation of RL Experts: Toward Continual Post-Training

- **Link:** https://arxiv.org/abs/2611.27376
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** RL post-training typically produces domain experts that must then be consolidated into one model, and as new experts keep arriving, this consolidation becomes a continual process. Weight merging and multi-teacher on-policy distillation (MOPD) must re-consolidate the whole model whenever an expert is added, and can erode capabilities outside the target domains. We propose Composable Soft-Prompt Distillation (CSPD), which keeps the pre-RL model frozen, distills each RL expert independently into a soft prompt, and composes experts by concatenating their prompts without joint training. A single s…
- **Upvotes:** 33

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Composable Soft-Prompt Distillation of RL Experts: Toward Continual Post-Training
kern: (skip: soft-prompt distillation of RL experts)
relevance: soft-prompt distillation of RL experts
```

**URL check:** https://arxiv.org/abs/2611.27376


### Distilling Visual Agents from Limited Interaction Experience

- **Link:** https://arxiv.org/abs/2611.28618
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** A few selected interaction trajectories combined with on-policy distillation allow a small visual agent to transfer broadly and recover most of a larger teacher's performance with minimal online experience.
- **Abstract:** How much interaction experience is needed to distill a capable visual agent? We study learning from few tasks and recorded interaction histories. Our framework selects representative trajectories using skill-context coverage and ordered visual-decision similarity. On-policy distillation (OPD) learns through fresh interaction on selected tasks or fresh student responses at fixed histories. Across Navigation, Sokoban, and spatial mapping, even one online training task supports transfer to other tasks. Four fixed trajectories raise a 4B student's success from 49.17% to 82.08% on standard Navigat…
- **Upvotes:** 21

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Distilling Visual Agents from Limited Interaction Experience
kern: (skip: visual agent distillation)
relevance: visual agent distillation
```

**URL check:** https://arxiv.org/abs/2611.28618


### DexDuet: Learning Contact-Preserving Bimanual Dexterity from Human Demonstrations

- **Link:** https://arxiv.org/abs/2611.30495
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** Human demonstrations provide a rich source of bimanual dexterous skills, yet transferring them to robot hands remains challenging. Existing methods primarily optimize object trajectory tracking, often overlooking how human hands interact with the object. Even with accurate tracking, robots may contact incorrect object parts or slide their fingers, resulting in unstable manipulation. We present DexDuet, a framework that learns contact-preserving bimanual dexterity from a single human demonstration. DexDuet employs two interaction rewards to preserve human hand-object configurations and contact…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: DexDuet: Learning Contact-Preserving Bimanual Dexterity from Human Demonstrations
kern: Human demonstrations provide a rich source of bimanual dexterous skills, yet transferring them to robot hands remains challenging. Existing methods primarily optimize object trajectory tracking, often overlooking how human hands interact with the object. Even with accurate tracking, robots may contact incorrect…
relevance: bimanual dexterity from demonstrations
```

**URL check:** https://arxiv.org/abs/2611.30495


### Residual Guidance for Real-Time Interactive Video Generation

- **Link:** https://arxiv.org/abs/2611.32820
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Residual Guidance is a training-free method that counteracts context inertia in streaming video generation by adding a residual from denoising the previous chunk under the new prompt to early denoising steps, improving prompt switching without training or per-model tuning.
- **Abstract:** Real-time interactive video generation allows users to change the prompt during generation to steer the evolving video. However, existing streaming models, which generate videos chunk by chunk, often keep following the previous prompt after a switch. We trace this failure to context inertia, where the previous chunk acts as a strong prior that suppresses the new prompt. Furthermore, we find that this inertia persists even when the cache retains only the previous chunk, yet discarding the context breaks visual continuity, which limits approaches that edit the cache. Rather than editing the cac…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Residual Guidance for Real-Time Interactive Video Generation
kern: (skip: streaming video)
relevance: streaming video
```

**URL check:** https://arxiv.org/abs/2611.32820


### Steerable by Design: Conditional Pretraining for Robust Control of Language Models

- **Link:** https://arxiv.org/abs/2611.32199
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** Our goal is to build language models that are steerable by design. Today's language models are pretrained with next-token prediction, which relegates alignment and control to the final 1% of training tokens or inference-time interventions. These models repurpose a single input channel for both instructions and data, leading to common failure modes where the model mistakenly treats data as instructions such as intentional jailbreaks and unintentional in-context alignment drift. To correct this, we propose a pretraining method and architecture that separates the two from the very start, produci…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Steerable by Design: Conditional Pretraining for Robust Control of Language Models
kern: (skip: steerable LMs)
relevance: steerable LMs
```

**URL check:** https://arxiv.org/abs/2611.32199


### Attack Policy Selection can Mislead Monitor Evaluators

- **Link:** https://arxiv.org/abs/2611.34934v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** AI monitors, classifiers that flag dangerous behaviour by AI agents, are often evaluated against transcripts generated by attack policies acting as proxies for dangerous behaviour in deployment. We evaluate an ex-production OpenAI monitor as a case study and find that measured false negative rate is highly sensitive to both the method used to generate attack policies and the level of optimisation applied within that method. This rate ranged from 0.5\% to 20.8\% across optimisation levels of a single method (reinforcement learning), and from 6.4\% to 23.0\% across methods at their best observe…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Attack Policy Selection can Mislead Monitor Evaluators
kern: AI monitors, classifiers that flag dangerous behaviour by AI agents, are often evaluated against transcripts generated by attack policies acting as proxies for dangerous behaviour in deployment. We evaluate an ex-production OpenAI monitor as a case study and find that measured false negative rate is highly sensitive…
relevance: monitor evaluation vs attack policies
```

**URL check:** https://arxiv.org/abs/2611.34934v1


### PyRUA-Dex: Learning Programmatic Policies for Dexterous Bimanual Manipulation with Coding Agents

- **Link:** https://arxiv.org/abs/2611.33144
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** A framework enables coding agents to develop dexterous manipulation policies without demonstrations by exploring and distilling successful attempts into a program, then refining it for strong simulated and real-world results.
- **Abstract:** Learning for dexterous manipulation is limited by the scarcity of high-quality demonstrations: retargeting from human video is imprecise, teleoperation gives no force feedback to the operator, and exoskeleton-based collection is hard to scale up. We present PyRUA-Dex, a framework that enables coding agents to develop dexterous manipulation through programmatic policy, without the need of demonstrations. The programmatic policy is developed in two stages: during exploration, multiple agents explore in parallel for task skills and ways to compose them, and a distilling agent condenses the succe…
- **Upvotes:** 39

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: PyRUA-Dex: Learning Programmatic Policies for Dexterous Bimanual Manipulation with Coding Agents
kern: A framework enables coding agents to develop dexterous manipulation policies without demonstrations by exploring and distilling successful attempts into a program, then refining it for strong simulated and real-world results.
relevance: coding agents learn dexterous policies
```

**URL check:** https://arxiv.org/abs/2611.33144


### Agentic LongLive: Asynchronous Agentic Memory for Long Video Generation

- **Link:** https://arxiv.org/abs/2611.34907
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** Real-time autoregressive video generators stream minutes of video and accept new prompts on the fly, but struggle to keep people, objects, and places consistent over a long interactive story. Agent systems provide such memory for offline multi-shot generation, yet they read the whole script in advance, plan each shot before generating it, and regenerate failed shots, which a live stream does not allow. We present Agentic LongLive, an asynchronous agentic memory for long video generation. A memory agent on separate GPUs reads only the prompts revealed so far, never the generated video, and kee…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Agentic LongLive: Asynchronous Agentic Memory for Long Video Generation
kern: Real-time autoregressive video generators stream minutes of video and accept new prompts on the fly, but struggle to keep people, objects, and places consistent over a long interactive story. Agent systems provide such memory for offline multi-shot generation, yet they read the whole script in advance, plan each shot…
relevance: agentic memory for long video
```

**URL check:** https://arxiv.org/abs/2611.34907


### RoboEvo^2: Recursive Robot Self-Improvement via Harness-Policy Co-Evolution

- **Link:** https://arxiv.org/abs/2611.34675
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** RoboEvo$^2$ recursively co-evolves a coding-agent harness and a vision-language-action policy, using policy failures to discover reusable skills and preference distillation to improve motor control, yielding large success gains without extra human demonstrations.
- **Abstract:** Robots should adapt to unfamiliar environments and acquire new skills through interaction, then execute those skills efficiently with practice. Vision-language-action policies provide efficient control, but often need additional human demonstrations to handle unfamiliar settings; reasoning agents can discover solutions using broad prior knowledge and robot-control APIs, but repeated deliberation and repair are costly. Inspired by human learning through reasoning and practice, we propose RoboEvo^2, a framework for recursive harness-policy co-evolution. In Policy-to-Harness (P2H) evolution, pol…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: RoboEvo^2: Recursive Robot Self-Improvement via Harness-Policy Co-Evolution
kern: RoboEvo$^2$ recursively co-evolves a coding-agent harness and a vision-language-action policy, using policy failures to discover reusable skills and preference distillation to improve motor control, yielding large success gains without extra human demonstrations.
relevance: harness-policy co-evolution
```

**URL check:** https://arxiv.org/abs/2611.34675


### Lost in Translation, Not in Confidence: Benchmarking and Calibrating Multilingual Decision Models

- **Link:** https://arxiv.org/abs/2611.33307
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** Decision models are language models fine-tuned to return a probability for each option of a typed query, which routers and guardrails threshold directly. They are built on multilingual bases but ranked almost entirely in English. We evaluate 25 top-ranked open-weight decision models on 17 tasks in 14 languages, comparing each language with English on parallel items. Every model loses accuracy in every language, from about 2 points in high-resource languages to 8 in Tamil, while confidence falls only half as much: a threshold set for 95\% accuracy in English yields 90% in Tamil. The size of th…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Lost in Translation, Not in Confidence: Benchmarking and Calibrating Multilingual Decision Models
kern: (skip: multilingual decision calibration)
relevance: multilingual decision calibration
```

**URL check:** https://arxiv.org/abs/2611.33307


### Co-Evolving Harnesses and Models: On-Policy Correction Helps Weaker Models Catch Up Where Imitation Fails

- **Link:** https://arxiv.org/abs/2609.09134
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Combining harness evolution with localized expert correction improves weaker models without disrupting their native planning style.
- **Abstract:** Agent harnesses (the system prompt, tool set, execution hooks, and context-management scaffolding around a model) are a critical determinant of agentic task success. Automated harness evolution can enable smaller models to perform well on domain-specific tasks at a fraction of frontier-model cost. Since both the harness and model weights shape behavior, we ask how harness evolution and lightweight fine-tuning should be combined. Across seven enterprise agent tasks, we first evolve a harness with the weaker model, then find that a stronger expert often uses it more effectively, suggesting expe…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Harness Engineering
title: Co-Evolving Harnesses and Models: On-Policy Correction Helps Weaker Models Catch Up Where Imitation Fails
kern: Combining harness evolution with localized expert correction improves weaker models without disrupting their native planning style.
relevance: co-evolving harness and model
```

**URL check:** https://arxiv.org/abs/2609.09134


### A Controlled Study of Models, Skills, Feedback, and Curriculum in Agentic Robotics

- **Link:** https://arxiv.org/abs/2611.09030
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** A controlled simulation study of agentic robotics finds that successful self-learning depends less on information access than on how well agents interpret feedback, attribute failures, reason about spatial and geometric structure, and revise code to improve robot policies.
- **Abstract:** Agentic robotics asks coding agents to implement and iteratively improve robot policies from simulated and real-world physical interactions. We study the self-learning loop of agentic robotics through a controlled simulation study spanning nine manipulation tasks, 631 different experiment configurations, and 28K coding agent rollouts, systematically varying model capability, skill priors, feedback structure, and curriculum. The experiment data suggests that the bottleneck is often not the access to sufficient information, but interpreting it into the right policy update. Across these factors,…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: A Controlled Study of Models, Skills, Feedback, and Curriculum in Agentic Robotics
kern: A controlled simulation study of agentic robotics finds that successful self-learning depends less on information access than on how well agents interpret feedback, attribute failures, reason about spatial and geometric structure, and revise code to improve robot policies.
relevance: agentic robotics; feedback interpretation
```

**URL check:** https://arxiv.org/abs/2611.09030


### RoboAware: Learning to Coordinate Embodied Skills from Counterfactual Outcomes

- **Link:** https://arxiv.org/abs/2610.11480
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** RoboAware learns a state-conditioned coordinator to select between modular robot skills and frozen policies using counterfactual branching and hierarchical reinforcement learning, improving embodied task success.
- **Abstract:** Embodied coding agents can combine modular robot skills with frozen end-to-end policies, yet effective composition requires anticipating which policy family will succeed in the current physical state. We present RoboAware, which builds on coding agents' skill orchestration by learning only a state-conditioned responsibility coordinator from counterfactual outcomes. Inspired by the success of REPL, we propose the P^5 schema and formulate a hierarchical MDP based on it. P^5 organizes skills uniformly into five semantic stages, defining where responsibility can be compared. To address the lack o…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: RoboAware: Learning to Coordinate Embodied Skills from Counterfactual Outcomes
kern: RoboAware learns a state-conditioned coordinator to select between modular robot skills and frozen policies using counterfactual branching and hierarchical reinforcement learning, improving embodied task success.
relevance: coordinating embodied skills
```

**URL check:** https://arxiv.org/abs/2610.11480


### Handoff Debt: The Rediscovery Cost When Coding Agents Take Over Interrupted Tasks

- **Link:** https://arxiv.org/abs/2606.02875
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Evaluating interrupted coding agents reveals that structured handoff notes significantly reduce successor rediscovery costs compared to repository-only takeovers.
- **Abstract:** Coding-agent benchmarks evaluate whether a single uninterrupted agent can resolve a repository issue. Real software work is messier: tasks are interrupted, reassigned, reviewed, and resumed from partial states left by another agent or engineer. We study this missing dimension through handoff debt: the rediscovery cost imposed when a predecessor's work is opaque or incomplete. Our takeover protocol interrupts a coding agent at deterministic handoff points, freezes the repository, and evaluates successor agents under four handoff views: repository state only, raw trace, summary notes, and struc…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Workflow & Specs
title: Handoff Debt: The Rediscovery Cost When Coding Agents Take Over Interrupted Tasks
kern: Evaluating interrupted coding agents reveals that structured handoff notes significantly reduce successor rediscovery costs compared to repository-only takeovers.
relevance: handoff notes between agents
```

**URL check:** https://arxiv.org/abs/2606.02875


### Cortex: Measurement-Gated Evolution and Pruning of Coding-Agent Skills and Rules

- **Link:** https://arxiv.org/abs/2610.14216
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Cortex validates agent harness updates by replaying developer corrections, retaining only rules and skills that consistently improve performance without degrading tasks.
- **Abstract:** Coding agents such as Claude Code also follow text files that developers write for them: a project file, skills the agent may choose to open, and rules that load automatically when the agent reads matching files. We call these files the agent's harness. Developers add to it whenever they correct the agent, but one success proves little: the same agent can pass a task once and fail it the next time. We present Cortex, a tool that tests changes to the harness instead of trusting them. It saves fixes from the developer's sessions as replayable tasks, finds the corrections that recur, writes one…
- **Upvotes:** 5

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Prompt Engineering
title: Cortex: Measurement-Gated Evolution and Pruning of Coding-Agent Skills and Rules
kern: Cortex validates agent harness updates by replaying developer corrections, retaining only rules and skills that consistently improve performance without degrading tasks.
relevance: measurement-gated evolution of skills/rules
```

**URL check:** https://arxiv.org/abs/2610.14216


### BrickBench: Evaluating Agentic Brick Design

- **Link:** https://arxiv.org/abs/2610.12452
- **Source:** HF q:explore · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** BrickBench evaluates agents on text-conditioned LEGO design requiring physical validity and semantic alignment, revealing that current agents meet basic constraints but lag behind human quality.
- **Abstract:** We propose BrickBench, a benchmark for agentic text-conditioned LEGO-set design. Given a prompt, an agent is tasked with producing an assembly that not only satisfies semantic and design criteria, but that can also be physically built. To do so, it must select parts from a discrete library and reason jointly about local and global constraints. We score validity, alignment, and design across three settings that vary in scale and part availability. We provide BrickAgent, an environment for coding agents to construct, inspect, and validate their designs. We find that leading agents largely satis…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: BrickBench: Evaluating Agentic Brick Design
kern: (skip: LEGO design benchmark)
relevance: LEGO design benchmark
```

**URL check:** https://arxiv.org/abs/2610.12452


### Names Are Not Objects: Object-Bound Confinement for Compromised AI Coding Agents

- **Link:** https://arxiv.org/abs/2610.14488
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** Coding agents read repositories and web pages that anyone can write, and then act with their user's authority. Prompt-injection defenses make it less likely that the model is steered but do not prevent it, so the system around the model must contain an agent that is already compromised. Many exploits against deployed coding agents share one cause: a check approves a name, such as a path, an argument vector, or a directory, and a later step maps that name to a different object: the file behind a symlink, the behavior an option selects, or a repository that git discovers on its own. We present…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Names Are Not Objects: Object-Bound Confinement for Compromised AI Coding Agents
kern: Coding agents read repositories and web pages that anyone can write, and then act with their user's authority. Prompt-injection defenses make it less likely that the model is steered but do not prevent it, so the system around the model must contain an agent that is already compromised. Many exploits against deployed…
relevance: confinement for compromised coding agents
```

**URL check:** https://arxiv.org/abs/2610.14488


### Arkios: An Open Bilingual English-Nepali Language Model Trained From Scratch, with a Devanagari-Aware Tokenizer

- **Link:** https://arxiv.org/abs/2608.30092
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Gist (HF ai_summary):** Arkios is a 1.04B-parameter bilingual English-Nepali dense transformer pretrained on limited tokens, evaluated on ARC benchmarks, and shown to require careful prompt formatting for valid low-resource language assessment, alongside a manifest-conditioned tool-use contract during instruction tuning.
- **Abstract:** We present Arkios, a 1.04B-parameter dense transformer pretrained from scratch on 150B tokens of bilingual English-Nepali text, using a custom single-file C/CUDA training stack and a Devanagari-aware byte-level BPE tokenizer built for this project. On ARC-Easy and ARC-Challenge, Arkios exceeds three comparably sized open models (Pythia-1.4B, TinyLlama-1.1B, OLMo-1B) despite an order of magnitude fewer training tokens, likely aided by a match between our educational-web-text pretraining data and ARC's grade-school-science format rather than a general capability advantage. We report full evalua…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Arkios: An Open Bilingual English-Nepali Language Model Trained From Scratch, with a Devanagari-Aware Tokenizer
kern: (skip: low-resource bilingual LM)
relevance: low-resource bilingual LM
```

**URL check:** https://arxiv.org/abs/2608.30092


### What Does Skill Lift Actually Measure? A Source-Code-Level Audit and Noise-Aware Reanalysis of SkillsBench

- **Link:** https://arxiv.org/abs/2611.33943
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** Prompt Engineering _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Prompt Engineering
title: What Does Skill Lift Actually Measure? A Source-Code-Level Audit and Noise-Aware Reanalysis of SkillsBench
kern: (no abstract in dumps; skill lift audit)
relevance: skill lift audit
```

**URL check:** https://arxiv.org/abs/2611.33943

