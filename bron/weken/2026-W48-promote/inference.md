# Promote drafts — 2026-W48 — Inference

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### Subquadratic Attention with a Hierarchical Tree-Structured Indexer

- **Link:** https://arxiv.org/abs/2610.42112
- **Source:** HF q:agentic · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** Zyphra Hierarchical Attention uses a tree-structured index over compressed key summaries to achieve subquadratic attention scaling for long-context language models.
- **Abstract:** The quadratic scaling of attention is a fundamental bottleneck limiting the long-context capabilities of large language models (LLMs). A variety of approaches have attempted to circumvent this, but they either fail to match attention's expressiveness (e.g., sliding-window or linear attention variants with fixed-size state) or only achieve constant-factor speedups (e.g., sparse attention methods whose indexers themselves scale quadratically). In this paper, we derive an asymptotically subquadratic sparse attention method based on a hierarchical, tree-structured indexer, which we call Zyphra Hi…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Subquadratic Attention with a Hierarchical Tree-Structured Indexer
kern: Zyphra Hierarchical Attention uses a tree-structured index over compressed key summaries to achieve subquadratic attention scaling for long-context language models.
relevance: subquadratic attention indexer
```

**URL check:** https://arxiv.org/abs/2610.42112


### Cache Engineering for Agents

- **Link:** https://arxiv.org/abs/2610.28577
- **Source:** HF q:context · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** AKV introduces cache engineering to manage LLM agent key-value caches without altering trajectories, improving efficiency and accuracy via drop and repos operations with a co-designed serving engine.
- **Abstract:** Large Language Model (LLM) agents can handle increasingly complex tasks, navigating long trajectories of observations and actions. As these trajectories grow, key-value (KV) cache I/O and storage become the dominant cost. Trajectories can also exceed the LLM's maximum context length, requiring control over active cache growth. Prior work uses context engineering to reduce cache size by trimming or summarizing history. However, modifying the trajectory prefix invalidates subsequent cached states and triggers costly re-prefilling of retained context. Task accuracy can also suffer when too littl…
- **Upvotes:** 104

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: Cache Engineering for Agents
kern: AKV introduces cache engineering to manage LLM agent key-value caches without altering trajectories, improving efficiency and accuracy via drop and repos operations with a co-designed serving engine.
relevance: KV-cache engineering for agents
```

**URL check:** https://arxiv.org/abs/2610.28577


### ReFold: Training-Free Reversible Inter-Turn Context Folding for Long-Horizon Agents

- **Link:** https://arxiv.org/abs/2610.07863
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** ReFold is a training-free rendering layer that compresses rendered context for long-horizon LLM agents by reversibly removing redundant content, reducing token usage and memory without degrading success rates.
- **Abstract:** Long-horizon LLM agents act on an append-only interaction history that is re-sent to the model at every step, so the context and its cost grow with steps until the sessions exceed the context window. Existing methods manage the context through context requirement prediction, relying on additional model calls, heuristic rules, or trained policies. However, these predictive approaches introduce runtime overhead, invalidate prefix caches, and permanently discard content with no guarantee of recovery. To overcome these limitations, we introduce ReFold: a training-free rendering layer that preserv…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Context Engineering
title: ReFold: Training-Free Reversible Inter-Turn Context Folding for Long-Horizon Agents
kern: ReFold is a training-free rendering layer that compresses rendered context for long-horizon LLM agents by reversibly removing redundant content, reducing token usage and memory without degrading success rates.
relevance: reversible context folding
```

**URL check:** https://arxiv.org/abs/2610.07863


### MemOnce: A Scalable Memory Architecture for Large Language Models

- **Link:** https://arxiv.org/abs/2611.27973
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Abstract:** Deploying large language models (LLMs) in long-horizon and continual interactions requires maintaining reusable memory states for future inference, posing challenges for existing architectures. Standard Transformers accumulate layer-wise, token-level KV caches, incurring linear GPU memory growth and quadratic computational complexity as the context expands. In contrast, linear-time architectures compress history into fixed-size states, but struggle to retain fine-grained details. We introduce MemOnce, a foundation architecture that learns scalable memory states for language models. MemOnce is…
- **Upvotes:** 30

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: MemOnce: A Scalable Memory Architecture for Large Language Models
kern: Deploying large language models (LLMs) in long-horizon and continual interactions requires maintaining reusable memory states for future inference, posing challenges for existing architectures. Standard Transformers accumulate layer-wise, token-level KV caches, incurring linear GPU memory growth and quadratic…
relevance: scalable memory architecture
```

**URL check:** https://arxiv.org/abs/2611.27973


### Beam Model Technical Report

- **Link:** https://arxiv.org/abs/2611.26358
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** Beam is a sparse Mixture-of-Experts language model optimized for coding, reasoning, and agentic workloads, using large-scale asynchronous reinforcement learning, long-context midtraining, quantization, and speculative decoding to deliver strong reasoning and safety with efficient inference.
- **Abstract:** Beam is a sparse Mixture-of-Experts (MoE) model with 501.3B total parameters and 23.4B active parameters, specifically built and optimized for coding, reasoning, and agentic workloads. Beam delivers frontier level reasoning, while requiring 3-4x less inference compute than many models of its class. Pretrained on 23.8T diverse, curated, high-quality tokens, Beam features a 1M-token context window achieved through a novel two-stage midtraining phase, built on verifiable, correctness-anchored data. Post-training leveraged a large-scale, fully asynchronous reinforcement learning (RL) campaign acr…
- **Upvotes:** 21

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Industrie
title: Beam Model Technical Report
kern: Beam is a sparse Mixture-of-Experts language model optimized for coding, reasoning, and agentic workloads, using large-scale asynchronous reinforcement learning, long-context midtraining, quantization, and speculative decoding to deliver strong reasoning and safety with efficient inference.
relevance: sparse MoE for agentic workloads
```

**URL check:** https://arxiv.org/abs/2611.26358


### Don't Sleep, Keep Watch: Proactive Perception for Computer-Use Agents

- **Link:** https://arxiv.org/abs/2611.28947
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** NightWatch adds a lightweight streaming watcher to vision-language computer-use agents to keep perception synchronized with dynamic interfaces, reducing latency and wasted time while maintaining or improving task success.
- **Abstract:** Computer-use agents (CUAs) built on vision-language models are increasingly entrusted with long-horizon tasks in live desktop, web, and mobile environments, where the screen keeps changing on its own. However, current CUAs lack real-time situational awareness: they perceive the environment through discrete snapshots, and the substantial inference latency of VLMs, compounded by highly dynamic interfaces, opens a perception-action gap in which the observed state frequently becomes stale before the corresponding action is executed. To bridge this gap, we present NightWatch, a plug-and-play frame…
- **Upvotes:** 100

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Don't Sleep, Keep Watch: Proactive Perception for Computer-Use Agents
kern: NightWatch adds a lightweight streaming watcher to vision-language computer-use agents to keep perception synchronized with dynamic interfaces, reducing latency and wasted time while maintaining or improving task success.
relevance: proactive perception for computer-use agents
```

**URL check:** https://arxiv.org/abs/2611.28947


### On-Policy Codec Distillation for Efficient All-in-One Video Generation

- **Link:** https://arxiv.org/abs/2611.31184
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Abstract:** Modern visual generative models operate on tokens, and every visual asset they receive, whether an identity, a scribble, a depth map, or a motion video, is tokenized and appended to the input token sequence. Consequently, conditioning quickly dominates the computation cost. Yet most of these tokens carry redundant spatiotemporal information. Our key insight is that identifying what is genuinely new is exactly the problem that classical video codecs have long solved. Thus, we first introduce a codec-based token pruning method that discards redundant tokens. Then, we propose an on-policy self-d…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: On-Policy Codec Distillation for Efficient All-in-One Video Generation
kern: (skip: video codec distillation)
relevance: video codec distillation
```

**URL check:** https://arxiv.org/abs/2611.31184


### Mixture-of-Loops Transformer

- **Link:** https://arxiv.org/abs/2611.34923v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** A Mixture-of-Loops Transformer reuses key-value memory across loops and depths, and its U-shaped variant improves pretraining efficiency and inference latency.
- **Abstract:** Looped Transformers boost expressivity by reusing shared layers across loops, yet at the cost of efficiency. Pushing their expressivity-efficiency frontier requires rethinking the core mechanism connecting adjacent loops: What should be passed as a Transformer loops? We introduce Mixture-of-Loops Transformer (MoLT), whose Mixture-of-Loops Attention (MoLA) uses keys and values (KV) as memory for selective reuse across depths and loops. Under loop residual, MoLT-R retains the residual stream and reads local KV across loops for expressivity. Under loop KV, MoLT-KV instead restarts from embedding…
- **Upvotes:** 44

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: Mixture-of-Loops Transformer
kern: A Mixture-of-Loops Transformer reuses key-value memory across loops and depths, and its U-shaped variant improves pretraining efficiency and inference latency.
relevance: mixture-of-loops transformer
```

**URL check:** https://arxiv.org/abs/2611.34923v1


### LoopTitan: What Does Parameter Revisit Buy a Mixture-of-Experts?

- **Link:** https://arxiv.org/abs/2611.34821v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Abstract:** Looped Mixture-of-Experts (MoE) architectures revisit layer parameters across depths. This design increases effective depth without adding parameters. Recent looped MoE studies report substantial gains over the standard MoE at matched budgets (parameters, FLOPs and KV cache). However, the reported gains still confound parameter revisit with other design choices, e.g., network shape and residual scale. We ask, what does parameter revisit itself buy? Using matched non-revisit controls, we find that parameter revisit itself buys almost nothing. We argue that revisit only offers a freedom an MoE…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Model internals
title: LoopTitan: What Does Parameter Revisit Buy a Mixture-of-Experts?
kern: Looped Mixture-of-Experts (MoE) architectures revisit layer parameters across depths. This design increases effective depth without adding parameters. Recent looped MoE studies report substantial gains over the standard MoE at matched budgets (parameters, FLOPs and KV cache). However, the reported gains still…
relevance: looped MoE; parameter revisit
```

**URL check:** https://arxiv.org/abs/2611.34821v1


### LiveVAE: Causal Window Attention Makes Efficient Streaming Video VAE

- **Link:** https://arxiv.org/abs/2611.34912
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Abstract:** While video diffusion models have grown faster and increasingly streamable, the video VAE remains a primary latency bottleneck across interactive generation and editing pipelines. Existing VAEs and their acceleration methods rely mainly on heavy convolutions or full frame attention, and most focus only on decoding, leaving encoding costly for streaming conditional generation and editing. This raises a natural question: Do video VAE encoding and decoding actually require such global spatiotemporal modeling? By analyzing the effective receptive fields of pretrained video VAEs, we find that both…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: LiveVAE: Causal Window Attention Makes Efficient Streaming Video VAE
kern: (skip: streaming video VAE)
relevance: streaming video VAE
```

**URL check:** https://arxiv.org/abs/2611.34912


### Gamer: A Generalist Vision-Language-Action Foundation Model for Long-Horizon Real-Time Game Agent

- **Link:** https://arxiv.org/abs/2611.18397
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** Gamer is a generalist agent framework that integrates perception, memory, and multi-step reasoning, trained through continued pre-training, sparse-thinking instruction tuning, and multi-turn reinforcement learning to interact efficiently in 2D and 3D environments.
- **Abstract:** We introduce Gamer, a generalist agent framework built for long-horizon tasks in complex interactive environments. Its end-to-end architecture combines perception, memory management, and multi-step reasoning. A shared training and deployment pipeline supports interaction with both conventional 2D graphical interfaces and complex 3D simulated worlds. We first continue pre-training on a dataset constructed from tens of thousands of hours of device-level keyboard and mouse interaction. These trajectories span simulated games and embodied environments, allowing the model to learn environmental dy…
- **Upvotes:** 166

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Gamer: A Generalist Vision-Language-Action Foundation Model for Long-Horizon Real-Time Game Agent
kern: Gamer is a generalist agent framework that integrates perception, memory, and multi-step reasoning, trained through continued pre-training, sparse-thinking instruction tuning, and multi-turn reinforcement learning to interact efficiently in 2D and 3D environments.
relevance: VLA foundation model for games
```

**URL check:** https://arxiv.org/abs/2611.18397


### The Other Half of the Memory Wall: Serving 35B MoEs from SSD with Trained Routing Prediction

- **Link:** https://arxiv.org/abs/2609.18063
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** Edge0 enables efficient mixture-of-experts inference on consumer hardware by predicting expert routing ahead of time and using recovery adapters to maintain quality with minimal active memory.
- **Abstract:** Mixture-of-experts (MoE) inference on consumer hardware is bounded by weight memory: a 35B-class model is 19.5GB at 4-bit, and sparsity shrinks the compute per token, not the bytes that must be held. Naive offloading to SSD does not help on its own, because layer N+1's experts must be chosen before layer N's output exists, so the reads cannot start early enough to hide behind compute. We present Edge0, a streaming MoE inference engine that closes the gap with a prerouter: a per-layer head predicts the next layer's routing one token ahead, and the prediction is consumed as the routing itself,…
- **Upvotes:** 36

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Inference
title: The Other Half of the Memory Wall: Serving 35B MoEs from SSD with Trained Routing Prediction
kern: Edge0 enables efficient mixture-of-experts inference on consumer hardware by predicting expert routing ahead of time and using recovery adapters to maintain quality with minimal active memory.
relevance: serving 35B MoE from SSD
```

**URL check:** https://arxiv.org/abs/2609.18063


### MedJev: A System One Vision-Language Decision Model for Fast and Effective Medical Image Understanding

- **Link:** https://arxiv.org/abs/2611.20992
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Abstract:** Medical image understanding with vision-language models (VLMs) typically relies on autoregressively generating reasoning and answer tokens. These unnecessary tokens make the inference cost scale with the response length and force the answer to be parsed from free-form text, incurring avoidable latency and decision errors. To this end, we introduce MedJev, a system one vision-language decision model that maps medical images, questions, and candidate answers directly to decisions in a single multimodal forward pass, without any autoregressive generation process. For fast inference, MedJev remov…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: MedJev: A System One Vision-Language Decision Model for Fast and Effective Medical Image Understanding
kern: (skip: medical image VLM)
relevance: medical image VLM
```

**URL check:** https://arxiv.org/abs/2611.20992


### MovieRoll: A Systematic Framework for Rolling Out Long-Form Videos

- **Link:** https://arxiv.org/abs/2611.21339
- **Source:** HF trending · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Abstract:** Streaming video generation must sustain quality beyond the training horizon while handling self-generated history and growing cache costs. To address these challenges, we present MovieRoll, a base-to-distilled framework that connects streaming fine-tuning, long-rollout distillation, and long-horizon inference. We first establish a robust multi-step base through Window-wise Teacher Forcing (WinTF), which jointly denoises chunks at progressive noise levels with bidirectional attention within each window and causal access to preceding history. To retain historical context efficiently, hierarchic…
- **Upvotes:** 12

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: MovieRoll: A Systematic Framework for Rolling Out Long-Form Videos
kern: (skip: long-form video rollout)
relevance: long-form video rollout
```

**URL check:** https://arxiv.org/abs/2611.21339


### ActionCodec2: A Streaming Action Tokenizer

- **Link:** https://arxiv.org/abs/2611.15490
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** ActionCodec2 is a non-neural streaming action tokenizer that incrementally releases executable actions with bounded reconstruction error, uses Set-BPE to merge motion primitives, and enables VLA policies to use state feedback and VLM agents to build reusable macros.
- **Abstract:** Most action tokenizers for autoregressive vision language action (VLA) models compress motion into chunks that must be decoded in full before their actions become executable. We introduce ActionCodec2, a non-neural streaming tokenizer that releases actions incrementally while keeping trajectory reconstruction error within a prescribed tolerance. Its encoder quantizes each step relative to the decoder's reconstructed state, so the selected motion primitive corrects residual error rather than allowing errors from independently quantized increments to accumulate. Finding the smallest such primit…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: ActionCodec2: A Streaming Action Tokenizer
kern: ActionCodec2 is a non-neural streaming action tokenizer that incrementally releases executable actions with bounded reconstruction error, uses Set-BPE to merge motion primitives, and enables VLA policies to use state feedback and VLM agents to build reusable macros.
relevance: streaming action tokenizer for VLA
```

**URL check:** https://arxiv.org/abs/2611.15490


### Beyond Benchmarks: Can Small Open-Weight Models Get Real Coding Work Done?

- **Link:** https://arxiv.org/abs/2610.34241
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Inference _(kw)_
- **Gist (HF ai_summary):** Empirical studies of open-weight coding agents reveal that verified code success depends on serving setup, protocol design, and hidden behavioral checks rather than text coherence alone.
- **Abstract:** Making an open-weight language model generate text is not the same as making it finish coding work. This retrospective empirical systems experience report follows my engineering work from July to October 2026 across coding clients, model-specific serving recipes, vLLM, SGLang, llama.cpp, and MLX. Models behind a nominally compatible endpoint still differed in tool-call formatting, turn control, context behavior, cache reuse, and reliability. A served model, coherent text, executed tool calls, and code that passes independent behavioral checks proved to be distinct levels of progress. The evid…
- **Upvotes:** 8

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Industrie
title: Beyond Benchmarks: Can Small Open-Weight Models Get Real Coding Work Done?
kern: Empirical studies of open-weight coding agents reveal that verified code success depends on serving setup, protocol design, and hidden behavioral checks rather than text coherence alone.
relevance: small open-weight models on real coding work
```

**URL check:** https://arxiv.org/abs/2610.34241

