# Promote drafts — 2026-W48 — Ship quality

> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).
> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK=2026-W48`.
### HarnessRisk: A Lifecycle-Oriented Benchmark for Agent Harness Safety

- **Link:** https://arxiv.org/abs/2608.17597
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** HarnessRisk evaluates agent harness safety across six operational phases, revealing that configuration vulnerabilities and detection gaps allow high attack success despite preserved utility.
- **Abstract:** Large language models are increasingly deployed through agent harnesses that manage tools, extensions, persistent state, permissions, and external actions. Existing safety benchmarks mainly target individual attack mechanisms or a limited subset of operational settings, making it difficult to compare how safety failures emerge across different harness responsibilities. We present HarnessRisk, a lifecycle oriented benchmark that organizes agent harness safety into six operational phases including Harness Configuration, Capability Extension, Runtime Operation, State Persistence, Action Control,…
- **Upvotes:** 11

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: HarnessRisk: A Lifecycle-Oriented Benchmark for Agent Harness Safety
kern: HarnessRisk evaluates agent harness safety across six operational phases, revealing that configuration vulnerabilities and detection gaps allow high attack success despite preserved utility.
relevance: harness safety across lifecycle
```

**URL check:** https://arxiv.org/abs/2608.17597


### Forgetting is Not Always Bad: A Neuro-Inspired Memory Repair Mechanism for Poisoned LLM Agents

- **Link:** https://arxiv.org/abs/2610.13267
- **Source:** HF q:token · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** DREAM is a training-free framework that selectively suppresses poisoned memories in LLM agents via reactivation-based repair, reducing backdoor success by over 95% with lower overhead.
- **Abstract:** Large language model (LLM) agents are highly vulnerable to memory-poisoning attacks. Existing defenses primarily rely on external modules for either static memory isolation or continuous online auditing, resulting in low memory efficiency and high computational overhead. To address these limitations, inspired by neuroscientific mechanisms that weak reactivation can destabilize memories and induce decay in the absence of reinforcement, we propose an agent-intrinsic training-free memory repair framework, DREAM (Dynamic Reactivation for Engram Attenuation in Memory), that enables selective funct…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Forgetting is Not Always Bad: A Neuro-Inspired Memory Repair Mechanism for Poisoned LLM Agents
kern: DREAM is a training-free framework that selectively suppresses poisoned memories in LLM agents via reactivation-based repair, reducing backdoor success by over 95% with lower overhead.
relevance: memory repair against poisoning
```

**URL check:** https://arxiv.org/abs/2610.13267


### Exploited Before It Was Fixed? Vulnerability Timelines from Open, Machine-Readable Evidence

- **Link:** https://arxiv.org/abs/2611.22479
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** -05-X-03), Known Exploited Vulnerabilities (KEV) catalogs, and exploitation sightings. We introduce an evidence model implemented in Vulnerability-Lookup that selects the earliest evidence for each lifecycle event, distinguishes vulnerability-specific records, preserves date precision, and ensures traceability to original sources. Among 3,758 vulnerability identifiers with exploitation evidence, 98% have disclosure dates, while only 15.7% have patch evidence. Vendor-side dates required by VTEM are entirely absent. Most exploitation dates originate from catalog listings, including 1,041 entrie…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Exploited Before It Was Fixed? Vulnerability Timelines from Open, Machine-Readable Evidence
kern: (skip: CVE/KEV timeline construction)
relevance: CVE/KEV timeline construction
```

**URL check:** https://arxiv.org/abs/2611.22479


### Embodied AI Fails the Mirror Test: How a Simple Mirror Breaks Robot Policies

- **Link:** https://arxiv.org/abs/2611.33010
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** A new benchmark shows that many robot manipulation policies perform worse when mirrors are present, often because they confuse reflections with real objects rather than simply colliding with the mirror.
- **Abstract:** Can a simple mirror expose the limitations of today's robotic manipulation policies? Inspired by the mirror self-recognition test in animal cognition, we investigate whether robot policies can reliably manipulate physical objects in scenes containing their reflections. We introduce RoboDojo-Mirror, a benchmark built on RoboDojo that preserves task objectives, success criteria, and policy checkpoints while comparing a mirror-free baseline with single-mirror, dual-mirror, and mirrored-tabletop conditions. Across five policies spanning Vision-Language-Action models, World Action Models, and agen…
- **Upvotes:** 32

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Embodied & Physical AI
title: Embodied AI Fails the Mirror Test: How a Simple Mirror Breaks Robot Policies
kern: A new benchmark shows that many robot manipulation policies perform worse when mirrors are present, often because they confuse reflections with real objects rather than simply colliding with the mirror.
relevance: mirror test breaks robot policies
```

**URL check:** https://arxiv.org/abs/2611.33010


### LingSante MedGuard Technical Report

- **Link:** https://arxiv.org/abs/2611.25509
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** As medical AI is increasingly used for patient consultation and clinical decision support, identifying harmful, non-compliant, or ethically problematic responses is essential for responsible deployment. Assessing these risks requires checking clinical claims against relevant evidence, verifying calculations, and applying medical requirements under their intended conditions. We introduce LingSante MedGuard, a capability-enhanced guardrail that integrates supervision from a medical guardrail teacher model and six specialized medical capability experts into a unified model. The guardrail teacher…
- **Upvotes:** 30

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: LingSante MedGuard Technical Report
kern: (skip: medical guard)
relevance: medical guard
```

**URL check:** https://arxiv.org/abs/2611.25509


### GRAPE-Bench: When Vision Degrades, Does Video Reasoning Hold?

- **Link:** https://arxiv.org/abs/2611.33020
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** GRAPE-Bench jointly evaluates video reasoning under visual degradation and question difficulty, exposing model weaknesses and enabling improvement and control.
- **Abstract:** Despite strong performance on standard benchmarks, video reasoning models remain vulnerable to visual degradation, raising concerns about their reliability in safety-critical scenarios. Existing benchmarks address this concern in part by simulating visual degradation or probing model reasoning with challenging questions, leaving open how well models handle naturally degraded video and whether they can make the simpler judgments that matter for safe driving. To this end, we introduce GRAPE-Bench, which jointly evaluates video reasoning across visual degradation conditions and question difficul…
- **Upvotes:** 4

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Vision, docs & perception
title: GRAPE-Bench: When Vision Degrades, Does Video Reasoning Hold?
kern: GRAPE-Bench jointly evaluates video reasoning under visual degradation and question difficulty, exposing model weaknesses and enabling improvement and control.
relevance: video reasoning under degradation
```

**URL check:** https://arxiv.org/abs/2611.33020


### A Survey of Security, Privacy, and Ethics of Large Language Models in Telecom

- **Link:** https://arxiv.org/abs/2611.34868v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** Large Language Models (LLMs) are increasingly integrated into telecommunications for customer service, network analytics, and operational support. While offering efficiency and innovation, their deployment raises critical privacy, security, and ethical challenges due to the uniquely sensitive and longitudinal nature of telecom data. This paper presents a survey of LLM risks and safeguards in telecom context. Our survey introduces a telecom-specific taxonomy linking privacy, security, and ethics with use cases and outlines open research challenges such as longitudinal data privacy, cross-borde…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: A Survey of Security, Privacy, and Ethics of Large Language Models in Telecom
kern: (skip: telecom LLM survey)
relevance: telecom LLM survey
```

**URL check:** https://arxiv.org/abs/2611.34868v1


### VulnSafe: Measuring Vulnerability-Aware Relational Safety in Large Language Models

- **Link:** https://arxiv.org/abs/2611.34819v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** Emotionally supportive interactions require large language models not only to avoid overtly harmful content, but also to recognize vulnerability-related risk, regulate their relational stance, preserve user agency, and provide context-appropriate support. Existing safety benchmarks often measure isolated violations, leaving unclear what underlying response competence their scores represent. We introduce VulnSafe, a Chinese capability assessment centered on Vulnerability-Aware Response Competence (VARC). VARC organizes relational safety into five complementary constructs: Risk Perception, Safe…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: VulnSafe: Measuring Vulnerability-Aware Relational Safety in Large Language Models
kern: (skip: relational safety)
relevance: relational safety
```

**URL check:** https://arxiv.org/abs/2611.34819v1


### Deep Reinforcement Learning for Multi-UAV Data Harvesting Under Variable Team Sizes and Agent Loss

- **Link:** https://arxiv.org/abs/2611.34818v1
- **Source:** api recent · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** Collecting data from wireless sensors can be challenging when limited communication infrastructure prevents them from offloading their measurements. In such settings, unmanned aerial vehicles (UAVs) can exploit their mobility to harvest data locally, while coordinated UAV teams can provide efficient and redundant coverage of remote areas. Multi-agent reinforcement learning (MARL) enables such teams to learn decentralized coordination policies. However, training separate policies for different team and sensor populations is costly, and fixed-population policies may be vulnerable to agent failu…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: Deep Reinforcement Learning for Multi-UAV Data Harvesting Under Variable Team Sizes and Agent Loss
kern: (skip: UAV data harvesting)
relevance: UAV data harvesting
```

**URL check:** https://arxiv.org/abs/2611.34818v1


### VibeVideoAgent: Closing the Perceptual Loop for Code-Driven Video Generation

- **Link:** https://arxiv.org/abs/2611.34237
- **Source:** HF day · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** Code-driven video generation asks a coding agent to write and run rendering programs. This gives exact control over typography, data visualizations, synchronized audio, and multi-shot scenes, and it leaves an editable project behind. A program that exits cleanly can still render overlapping labels, a camera aimed away from its subject, broken object interactions, or narration that drifts out of sync, and none of these raise a runtime error. Feeding rendered frames and audio back into the coding session bloats its long-horizon context, while critiquing only the finished full-resolution render…
- **Upvotes:** 49

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: skip
theme: 
title: VibeVideoAgent: Closing the Perceptual Loop for Code-Driven Video Generation
kern: (skip: code-driven video generation)
relevance: code-driven video generation
```

**URL check:** https://arxiv.org/abs/2611.34237


### Safe, Persistent, and Evolving Agent Harness for Understanding Partially Observable Worlds

- **Link:** https://arxiv.org/abs/2610.11552
- **Source:** HF q:harness · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** A multi-agent execution framework with policy checks, persistent state, and abductive rule discovery improves safe task completion in enterprise and scientific workflows across several language models.
- **Abstract:** Large language model agents can invoke tools fluently, but enterprise workflows demand more than selecting the right tools: actions must strictly comply with organizational policies, tool feedback often conceals hidden side effects under partial observability, and long-horizon tasks require persistent state tracking across multiple records. To address these challenges, we introduce E-Ledger, a multi-agent harness for safe and persistent execution. E-Ledger employs a code approval layer that checks every proposed action against policy before execution, and maintains a world ledger of verified…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Safe, Persistent, and Evolving Agent Harness for Understanding Partially Observable Worlds
kern: A multi-agent execution framework with policy checks, persistent state, and abductive rule discovery improves safe task completion in enterprise and scientific workflows across several language models.
relevance: safe persistent evolving harness
```

**URL check:** https://arxiv.org/abs/2610.11552


### Coda: Exploiting Admission Flexibility for Coding-Agent Serving

- **Link:** https://arxiv.org/abs/2610.03088
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** Coda improves coding-agent serving by using readiness-informed admission and routing to align reusable KV states and compatible context lengths, boosting throughput and SLO compliance.
- **Abstract:** Coding agents powered by large language models (LLMs) repeatedly alternate between model inference and tool calls, creating long-lived sessions with reusable key-value (KV) states and asynchronous request resumptions. Logical readiness, however, does not ensure efficient admission in a shared serving system. Through direct trace analysis and trace-driven replay, we identify two mismatches: reusable KV states reside across storage tiers and incur unequal computational costs for state preparation, while requests with heterogeneous context lengths can decode inefficiently together. Our central i…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Inference
title: Coda: Exploiting Admission Flexibility for Coding-Agent Serving
kern: Coda improves coding-agent serving by using readiness-informed admission and routing to align reusable KV states and compatible context lengths, boosting throughput and SLO compliance.
relevance: coding-agent serving; KV reuse
```

**URL check:** https://arxiv.org/abs/2610.03088


### Step-Zero Attack: Agent Safety Before Observability

- **Link:** https://arxiv.org/abs/2611.01953
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** Existing attacks and defenses for coding agents act once content enters the model context: injected text persuades the model, and guards inspect what the model reads. Yet to judge whether processing an unknown archive, network response, or image is safe, an agent often must process it first, and that step can do harm before any content reaches the model. We call this first processing Step Zero, and harm done by it a Step-Zero attack. Across seven harnesses and six models, each agent received only a path or URL to a crafted input, paired with a benign twin showing the same visible fields. Step…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Step-Zero Attack: Agent Safety Before Observability
kern: Existing attacks and defenses for coding agents act once content enters the model context: injected text persuades the model, and guards inspect what the model reads. Yet to judge whether processing an unknown archive, network response, or image is safe, an agent often must process it first, and that step can do harm…
relevance: attacks before observability
```

**URL check:** https://arxiv.org/abs/2611.01953


### Acquiring and Verifying Repository Norms for Coding Agents

- **Link:** https://arxiv.org/abs/2610.07757
- **Source:** HF q:agentctx · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** RepoNorm extracts repository-specific contribution norms from source and version history to improve coding agent compliance without altering task prompts.
- **Abstract:** Changes produced by coding agents can pass functional tests while leaving repository contribution requirements unmet. Following repository-specific norms requires identifying guidance dispersed across repository sources and interpreting its conditions and exceptions. Retrieval and documentation approaches supply general context, but agents must still determine which norms apply. We introduce RepoNorm to acquire explicit and implicit repository norms independently of coding tasks. It checks norm content and applicability using repository evidence, consults Git history when needed, and delivers…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent-docs & docs-architectuur
title: Acquiring and Verifying Repository Norms for Coding Agents
kern: RepoNorm extracts repository-specific contribution norms from source and version history to improve coding agent compliance without altering task prompts.
relevance: repository norms for coding agents
```

**URL check:** https://arxiv.org/abs/2610.07757


### Soei: Structured Observability of Evidence and Intent for Multi-Agent AI Software Engineering

- **Link:** https://arxiv.org/abs/2610.39468
- **Source:** HF q:tokencost · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Abstract:** AI coding agents now do long, multi-step and multi-session software work with little supervision. When a developer comes back to that work, the useful question is not what the model said but what was actually done, by whom, and whether it is finished. We study this in three parts. First, we verify Agenttrail, an open-source local observability tool for coding agents, against its source at commit e4ba2da: nine documented constants and mechanisms hold at file-and-line level, two event pipelines are never unified, and its Map service has an unauthenticated local mutation surface. Second, we run…
- **Upvotes:** 1

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: Soei: Structured Observability of Evidence and Intent for Multi-Agent AI Software Engineering
kern: AI coding agents now do long, multi-step and multi-session software work with little supervision. When a developer comes back to that work, the useful question is not what the model said but what was actually done, by whom, and whether it is finished. We study this in three parts. First, we verify Agenttrail, an…
relevance: observability of evidence and intent
```

**URL check:** https://arxiv.org/abs/2610.39468


### Same Bytes, Different Authority: Reserved-Token Representations in Chat-Template Prompt Injection

- **Link:** https://arxiv.org/abs/2609.35932
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** Reserved control tokens in chat templates significantly amplify prompt injection attacks against LLM agents compared to equivalent subword sequences, with instruction tuning reinforcing this vulnerability and standard tokenizer mitigations failing to protect tool-protocol channels.
- **Abstract:** Prompt injection against LLM agents becomes much stronger when the injected instruction is wrapped in the model's own chat template. A forged template marker such as <|im_start|> can reach the model either as a single reserved control token or as a sequence of ordinary subword tokens. The two decode to exactly the same text, and because tokenization runs on the server, the defender rather than the attacker decides which one the model receives. We use this to measure how much of the injected instruction's authority comes from the reserved token's learned representation. Encoding the forged mar…
- **Upvotes:** 6

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Agent Safety
title: Same Bytes, Different Authority: Reserved-Token Representations in Chat-Template Prompt Injection
kern: Reserved control tokens in chat templates significantly amplify prompt injection attacks against LLM agents compared to equivalent subword sequences, with instruction tuning reinforcing this vulnerability and standard tokenizer mitigations failing to protect tool-protocol channels.
relevance: reserved tokens amplify prompt injection
```

**URL check:** https://arxiv.org/abs/2609.35932


### ContractBench: Can LLM Agents Preserve Observation Contracts?

- **Link:** https://arxiv.org/abs/2605.17281
- **Source:** HF q:toolout · **triage:** keep
- **Theme (proposed):** Ship quality _(kw)_
- **Gist (HF ai_summary):** Observation contract compliance in tool-augmented LLM agents is an emergent, regression-prone capability evaluated via ContractBench, revealing significant failure rates across frontier models and non-monotonic scaling behaviors.
- **Abstract:** Tool-augmented LLM agents call APIs whose intermediate outputs, such as presigned URLs, session tokens, and OAuth state parameters, are observation contracts: artifacts whose later use is constrained by the external system that produced them. We show that observation contract compliance (preserving the temporal validity and byte-level integrity) is an emergent, regression-prone capability: it is neither guaranteed by general tool-use ability nor consistently improved by larger or newer models. To measure this, we introduce ContractBench, a benchmark of 33 dual-axis tasks that probe two orthog…

**Agent: fill in before accepting**

```yaml
# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)
decision: accept
theme: Ship quality
title: ContractBench: Can LLM Agents Preserve Observation Contracts?
kern: Observation contract compliance in tool-augmented LLM agents is an emergent, regression-prone capability evaluated via ContractBench, revealing significant failure rates across frontier models and non-monotonic scaling behaviors.
relevance: observation contract compliance
```

**URL check:** https://arxiv.org/abs/2605.17281

