# Promote drafts — 2026-W48 — _uncertain

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Role:** no confident theme — set `theme:` to an exact H1 of `bronnen.md`, or `skip`.
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### Our Own Jev: Typed Decisions in One Forward Pass, from an In-House Judge to Open LoRA Models

- **Link:** https://arxiv.org/abs/2610.29052
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A typed decision framework using frozen language model backbones with small LoRA adapters and pointer heads enables low-cost, private judging and competitive benchmark performance without training output layers.
- **Abstract:** A typed decision maps evidence, a question and a fixed set of options to a probability for every option, computed in one forward pass, by reading a language model's logits or a small head over its hidden states, instead of generating and parsing text. The commercial system Jev popularised this System~1 interface, and open reproductions have followed. We report two uses of the pattern. Part I describes an in-house System~1 judge that triages about 148K agentic coding session records for a training corpus. It replaces a frontier LLM judge that cost on the order of \1,000 per pass and whose stor…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Industrie
title: Our Own Jev: Typed Decisions in One Forward Pass, from an In-House Judge to Open LoRA Models
kern: A typed decision framework using frozen language model backbones with small LoRA adapters and pointer heads enables low-cost, private judging and competitive benchmark performance without training output layers.
relevance: typed decision models, small adapters
```

**URL check:** https://arxiv.org/abs/2610.29052


### Higher-order pruning of experts in mixture-of-experts language models

- **Link:** https://arxiv.org/abs/2609.18916
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** HOPE is a second-order pruning objective for Mixture-of-Experts language models that accounts for cooperative expert interactions, enabling aggressive compression with minimal performance loss.
- **Abstract:** Mixture-of-Experts (MoE) language models suffer from large parameter counts, which create a significant memory bottleneck. Expert pruning is the most direct approach for reducing this parameter count, yet existing methods make pruning decisions for each expert independently, and assume experts' contributions are purely additive. In reality, expert usage in MoEs is inherently cooperative. We derive HOPE (Higher-Order Pruning of Experts), a second-order pruning objective which provably minimizes an upper bound on the error resulting from pruning. We show that REAP (a state-of-the-art first-orde…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Higher-order pruning of experts in mixture-of-experts language models
kern: HOPE is a second-order pruning objective for Mixture-of-Experts language models that accounts for cooperative expert interactions, enabling aggressive compression with minimal performance loss.
relevance: MoE expert pruning
```

**URL check:** https://arxiv.org/abs/2609.18916


### cmHC: Balancing Stream Mixing in Hyper-Connections via Geometric Contraction

- **Link:** https://arxiv.org/abs/2611.27193
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Constraining residual stream mixing within the Birkhoff polytope via geometric contraction improves stability and scalability of hyper-connections in large-scale dense and mixture-of-experts model pretraining.
- **Abstract:** Manifold-constrained Hyper-Connections (mHC) extends residual connections to multiple streams and stabilizes residual propagation by constraining stream-mixing residual matrices to the Birkhoff polytope, the set of doubly stochastic matrices. In this work, we investigate how to effectively mix residual streams within the Birkhoff polytope. We reveal a mixing trade-off: when under-mixed residual matrices stay close to the vertices of the Birkhoff polytope, hyper-connections will degenerate into a set of nearly independent streams; when over-mixed residual matrices are concentrated around the u…
- **Upvotes:** 94

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: cmHC: Balancing Stream Mixing in Hyper-Connections via Geometric Contraction
kern: Constraining residual stream mixing within the Birkhoff polytope via geometric contraction improves stability and scalability of hyper-connections in large-scale dense and mixture-of-experts model pretraining.
relevance: hyper-connections stability
```

**URL check:** https://arxiv.org/abs/2611.27193


### Learning Video Foresight Reasoning from Unlabeled Videos via On-Policy Self-Distillation

- **Link:** https://arxiv.org/abs/2611.26954
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Future-OPSD trains vision-language models via on-policy self-distillation and a contrastive privilege advantage derived from a foresight score, improving video foresight prediction and planning without extra annotations or LLM supervision.
- **Abstract:** Video foresight reasoning requires vision-language models to anticipate future events or next actions from currently observed videos. Existing methods fit future captions, rationales, or full visual states, but face two limitations. First, they rely on annotations or external large models for supervision, limiting scalability. We address this with an on-policy self-distillation framework that turns past-future video pairs into a natural self-supervised signal without extra annotations or LLM supervision. Second, they treat the whole future clip as equally valuable, although most of it is irre…
- **Upvotes:** 43

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: Learning Video Foresight Reasoning from Unlabeled Videos via On-Policy Self-Distillation
kern: Future-OPSD trains vision-language models via on-policy self-distillation and a contrastive privilege advantage derived from a foresight score, improving video foresight prediction and planning without extra annotations or LLM supervision.
relevance: video foresight reasoning
```

**URL check:** https://arxiv.org/abs/2611.26954


### Reading the Unreadable: Text-Aware Image Super-Resolution Needs Reasoning

- **Link:** https://arxiv.org/abs/2611.15449
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Text-aware image super-resolution (TAISR) aims to recover high-resolution images from low-resolution inputs while preserving textual content. Existing methods treat this as a visual restoration problem, yet severely degraded text often cannot be read from local visual evidence alone. Humans instead read it by reasoning over image context, logical patterns, and prior knowledge. This raises a fundamental question: Does TAISR need reasoning? To answer this, we introduce two diagnostic tools. The first, ReasonText, is a human-curated benchmark that separates reasoning-required text from locally r…
- **Upvotes:** 26

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Reading the Unreadable: Text-Aware Image Super-Resolution Needs Reasoning
kern: (skip: image super-resolution)
relevance: image super-resolution
```

**URL check:** https://arxiv.org/abs/2611.15449


### Seeing the Invisible: How Vision-Language Models Read, Predict and Trace Radio Fields

- **Link:** https://arxiv.org/abs/2611.28123
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Operating in the physical world requires reasoning beyond what cameras directly capture. In a city, radio signals are invisible to the lens, yet their strength is governed by the buildings and streets an image does show. Given only these visible structures, can vision-language models (VLMs) infer the invisible radio field they shape? Probing true physical reasoning requires exact fields in real cities, alongside controlled interventions where a single physical factor changes. We build a label-free engine that turns any coordinate on Earth into a ray-traceable city, simulates matched single-fa…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Seeing the Invisible: How Vision-Language Models Read, Predict and Trace Radio Fields
kern: (skip: radio field reasoning)
relevance: radio field reasoning
```

**URL check:** https://arxiv.org/abs/2611.28123


### StereoVLM: Binocular Vision-Language Models for Metric 3D Spatial Reasoning

- **Link:** https://arxiv.org/abs/2611.27915
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** StereoVLM is a geometry-aware binocular vision-language model trained with hierarchical supervision from calibrated stereo to enable metric 3D spatial reasoning, evaluated by Stereo3D-Bench.
- **Abstract:** Vision-language models (VLMs) exhibit strong semantic understanding but remain limited in their ability to reason about metric 3D space in the physical world. Existing VLMs typically infer 3D scene structure from one or more images without known camera calibration or cross-view geometric constraints. This makes metric 3D inference inherently ambiguous and leaves it unclear whether their spatial predictions are grounded in visual evidence or driven primarily by semantic priors. In contrast, calibrated stereo provides explicit cross-view geometry that resolves this ambiguity and offers a more r…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: StereoVLM: Binocular Vision-Language Models for Metric 3D Spatial Reasoning
kern: StereoVLM is a geometry-aware binocular vision-language model trained with hierarchical supervision from calibrated stereo to enable metric 3D spatial reasoning, evaluated by Stereo3D-Bench.
relevance: binocular metric 3D reasoning
```

**URL check:** https://arxiv.org/abs/2611.27915


### AeroRSI: Recursive Self-Improvement for Aerial Vision-Language Navigation

- **Link:** https://arxiv.org/abs/2611.24077
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Vision-language-action (VLA) models enable unmanned aerial vehicles (UAVs) to follow natural-language instructions, yet still fail frequently in closed-loop flight. Correcting these failures requires repairs, i.e., actions that avoid them at the states the policy itself reaches, which human pilots cannot label at scale and rule-based planners cannot supply reliably. In this paper, we present AeroRSI, a recursive self-improvement framework in which an aerial navigation policy iteratively learns from its own failures. Our key insight is that a failing policy should judge its own repairs by flyi…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: AeroRSI: Recursive Self-Improvement for Aerial Vision-Language Navigation
kern: Vision-language-action (VLA) models enable unmanned aerial vehicles (UAVs) to follow natural-language instructions, yet still fail frequently in closed-loop flight. Correcting these failures requires repairs, i.e., actions that avoid them at the states the policy itself reaches, which human pilots cannot label at…
relevance: aerial VLN
```

**URL check:** https://arxiv.org/abs/2611.24077


### PURE: A Diagnostic Benchmark for Multi-Granularity Multimodal Identity Matching

- **Link:** https://arxiv.org/abs/2611.22343
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A diagnostic benchmark evaluates multimodal large language models on multi-granularity identity matching, revealing gaps in understanding, reasoning, and evidence-grounded judgment across base and variant levels.
- **Abstract:** Identity matching asks whether two records denote the same identity, yet the answer depends on the target granularity. Two records may match at the base level but not at the variant level: they share an underlying design while differing in attributes such as color or size. Final matching accuracy does not separately characterize the capabilities involved. To study this problem, we use e-commerce as a challenging real-world domain. We introduce PURE, a diagnostic benchmark for multi-granularity multimodal identity matching covering four capability dimensions: Perception, Understanding, Reasoni…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: PURE: A Diagnostic Benchmark for Multi-Granularity Multimodal Identity Matching
kern: (skip: identity matching benchmark)
relevance: identity matching benchmark
```

**URL check:** https://arxiv.org/abs/2611.22343


### Taking Apart and Putting Together: Tracking Objects Through Physical Transformations

- **Link:** https://arxiv.org/abs/2611.27398
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A training-free framework tracks objects through physical assemblies and disassemblies by generating and evaluating split/merge proposals and querying a multimodal large language model for verification and labeling, achieving state-of-the-art accuracy and faster performance on a new benchmark.
- **Abstract:** We introduce Transformation Tracking and Understanding (TTU), extending video object tracking to environments where objects undergo physical assemblies and disassemblies. TTU requires continuously tracking objects through transformations, identifying new entities, maintaining a state graph of their relationships, and assigning semantic labels to transformations. While foundation models (e.g., SAM 2/3) maintain tracklets through appearance changes, they cannot update semantic identities as objects physically evolve. Prior work addresses only disassemblies, relying on expensive searches trigger…
- **Upvotes:** 5

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Taking Apart and Putting Together: Tracking Objects Through Physical Transformations
kern: (skip: object tracking)
relevance: object tracking
```

**URL check:** https://arxiv.org/abs/2611.27398


### Motion-Aware Reward Modeling for Instruction-Guided Video Editing

- **Link:** https://arxiv.org/abs/2611.22495
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Reward models for instruction-guided video editing can favor temporal consistency at the expense of motion. We study this failure, termed motion collapse, using controlled motion-suppression variants of real edits. On VE-Bench, the evaluated composite reward prefers a motion-suppressed candidate in 97% of cases. Learned video rewards and a VLM judge also struggle with mild suppression, while latent optimization and reward-guided fine-tuning exploit this weakness to increase reward as motion declines. A linear probe of our base reward backbone performs near chance on mild suppression, motivati…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Motion-Aware Reward Modeling for Instruction-Guided Video Editing
kern: (skip: video editing reward)
relevance: video editing reward
```

**URL check:** https://arxiv.org/abs/2611.22495


### WorldLeague: Benchmarking Physical Agency

- **Link:** https://arxiv.org/abs/2611.30989
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** WorldLeague benchmarks 13 AI systems on 60 simulated robot tasks spanning exploration, rearrangement, and adaptation, measuring progress and success to compare autonomous physical goal achievement.
- **Abstract:** AI systems can now operate Blender, follow instructions in complex video games, and manipulate objects with robot arms. What range of physical goals can today's AI systems achieve autonomously? Answering this question requires testing systems on tasks that demand different combinations of perception, memory, planning, and action. We introduce WorldLeague, a benchmark that compares AI systems on a common set of 60 simulated robot tasks by measuring progress toward each task's physical goal from the robot's trajectory. Robots explore scenes to gather evidence in WorldSeek, rearrange objects in…
- **Upvotes:** 137

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: WorldLeague: Benchmarking Physical Agency
kern: WorldLeague benchmarks 13 AI systems on 60 simulated robot tasks spanning exploration, rearrangement, and adaptation, measuring progress and success to compare autonomous physical goal achievement.
relevance: physical agency benchmark
```

**URL check:** https://arxiv.org/abs/2611.30989


### WeMM-Ecom: Advancing Multimodal Content Understanding for WeChat E-Commerce

- **Link:** https://arxiv.org/abs/2611.30662
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** WeMM-Ecom, a family of multimodal large language models spanning dense and mixture-of-experts sizes, is trained with continued pre-training and hybrid-thinking post-training to achieve strong e-commerce and general-purpose results and is deployed in WeChat.
- **Abstract:** We present WeMM-Ecom, a family of multimodal large language models that deliver frontier e-commerce capabilities while achieving state-of-the-art general-purpose performance at their respective scales. The family spans five sizes, from a 0.8B dense model to a 35B mixture-of-experts model with 3B active parameters. Our training pipeline begins with two-stage continued pre-training that progressively raises the proportion of e-commerce data within a diverse multimodal data mixture, followed by hybrid-thinking post-training that combines on-policy distillation and reinforcement learning to suppo…
- **Upvotes:** 55

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: WeMM-Ecom: Advancing Multimodal Content Understanding for WeChat E-Commerce
kern: (skip: e-commerce multimodal)
relevance: e-commerce multimodal
```

**URL check:** https://arxiv.org/abs/2611.30662


### ViDecide: Teaching Video Diffusion Models to Reason and Plan Step by Step

- **Link:** https://arxiv.org/abs/2611.26389
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** ViDecide trains video diffusion models to make causal state-transition and stopping decisions, using Corrective Fine-tuning to improve multi-step planning success without policy gradients.
- **Abstract:** Current leading video generation models can synthesize highly realistic videos, while still frequently violating physical and logical constraints in multi-step reasoning and planning, even after training with large-scale reasoning data or existing diffusion RL methods. We attribute these failures to the conventional video training paradigm, which treats a solution as a fixed-length clip rather than a chain of decisions. We present ViDecide, a decision-centric framework that trains video diffusion models to predict state transitions causally and decide when to stop, with a decision-focused tra…
- **Upvotes:** 41

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: ViDecide: Teaching Video Diffusion Models to Reason and Plan Step by Step
kern: (skip: video diffusion planning)
relevance: video diffusion planning
```

**URL check:** https://arxiv.org/abs/2611.26389


### Unlocking the Power of Loops in Pretrained LLMs with Loop Residuals

- **Link:** https://arxiv.org/abs/2611.31094
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** LoopRes enables pretrained large language models to benefit from looped computation by letting layers attend to recent earlier loops with trainable loop-aware keys, yielding consistent gains and improved test-time scaling.
- **Abstract:** Looped Transformers iterate a shared block of layers to increase computation without adding parameters, offering stronger performance and test-time scaling. However, this power has so far required training from scratch and yielded only modest gains for LLMs. Finetuning existing models into loops is far cheaper, yet also brings only marginal gains over SFT. We propose LoopRes, an effective, scalable, and simple approach that turns loops into significant and consistent gains for pretrained LLMs. Building on Attention Residuals, LoopRes lets each looped layer attend directly to the outputs of ea…
- **Upvotes:** 24

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Unlocking the Power of Loops in Pretrained LLMs with Loop Residuals
kern: LoopRes enables pretrained large language models to benefit from looped computation by letting layers attend to recent earlier loops with trainable loop-aware keys, yielding consistent gains and improved test-time scaling.
relevance: loop residuals for pretrained LLMs
```

**URL check:** https://arxiv.org/abs/2611.31094


### ViDiHand2: Unifying Video Diffusion Priors and Hand Geometry for 3D Hand Motion Reconstruction in the Wild

- **Link:** https://arxiv.org/abs/2611.30597
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Learning robot manipulation from egocentric human videos requires accurate metric 3D hand motion. Recent methods leverage pretrained video diffusion model (VDM) priors to recover occluded hands directly from full-frame videos, but their appearance-based depth regression generalizes poorly to unseen cameras. In this work, we propose ViDiHand2, a geometry-driven framework that reformulates VDM-based hand depth estimation from direct regression into fine-grained geometric constraint solving. Specifically, we introduce Fine-Grained Geometric Lifting and Clip-Level Ray Fitting, which recover metri…
- **Upvotes:** 20

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: ViDiHand2: Unifying Video Diffusion Priors and Hand Geometry for 3D Hand Motion Reconstruction in the Wild
kern: (skip: hand motion reconstruction)
relevance: hand motion reconstruction
```

**URL check:** https://arxiv.org/abs/2611.30597


### Single-Transformer Latent Diffusion

- **Link:** https://arxiv.org/abs/2611.29064
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A single diffusion transformer can unify encoding, generation, and decoding by treating them as position-aligned sequence maps distinguished by a mode token and timestep, improving image generation quality and efficiency.
- **Abstract:** Latent generative models typically rely on three separate networks: an encoder that tokenizes pixels, a generator that models the latent distribution, and a decoder that maps latents back to pixels. UNITE recently merged the first two into a single generative encoder trained in one stage, but its decoder remains a separate network. We ask whether this last network can be folded in too, so that one diffusion transformer encodes, generates, and decodes. Simply letting the shared backbone decode does not help. What makes it work is to cast all three modes as position-aligned sequence maps over o…
- **Upvotes:** 17

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Single-Transformer Latent Diffusion
kern: (skip: single-transformer latent diffusion)
relevance: single-transformer latent diffusion
```

**URL check:** https://arxiv.org/abs/2611.29064


### UUBench: Understanding the Unspoken toward Full-Duplex Multimodal Interaction

- **Link:** https://arxiv.org/abs/2611.30157
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** UUBench assesses how well multimodal interactive systems understand and respond to users' implicit communicative needs through process- and outcome-oriented scoring grounded in observable audiovisual evidence.
- **Abstract:** Effective real-time, full-duplex multimodal interaction requires systems to understand not only what users say, but also the communicative needs conveyed through prosody, facial expressions, gestures, and context, and to generate audiovisual responses that appropriately address those needs. Existing evaluations offer limited insight into whether systems translate an understanding of such unspoken needs into effective responses. We introduce UUBench, a benchmark for assessing how well multimodal interactive systems Understand the Unspoken intent and address users' implicit communicative needs.…
- **Upvotes:** 17

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: UUBench: Understanding the Unspoken toward Full-Duplex Multimodal Interaction
kern: (skip: full-duplex interaction benchmark)
relevance: full-duplex interaction benchmark
```

**URL check:** https://arxiv.org/abs/2611.30157


### Polytropos: What Do Vision-Language Model Descriptions Make of a Cultural Object?

- **Link:** https://arxiv.org/abs/2611.29355
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Vision-language models have become a new kind of describer, writing about almost anything people see, and their descriptions now shape how cultures are known by people and by other models. Descriptions of cultures tend to turn particular things into types, and what a description loses shows what its describer lacks. We introduce Polytropos, a benchmark that measures what model descriptions of cultural objects keep of the particular object by turning each description back into an image and comparing it with the original photograph. On 374 objects from the Metropolitan Museum of Art and the Get…
- **Upvotes:** 16

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Polytropos: What Do Vision-Language Model Descriptions Make of a Cultural Object?
kern: (skip: cultural descriptions)
relevance: cultural descriptions
```

**URL check:** https://arxiv.org/abs/2611.29355


### ToolSmith: An Automatic Tool-Generation Framework for Multimodal Search Agents

- **Link:** https://arxiv.org/abs/2611.31198
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Recent multimodal search agents use reasoning, vision, and live web search across many turns to answer questions beyond parametric knowledge by orchestrating a small library of hand-crafted search and visual tools. However, the library is laborious to create and maintain, and frozen when new query types, evidence formats, and failure modes are encountered in the wild. Human practitioners, by contrast, cope with insufficient tools by fashioning new ones from familiar parts and reusing them across tasks. Inspired by this, we propose ToolSmith, an automatic tool-generation framework that grows a…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: ToolSmith: An Automatic Tool-Generation Framework for Multimodal Search Agents
kern: Recent multimodal search agents use reasoning, vision, and live web search across many turns to answer questions beyond parametric knowledge by orchestrating a small library of hand-crafted search and visual tools. However, the library is laborious to create and maintain, and frozen when new query types, evidence…
relevance: automatic tool generation for search agents
```

**URL check:** https://arxiv.org/abs/2611.31198


### WeightCode: Installing New Capabilities into Neural Networks via Weight-Space Programming

- **Link:** https://arxiv.org/abs/2611.25476
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Neural networks encode learned capabilities in their weights, yet extending those capabilities with explicit task knowledge remains a fundamental challenge. Here we show that Weight-Space Programming (WSP), in which executable programs read, construct or modify a network's weights directly, can install new capabilities within trained neural networks. WeightCode, a WSP framework, uses a frozen language model to write executable weight programs that install new computations into trained neural networks using task knowledge and their existing weights, without gradient-based training. Once instal…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: WeightCode: Installing New Capabilities into Neural Networks via Weight-Space Programming
kern: Neural networks encode learned capabilities in their weights, yet extending those capabilities with explicit task knowledge remains a fundamental challenge. Here we show that Weight-Space Programming (WSP), in which executable programs read, construct or modify a network's weights directly, can install new…
relevance: weight-space programming; capabilities
```

**URL check:** https://arxiv.org/abs/2611.25476


### Self-WSP: Can Language Models Improve Themselves Through Weight-Space Programming?

- **Link:** https://arxiv.org/abs/2611.28833
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Language models can edit their own neural network weights to improve task performance, though the resulting gains are poorly understood and sometimes matched by random search.
- **Abstract:** Frontier language models can now read and edit the weights of a neural network much like code and thereby improve a small model, an approach known as Weight-Space Programming (WSP). We further explore applying WSP to a language model itself, which we call Self-WSP. Specifically, Qwen3.5-0.8B reads its own weights, proposes an edit, and then continues with the edited weights as both problem solver and editor. We find many cases of genuine self-improvement. Self-edits can raise GSM8K accuracy from 11.8% to 62.2% and MATH500 accuracy from 7.0% to 32.2%, sometimes by changing only 16 parameters,…
- **Upvotes:** 13

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Self-WSP: Can Language Models Improve Themselves Through Weight-Space Programming?
kern: Language models can edit their own neural network weights to improve task performance, though the resulting gains are poorly understood and sometimes matched by random search.
relevance: weight-space programming
```

**URL check:** https://arxiv.org/abs/2611.28833


### WorldLatent: A Unified 4D Latent Space for World Perception and Generation

- **Link:** https://arxiv.org/abs/2611.31209
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** WorldLatent unifies 4D perception and generation in a shared multimodal latent space, enabling a single model to perform zero-shot 4D perception, coherent 4D generation, and controllable editing.
- **Abstract:** Generative Pre-Training (GPT) represents a profound milestone in natural language processing, serving as the foundation for most of today's state-of-the-art large language models. By casting diverse understanding and generation problems into a shared token representation, GPT enables a single architecture and unified optimization loop to master heterogeneous tasks across massive corpora, giving rise to powerful foundation models for natural language. In contrast, 4D spatiotemporal vision lacks a common representational protocol: perception (such as depth and camera estimation) and generation…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: WorldLatent: A Unified 4D Latent Space for World Perception and Generation
kern: WorldLatent unifies 4D perception and generation in a shared multimodal latent space, enabling a single model to perform zero-shot 4D perception, coherent 4D generation, and controllable editing.
relevance: unified 4D latent space
```

**URL check:** https://arxiv.org/abs/2611.31209


### SAVIOR: Sample-efficient Adaptation of Vision-Language Models for OCR Representation

- **Link:** https://arxiv.org/abs/2611.27319
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A sample-efficient curation method and a structure-aware layout metric enable a fine-tuned vision-language model to improve OCR on challenging financial document patterns, achieving high word recall and document question-answering F1.
- **Abstract:** Optical Character Recognition (OCR) pipelines and vision-language models exhibit high accuracy on standard OCR and document-understanding benchmarks, yet they systematically underperform on document patterns that are operationally critical in financial workflows. These patterns include vertical or rotated text, logo-embedded vendor names, fine-print regulatory clauses, degraded scans, and complex multi-column layouts. While underrepresented in public datasets, they constitute a substantial portion of real-world failure cases. We introduce SAVIOR, a sample-efficient data curation methodology t…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: SAVIOR: Sample-efficient Adaptation of Vision-Language Models for OCR Representation
kern: A sample-efficient curation method and a structure-aware layout metric enable a fine-tuned vision-language model to improve OCR on challenging financial document patterns, achieving high word recall and document question-answering F1.
relevance: OCR; financial document patterns
```

**URL check:** https://arxiv.org/abs/2611.27319


### HIVE-Bench: Evaluating Patch-Level Visual Representations for Egocentric Robot Manipulation

- **Link:** https://arxiv.org/abs/2611.30813
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A shared flow-matching policy that reads dense patch tokens from multiple vision encoders improves success on egocentric bimanual tasks, and inverse-dynamics readout of commanded motion is a strong pre-training signal, while recognition, depth, and correspondence transfer unreliably.
- **Abstract:** Pretrained vision is a common start for robot learning, but most comparisons still score one pooled vector from a third-person image. Bimanual policies instead read dense patch tokens from cameras on the robot. We introduce HIVE-Bench: one shared flow-matching policy reads 20 encoders from seven families on 24 egocentric bimanual tasks, across adaptation, task sharing, and sweeps of data, model size, and layer. Keeping the patches matters. Averaging each view to one token removes most of the success, adaptation helps every pair we test, and one shared policy keeps most of the success of separ…
- **Upvotes:** 10

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: HIVE-Bench: Evaluating Patch-Level Visual Representations for Egocentric Robot Manipulation
kern: A shared flow-matching policy that reads dense patch tokens from multiple vision encoders improves success on egocentric bimanual tasks, and inverse-dynamics readout of commanded motion is a strong pre-training signal, while recognition, depth, and correspondence transfer unreliably.
relevance: egocentric manipulation representations
```

**URL check:** https://arxiv.org/abs/2611.30813


### A Pipeline-Parallel System for Depth-Recurrent Models

- **Link:** https://arxiv.org/abs/2611.30581
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Loop-PP schedules cyclic pipeline stages for depth-recurrent models, overlapping communication and compute while preserving exact numerical equivalence, reducing memory and increasing throughput on MoE models.
- **Abstract:** Depth-recurrent (Looped) models raise effective depth by applying a shared stack of blocks several times. Scaling them usually requires pipeline parallelism, but commonly used interleaved 1F1B is drawn for an acyclic stage graph in which each micro-batch enters each stage once. Once that stack is split across stages, the same stage is visited several times on one micro-batch and later stages feed earlier ones: native 1F1B has no slot for the extra visit, cannot rank a first iteration against a second, and its neighbour-only send/receive order has no back edge to the first stage, so the arrang…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Inference
title: A Pipeline-Parallel System for Depth-Recurrent Models
kern: Loop-PP schedules cyclic pipeline stages for depth-recurrent models, overlapping communication and compute while preserving exact numerical equivalence, reducing memory and increasing throughput on MoE models.
relevance: pipeline parallel for depth-recurrent models
```

**URL check:** https://arxiv.org/abs/2611.30581


### Antom 3-in-1 Transformer: A Payment Foundation Model

- **Link:** https://arxiv.org/abs/2611.25403
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** We report the development of Antom 3-in-1 Transformer, a payment foundation model that integrates sequence, tabular, and graph representations for payment risk detection. The model contains approximately 7B parameters, with approximately 1.7B activated per task route. Antom 3-in-1 Transformer is pretrained to learn reusable behavioral and relational representations, primarily on Ant International's internal payment data. In a cross-business transfer experiment, pretraining improves the target business metric by 34.5% over the same architecture trained from scratch. With only 25% of the traini…
- **Upvotes:** 105

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Industrie
title: Antom 3-in-1 Transformer: A Payment Foundation Model
kern: We report the development of Antom 3-in-1 Transformer, a payment foundation model that integrates sequence, tabular, and graph representations for payment risk detection. The model contains approximately 7B parameters, with approximately 1.7B activated per task route. Antom 3-in-1 Transformer is pretrained to learn…
relevance: payment foundation model
```

**URL check:** https://arxiv.org/abs/2611.25403


### Qwen-Image-HD: Autoregressive Diffusion for High Definition Image Generation

- **Link:** https://arxiv.org/abs/2611.32736
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Fine-tuning a generator on a complete high-resolution canvas requires long image sequences and substantial computation, yet local regions can still exhibit unnatural repetitive stripes when training resources are limited. We introduce Qwen-Image-HD, which adapts Qwen-Image 2.0 to high-resolution synthesis through local training and blockwise autoregressive generation. Each prediction covers a target tile at 1K scale, conditioned on high-resolution upper and left neighbors and a compressed historical thumbnail. These conditions provide adjacent fine-scale structures and an overview of the scen…
- **Upvotes:** 22

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Qwen-Image-HD: Autoregressive Diffusion for High Definition Image Generation
kern: (skip: image generation)
relevance: image generation
```

**URL check:** https://arxiv.org/abs/2611.32736


### KMed-31B Technical Report

- **Link:** https://arxiv.org/abs/2611.28719
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** We present KMed-31B, a medical large language model post-trained from an open-weight model for on-premises deployment with limited hardware. Post-training a model for diverse medical tasks remains difficult, because improving one kind of task can lower performance on another. We attribute this to differences between tasks in expected output and available feedback. Medical question answering and diagnosis prediction have reference answers, whereas clinical inquiry has no single correct response and is judged with rubrics. We therefore divide medical training tasks into four categories by these…
- **Upvotes:** 21

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: KMed-31B Technical Report
kern: (skip: medical LLM)
relevance: medical LLM
```

**URL check:** https://arxiv.org/abs/2611.28719


### Reinforcing Diffusion Models by Instantaneous Trajectory Distribution Matching

- **Link:** https://arxiv.org/abs/2611.30986
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Forward diffusion reinforcement learning (RL)---enabling deterministic ODE sampling without trajectory backpropagation---has grown increasingly popular for efficiently aligning diffusion models. However, we reveal that existing methods essentially rely on signed reward-weighted regression (RWR), regressing the trainable policy velocity onto rollouts from a behavior distribution. Unbiased baseline subtraction implicitly assumes that the policy velocity equals the behavior marginal velocity---an idealized assumption violated under classifier-free guidance (CFG) rollouts, offline/off-policy upda…
- **Upvotes:** 15

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Reinforcing Diffusion Models by Instantaneous Trajectory Distribution Matching
kern: (skip: diffusion RL)
relevance: diffusion RL
```

**URL check:** https://arxiv.org/abs/2611.30986


### LeadVLA: Learning Follower-Aware Route Execution for Robot Leading

- **Link:** https://arxiv.org/abs/2611.30149
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** LeadVLA is a structured multimodal policy that separates route execution into explicit path, pace, and residual components, trained and evaluated with generated closed-loop data and a benchmark, achieving the highest success among tested robot policies and transferring to unseen real environments without fine-tuning.
- **Abstract:** Robot leading requires executing a route while continuously adapting to a designated follower. Existing robot-leading systems often mediate follower understanding and physical route execution through explicit states, planners, or modular interfaces; directly learning this coupling through end-to-end trajectory prediction can instead entangle route execution with follower response. We introduce LeadVLA, a structured multimodal policy that preserves the route as an explicit Path reference while learning a Pace for route progress and a Residual for local follower- and scene-conditioned adaptatio…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: LeadVLA: Learning Follower-Aware Route Execution for Robot Leading
kern: LeadVLA is a structured multimodal policy that separates route execution into explicit path, pace, and residual components, trained and evaluated with generated closed-loop data and a benchmark, achieving the highest success among tested robot policies and transferring to unseen real environments without fine-tuning.
relevance: follower-aware route execution
```

**URL check:** https://arxiv.org/abs/2611.30149


### RoomTokens: Masked Diffusion over Structured Tokens for Indoor Scene Synthesis

- **Link:** https://arxiv.org/abs/2611.30219
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Generating 3D indoor scenes requires a representation that captures object semantics, instance identity, height structure, and orientation while respecting room geometry. Methods that model scenes as sequences of object vectors learn spatial constraints implicitly, leaving collisions and boundary violations to losses or post-processing; semantic-map methods make occupancy explicit, but collapse instance and directional structure. We introduce RoomTokens, a sliced structured-token representation in which each token stores semantic class, instance-color identity, and facing field. This represen…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: RoomTokens: Masked Diffusion over Structured Tokens for Indoor Scene Synthesis
kern: (skip: indoor scene synthesis)
relevance: indoor scene synthesis
```

**URL check:** https://arxiv.org/abs/2611.30219


### VenusOCR2.0: Towards Efficient and Effective Document Parsing

- **Link:** https://arxiv.org/abs/2611.32617
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** We present VenusOCR2.0, a compact 1B-parameter vision-language recognizer designed for both high-accuracy and high-throughput document parsing across text, tables, and formulas. To continuously improve recognition quality without self-training collapse, we build a bounded recursive self-improvement (RSI) data engine where the model acts strictly as a weakness probe, while external multi-expert medoid consensus, VLM visual verification, and factorized synthesis supply reliable supervision across pretraining, curated SFT, and RLVR. VenusOCR2.0 couples a dynamic-resolution SigLIP2 encoder and 2x…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: VenusOCR2.0: Towards Efficient and Effective Document Parsing
kern: We present VenusOCR2.0, a compact 1B-parameter vision-language recognizer designed for both high-accuracy and high-throughput document parsing across text, tables, and formulas. To continuously improve recognition quality without self-training collapse, we build a bounded recursive self-improvement (RSI) data engine…
relevance: efficient document parsing
```

**URL check:** https://arxiv.org/abs/2611.32617


### LoopDVR: Looped Transformer for Efficient Dense Visual Recognition

- **Link:** https://arxiv.org/abs/2611.32067
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** LoopDVR converts pretrained Transformer-based dense visual recognition models into parameter-efficient looped networks by selectively reusing Transformer blocks with adapters, reducing parameters while preserving accuracy.
- **Abstract:** We propose LoopDVR, a framework for converting pretrained Transformer-based dense visual recognition models into parameter-efficient looped networks. Rather than reducing the network width or depth directly, LoopDVR reuses Transformer blocks across layers in both the ViT backbone and Transformer decoder, reducing the number of parameters while retaining the original computational structure. However, naively sharing parameters can disrupt the distinct transformations learned at different depths. To address this challenge, we identify suitable sharing groups based on inter-layer representation…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: LoopDVR: Looped Transformer for Efficient Dense Visual Recognition
kern: (skip: looped transformer for dense vision)
relevance: looped transformer for dense vision
```

**URL check:** https://arxiv.org/abs/2611.32067


### Mega-MMDF and DeepfakeBench-MM: Benchmarking Multimodal Deepfake Detection Across Diverse Forgery Pipelines

- **Link:** https://arxiv.org/abs/2510.22622
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A large audio-visual deepfake benchmark and standardized evaluation suite show that diverse composite-forgery training improves detection performance but does not reliably generalize to constituent manipulations, while modality masking and temporal misalignment increase detection errors.
- **Abstract:** Audio-visual deepfakes can spread misinformation and enable impersonation, undermining trust in digital media. However, existing datasets provide limited coverage of forgery operations and their combinations, constraining detector development and systematic evaluation. We introduce Mega-MMDF, containing 100,000 real and 1.2 million forged clips across 22 pipelines spanning modality-specific manipulations, stacked forgeries, and joint audio-video generation. To assess its training value and enable fair comparisons, we develop DeepfakeBench-MM, which standardizes training and evaluation across…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Mega-MMDF and DeepfakeBench-MM: Benchmarking Multimodal Deepfake Detection Across Diverse Forgery Pipelines
kern: (skip: deepfake detection)
relevance: deepfake detection
```

**URL check:** https://arxiv.org/abs/2510.22622


### Measuring Layer-wise Intrinsic Dimensionality of FFNs in LLMs via PCA

- **Link:** https://arxiv.org/abs/2611.32782
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Large language models exhibit a middle-heavy intrinsic-dimensionality profile in their feed-forward layers, and using this profile to guide width allocation improves pruning under a fixed parameter budget.
- **Abstract:** Modern large language models (LLMs) keep the feed-forward network (FFN) intermediate width identical across every layer, a convention inherited from the original Transformer. Yet mechanistic work suggests layers at different depths do qualitatively different work, raising a natural question: are their capacity demands also non-uniform, and if so, can a fixed parameter budget be allocated more wisely than uniformly? To probe this, we apply principal component analysis (PCA) to the input of each FFN down-projection and measure, for every layer, its intrinsic dimensionality as the smallest numbe…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Measuring Layer-wise Intrinsic Dimensionality of FFNs in LLMs via PCA
kern: Large language models exhibit a middle-heavy intrinsic-dimensionality profile in their feed-forward layers, and using this profile to guide width allocation improves pruning under a fixed parameter budget.
relevance: intrinsic dimensionality of FFNs
```

**URL check:** https://arxiv.org/abs/2611.32782


### PINE: Point, Instance and Normal Estimation in One-Step Diffusion Model

- **Link:** https://arxiv.org/abs/2611.29389
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Understanding a scene requires both geometry and semantics: geometry recovers its spatial structure, and semantics separates it into objects. Current models obtain the two from separate networks or separate passes. We present PINE, a one-step Omni Diffusion Transformer that predicts the point map, the surface normals, and the instance map of an image in one forward pass. PINE treats each map as a token stream, and a stream mask decides which streams interact. A camera-aware ray encoding positions every token by its camera ray rather than its pixel. Grounding attention adds the affinity of pre…
- **Upvotes:** 7

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: PINE: Point, Instance and Normal Estimation in One-Step Diffusion Model
kern: (skip: scene geometry estimation)
relevance: scene geometry estimation
```

**URL check:** https://arxiv.org/abs/2611.29389


### Separating Measurement Failures from Defence Failures in Split Language-Model Privacy

- **Link:** https://arxiv.org/abs/2611.31752
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Split-training privacy evaluations fail through distinct mechanisms. Evaluators can overlook an exposed gradient channel, align reconstructions against shifted labels, or deploy uncalibrated probes before testing a candidate defence, while calibrated attacks can also refute real defences. Separating these failure modes alters which claims survive. We conduct a retrospective evidentiary reanalysis across four split-LLM campaigns and two cross-cutting scope checks covering host key custody and variational mutual-information bounds, mapping every recorded claim to one of five admissibility state…
- **Upvotes:** 5

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Separating Measurement Failures from Defence Failures in Split Language-Model Privacy
kern: (skip: privacy measurement)
relevance: privacy measurement
```

**URL check:** https://arxiv.org/abs/2611.31752


### LoopedWAM: Looped World Action Models for Elastic Inference

- **Link:** https://arxiv.org/abs/2611.25595
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** World action models (WAMs) couple generative video modeling with robotic action prediction but typically require large video and action transformers, limiting deployment efficiency. We present LoopedWAM, a compact WAM that recurrently applies a shared six-block core in each expert, executing 30 transformer layers while storing only 12 blocks per expert. To account for their asymmetric inference costs, the video and action experts can operate at different depths: visual features are computed once per query, whereas action computation repeats at every sampling step. We further propose elastic s…
- **Upvotes:** 5

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: LoopedWAM: Looped World Action Models for Elastic Inference
kern: World action models (WAMs) couple generative video modeling with robotic action prediction but typically require large video and action transformers, limiting deployment efficiency. We present LoopedWAM, a compact WAM that recurrently applies a shared six-block core in each expert, executing 30 transformer layers…
relevance: looped world action models
```

**URL check:** https://arxiv.org/abs/2611.25595


### Distill to Loop: Turning Pretrained Diffusion Transformers into Looped Models with Adjustable Depth

- **Link:** https://arxiv.org/abs/2611.31977
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A pretrained diffusion transformer is distilled into a weight-shared looped student that supports variable loop counts at inference and uses depth-wise ODE solvers and loop guidance to match teacher quality with fewer parameters and less compute.
- **Abstract:** Looped transformers reuse one block of shared weights along the depth of the network. Recent looped diffusion transformers are trained from scratch, which repeats the full pretraining cost although strong pretrained non-looped diffusion transformers exist. We propose Distill to Loop (Dooop), which distills a pretrained non-looped diffusion transformer into a looped student whose blocks are initialized from the teacher's. We cast distillation as a fixed-point iteration toward the teacher, in which the output after every loop is trained toward the teacher, and each loop is one step of an ordina…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Distill to Loop: Turning Pretrained Diffusion Transformers into Looped Models with Adjustable Depth
kern: A pretrained diffusion transformer is distilled into a weight-shared looped student that supports variable loop counts at inference and uses depth-wise ODE solvers and loop guidance to match teacher quality with fewer parameters and less compute.
relevance: distilling DiT into looped models
```

**URL check:** https://arxiv.org/abs/2611.31977


### InstructReplay: Replaying Assistant Turns to Preserve General Behavior During Factual Fine-Tuning

- **Link:** https://arxiv.org/abs/2611.32918
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** InstructReplay preserves an instruction-tuned language model's general abilities during fact fine-tuning by keeping its responses close to the initial model's answers on general instructions, reducing benchmark decline while still learning new facts.
- **Abstract:** Fine-tuning an instruction-tuned language model on new facts often erodes its general abilities. We find that standard fine-tuning lowers instruction-following, reasoning and coding benchmarks by 35 points on average, and that these losses track a collapse in answer length: fine-tuned models at least halve their responses, and the further a response drifts from the initial model's length, the more often it fails. We propose InstructReplay: the initial model answers a set of general instructions once, and during fine-tuning the model is kept close to the initial model on these answers. Across…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: InstructReplay: Replaying Assistant Turns to Preserve General Behavior During Factual Fine-Tuning
kern: (skip: factual fine-tuning replay)
relevance: factual fine-tuning replay
```

**URL check:** https://arxiv.org/abs/2611.32918


### Do learned image captioning metrics generalize? Auditing duplicated samples in human-judgment benchmarks

- **Link:** https://arxiv.org/abs/2611.30488
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** An audit of recent image captioning evaluation benchmarks shows that duplicate samples and metric behavior inflate reported correlations, and proposes a protocol under which zero-shot vision-language judges perform best on recent test sets.
- **Abstract:** Learned image captioning metrics are trained and tested on human judgments, so their reported correlation is a claim about generalization. We audit this claim for the three most recent collections of such judgments, Polaris, Nebula, and Spica, matching images at the pixel level. First, test samples reappear in training sets: the Spica training set contains about two-thirds of the Polaris test set, with identical human ratings. Second, controlled retraining shows that duplicates can inflate a metric: for Pearl, the gain is confined to the duplicated samples and grows with every epoch; for DENE…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Do learned image captioning metrics generalize? Auditing duplicated samples in human-judgment benchmarks
kern: (skip: captioning metric audit)
relevance: captioning metric audit
```

**URL check:** https://arxiv.org/abs/2611.30488


### Clinical3D-Bench: Evaluating and Improving Spatial Intelligence of Multimodal LLMs in Hospital Environments

- **Link:** https://arxiv.org/abs/2611.32094
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A simulated hospital benchmark shows that multimodal large language models have limited spatial reasoning, while fine-tuning and a 3D-computation method improve their accuracy and reduce the gap to physicians.
- **Abstract:** Spatial reasoning in hospitals requires tracking look-alike equipment, interpreting patient-relative directions, and judging passage widths, yet existing benchmarks provide limited coverage of these abilities. We introduce Clinical3D-Bench, a simulated benchmark with 3,368 questions of eight types on egocentric walkthroughs of 373 hospital-room layouts. Layouts follow hospital design guidelines, answers are computed from the 3D scenes, and paired scene states test whether models change their answers when relevant evidence changes. Videos are photorealistic, and ten physicians screened the lay…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Clinical3D-Bench: Evaluating and Improving Spatial Intelligence of Multimodal LLMs in Hospital Environments
kern: (skip: clinical spatial reasoning benchmark)
relevance: clinical spatial reasoning benchmark
```

**URL check:** https://arxiv.org/abs/2611.32094


### Align the Pair, Not the Sample: Representation Alignment for Faster and Better One-Step Generato

- **Link:** https://arxiv.org/abs/2611.29547
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** In one-step generator training, aligning the paired reconstruction path rather than the generative path improves recall and sample quality while accelerating both training stages and lowering FID.
- **Abstract:** Representation alignment markedly accelerates diffusion training, but one-step generators raise a question that diffusion does not: which training path should receive the loss? A one-step generator sees two kinds of inputs. Corrupted real images come with their clean counterpart, which provides an instance-paired target. Samples generated from pure noise have no corresponding real image, yet this is where the final model operates. We study this question on Priming, which trains one-step generators from scratch by reconstructing corrupted images and then matching feature distributions with opt…
- **Upvotes:** 3

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Align the Pair, Not the Sample: Representation Alignment for Faster and Better One-Step Generato
kern: (skip: one-step generator alignment)
relevance: one-step generator alignment
```

**URL check:** https://arxiv.org/abs/2611.29547


### Tokenisation is not in APX

- **Link:** https://arxiv.org/abs/2611.34938v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** In this paper, we prove that, unless P=NP, no polynomial-time algorithm can find a tokeniser whose objective is within any constant factor of the optimum, meaning that tokenisation is not in the APX complexity class. We prove this for direct and bottom-up tokenisation, under both a compression or unigram log-likelihood objectives, and for binary or larger alphabets. We further show that, even over unary alphabets, direct tokenisation is APX-hard, and thus admits no polynomial-time approximation scheme.

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Tokenisation is not in APX
kern: (skip: tokenisation complexity proof)
relevance: tokenisation complexity proof
```

**URL check:** https://arxiv.org/abs/2611.34938v1


### Can image generation help visual reasoning? An empirical study

- **Link:** https://arxiv.org/abs/2611.34935v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Language models think in words; then multimodal models might think in images. We test whether a generated helper improves the answer to a visual question. A model describes the helper it needs and then answers using the original and generated images together. Across 13 vision-language model and generator pairs, generation lowers mean accuracy by 3.7 percentage points, with declines on nine of ten tasks. Two unified models, BAGEL and Janus-Pro-7B, each lose accuracy on eight tasks. On VSTAR, adding a generated image to the same planning hint lowers accuracy by 10.47 points. Repeated image edit…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Reasoning
title: Can image generation help visual reasoning? An empirical study
kern: Language models think in words; then multimodal models might think in images. We test whether a generated helper improves the answer to a visual question. A model describes the helper it needs and then answers using the original and generated images together. Across 13 vision-language model and generator pairs,…
relevance: image generation as reasoning aid
```

**URL check:** https://arxiv.org/abs/2611.34935v1


### RePace: Reasoning about Demonstration Speedup for Faster Vision-Language-Action Policies

- **Link:** https://arxiv.org/abs/2611.34864v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Since vision-language-action (VLA) policies can inherit the slow pace of human demonstrations, accelerating these demonstrations before fine-tuning can lead to faster VLA policies without an additional speed-selection module at deployment. Several offline speedup methods have focused on identifying segments that require less precision and assigning predefined speedup factors to the segments. However, even within a single segment, a speedup factor suitable for steady motion may be too high when precise alignment is required. To this end, this paper presents RePace, an offline reasoning framewo…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: RePace: Reasoning about Demonstration Speedup for Faster Vision-Language-Action Policies
kern: (skip: VLA demo speedup)
relevance: VLA demo speedup
```

**URL check:** https://arxiv.org/abs/2611.34864v1


### Focus Only on What's Important: Training-Free Focus Maps for Frozen Vision Transformers in Long-Video Object Segmentation

- **Link:** https://arxiv.org/abs/2611.34863v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Vision transformers are strong but costly image encoders for video object segmentation. Training-free token merging cuts compute uniformly across the frame, including on tracked objects. We give a frozen DINOv3 ViT inside a trained Cutie head a training-free focus map: full resolution where the segmenter expects its objects and coarser merging elsewhere. Protecting only the previous frame's mask works on short clips but fails on long videos, where fast motion pushes targets outside the margin and into background merging, locking in loss. Our policy instead takes the union of velocity-shifted…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Focus Only on What's Important: Training-Free Focus Maps for Frozen Vision Transformers in Long-Video Object Segmentation
kern: (skip: token merging for video object segmentation)
relevance: token merging for video object segmentation
```

**URL check:** https://arxiv.org/abs/2611.34863v1


### BOP-Refer: Benchmark for Monocular 3D and 2D Object Grounding

- **Link:** https://arxiv.org/abs/2611.34862v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** We introduce BOP-Refer, the first benchmark for monocular 3D and 2D grounding of everyday and industrial objects sourced from 9 diverse BOP datasets. We pair images from these datasets with VLM-generated and human-verified referring expressions, and derive accurate ground-truth 3D and 2D bounding boxes of the referred objects from their 3D models and 6DoF pose annotations. Our systematic evaluation of 17 frontier VLMs across the major proprietary and open-weight families (Gemini, GPT, Claude, Qwen, Gemma) shows that the best model, Gemini 4 Carbon, reaches 72.6% AP_IoU2D in 2D but only 12.4%…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: BOP-Refer: Benchmark for Monocular 3D and 2D Object Grounding
kern: We introduce BOP-Refer, the first benchmark for monocular 3D and 2D grounding of everyday and industrial objects sourced from 9 diverse BOP datasets. We pair images from these datasets with VLM-generated and human-verified referring expressions, and derive accurate ground-truth 3D and 2D bounding boxes of the…
relevance: 3D grounding benchmark
```

**URL check:** https://arxiv.org/abs/2611.34862v1


### Model Weights, Airlocks and Sandboxes: A Call for Technical Validation of Re-identification Tests under the EDPB Anonymisation Guidelines

- **Link:** https://arxiv.org/abs/2611.34859v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** The Guidelines 02/2026 on anonymisation of the European Data Protection Board (EDPB), published for consultation in July 2026, assess anonymity relative to the entities that may access data. They bring AI models into scope and call for testing, but do not say how a re-identification test should be designed or validated, or how far its result counts as evidence. Building on our reply to the consultation, we describe a framework based on a secure processing environment whose outputs are reviewed before release (an airlock), and distinguish forms of release and three types of evidence: formal, e…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Model Weights, Airlocks and Sandboxes: A Call for Technical Validation of Re-identification Tests under the EDPB Anonymisation Guidelines
kern: (skip: privacy/regulation)
relevance: privacy/regulation
```

**URL check:** https://arxiv.org/abs/2611.34859v1


### From Prediction to Decision: Decision-Focused Fine-Tuning of Autoregressive Tabular Transformers for Cost-Sensitive Financial Events

- **Link:** https://arxiv.org/abs/2611.34858v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Autoregressive transformers trained on tokenized tabular event streams are a simple and strong baseline for predicting financial events such as fraud. Yet institutions do not act on probabilities; they act on decisions whose consequences are asymmetric and heteroscedastic: the cost of a missed high-value fraud and that of a wrongly declined small purchase are not the same. The standard bridge is post-hoc Bayes-optimal thresholding of calibrated probabilities under a cost matrix. We ask whether fine-tuning the model to the decision objective can do better. We fine-tune the same pretrained mode…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: From Prediction to Decision: Decision-Focused Fine-Tuning of Autoregressive Tabular Transformers for Cost-Sensitive Financial Events
kern: (skip: tabular event prediction)
relevance: tabular event prediction
```

**URL check:** https://arxiv.org/abs/2611.34858v1


### Put the World Back: Timestamps Matter in Time Series Reasoning

- **Link:** https://arxiv.org/abs/2611.34848v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Large language models (LLMs) are increasingly applied to time series reasoning. However, current evaluations often give models events in chronological order and already matched to the time series. This makes it unclear whether models use timestamps to connect events with observations or simply take shortcuts. To expose this ambiguity, we reformulate time series reasoning from a world-to-series projection perspective, viewing timestamps as explicit indices that connect numerical observations and external events to shared world states. We identify three structures that timestamps can make expli…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Put the World Back: Timestamps Matter in Time Series Reasoning
kern: (skip: time series reasoning)
relevance: time series reasoning
```

**URL check:** https://arxiv.org/abs/2611.34848v1


### Probing Visual Idiosyncrasies in Text-to-Image Models

- **Link:** https://arxiv.org/abs/2611.34843v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Text-to-Image (T2I) models turn short text descriptions into images, and the leading models now produce images of comparable visual quality. Whether their outputs still carry model-specific characteristics matters for attribution, for model comparison beyond aggregate quality, and for evaluations that assume anonymity. We ask whether images from frontier T2I models can still be classified by source, and which visual properties make this possible. Here we show that a standard ResNet-50 identifies the source of an image among HiDream-O1-Dev, FLUX.2-dev, HunyuanImage-3.0, and Qwen-Image-2512, th…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Probing Visual Idiosyncrasies in Text-to-Image Models
kern: (skip: T2I idiosyncrasies)
relevance: T2I idiosyncrasies
```

**URL check:** https://arxiv.org/abs/2611.34843v1


### Repairing the Trustworthiness of Distilled Language Models

- **Link:** https://arxiv.org/abs/2611.34831v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Knowledge distillation enables the deployment of large language models through smaller student models, but the compression process can introduce regressions in trustworthiness even when downstream performance is preserved. Repairing such failures is challenging because the original distillation corpus is often unavailable, while direct preference optimization may alter capabilities inherited from the teacher. We propose a targeted repair framework based on the proximal Bregman response function (PBRF) that addresses both limitations. We estimate the curvature required for PBRF using a surroga…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Repairing the Trustworthiness of Distilled Language Models
kern: (skip: distillation trustworthiness)
relevance: distillation trustworthiness
```

**URL check:** https://arxiv.org/abs/2611.34831v1


### Sage-Med: Scaling Medical Multimodal Intelligence

- **Link:** https://arxiv.org/abs/2611.34575
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Establishing effective scaling laws for medical multimodal large language models (MLLMs) remains a persistent and fundamental challenge. Our systematic evaluation shows that existing medical MLLMs tend to underperform frontier general-purpose MLLMs across a range of medical tasks, while scaling model size primarily improves text capabilities rather than multimodal perception, and enabling reasoning modes fails to close this visual gap. To investigate how medical multimodal intelligence scales in practice, we introduce Sage-Med-Preview, a 35B-parameter medical multimodal model with 3B activate…
- **Upvotes:** 43

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Sage-Med: Scaling Medical Multimodal Intelligence
kern: (skip: medical scaling)
relevance: medical scaling
```

**URL check:** https://arxiv.org/abs/2611.34575


### Improving and Expanding Video Editing Capabilities Without Videos

- **Link:** https://arxiv.org/abs/2611.34941
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Image-to-Video Transfer improves pretrained video editors by training them as image editors on single images, enabling new video editing tasks and state-of-the-art results on OpenVE-Bench and OpenVE++.
- **Abstract:** Image editing models can follow a wide range of instructions, but video editing models still lag behind, limited in part by the difficulty of collecting paired source and edited videos. Is it possible to transfer advanced image editing capabilities to video editors without new paired videos? We introduce Image-to-Video Transfer (I2VT), which improves pretrained video editors and expands them to new editing tasks using an image editor. It enables efficient post-training with no architectural changes and no new videos, using only individual images. Our key idea is to let the video editor role-p…
- **Upvotes:** 29

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Improving and Expanding Video Editing Capabilities Without Videos
kern: (skip: video editing)
relevance: video editing
```

**URL check:** https://arxiv.org/abs/2611.34941


### DyLoMo-DiT: Dynamic Looped Mixture-of-Experts Diffusion Transformers

- **Link:** https://arxiv.org/abs/2611.30844
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A dynamic looped mixture-of-experts diffusion transformer reuses shared parameters and varies compute across noise levels, improving image generation quality under matched budgets.
- **Abstract:** Diffusion Transformers (DiTs) scale model capacity by increasing both parameter count and computation. Mixture-of-Experts (MoE) variants expand parameter capacity while keeping per-token computation roughly fixed, but still require substantial parameter storage. In this paper, we propose Dynamic Looped MoE DiT (DyLoMo-DiT), which reuses parameters rather than adding them: a weight-shared loop repeatedly applies the middle layers, while sparse experts allocate parameter capacity across tokens. This design deepens the network without adding parameters, freeing the parameter budget for other use…
- **Upvotes:** 25

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: DyLoMo-DiT: Dynamic Looped Mixture-of-Experts Diffusion Transformers
kern: A dynamic looped mixture-of-experts diffusion transformer reuses shared parameters and varies compute across noise levels, improving image generation quality under matched budgets.
relevance: dynamic looped MoE DiT
```

**URL check:** https://arxiv.org/abs/2611.30844


### HOG-WAM: Improving Visual Robustness through Future Gradient Prediction

- **Link:** https://arxiv.org/abs/2611.34811
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** HOG-WAM improves visually robust control in world-action models by adding future Histograms of Oriented Gradients as auxiliary structural supervision through a training-only HOG diffusion transformer, yielding higher success under observation corruptions while preserving the original RGB-to-action inference architecture.
- **Abstract:** World-action models jointly predict future observations and actions, yet visual corruption can disrupt the resulting policies. We introduce HOG-WAM, which adds future Histograms of Oriented Gradients (HOG) as structural supervision derived directly from demonstration images. An auxiliary HOG diffusion transformer (DiT) module reads RGB features through asymmetric attention, allowing its objective to shape the visual representation used for control. The module is used only during training and removed at inference, preserving FastWAM's RGB-to-action architecture. We evaluate four controlled obs…
- **Upvotes:** 20

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: HOG-WAM: Improving Visual Robustness through Future Gradient Prediction
kern: (skip: world-action model robustness)
relevance: world-action model robustness
```

**URL check:** https://arxiv.org/abs/2611.34811


### AIRIS: Benchmarking Social Embodied Intelligence in Egocentric Streaming Videos

- **Link:** https://arxiv.org/abs/2611.34347
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Embodied agents operating around people must not only recognize social cues, but also decide when the available evidence is sufficient, whether to intervene, and how to respond without violating social norms. Existing benchmarks typically evaluate these abilities in isolation or with access to completed videos, obscuring where an online social decision fails. We introduce AIRIS, a causal streaming benchmark that formulates social embodied intelligence as a time-anchored chain of Attention, Intention, Reaction, and Interaction (A-I-R-I). AIRIS contains 8,000 expert-curated questions grounded i…
- **Upvotes:** 16

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: AIRIS: Benchmarking Social Embodied Intelligence in Egocentric Streaming Videos
kern: Embodied agents operating around people must not only recognize social cues, but also decide when the available evidence is sufficient, whether to intervene, and how to respond without violating social norms. Existing benchmarks typically evaluate these abilities in isolation or with access to completed videos,…
relevance: social embodied intelligence
```

**URL check:** https://arxiv.org/abs/2611.34347


### FoundSurface: Feedforward Ray-Based 3D Scene Surface Reconstruction from Unposed Images

- **Link:** https://arxiv.org/abs/2611.34128
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A generalizable pipeline reconstructs continuous, high-fidelity 3D surfaces from unposed images by integrating pointmap and ray-based representations, achieving strong zero-shot generalization.
- **Abstract:** Accurate 3D surface reconstruction from unposed images remains a fundamental challenge in computer vision. Recent feed-forward pointmap methods eliminate the need for camera poses but inherently produce discrete, sparse representations. In this paper, we present a generalizable pipeline that directly recovers continuous, high-fidelity 3D surfaces from unposed images by seamlessly integrating pointmap- and ray-based representations. Our approach first extracts explicit geometric priors using a pre-trained pointmap model. A query-view-centric selection module then identifies geometrically relev…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: FoundSurface: Feedforward Ray-Based 3D Scene Surface Reconstruction from Unposed Images
kern: A generalizable pipeline reconstructs continuous, high-fidelity 3D surfaces from unposed images by integrating pointmap and ray-based representations, achieving strong zero-shot generalization.
relevance: 3D surface reconstruction
```

**URL check:** https://arxiv.org/abs/2611.34128


### Target-Part Preference Optimization for Part-Aware 3D Generation

- **Link:** https://arxiv.org/abs/2611.30472
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Preference fine-tuning based on Direct Preference Optimization adapts a pretrained part-aware 3D generator with limited part annotations, yielding the best multi-part results at medium scale but less consistent gains under distribution shift.
- **Abstract:** Part-aware 3D generation requires not only globally plausible objects but also complete, well-separated semantic parts, yet high-quality part decompositions remain too scarce to support large-scale supervised fine-tuning. We study whether preference fine-tuning based on Direct Preference Optimization (DPO) can adapt a pretrained part-aware generator from limited part-annotated data without architectural changes. We rank candidates generated with different random seeds against ground-truth (GT) geometric metrics, and select the (object, target-part) examples with the largest across-seed qualit…
- **Upvotes:** 14

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Target-Part Preference Optimization for Part-Aware 3D Generation
kern: (skip: 3D generation preference)
relevance: 3D generation preference
```

**URL check:** https://arxiv.org/abs/2611.30472


### Let Vision-Language Models Generate Images through Their Representations

- **Link:** https://arxiv.org/abs/2611.31237
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** Integral converts a pretrained vision-language model into a unified multimodal model by constructing a shared visual representation space, preserving understanding while enabling strong visual generation.
- **Abstract:** Recent unified multimodal models aim to combine visual understanding and generation within a single model, yet effectively integrating the two capabilities remains challenging. Leveraging pretrained vision-language models offers a way to build on already learned multimodal knowledge, but making this knowledge effectively accessible to visual generation remains nontrivial. We find that a central challenge lies in the heterogeneous visual representations used for understanding and generation. To address this challenge, we introduce Integral, which converts a pretrained vision-language model int…
- **Upvotes:** 21

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Let Vision-Language Models Generate Images through Their Representations
kern: (skip: VLM image generation)
relevance: VLM image generation
```

**URL check:** https://arxiv.org/abs/2611.31237


### Beyond Self-Consistency: Recursive Self-Improvement at Test Time

- **Link:** https://arxiv.org/abs/2611.30965
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A label-free test-time framework, TT-RSI, improves large language models by repeatedly re-solving questions with prior solutions and distilling refinements into model weights, outperforming self-consistency methods under the same test-time scaling budget.
- **Abstract:** Large language models (LLMs) that continue improving after deployment (e.g., recursive self-improvement) offer a promising path toward general intelligence. Current test-time methods pursue this goal on unlabeled questions, primarily relying on self-consistency: they generate independent solutions and use majority voting to select an answer or construct training targets. This leaves earlier reasoning unused at inference and can reinforce an incorrect majority during training. Humans instead build on earlier attempts to preserve useful reasoning, correct mistakes and improve their problem-solv…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Reasoning
title: Beyond Self-Consistency: Recursive Self-Improvement at Test Time
kern: A label-free test-time framework, TT-RSI, improves large language models by repeatedly re-solving questions with prior solutions and distilling refinements into model weights, outperforming self-consistency methods under the same test-time scaling budget.
relevance: test-time recursive self-improvement
```

**URL check:** https://arxiv.org/abs/2611.30965


### ROAM-Bench: Evaluating Embodied Active Spatial Intelligence through Evidence Verification

- **Link:** https://arxiv.org/abs/2611.33143
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Embodied spatial intelligence requires agents to gather information through exploration and interaction, then use it to reason and act. Existing benchmarks insufficiently distinguish correct outcomes from completion of these task requirements. We introduce ROAM-Bench to evaluate these abilities under robot motion and collision constraints. Independent checks use simulation state and episode records to assess outcomes and task requirements, with stronger checks of geometry, coverage, or placement. It comprises 250 manually validated tasks across 11 types in five groups and 27 indoor environmen…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: ROAM-Bench: Evaluating Embodied Active Spatial Intelligence through Evidence Verification
kern: Embodied spatial intelligence requires agents to gather information through exploration and interaction, then use it to reason and act. Existing benchmarks insufficiently distinguish correct outcomes from completion of these task requirements. We introduce ROAM-Bench to evaluate these abilities under robot motion and…
relevance: embodied active spatial intelligence
```

**URL check:** https://arxiv.org/abs/2611.33143


### iMFPO: Improving Mean Flow Policy Optimization with Drift-Aware Velocity Alignment for Embodied Control

- **Link:** https://arxiv.org/abs/2611.33922
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** iMFPO enables efficient one-step action generation for embodied control by decoupling velocity learning and aligning drift-aware velocities during reward-driven policy optimization.
- **Abstract:** Flow-based generative policies offer expressive action modeling for embodied control, yet achieving efficient one-step generation under reward-driven policy optimization remains challenging. In particular, evolving action distributions during online reinforcement learning may introduce inconsistencies between instantaneous-velocity learning and interval-averaged action generation. To address this challenge, we propose iMFPO, a one-step generative policy optimization framework with decoupled velocity learning and drift-aware velocity alignment. A shared interval-conditioned actor supports inst…
- **Upvotes:** 9

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: iMFPO: Improving Mean Flow Policy Optimization with Drift-Aware Velocity Alignment for Embodied Control
kern: (skip: mean flow policy optimization)
relevance: mean flow policy optimization
```

**URL check:** https://arxiv.org/abs/2611.33922


### Change the Base, Change the Game: Rethinking Pan-sharpening

- **Link:** https://arxiv.org/abs/2611.32002
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Many pan-sharpening (PS) networks reconstruct high-resolution multispectral (HRMS) images by adding learned residuals to 4times-interpolated low-resolution multispectral (LRMS) inputs, incorporating panchromatic (PAN) detail only through these residual corrections. This raises a simple question: Why start with a blurry base when sharp spatial detail is already available? We propose PanBase, a sharper multispectral starting point designed for more effective residual learning. Guided by physical sensor characteristics, PanBase combines PAN spatial detail with LRMS spectral information while enf…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Change the Base, Change the Game: Rethinking Pan-sharpening
kern: (skip: pan-sharpening)
relevance: pan-sharpening
```

**URL check:** https://arxiv.org/abs/2611.32002


### CONCOR: Benchmarking Contrastive Decoding for Visual Hallucination Mitigation Beyond Final-Output Performance

- **Link:** https://arxiv.org/abs/2611.30460
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A controlled benchmark directly evaluates contrastive corrections in multimodal large language models to better understand and mitigate object hallucination beyond final task scores.
- **Abstract:** Contrastive decoding (CD) mitigates object hallucination in multimodal large language models (MLLMs) by contrasting token distributions under different conditions to adjust token scores. However, existing generative and discriminative benchmarks primarily measure final task scores, which can be confounded by candidate filtering, changes in generation trajectories, and response biases, making it difficult to isolate the effects of the underlying contrastive adjustments. To address these limitations while complementing existing evaluations, we introduce CONCOR (Contrastive Correction Evaluation…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: CONCOR: Benchmarking Contrastive Decoding for Visual Hallucination Mitigation Beyond Final-Output Performance
kern: (skip: contrastive decoding for hallucination)
relevance: contrastive decoding for hallucination
```

**URL check:** https://arxiv.org/abs/2611.30460


### Speak When You See It: Proactive Task Assistants Should Wait for Evidence, Not the Clock

- **Link:** https://arxiv.org/abs/2611.30895
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Proactive assistants that guide people through physical tasks must decide, every few seconds, whether a step is complete and whether a mistake has occurred. We find that two benchmarks for this task largely reward knowing when rather than seeing what: a timer that never looks at the video, raising an alarm at 25 s and confirming each step at 30 s, reaches a mistake F1 of 0.373 on Ego-MC-Bench, above every published result (at most 0.27). We formalize this as the video-blind frontier, the best trade-off between completion accuracy and mistake F1 that policies reach from the elapsed time, the i…
- **Upvotes:** 2

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Speak When You See It: Proactive Task Assistants Should Wait for Evidence, Not the Clock
kern: Proactive assistants that guide people through physical tasks must decide, every few seconds, whether a step is complete and whether a mistake has occurred. We find that two benchmarks for this task largely reward knowing when rather than seeing what: a timer that never looks at the video, raising an alarm at 25 s…
relevance: proactive assistants; wait for evidence
```

**URL check:** https://arxiv.org/abs/2611.30895


### A Mesh for Every Moment

- **Link:** https://arxiv.org/abs/2611.34939
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** We present MEMO (a Mesh for Every MOment), a method that reconstructs the geometry of complete dynamic scenes, captured by multiple synchronized cameras, and extracts a mesh at every frame. Existing dynamic Gaussian splatting methods either model appearance alone or target isolated objects segmented by foreground masks, and all of them recover meshes by TSDF fusion or Poisson reconstruction, whose fixed grids limit the detail they can capture. At the core of MEMO is a per-Gaussian motion model inspired by Gaussian processes, which represents each Gaussian's position and rotation over time as…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: A Mesh for Every Moment
kern: We present MEMO (a Mesh for Every MOment), a method that reconstructs the geometry of complete dynamic scenes, captured by multiple synchronized cameras, and extracts a mesh at every frame. Existing dynamic Gaussian splatting methods either model appearance alone or target isolated objects segmented by foreground…
relevance: dynamic scene reconstruction
```

**URL check:** https://arxiv.org/abs/2611.34939


### DexEngine: Scaling Human Demonstrations into Physically Executable Whole-Robot Data

- **Link:** https://arxiv.org/abs/2611.33579
- **Source:** HF daily · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** A growing body of recent work addresses the retargeting of human hand-object demonstrations to robotic hands. To train whole-robot policies, however, the retargeted motions must be kinematically feasible and physically executable, and be produced efficiently at scale. We present DexEngine, a simulation pipeline that turns human manipulation data into train-ready, physically executable arm-hand trajectories. DexEngine first places each clip's hand-object motion where the arms can reach it, finds an arm motion that follows the human hands, and then corrects the motion in physics simulation with…
- **Upvotes:** 16

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: DexEngine: Scaling Human Demonstrations into Physically Executable Whole-Robot Data
kern: A growing body of recent work addresses the retargeting of human hand-object demonstrations to robotic hands. To train whole-robot policies, however, the retargeted motions must be kinematically feasible and physically executable, and be produced efficiently at scale. We present DexEngine, a simulation pipeline that…
relevance: human-to-robot data scaling
```

**URL check:** https://arxiv.org/abs/2611.33579


### Negative-Only Policy Optimization for One-Sided Verifiable Rewards

- **Link:** https://arxiv.org/abs/2611.17287
- **Source:** HF daily · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** Reinforcement learning with verifiable rewards (RLVR) typically relies on a verifier that can reliably judge whether sampled solutions are correct. However, in many realistic settings, complete verification is generally unavailable, while cheap checks can only falsify failures. We formalize this regime as one-sided verifiability (OSV): verified negatives are reliable counterexamples, but verified positives are merely non-falsified candidates and may contain many false positives. This asymmetry makes standard RLVR unreliable, because reinforcing verified positives can directly reward shortcuts…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Negative-Only Policy Optimization for One-Sided Verifiable Rewards
kern: (skip: negative-only policy optimization)
relevance: negative-only policy optimization
```

**URL check:** https://arxiv.org/abs/2611.17287


### Depth Pro 2: Sharp and Temporally Consistent Metric Monocular Depth

- **Link:** https://arxiv.org/abs/2611.26603
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** A single scalable network estimates dense metric depth for images and video at native resolution, jointly improving metric accuracy, boundary sharpness, and temporal consistency.
- **Abstract:** We present Depth Pro 2, an approach to estimating dense metric depth for images and video at full resolution. By analyzing prior methods for monocular depth estimation, we find that they commonly trade off temporal consistency and boundary sharpness: multi-frame methods favor consistency, single-frame methods favor sharpness. To overcome this trade-off, we train a single, scalable network that processes both images and video and predicts depth maps at native resolution. Depth Pro 2 produces depth maps that are metrically accurate, sharp, and temporally consistent all at once, outperforming pr…
- **Upvotes:** 40

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: Depth Pro 2: Sharp and Temporally Consistent Metric Monocular Depth
kern: A single scalable network estimates dense metric depth for images and video at native resolution, jointly improving metric accuracy, boundary sharpness, and temporal consistency.
relevance: metric depth estimation
```

**URL check:** https://arxiv.org/abs/2611.26603


### π^4: A Foundation Model for 4D Scene Geometry and Motion

- **Link:** https://arxiv.org/abs/2611.23144
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** This unified foundation model enables the recovery of dense geometry, camera poses, and object tracking from diverse, uncalibrated observations in 4D scenes using a shared geometry and motion branch architecture.
- **Abstract:** π^4 is a unified foundation model for 4D scene perception. From diverse, uncalibrated RGB observations in the wild---a single image, an unordered collection, or a video sequence---it recovers dense geometry, camera poses, and metric scale, together with 2D/3D point tracks and moving-object masks for multi-image inputs. It couples a geometry branch with a geometry-conditioned motion branch, which predicts image-space correspondences that are lifted into 3D using reconstructed target-view geometry. Across diverse benchmarks, π^4 achieves the best overall average rank in geometry evaluation, alo…
- **Upvotes:** 21

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: World models & generative video
title: π^4: A Foundation Model for 4D Scene Geometry and Motion
kern: This unified foundation model enables the recovery of dense geometry, camera poses, and object tracking from diverse, uncalibrated observations in 4D scenes using a shared geometry and motion branch architecture.
relevance: 4D scene geometry foundation model
```

**URL check:** https://arxiv.org/abs/2611.23144


### VoxMel TTS Technical Report

- **Link:** https://arxiv.org/abs/2611.20254
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** VoxMel is a tokenizer-free autoregressive TTS framework that uses an invertible two-axis Haar transform to decompose mel spectrograms into Coarse-Mel and residual tiers, enabling stable high-fidelity generation with strong recognition and speaker-similarity results.
- **Abstract:** Continuous autoregressive TTS relies on an acoustic target that enables stable next-latent modeling while preserving fine-grained acoustic details. While existing approaches employ learned compressed representations (e.g., continuous VAE latents) to render prediction tractable, they rely on complex neural encoders that often cap generation fidelity. Conversely, training-free targets like mel-spectrograms eliminate encoder overhead, yet their potential for autoregressive generation remains largely underexplored. In this work, we propose VoxMel, a tokenizer-free framework for autoregressive TTS…
- **Upvotes:** 17

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: VoxMel TTS Technical Report
kern: (skip: TTS)
relevance: TTS
```

**URL check:** https://arxiv.org/abs/2611.20254


### KuaiSearch: An E-Commerce Search Dataset with Authentic Queries and Product Texts for Recall, Ranking, and Relevance

- **Link:** https://arxiv.org/abs/2602.11518
- **Source:** HF q:semantic · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** KuaiSearch is a realistic large-scale e-commerce search dataset derived from real user interactions that supports evaluation across recall, ranking, and relevance stages.
- **Abstract:** E-commerce search connects user needs with massive product inventories, yet real-world systems face challenges from ambiguous queries, noisy product texts, and diverse user preferences. Recent advances in large language models (LLMs) offer new opportunities for semantic understanding and intent modeling, but existing e-commerce search datasets remain limited by heuristically constructed queries, popularity-based filtering, anonymized texts, and incomplete coverage of the search pipeline. These limitations hinder realistic evaluation of LLM-based e-commerce search. To address this gap, we intr…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: KuaiSearch: An E-Commerce Search Dataset with Authentic Queries and Product Texts for Recall, Ranking, and Relevance
kern: (skip: e-commerce search dataset)
relevance: e-commerce search dataset
```

**URL check:** https://arxiv.org/abs/2602.11518


### SLCA-GRPO: Resolving Cross-Segment Credit Misattribution in Tool-Calling RL

- **Link:** https://arxiv.org/abs/2609.29050
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Gist (HF ai_summary):** SLCA-GRPO uses segment-locked credit assignment and hierarchical rewards to separate tool and summary optimization, improving convergence and accuracy for tool-calling agents.
- **Abstract:** Tool-calling agents produce heterogeneous outputs, interleaving structured tool invocations with user-facing natural language summaries. This output heterogeneity presents a structural failure mode in standard on-policy Reinforcement Learning (RL): algorithms like GRPO indiscriminately broadcast a homogeneous trajectory-level scalar advantage to all tokens. Consequently, gradient noise from summary generation leaks into tool-decision tokens, causing cross-segment credit misattribution and brittle optimization. In this work, we propose SLCA-GRPO, a framework incorporating Segment-Locked Credit…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: SLCA-GRPO: Resolving Cross-Segment Credit Misattribution in Tool-Calling RL
kern: (skip: credit assignment for tool-calling RL)
relevance: credit assignment for tool-calling RL
```

**URL check:** https://arxiv.org/abs/2609.29050


### Building on Nemotron 3.5 Parse: Open Data, Fine-Tuning, and Faster Inference

- **Link:** https://huggingface.co/blog/nvidia/building-on-nemotron-35-parse-open-data-fine-tunin
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: Building on Nemotron 3.5 Parse: Open Data, Fine-Tuning, and Faster Inference
kern: (no abstract in dumps; document parsing; open data + fine-tuning)
relevance: document parsing; open data + fine-tuning
```

**URL check:** https://huggingface.co/blog/nvidia/building-on-nemotron-35-parse-open-data-fine-tunin


### Where scientists draw the line on AI agents

- **Link:** https://huggingface.co/blog/allenai/where-scientists-draw-the-line-on-ai-agents
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Where scientists draw the line on AI agents
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/allenai/where-scientists-draw-the-line-on-ai-agents


### Hill-climbing Inkling 2 Mini inference on one RTX PRO 6000

- **Link:** https://huggingface.co/blog/inkling-2-mini-inference-hillclimb
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Hill-climbing Inkling 2 Mini inference on one RTX PRO 6000
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/inkling-2-mini-inference-hillclimb


### How to build and maintain an agentic evaluation

- **Link:** https://huggingface.co/blog/agentic-evals
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: How to build and maintain an agentic evaluation
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/agentic-evals


### 180B Parameters, 32GB of RAM: Pushing MoE Inference to the Limit with Transformers

- **Link:** https://huggingface.co/blog/moe-expert-streaming
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Inference
title: 180B Parameters, 32GB of RAM: Pushing MoE Inference to the Limit with Transformers
kern: (no abstract in dumps; MoE inference on 32GB)
relevance: MoE inference on 32GB
```

**URL check:** https://huggingface.co/blog/moe-expert-streaming


### Rumble-2-Flash: an open 0.5B speech model for 40+ languages

- **Link:** https://huggingface.co/blog/rumble-2-flash
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Rumble-2-Flash: an open 0.5B speech model for 40+ languages
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/rumble-2-flash


### Hugging Face and OpenRouter join forces to make open-weight models easy to run

- **Link:** https://huggingface.co/blog/openrouter
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Hugging Face and OpenRouter join forces to make open-weight models easy to run
kern: (skip: HF/OpenRouter partnership post)
relevance: HF/OpenRouter partnership post
```

**URL check:** https://huggingface.co/blog/openrouter


### LLMON: An LLM-Native Markup Language, now in Granite 4.1 3B and 8B

- **Link:** https://huggingface.co/blog/ibm-granite/llmon-an-llm-native-markup-language-now-in-granite
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: LLMON: An LLM-Native Markup Language, now in Granite 4.1 3B and 8B
kern: (skip: markup language post)
relevance: markup language post
```

**URL check:** https://huggingface.co/blog/ibm-granite/llmon-an-llm-native-markup-language-now-in-granite


### The Definitive Fine-Tuning Guide for 3D Generation Models

- **Link:** https://huggingface.co/blog/3d-lora-finetuning
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: The Definitive Fine-Tuning Guide for 3D Generation Models
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/3d-lora-finetuning


### BotPsy: On-Device Personal Assistant with a Sub-Billion-Parameter Agentic Language Model

- **Link:** https://huggingface.co/blog/qvac/botpsy
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: BotPsy: On-Device Personal Assistant with a Sub-Billion-Parameter Agentic Language Model
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/qvac/botpsy


### Decision Models in Hugging Face

- **Link:** https://huggingface.co/blog/decision
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Decision Models in Hugging Face
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/decision


### A Closer Look at Phonon TTS. Launching High-Quality On-Device Speech That Tops the Benchmarks.

- **Link:** https://huggingface.co/blog/phonon-tts
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: A Closer Look at Phonon TTS. Launching High-Quality On-Device Speech That Tops the Benchmarks.
kern: (skip: on-device TTS)
relevance: on-device TTS
```

**URL check:** https://huggingface.co/blog/phonon-tts


### Palette: teaching a small model to build decks in your design language

- **Link:** https://huggingface.co/blog/ibm-research/palette-deck-building
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Palette: teaching a small model to build decks in your design language
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/ibm-research/palette-deck-building


### CWE-bench v2: More coverage, quality, and transparency

- **Link:** https://huggingface.co/blog/cwe-bench
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: CWE-bench v2: More coverage, quality, and transparency
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/cwe-bench


### Transformers Model Integration Contracts

- **Link:** https://huggingface.co/blog/transformers-mic
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Transformers Model Integration Contracts
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/transformers-mic


### Granite Switch 4.1.1 — Update models like you update software

- **Link:** https://huggingface.co/blog/ibm-granite/granite-switch-4-1-1
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Granite Switch 4.1.1 — Update models like you update software
kern: (skip: model update post)
relevance: model update post
```

**URL check:** https://huggingface.co/blog/ibm-granite/granite-switch-4-1-1


### Introducing AnySpeechRecognizer and AnyDecisionModel: Open Models for Speech and Decisions on Apple Platforms

- **Link:** https://huggingface.co/blog/anydecisionmodel
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Introducing AnySpeechRecognizer and AnyDecisionModel: Open Models for Speech and Decisions on Apple Platforms
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/anydecisionmodel


### Build specialized multimodal models with LFM3

- **Link:** https://huggingface.co/blog/LiquidAI/lfm3
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Build specialized multimodal models with LFM3
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/LiquidAI/lfm3


### Does Your Model Run on AWS Trainium? Look It Up

- **Link:** https://huggingface.co/blog/torch-neuronx-model-support
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Does Your Model Run on AWS Trainium? Look It Up
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/torch-neuronx-model-support


### Turning Database Grading into RL Rewards: Post-Training Agents with ThinkingBox

- **Link:** https://huggingface.co/blog/microsoft/thinkingbox-training
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Turning Database Grading into RL Rewards: Post-Training Agents with ThinkingBox
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/microsoft/thinkingbox-training


### How Specializing the Vocabulary of SLMs Can Cut Inference Cost by 77% in Real Applications

- **Link:** https://huggingface.co/blog/Dharma-AI/vocabx-vocabulary-specialization
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Inference
title: How Specializing the Vocabulary of SLMs Can Cut Inference Cost by 77% in Real Applications
kern: (no abstract in dumps; vocabulary specialization cuts inference cost)
relevance: vocabulary specialization cuts inference cost
```

**URL check:** https://huggingface.co/blog/Dharma-AI/vocabx-vocabulary-specialization


### AnyLanguageModel 1.0: One Year of Local Models on Apple Platforms

- **Link:** https://huggingface.co/blog/anylanguagemodel-1-0
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: AnyLanguageModel 1.0: One Year of Local Models on Apple Platforms
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/anylanguagemodel-1-0


### TorchNeuron: running HF models on AWS Trainium is easier than ever

- **Link:** https://huggingface.co/blog/hf-torchneuron
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: TorchNeuron: running HF models on AWS Trainium is easier than ever
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://huggingface.co/blog/hf-torchneuron


### Welcome Beam: a 501B open model you can own, customize, and scale

- **Link:** https://huggingface.co/blog/reflection-beam
- **Source:** HF blog · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Welcome Beam: a 501B open model you can own, customize, and scale
kern: (skip: open model announcement)
relevance: open model announcement
```

**URL check:** https://huggingface.co/blog/reflection-beam


### Context Scaling: A New Frontier of AI Scaling

- **Link:** https://arxiv.org/abs/2611.33160
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Context Scaling: A New Frontier of AI Scaling
kern: (no abstract in dumps; context scaling)
relevance: context scaling
```

**URL check:** https://arxiv.org/abs/2611.33160


### Constraint-Aware Test-Time Scoring for LLM and VLM Candidate Selection

- **Link:** https://arxiv.org/abs/2611.33161
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Constraint-Aware Test-Time Scoring for LLM and VLM Candidate Selection
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33161


### Attributing Agentic Failure in Reasoning Vision-Language Models with Interactive 2D Environments

- **Link:** https://arxiv.org/abs/2611.33162
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Attributing Agentic Failure in Reasoning Vision-Language Models with Interactive 2D Environments
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33162


### Quantum Machine Learning for Signature Forgery Detection

- **Link:** https://arxiv.org/abs/2611.33163
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Quantum Machine Learning for Signature Forgery Detection
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33163


### AutoformBench: A Lean Formalization Benchmark for Advanced Mathematics

- **Link:** https://arxiv.org/abs/2611.33165
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: AutoformBench: A Lean Formalization Benchmark for Advanced Mathematics
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33165


### Feature-Based Explainability of Transformer Scoring Models: A Fidelity-First Framework for Automated Writing Assessment

- **Link:** https://arxiv.org/abs/2611.33175
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Feature-Based Explainability of Transformer Scoring Models: A Fidelity-First Framework for Automated Writing Assessment
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33175


### Psychophysics of Duration Perception in Multimodal Large Language Models

- **Link:** https://arxiv.org/abs/2611.33176
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Psychophysics of Duration Perception in Multimodal Large Language Models
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33176


### Deep Learning-Based Mesoscopic Emission Modeling

- **Link:** https://arxiv.org/abs/2611.33179
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Deep Learning-Based Mesoscopic Emission Modeling
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33179


### General-Purpose Decision Models for AI Configuration Tuning

- **Link:** https://arxiv.org/abs/2611.33190
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: General-Purpose Decision Models for AI Configuration Tuning
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33190


### Verified experience improves materials prediction with large language models

- **Link:** https://arxiv.org/abs/2611.33195
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Verified experience improves materials prediction with large language models
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33195


### Extraneous Cognitive Load in Large Language Models

- **Link:** https://arxiv.org/abs/2611.33197
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Extraneous Cognitive Load in Large Language Models
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33197


### KiRA: Kronecker Input-Gated Rank Adaptation for Parameter-Efficient Fine-Tuning of Pretrained Models

- **Link:** https://arxiv.org/abs/2611.33236
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: KiRA: Kronecker Input-Gated Rank Adaptation for Parameter-Efficient Fine-Tuning of Pretrained Models
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33236


### Sequential Testing on Complex and High Dimensional Data Streams Leveraging Unsupervised Model Errors

- **Link:** https://arxiv.org/abs/2611.33238
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Sequential Testing on Complex and High Dimensional Data Streams Leveraging Unsupervised Model Errors
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33238


### One Token, Many Lessons: Sliding-Window Attention within Gated Delta Networks

- **Link:** https://arxiv.org/abs/2611.33257
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: One Token, Many Lessons: Sliding-Window Attention within Gated Delta Networks
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33257


### What, Who, and When: Structured Harm Assessment for Mental Health Safety via Short Reasoning

- **Link:** https://arxiv.org/abs/2611.33263
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: What, Who, and When: Structured Harm Assessment for Mental Health Safety via Short Reasoning
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33263


### Two Timescales of Forgetting in Fine-tuning of Language Models: Fast Behavioral Suppression and Slow Representational Drift

- **Link:** https://arxiv.org/abs/2611.33302
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Two Timescales of Forgetting in Fine-tuning of Language Models: Fast Behavioral Suppression and Slow Representational Drift
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33302


### Certify What You Plant: Shortcut-Free Proof Depth in Logical Reasoning Data

- **Link:** https://arxiv.org/abs/2611.33303
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Certify What You Plant: Shortcut-Free Proof Depth in Logical Reasoning Data
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33303


### The Platonic Representation Hypothesis in Jacobian-Space: Language and Vision Models Agree Approximately Up to a Rotation

- **Link:** https://arxiv.org/abs/2611.33304
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: The Platonic Representation Hypothesis in Jacobian-Space: Language and Vision Models Agree Approximately Up to a Rotation
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33304


### Change Partners at Every Layer: Balanced Random Regrouping for Model Merging

- **Link:** https://arxiv.org/abs/2611.33308
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Change Partners at Every Layer: Balanced Random Regrouping for Model Merging
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33308


### Brand Recall and Category Accuracy in Language Models: An Audit of 1,000 B2B SaaS Brands

- **Link:** https://arxiv.org/abs/2611.33322
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Brand Recall and Category Accuracy in Language Models: An Audit of 1,000 B2B SaaS Brands
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33322


### Sparse Adaptation for In-Context Learning on Data Streams

- **Link:** https://arxiv.org/abs/2611.33325
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Sparse Adaptation for In-Context Learning on Data Streams
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33325


### FlowersBench: A FluidFlower-Inspired Dataset for Benchmarking Carbon Storage Surrogates Across Geological Structures

- **Link:** https://arxiv.org/abs/2611.33335
- **Source:** rss AI+LG+CL · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: FlowersBench: A FluidFlower-Inspired Dataset for Benchmarking Carbon Storage Surrogates Across Geological Structures
kern: (skip: carbon storage surrogates)
relevance: carbon storage surrogates
```

**URL check:** https://arxiv.org/abs/2611.33335


### What Must LLM Agents Communicate? From Information Loss to Communication Failures

- **Link:** https://arxiv.org/abs/2611.33318
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: What Must LLM Agents Communicate? From Information Loss to Communication Failures
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33318


### When Are Parallel Subagents Effective for Coding? An Empirical Study on Repository Construction

- **Link:** https://arxiv.org/abs/2611.33893
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Graph Engineering
title: When Are Parallel Subagents Effective for Coding? An Empirical Study on Repository Construction
kern: (no abstract in dumps; parallel subagents effectiveness)
relevance: parallel subagents effectiveness
```

**URL check:** https://arxiv.org/abs/2611.33893


### PROVE: Mitigating Long-Horizon LLM Collusion with Reinforcement Learning from Verified Evidence

- **Link:** https://arxiv.org/abs/2611.34215
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: PROVE: Mitigating Long-Horizon LLM Collusion with Reinforcement Learning from Verified Evidence
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34215


### VisualMontage: Manipulating the Beliefs of Vision-Language Agents with Authentic Image Sequences

- **Link:** https://arxiv.org/abs/2611.34603
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: VisualMontage: Manipulating the Beliefs of Vision-Language Agents with Authentic Image Sequences
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34603


### GRASP: Graph Agentic Search over Propositions for Multi-hop Question Answering

- **Link:** https://arxiv.org/abs/2605.16598
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: GRASP: Graph Agentic Search over Propositions for Multi-hop Question Answering
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2605.16598


### VirusCascade: Hijacking Collaborative Reflection in LLM-Powered Recommender Agents

- **Link:** https://arxiv.org/abs/2609.38270
- **Source:** rss cs.MA · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: VirusCascade: Hijacking Collaborative Reflection in LLM-Powered Recommender Agents
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2609.38270


### Building a Unified Inline Code Editing Model for GitHub Copilot

- **Link:** https://arxiv.org/abs/2611.33314
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Building a Unified Inline Code Editing Model for GitHub Copilot
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33314


### GhostAPI-V: Evaluating Audited Diagnostics for Internal API Migration Repair

- **Link:** https://arxiv.org/abs/2611.33396
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: GhostAPI-V: Evaluating Audited Diagnostics for Internal API Migration Repair
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33396


### DevEx is for Humans, AX is for Agents: Measuring Context Health in Agentic Software Work

- **Link:** https://arxiv.org/abs/2611.33480
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: DevEx is for Humans, AX is for Agents: Measuring Context Health in Agentic Software Work
kern: (no abstract in dumps; context health measurement in agentic work)
relevance: context health measurement in agentic work
```

**URL check:** https://arxiv.org/abs/2611.33480


### Evaluating More with Less: Black-Box Test Selection for AI Agents

- **Link:** https://arxiv.org/abs/2611.34617
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Evaluating More with Less: Black-Box Test Selection for AI Agents
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.34617


### Demystifying Real-world LLM Service Freeloading

- **Link:** https://arxiv.org/abs/2611.33218
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Demystifying Real-world LLM Service Freeloading
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33218


### Real Package, Wrong Controller: Static Auditing of Vendor--Protocol Mismatches in LLM-Generated PLC Code

- **Link:** https://arxiv.org/abs/2611.33227
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Real Package, Wrong Controller: Static Auditing of Vendor--Protocol Mismatches in LLM-Generated PLC Code
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33227


### How Much Effort Does an AI Code Reviewer Need? Evidence from Claude 5.5 Models on Plausible-but-Wrong Patches

- **Link:** https://arxiv.org/abs/2611.33639
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: How Much Effort Does an AI Code Reviewer Need? Evidence from Claude 5.5 Models on Plausible-but-Wrong Patches
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33639


### REFORGE: LLM-Assisted RTL Bug Repair with Structured Context and Verification Feedback

- **Link:** https://arxiv.org/abs/2611.33748
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: REFORGE: LLM-Assisted RTL Bug Repair with Structured Context and Verification Feedback
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2611.33748


### DRAFT-ing Architectural Design Decisions using LLMs

- **Link:** https://arxiv.org/abs/2504.08207
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: DRAFT-ing Architectural Design Decisions using LLMs
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2504.08207


### A Threshold Model of Fault Propagation in AI-Native Software Ecosystems

- **Link:** https://arxiv.org/abs/2604.19827
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: A Threshold Model of Fault Propagation in AI-Native Software Ecosystems
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2604.19827


### Agentic Model Checking

- **Link:** https://arxiv.org/abs/2605.21434
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Agentic Model Checking
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2605.21434


### AiFlow: Construction-to-Retirement Conformance for Versioned LLM Services

- **Link:** https://arxiv.org/abs/2608.00558
- **Source:** rss cs.SE · **triage:** keep
- **Theme (proposed):** ? uncertain _(uncertain)_
- **Abstract:** _not found in dumps — read the link before accepting_

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: AiFlow: Construction-to-Retirement Conformance for Versioned LLM Services
kern: (skip: no abstract captured)
relevance: no abstract captured
```

**URL check:** https://arxiv.org/abs/2608.00558

