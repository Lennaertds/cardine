# Promote drafts — 2026-W48 — Model internals

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### Video Generation Meets Agent Harness: Agentic Video Generation, Agentic World Modeling and Recursive Self-Improvement

- **Link:** https://arxiv.org/abs/2610.40191
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** Agent harnesses integrate video generation and world models to enable planning, tool use, and recursive self-improvement for autonomous multi-shot video production.
- **Abstract:** Video generation is shifting from end-to-end synthesis toward agentic generation, where planning, tool use, and feedback enable coherent, controllable multi-shot videos. In parallel, video world models provide action-conditioned observations and predicted futures, serving as interactive environments for agents. We study their intersection through the agent harness: an executable runtime that constructs context, exposes tools, maintains state, routes feedback, and manages budgets around video models. This report examines three directions. First, agentic video generation, where harnesses coordi…
- **Upvotes:** 76

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Video Generation Meets Agent Harness: Agentic Video Generation, Agentic World Modeling and Recursive Self-Improvement
kern: Agent harnesses integrate video generation and world models to enable planning, tool use, and recursive self-improvement for autonomous multi-shot video production.
relevance: agent harness for video generation
```

**URL check:** https://arxiv.org/abs/2610.40191


### IQuest-Q1: Advancing Foundation Capabilities for Agentic CLI Systems

- **Link:** https://arxiv.org/abs/2610.30949
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** IQuest-Q1 is a sparse Mixture-of-Experts foundation model trained via multi-stage pre-training, mid-training, and post-training to achieve strong agentic coding and general capabilities.
- **Abstract:** We present IQuest-Q1, a sparse Mixture-of-Experts (MoE) agentic foundation model with 320B total parameters (15B activated). IQuest-Q1 is developed through a three-stage process: (1) stable and efficient pre-training, combining Stable SplitNorm, Muon, and muP with a two-stage curriculum whose second stage increases the coding-data mixture, preserving a wide stability margin between safe and optimal learning rates; (2) fine-grained mid-training, expanding the data mixture across domains and formats and progressively extending the context; and (3) multi-scaffold with multi-version post-training…
- **Upvotes:** 100

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Industrie
title: IQuest-Q1: Advancing Foundation Capabilities for Agentic CLI Systems
kern: IQuest-Q1 is a sparse Mixture-of-Experts foundation model trained via multi-stage pre-training, mid-training, and post-training to achieve strong agentic coding and general capabilities.
relevance: MoE foundation for agentic CLI
```

**URL check:** https://arxiv.org/abs/2610.30949


### Non-penetrating World Models

- **Link:** https://arxiv.org/abs/2611.27963
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** A benchmark and lightweight framework leverage hidden states from frozen diffusion transformers to detect and prevent object penetration in interactive video world models, reducing physical violations and generalizing zero-shot.
- **Abstract:** We study a new problem of preventing object penetration in interactive video world models. To understand how existing models handle this, we introduce NoPeBench, a benchmark that evaluates how world models respond to physical obstacles. Our evaluation reveals that none of the open-source models can reliably prevent such failures. Surprisingly, however, these models already encode the information needed to predict such violations. We find that the hidden states of diffusion transformers (DiTs) can predict whether a candidate action will penetrate an obstacle. Building on this, we introduce NoP…
- **Upvotes:** 62

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Non-penetrating World Models
kern: A benchmark and lightweight framework leverage hidden states from frozen diffusion transformers to detect and prevent object penetration in interactive video world models, reducing physical violations and generalizing zero-shot.
relevance: non-penetrating world models
```

**URL check:** https://arxiv.org/abs/2611.27963


### GameWM: Toward Next-Generation Video Games with Interaction-Centric World Models

- **Link:** https://arxiv.org/abs/2611.19247
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** GameWM divides game generation between an engine that preserves exact rules and state and a generative video model that creates visual and interactive detail, allowing personalized games with consistent mechanics.
- **Abstract:** For more than half a century, video games have pursued better graphics, more natural interaction, and more engaging gameplay. Generative video models (VMs) now bear on all three. Neural networks already draw most of the pixels in shipped games, and recent world models let a lightweight game engine keep the world state while a VM turns the engine's coarse proxy video into final frames. These systems, however, treat the VM as a renderer that only restyles motion the engine has already authored, which leaves most of its generative capacity unused and limits the diversity a game can offer. We pre…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: GameWM: Toward Next-Generation Video Games with Interaction-Centric World Models
kern: GameWM divides game generation between an engine that preserves exact rules and state and a generative video model that creates visual and interactive detail, allowing personalized games with consistent mechanics.
relevance: world models for games
```

**URL check:** https://arxiv.org/abs/2611.19247


### Plan4D: Generative Plannable 4D Worlds

- **Link:** https://arxiv.org/abs/2611.26516
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Abstract:** Most world models for future prediction prioritize aestetic quality of generated videos, but offer only weak physical grounding and limited geometric consistency over time, due to the lack of explicit 4D modeling. In this paper, we introduce plan4d, a possible next milestone towards building a generative plannable 4D world model that predicts future RGB videos together with dense 4D geometry, including depth, cameras, point clouds, and scene flow from an observed scene context and text-specified actions. Since training data with paired actions and dense 4D annotations is inherently scarce, pl…
- **Upvotes:** 30

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Plan4D: Generative Plannable 4D Worlds
kern: Most world models for future prediction prioritize aestetic quality of generated videos, but offer only weak physical grounding and limited geometric consistency over time, due to the lack of explicit 4D modeling. In this paper, we introduce plan4d, a possible next milestone towards building a generative plannable 4D…
relevance: plannable 4D worlds
```

**URL check:** https://arxiv.org/abs/2611.26516


### World Models as Native Latent Action Models

- **Link:** https://arxiv.org/abs/2611.30898
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** Native LAM distills compact latent actions from a pretrained video diffusion transformer via learnable dynamics registers, and PAWlicy uses these actions to pretrain VLA policies without generating video, achieving strong robotic control and cross-embodiment transfer.
- **Abstract:** Large and diverse video sources, such as egocentric human video and heterogeneous robot recordings, carry rich dynamics but come either without actions or without a shared action space. Latent action models (LAMs) can recover these dynamics, but they train their inverse- and forward-dynamics models (IDM, FDM) from scratch, trading off pixel reconstruction against latent capacity and accuracy. Pretrained video world models natively generate high-fidelity dynamics, yet represent them densely, entangled across all layers. Viewing the world model as a LAM, we show that these dynamics can be extra…
- **Upvotes:** 28

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: World Models as Native Latent Action Models
kern: Native LAM distills compact latent actions from a pretrained video diffusion transformer via learnable dynamics registers, and PAWlicy uses these actions to pretrain VLA policies without generating video, achieving strong robotic control and cross-embodiment transfer.
relevance: latent action models from video
```

**URL check:** https://arxiv.org/abs/2611.30898


### Fast-JEPA: Advancing the Success-Latency Frontier for Latent World Models

- **Link:** https://arxiv.org/abs/2611.25927
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** Fast-JEPA is a latent world model planning framework that improves the success-latency trade-off of predictive search by predicting complete action-sequence outcomes and using goal-directed plans, with evaluation on manipulation and navigation tasks and a new dynamic planning benchmark.
- **Abstract:** Latent world models predict the outcomes of action sequences, but comparing candidate plans through recursive rollout remains expensive at test time. We introduce Fast-JEPA, a latent world model planning framework that advances the success-latency Pareto frontier of predictive search. Fast-JEPA reorganizes predictive computation to support effective action-sequence search at low planning cost. It constructs a goal-directed plan to guide search and directly predicts the outcomes of complete candidates for efficient comparison, avoiding recursive state rollout during refinement. Across PushT, R…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Fast-JEPA: Advancing the Success-Latency Frontier for Latent World Models
kern: Fast-JEPA is a latent world model planning framework that improves the success-latency trade-off of predictive search by predicting complete action-sequence outcomes and using goal-directed plans, with evaluation on manipulation and navigation tasks and a new dynamic planning benchmark.
relevance: latent world-model planning
```

**URL check:** https://arxiv.org/abs/2611.25927


### Not all world models can doubt: how training objective and architecture shape epistemic uncertainty in JEPA and RSSM world models

- **Link:** https://arxiv.org/abs/2611.34830v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Abstract:** World models predict how an environment responds to actions, so that candidate actions can be evaluated before execution. Executed actions, or decisions, taken in this manner are only as reliable as the model's predictive capabilities, and predictions in turn are only reliable within the model's experience. Epistemic uncertainty (EU) is the signal that marks where that experience ends. In this work we offer an extensive empirical study on how training objectives and architectures shape epistemic uncertainty of world models. More precisely, we present a controlled comparison of post-hoc EU (la…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Not all world models can doubt: how training objective and architecture shape epistemic uncertainty in JEPA and RSSM world models
kern: World models predict how an environment responds to actions, so that candidate actions can be evaluated before execution. Executed actions, or decisions, taken in this manner are only as reliable as the model's predictive capabilities, and predictions in turn are only reliable within the model's experience. Epistemic…
relevance: epistemic uncertainty in world models
```

**URL check:** https://arxiv.org/abs/2611.34830v1


### What Is Redundant at High Resolution? Efficient Attention and Feed-Forward Design for All-in-One Image Restoration

- **Link:** https://arxiv.org/abs/2611.33636
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** A multi-scale image restoration network reduces redundant computation in attention and feed-forward layers to achieve state-of-the-art restoration with faster inference.
- **Abstract:** Multi-scale architectures are widely adopted in all-in-one image restoration (AIO-IR) to capture larger-scale context at low-resolution stages and refine details at high-resolution (HR) stages. However, processing spatially large feature maps at HR stages incurs substantial computational costs and memory traffic, making efficient HR processing challenging. To address this challenge, we propose High-resolution Global-Local Restoration (HiGLR), an efficient multi-scale AIO-IR network grounded in an analysis of spatial redundancy in self-attention and convolutional feed-forward networks (ConvFFN…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: What Is Redundant at High Resolution? Efficient Attention and Feed-Forward Design for All-in-One Image Restoration
kern: (skip: image restoration attention)
relevance: image restoration attention
```

**URL check:** https://arxiv.org/abs/2611.33636


### Beyond the Happy Path: Generalizing Robot World Models from Simulated Failures

- **Link:** https://arxiv.org/abs/2611.33925
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** Training world models on simulated manipulation failures with interaction alignment and surface correspondence reduces object trajectory and action-outcome prediction errors, including on unseen objects and real data.
- **Abstract:** Robot world models are increasingly used to evaluate and plan policies, yet robot training data are dominated by successful demonstrations. Off the happy path, when a grasp is misaligned or mistimed and the object is pushed, tilted, or slips, their predictions break down. Across five pretrained action-conditioned models, object-motion error is at most 10.4% lower than that of a static baseline that copies the first frame, and two models are worse than this baseline. We present WorldReforge, which teaches world models what happens when manipulation goes wrong. We construct the Reforge dataset…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Beyond the Happy Path: Generalizing Robot World Models from Simulated Failures
kern: Training world models on simulated manipulation failures with interaction alignment and surface correspondence reduces object trajectory and action-outcome prediction errors, including on unseen objects and real data.
relevance: robot world models from failures
```

**URL check:** https://arxiv.org/abs/2611.33925


### OmniPersist: Persistent Dynamic World Modeling via Coupled Panoramic Evolution

- **Link:** https://arxiv.org/abs/2611.32473
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Abstract:** Action-conditioned world models play a vital role in robotics and autonomous driving, yet existing video diffusion models struggle to maintain dynamic object persistence. When the camera turns away and returns, out-of-view moving entities fail to evolve plausibly in latent space, often mutating or vanishing entirely due to bounded perspective views. To resolve this issue, we propose OmniPersist, a unified framework that couples perspective video generation with panoramic evolution within a single-stage diffusion model, without relying on auxiliary models or initial panoramic inputs. To mainta…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: OmniPersist: Persistent Dynamic World Modeling via Coupled Panoramic Evolution
kern: Action-conditioned world models play a vital role in robotics and autonomous driving, yet existing video diffusion models struggle to maintain dynamic object persistence. When the camera turns away and returns, out-of-view moving entities fail to evolve plausibly in latent space, often mutating or vanishing entirely…
relevance: panoramic persistent world modeling
```

**URL check:** https://arxiv.org/abs/2611.32473


### Simulator-as-Proxy World Model for Robot Manipulation

- **Link:** https://arxiv.org/abs/2611.32786
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Gist (HF ai_summary):** SimPWM uses a parameter-free simulator as a proxy to generate robot videos and simulated states, revealing that video models follow arm motion more reliably than object dynamics and often ignore simulated object state.
- **Abstract:** Video world models for robots are increasingly conditioned on a simulated or rendered proxy of the scene, on the assumption that the video will show what the proxy shows. Testing this assumption requires a proxy whose state is explicit and can be perturbed. We present SimPWM (Simulator-as-Proxy World Model): given a calibrated camera, it represents, from the first frame alone, the robot by its 3D model and the objects the gripper may touch as 3D points; a rule-based simulator with no trained parameters moves them under the actions, and a video model renders the result. SimPWM returns the real…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: Simulator-as-Proxy World Model for Robot Manipulation
kern: SimPWM uses a parameter-free simulator as a proxy to generate robot videos and simulated states, revealing that video models follow arm motion more reliably than object dynamics and often ignore simulated object state.
relevance: simulator as proxy world model
```

**URL check:** https://arxiv.org/abs/2611.32786


### Do We Still Need Reinforcement Learning When We Can Read the World Model?

- **Link:** https://arxiv.org/abs/2611.34656
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** Model internals _(kw)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Do We Still Need Reinforcement Learning When We Can Read the World Model?
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34656

