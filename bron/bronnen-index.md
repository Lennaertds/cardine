# Bronnen-index

> **Rol:** Snelle inhoudsopgave van [bronnen.md](bronnen.md): thema’s en §-nummers, zonder de volledige samenvattingen te lezen.
> **Niet hier:** de samenvattingen zelf, of de principes (zie [principes.md](principes.md)).

Indeling is **per thema** (video én geschreven door elkaar). De **vierlagen-stack** is het raamwerk; daarna kernpraktijk; daarna fundament-spiegel (Inference → Industrie). Elke § in `bronnen.md` begint met **Type** + **URL**. Diepte: [fundament/](fundament/INDEX.md). Prompt: [fundament/prompts/youtube-samenvatting.md](fundament/prompts/youtube-samenvatting.md).

`§n` = hoofdstuk in `bronnen.md` (chronologisch toegekend, vast). §1–§9 en §10–§24 zijn vast; nieuwere bronnen §25–§192. [Totaaloverzicht](bronnen.md#totaaloverzicht) bijwerken bij nieuwe bronnen.

---

## Vierlagen-stack

### 1. [Prompt Engineering](bronnen.md#prompt-engineering)

| § | Titel | Over |
|---|--------|------|
| §3 | Building Great Agent Skills | Skill-ontwerp; vermijd *Skill Hell*; triggers, pruning, *leading words* |
| §50 | Ponytail (lazy senior skill) | YAGNI-ladder, commands, benchmarks; kritiek → §51 |
| §51 | Ponytail? YAGNI! (Scott Logic) | Skill ≈ YAGNI; kwetsbare LOC-benchmarks; leer zelf sturen |
| §54 | Skills vs MCP vs RAG vs Memory (IBM) | Taxonomie: procedure / live tools / mens-docs / agent-ervaring; anti dump-context |
| §195 | Chain-of-Thought (Wei et al.) | CoT-redeneren; 2–5× outputtokens, −50–80% fouten; harness vs prompt |
| §197 | Cortex: Measurement-Gated Evolution and Pruning of Coding-Agent Skills and Rules | Cortex validates agent harness updates by replaying developer corrections, retaining only rules and skills… |
| §198 | Harness Engineering in LLM Tool Use via Agent-Native Reusable Tool Primitives | Tool Primitives and ToolFace enable robust multi-turn tool use via natural language interfaces and dynamic… |
| §199 | How Feedback-Free Self-Evolution Reshapes Agent Skills: A Systematic Study | Agent skills are documents in which experts write down procedural knowledge, and models increasingly maintain… |
| §200 | SKILL.state: Scalable Long-Horizon Agent Skills | SKILL.state replaces growing conversation histories with a mutable execution state to improve accuracy and… |
| §201 | Vision-as-a-Tool: Visual Harness for Multimodal Agentic Coding | A new Vision-as-a-Tool paradigm enables text-only and multimodal coding agents to offload or augment visual… |
| §202 | What Does Skill Lift Actually Measure? A Source-Code-Level Audit and Noise-Aware Reanalysis of SkillsBench | (no abstract in dumps; skill lift audit) |

### 2. [Context Engineering](bronnen.md#context-engineering)

| § | Titel | Over |
|---|--------|------|
| §8 | Context Engineering for AI Agents | Context rot, attention budget, Validate / Prune / Curate |
| §9 | Context Engineering in IDE's | Modulaire `/docs` in Cursor/Claude Code i.p.v. één reuzenprompt |
| §10 | Anthropic — Effective context engineering | Context als eindige grondstof; just-in-time |
| §17 | Lost in the Middle | Info in het midden van lange context presteert slechter |
| §18 | Chroma — Context Rot | Meer tokens ≠ beter, ook binnen het venster |
| §194 | LeanVec (HF/Pinecone) | Token-deduplicatie & context-compressie vóór inferentie |
| §196 | Long Contexts Empirical (Liu) | Recency bias > primacy; prefill-order; KV-cache effect |
| §52 | MemPalace | Lokale verbatim agent-memory; wings/rooms; BM25+vector; vs curated docs |
| §69 | Cursor Instant Grep | Lokale regex-index voor agent-search; embeddings-path afgebouwd; Explore-subagent |
| §70 | Cursor semantic search | Eigen embeddings; Context Bench +12.5%; keep-rate A/B; historisch t.o.v. §69 |
| §71 | Cursor secure indexing | Merkle sync, simhash reuse, content proofs; TTFR-cijfers |
| §72 | Cursor dynamic context discovery | Files-primitief; MCP −46.9% tokens; history/terminal als files |
| §146 | Hindsight (Better Stack) | Postgres+pgvector memory; fact-rewrite 5W; vs Zep/Supermemory; team-share |
| §149 | Sverklo (Groshin) | Tokens én F1 op zoekprobes; grep wint op F1 |
| §152 | Graph vs grep-then-read | 75–82% minder tokens, geen recall; orakel buiten de graaf |
| §153 | Remy — grep vs LSP | Blogkaart: juistheid bijna gelijk, tokens lopen uiteen |
| §154 | Xu — LSP en tokens-to-success | LSP bespaart op lokalisatie niet; meter is tokens bij gelijke slaagkans |
| §155 | Jevgrep (Gamal, Shaar) | Eén zoekstap, ~30% claim; één taak zou 92% van de winst dragen. Paywall |
| §159 | Bellam — graphs and embeddings | Ablatie grep / embeddings / graaf op lokalisatie; geen tokenprotocol |
| §160 | Augment SWE-bench-blog | Grep volstond voor slaagkans; embeddings voor grote of vage repos |
| §161 | Frischer-gist | Kaart van zoek- en tokenclaims; geen bewijs |
| §162 | ColGrep-Agent (LightOn/HF) | Lokale 2B search-agent; −34% tokens vs grep op zoekvragen |
| §163 | DAIR.AI weekoverzicht | o.a. *Is Grep All You Need?* (arXiv:2605.15184) |
| §164 | Aksan — rg / ast-grep / semantic | Beslisboom + tokenbudget; CoREB keyword-collapse |
| §165 | GrepAI (Bernabeu) + Reddit | Semantische CLI; auteur-bench −27,5% kost; forumalternatieven |
| §166 | Hypergrep RESEARCH.md | Index + graaf + prefetch; prior-artkaart |
| §167 | Better Call Grep (Wang e.a.) | Lexicale retrieval voor repo-level completion |
| §168 | LocAgent (Chen e.a.) | Graafgeleide lokalisatie-agent |
| §169 | SpIDER (Chaudhari e.a.) | Dense embeddings + call edges voor issues |
| §170 | Code Isn’t Memory (Bhola e.a.) | Structurele index ín de coding agent |
| §171 | SweRank (Reddy e.a.) | Issue-lokalisatie als code ranking |
| §172 | LLM Agents Can See Repos (Ma e.a.) | Repository-visibility voor agents |
| §173 | SHERLOC (Tamoyan e.a.) | Diagnostische lokalisatie; ~½ budget vóór edit |
| §174 | Jiang — iterative code graph | Issue-lokalisatie via graafzoeken |
| §175 | TokenCast (Ouyang e.a.) | Tokenforecast tijdens agentruns |
| §176 | Bai — How Do Agents Spend Money | Tokenconsumptie in agentic coding |
| §177 | Jain — code retrieval study | Verkennend overzicht retrieval in agents |
| §178 | Cao — agents as long-context | Tool-lus als long-context processor |
| §187 | SWE-bench-familie (bundel) | Java/Multimodal/Plus/Live/… PDF’s in `pdfs/` |
| §188 | Mem0 + Zep | Agent-memorylagen |
| §203 | "PRISM" Is Not All You Need: Cross-Topic Name Collisions and Scientific Paper Retrieval | Cross-topic name collisions in AI papers have risen sharply, and shared-name papers remain harder to identify… |
| §204 | AutoCompact: Learning When to Compact Context in Long-Horizon Coding Agents | AutoCompact trains coding agents to manage long-horizon context via supervised fine-tuning and reinforcement… |
| §205 | Cache Engineering for Agents | AKV introduces cache engineering to manage LLM agent key-value caches without altering trajectories,… |
| §206 | CliffCompaction: Cost-Efficient Compaction for Long-Horizon Coding Agents | CliffCompaction reduces multi-session agent costs by up to 50% through faithful truncation of original… |
| §207 | Coding Agent Memory Post-Training II: Unlocking the Memory Potential of Pre-trained File Operations for Long-Horizon Tasks via On-Policy Distillation | A single policy trained with asynchronous on-policy distillation across five long-horizon agentic… |
| §208 | Coding Agent Memory Post-training: Unlocking the Memory Potential of Pre-trained File Operations for Long-Horizon Tasks via Reinforcement Learning | Language-model agents increasingly tackle long-horizon tasks whose interaction histories exceed the model's… |
| §209 | Compress What You See, Not What You Say: Anchored Context Distillation for Latent-Observation Software Engineering Agents | LOHA and ACD compress agent interaction histories by encoding older observations as soft tokens while… |
| §210 | Context Scaling: A New Frontier of AI Scaling | (no abstract in dumps; context scaling) |
| §211 | ContextRender: From Execution Dependencies to Agent Context | ContextRender uses an execution-dependency graph and Tool-Flow Analysis to select tool results under a fixed… |
| §212 | Cost-Effective Repository Exploration for Agentic Issue Localization | Repository exploration can be delegated to lower-cost models that retain most localization quality while… |
| §213 | Decoupling Memory from Context: Structured Memory for Token-Efficient Test-Time Continual Learning | GraphMemory is a lightweight graph-based memory system that optimizes context by retrieving only relevant… |
| §214 | DevEx is for Humans, AX is for Agents: Measuring Context Health in Agentic Software Work | (no abstract in dumps; context health measurement in agentic work) |
| §215 | DiLE: Discrimination-Aware Latent-Space Learning for Universal Multimodal Embeddings | A discrimination-aware latent-space learning framework combines task guidance with on-policy retrieval… |
| §216 | Embeddings vs. Grep: Rethinking the Dense Advantage in Code Search | Code-search benchmarks show dense encoders well ahead of BM25, yet coding agents do well with grep. What does… |
| §217 | ExecRetrieval: Measuring the Functional-Correctness Gap in Code-Embedding Retrieval | ExecRetrieval evaluates whether code embeddings can distinguish correct implementations from near-identical… |
| §218 | FeatLens: Feature-Guided Dependency Retrieval for Repository-Level Code Generation | FeatLens improves repository-level code generation by using feature-guided indexing and graph expansion to… |
| §219 | GenRec: An LLM-Backed Recommendation Ranker at Netflix | Netflix's GenRec replaces engineered feature-based ranking with an LLM-driven ranker using verbalized… |
| §220 | HiVe-Mem: Interleaving Horizontal Memory Expansion and Vertical Evidence Composition for Multimodal Agents | A novel multimodal memory framework enhances long-term interaction by combining relational graph expansion of… |
| §221 | How Do AI Agents Waste Your Money? | A framework measures and validates unnecessary token use in AI agents by normalizing trajectories,… |
| §222 | Let the Fixer Decide: Training a Code Localizer from the Fixer's Likelihood | A code localizer is trained with scores from a frozen fixer via weighted supervised fine-tuning, improving… |
| §223 | MMMem: Self-Improving Agents with Task-Aware Multimodal Experience Consolidation | A task-aware multimodal memory framework consolidates experience from completed tasks using source-linked… |
| §224 | ReFold: Training-Free Reversible Inter-Turn Context Folding for Long-Horizon Agents | ReFold is a training-free rendering layer that compresses rendered context for long-horizon LLM agents by… |
| §225 | RepoAtlas: Guiding Coding Agents via Evolving Multimodal Repository Views | RepoAtlas improves repository-level issue resolution by maintaining focused, evolving multimodal views of… |
| §226 | Revisiting LLMs as Context Engineers | As large language models (LLMs) are used in more and more new tasks, context engineering becomes a… |
| §227 | Skip the Compressor: Coding Agents Fix More Issues When They Pick Whole Files | CQ2-CARE improves software issue resolution by selecting exact files to include verbatim within a token… |
| §228 | Small Agents with Semantic Search: Efficient Multilingual Code Localization | Compact specialized agents using local semantic search improve file localization accuracy and efficiency… |
| §229 | SoL-Pi: Recursively Scaling Auto-Research Loops for Efficient Agent Harness | SoL-Pi improves token efficiency in autonomous coding agents through recursive self-improvement mechanisms,… |
| §230 | StreamScout: Learning When to Look Deeper for Streaming Video Understanding | StreamScout adaptively escalates visual evidence retrieval for streaming video queries, reducing token use… |
| §231 | Switch-SWE: Do Coding Agents Hold Focus When Switching Between Unfinished Tasks? | A benchmark for resuming interrupted software tasks reveals performance drops from interleaved work, and a… |
| §232 | Tools Need Not Speak in Text: Latent Context Compression for Agents | A continuous latent context compression model for LLM agents compresses tool observations into latent tokens… |
| §233 | ToolSmith: An Automatic Tool-Generation Framework for Multimodal Search Agents | Recent multimodal search agents use reasoning, vision, and live web search across many turns to answer… |
| §234 | VideoJSON: A Minimal Harness Beats Purpose-Built Memory for Ultra-Long Video Understanding | Answering questions over days or weeks of video requires searching for scattered clues across long timelines.… |
| §235 | When the harness decides success: state that cannot be re-observed | Agent harness choices for managing context across turns significantly affect success depending on whether… |

### 3. [Harness Engineering](bronnen.md#harness-engineering)

| § | Titel | Over |
|---|--------|------|
| §5 | Harnesses in AI (Tejas Kumar) | Deterministische schil: guardrails, compressors, sandboxes |
| §11 | Anthropic — Building effective agents | Eenvoudige patronen; workflows vs agents |
| §12 | Anthropic — Claude Code best practices | Context vol = slechter; CLAUDE.md, hooks, skills |
| §19 | SWE-agent | Agent-computer interface; feedbackloops |
| §25 | Is the Agent Harness Dead? | Evolutie van harnesses; wat blijft wanneer models verbeteren |
| §30 | Why Harness is SO Expensive | *Harness tax*, roundtrips, prompt caching-economie |
| §33 | Pi Agent Framework / Negative Space | Minimale harness; TypeScript-extensies; OpenClaw |
| §73 | Cursor Composer (RL) | MoE agent-model; Cursor Bench; tool-RL in sandboxes |
| §74 | Cursor harness verbeteren | Static→dynamic; Keep Rate; tool-error taxonomy; per-model tools |
| §75 | Cursor Codex harness | Per-model tweaks; reasoning traces −30%; shell-forward; take-action |
| §76 | Pi Coding Agent (pi.dev) | Minimale TS-harness; AGENTS.md; SDK/RPC; tree sessions; packages |
| §77 | DeepSeek Harness (`dsh`) | Cordis plugins; profiles/bundles; session log = model-visible; ≠ model-§ |
| §78 | Cline | Shared core + HostProvider; Plan/Act; IDE/CLI/SDK; Apache 2.0 |
| §79 | OpenCode | Terminal-first; build/plan; permissions; AGENTS.md; anomalyco |
| §80 | Artificial Analysis Coding Agent Index | Model+harness benches; $/task Pareto; DeepSeek Flash cost-frontier |
| §81 | Stop Comparing Without Disclosing Harness | Binding Constraint; HV≥MV; disclose H |
| §82 | Scaffold Effect (Vats & Golev) | 40× tokens/solved; failure fingerprints |
| §83 | Meta-Harness + SWE-bench Pro grid | H×M; Spearman −0.05; crush/pi vs vendor |
| §84 | Harness-Bench (TheLime1) | Community leaderboard; ≠ PKU §133 |
| §85 | Arena HarnessTax | Cost-dominant; Pi Pareto; vendor≠best |
| §86 | Community / BenchGen | Reddit: harness bottleneck; Assess |
| §105 | Decoding AI Decode harness | System design; 6 modules+LSP; course |
| §106 | LangChain create_agent middleware | Minimal loop; task–harness fit |
| §107 | Instructions ≠ enforcement | Fire-poster metafoor; hooks > prompts |
| §108 | learn-agent-architecture thesis | Model vs harness; mini-swe vs DSH |
| §109 | Vercel Academy TeensyCode | TS harness course; sandbox/prune |
| §110 | Composio DEV harness essay | Exec bottleneck; ToolRouter demo |
| §111 | Heeki / Loom + AgentCore | Managed harness; enterprise |
| §112 | Mastra anatomy long-running | Channel; compaction; approval chain |
| §113 | OpenAI harness engineering | Dunne AGENTS TOC; docs SoR; architecture-as-code |
| §114 | Steering Claude Code | CLAUDE.md / skills / hooks / rules trade-offs |
| §115 | Hooks deterministic guardrails | Should (prompt) vs must (hook) |
| §116 | Böckeler harness engineering | Guides + sensors; computational vs inferential |
| §117 | Anthropic long-running harness | Default-FAIL; PreToolUse evidence; handoff |
| §118 | Verification Gates (Agent Patterns) | Stop-hook; laag: edit → feature → CI |
| §119 | make check oracle (Big Iron) | Vier plekken; check vs check-full; revert |
| §120 | HAR verify + commit gate | Quick/full; content-hash pre-commit |
| §121 | Claude Code verify spectrum | Prompt → /goal → Stop → second opinion |
| §122 | Emma verification ladder | Anti-theater; intensity dial; checkpoint |
| §128 | Claude Code sessions | Directory-bound JSONL; continue/resume |
| §129 | Claude Code worktrees | Parallel scope; resume re-enters worktree |
| §130 | Pi sessions + tree | Cwd-grouped JSONL; /tree /fork; ≠ repo-spine |
| §131 | Planning-with-files | Plan/progress/ledger on disk; clear-proof |
| §132 | Cursor workspace-path chats | History tied to path; pool-A failure mode |
| §133 | Harness-Bench PKU (arXiv:2605.27922) | 106×6×8; NanoBot 76.2 vs OpenClaw 52.4; H×M |
| §141 | Kimi Code CLI | TS harness; hooks; coder/explore/plan |
| §150 | FastContext (Zhang e.a.) | Explorer naast de agent; read/glob/grep; tokens bij de hoofdagent |
| §151 | CodeGrep (Chen e.a.) | Getrainde retriever; slaagkans gehouden, minder rondes en tokens |
| §156 | SWE-bench (Jimenez e.a.) | Issue + repo → patch; takenprotocol, geen zoeklaag |
| §157 | Agentless (Xia e.a.) | Lokalisatie buiten de agentlus; kost naast slaagkans |
| §158 | TokenEconomizer (Li e.a.) | Adaptieve kostcontroller; vaste repo-map niet consistent goedkoper |
| §179 | OpenHands (Wang e.a.) | Open software-agent platform |
| §180 | Niklaus — evolve the harness | Scaffold-evolutie rond vast model |
| §181 | Harness2 (Xu e.a.) | Recursieve harness-RSI |
| §182 | Raven (EverMind) | Harness-of-harnesses |
| §183 | Harness-S (Zhang e.a.) | Sibling-harnesses voor training |
| §184 | Claw-SWE-Bench (Zheng e.a.) | OpenClaw-stijl harness-bench |
| §185 | SWE-Adept (He & Roy) | Deep codebase analysis + issue resolution |
| §186 | CodeR (Chen e.a.) | Multi-agent + task graphs |
| §189 | AgentScope (Gao; Pan) | Framework + large-scale simulation |
| §190 | ARIS + COLLEAGUE.SKILL | Research multi-agent; skill distillation |
| §236 | ActiveSaddler: Automated Curriculum Learning for Agent Harness Optimization | ActiveSaddler treats harness optimization as adaptive curriculum learning by modeling training scenarios as a… |
| §237 | Agent Lightning v1.0: Towards Harnessed Agentic RL | Agent Lightning v1.0 enables reproducible reinforcement learning for arbitrary agent harnesses, substantially… |
| §238 | An Empirical Study of Harness Design for Coding Agents | Component-level analysis of a coding harness reveals that context management prevents overflow failures,… |
| §239 | AutoSaddler: Automatic Harness Optimization with Durable Updates from Agent Execution Traces | AutoSaddler automatically improves LLM agent harnesses via offline failure-driven optimization, boosting… |
| §240 | Beneath the Surface: What We Overlook When We Talk About Agent Evolution | Agent harness evolution can improve benchmark performance without weight updates, but gains are unreliable,… |
| §241 | ClawGym II: Exploring Black-Box RL on Agent Harness | A unified black-box reinforcement learning framework enables stable, scalable optimization of general agents… |
| §242 | Co-Evolving Harnesses and Models: On-Policy Correction Helps Weaker Models Catch Up Where Imitation Fails | Combining harness evolution with localized expert correction improves weaker models without disrupting their… |
| §243 | Dynamic Harness Search: Building Multi-Agent Systems Per-Query via Prediction | SHIFT learns to build task-specific agent harnesses via a local LLM policy and value function, achieving… |
| §244 | Elicitation or Expansion? Demystifying Gains from Agent Harness Optimization | Harness optimization improves language model agents by altering task coverage and reliability differently… |
| §245 | Harness Scaling for Generalizable Agentic Reinforcement Learning | Harness Scaling improves agentic reinforcement learning by training across diverse execution configurations,… |
| §246 | Harness-RL: Black-Box Reinforcement Learning with Action-Args Decoupling for Central-Agent Multi-Agent Harnesses | Harness-RL improves multi-agent coordination by separating action and argument optimization and modeling… |
| §247 | Harness-Zero: Harness Distillation via Agent-as-Harness | Harness-Zero distills specialized agent harness behaviors into model weights via agent-as-harness correction,… |
| §248 | Harness^2: Recursive Agent Harnessing for an Open World | Harness² improves agent execution harnesses through recursive task-level refinement and continual… |
| §249 | HarnessDev: Can LLMs Create and Evolve Their Own Agent Harness? | HarnessDev evaluates agents by measuring their ability to build and iteratively improve execution… |
| §250 | Harnesses That Improve Themselves: A Unifying Framework for Self-Improving Agent Harnesses | Self-improving agent harnesses can be built by modularly editing four runtime components through a… |
| §251 | How Do Agent Harnesses Create Value? Planning Information and Release Control in Stateful LLM Agents | In τ²-bench, structured planning guidance improves task success over sham controls, while a terminal verifier… |
| §252 | Humanize: Judgement Engineering for Agentic Coding | Humanize is a multi-agent orchestration framework for agentic coding that uses explicit mechanical gates and… |
| §253 | Introducing harness adapters: adapt your favorite model to your harness to improve performance and cost | (no abstract in dumps; harness adapters) |
| §254 | JIT-Agent: Scaling Harness Intelligence via Just-in-Time Harness Evolution | JIT-Agent is a trainable model that synthesizes adaptive agent harnesses for off-the-shelf LLMs, improving… |
| §255 | Learning from Research: Toward Lifelong Agent Harness Evolution | A framework uses state-of-the-art research and topic modeling to guide modular improvements in a language… |
| §256 | Learning Meta-Skills for Agent Harness Design in Test-Time AI4AI | Fixed-weight AI agents learn to build reusable execution environments for other agents via meta-skills… |
| §257 | MILO: Automated Harness Discovery via Orchestrated Multi-Agent Evolution | MILO co-evolves agent harnesses and search strategies via island-based lineage memory and adaptive… |
| §258 | Mixture of Self-Improving Branches For Agent Harness Optimization | Adaptive branching with evolving development subsets and proposal policies improves recursive… |
| §259 | Omni-IO Skills: Harnessing Your Agent Omni-Native | Omni-IO Skills is a plug-and-play harness that enables general agents to coordinate multimodal workflows… |
| §260 | ParetoSaddler: Pareto-Guided Optimization of Agent Harnesses for Quality and Cost | ParetoSaddler improves LLM agent harnesses by separately promoting intermediate candidates via Bayesian… |
| §261 | PluginRSI: Recursive Improvement of Agent Harnesses with Reusable Plugins | PluginRSI improves language model harnesses by evolving reusable, composable plugins that accelerate… |
| §262 | Rethinking Verification in Agent Harnesses | Verification strategies for agent harnesses—spanning instructions, reminders, gates, and independent… |
| §263 | RRSI: Regularized Recursive Self-Improvement of Agent Harnesses | Regularized recursive self-improvement of agent harnesses improves out-of-distribution performance by… |
| §264 | Self-Evolving Agent Harness | A framework for self-evolving agent harnesses uses feedback-driven revisions and evolutionary optimization… |
| §265 | Stellar Colosseum: A Many-Agent Harness for Long-Horizon Research in Mathematics and Theoretical Computer Science | Stellar Colosseum is a model-agnostic inference harness that improves long-horizon mathematical and… |
| §266 | Trial by Trace: Benchmarking AI Agent Harnesses for Reliability and Failure Attribution | TraceTrial-Bench evaluates agent harness reliability across seven components using mechanism-oriented tasks,… |
| §267 | VERSE: Verified Self-Evolving Optimizer for Agent Harnesses | VERSE enables an optimizer to self-evolve its diagnostic and verification tools, improving agent harness… |
| §268 | VideoEvolve: Evolving Agent Harnesses for Video Temporal Grounding | VideoEvolve automates the evolution of agent harnesses for video temporal grounding by refining instructions… |
| §269 | What Does a Harness Buy? Tokens, Mostly | Harness choice changes cost up to 3x and causes score variance comparable to reruns, with only minor… |
| §270 | Your Policy Is Secretly a Harness: The Decision Geometry of Agent Interfaces | Under KL-regularized control, a policy encodes its harness preferences, so deployed performance equals… |

### 4. [Loop Engineering](bronnen.md#loop-engineering)

| § | Titel | Over |
|---|--------|------|
| §26 | What Is Loop Engineering? (IBM) | Self-prompting, triggers, risico's (*comprehension debt*) |
| §27 | Loop Engineering Explained (Caleb) | Stack Prompt → Context → Harness → Loop |
| §271 | Experience-Handoff Reinforcement Learning for Recursive Self-Improvement | Language-model agents trained with reinforcement learning can improve by learning to create and curate… |
| §272 | LongWoF-Bench: Evaluating EvoMap Genes for Verifiable Long-Workflow Tasks | EvoMap externalizes verified execution experience into reusable structured Gene, improving long-workflow task… |
| §273 | Recursive Experiential-Working Memory Evolution for Long-Horizon Agent Harnesses | Recuris introduces a recursive memory architecture that tracks progress and guides skill selection to improve… |
| §274 | TSFLab: A Self-Improving Agent-Agnostic Workbench for Time Series Forecasting Research | TSFLab is a self-improving agent-agnostic workbench that equips coding agents with shared resources to reduce… |

---

## Kernpraktijk


### [Embodied & Physical AI](bronnen.md#embodied--physical-ai)

| § | Titel | Over |
|---|--------|------|
| §286 | A Controlled Study of Models, Skills, Feedback, and Curriculum in Agentic Robotics | A controlled simulation study of agentic robotics finds that successful self-learning depends less on… |
| §287 | A Glimpse of Training VLMs as Foundation Models for Robotic Manipulation | nanoAstra combines semantic action modeling with capability-preserving supervised fine-tuning to train… |
| §288 | ACAP: Asynchronous Coding Agents for Efficient Robot Control | Coding agents can construct and revise robot behavior during execution, but using one agent for the whole… |
| §289 | ActionCodec2: A Streaming Action Tokenizer | ActionCodec2 is a non-neural streaming action tokenizer that incrementally releases executable actions with… |
| §290 | AeroRSI: Recursive Self-Improvement for Aerial Vision-Language Navigation | Vision-language-action (VLA) models enable unmanned aerial vehicles (UAVs) to follow natural-language… |
| §291 | AgentRoboCritic: Understanding the Capability of Frontier Agents on Direct Robot Control | Frontier multimodal language agents such as GPT-6 Astra have demonstrated strong capabilities in controlling… |
| §292 | AIRIS: Benchmarking Social Embodied Intelligence in Egocentric Streaming Videos | Embodied agents operating around people must not only recognize social cues, but also decide when the… |
| §293 | Auriga Technical Report: A Task-Agnostic Agent Harness for Zero-Shot Embodied Manipulation | Auriga, a task-agnostic agent harness, closes most of the planning-execution gap in zero-shot robot… |
| §294 | AutoPILOT: A Visual Agent Harness for Real-Time Gameplay | A harness that lets multimodal foundation models emit primitive actions, open-loop macros, or closed-loop… |
| §295 | Coding4Games: Can Modern Coding Agents Play Modern Video Games? | Games, especially modern AAA games, challenge language models to perceive complex scenes, control actions,… |
| §296 | DemoFoundry: Toward Scalable Photorealistic Robot Data with Coding Agents and Generative Rendering | Scaling robot learning requires demonstrations that combine realistic visual observations with reliable… |
| §297 | DexDuet: Learning Contact-Preserving Bimanual Dexterity from Human Demonstrations | Human demonstrations provide a rich source of bimanual dexterous skills, yet transferring them to robot… |
| §298 | DexEngine: Scaling Human Demonstrations into Physically Executable Whole-Robot Data | A growing body of recent work addresses the retargeting of human hand-object demonstrations to robotic… |
| §299 | Don't Sleep, Keep Watch: Proactive Perception for Computer-Use Agents | NightWatch adds a lightweight streaming watcher to vision-language computer-use agents to keep perception… |
| §300 | EgoUseBench: Benchmarking Computer-Use Agents under Evolving First-Person Contexts | AI wearables, such as smart glasses, extend the context available to agents beyond digital environments to… |
| §301 | Embo-Harness: Towards Understanding Frontier-Model-as-Policy Harness | A systematic framework shows that frontier multimodal models can serve as robot policies when harnessed with… |
| §302 | Embodied AI Fails the Mirror Test: How a Simple Mirror Breaks Robot Policies | A new benchmark shows that many robot manipulation policies perform worse when mirrors are present, often… |
| §303 | Embodied-Harness: Towards Recursive Self-Improvement for Robotic Manipulation | A dual-agent framework with hierarchical memory and recursive self-improvement enables robotic manipulation… |
| §304 | EMHO: EMbodied Agent Harness Optimization via Experience Traces | EMHO is a self-evolving framework that improves embodied agent harnesses directly from experience traces by… |
| §305 | GameAnything: From Any Inspirations to Playable Game Worlds | An open-source agentic platform and benchmark enable iterative transformation of multimodal inspirations… |
| §306 | GameDojo: Benchmarking Real-Time Interactive Agents in Video Games | GameDojo is a controllable benchmark of 120 boss encounters across 20 games with 600 hours of gameplay… |
| §307 | Gamer: A Generalist Vision-Language-Action Foundation Model for Long-Horizon Real-Time Game Agent | Gamer is a generalist agent framework that integrates perception, memory, and multi-step reasoning, trained… |
| §308 | HarnessVLN: Unifying Training-Free Embodied Navigation through an Agent Harness | HarnessVLN is a zero-shot framework that validates navigation plans against spatial evidence and maintains… |
| §309 | Has GPT-6-Astra Achieved Embodied Intelligence? | GPT-6-Astra achieves high performance across diverse robotic tasks via in-context learning, yet real-world… |
| §310 | HIVE-Bench: Evaluating Patch-Level Visual Representations for Egocentric Robot Manipulation | A shared flow-matching policy that reads dense patch tokens from multiple vision encoders improves success… |
| §311 | ICLWorld: Benchmarking In-Context Learning of Agents from Digital to Physical Worlds | An online benchmark evaluates in-context learning across computer-use and robot-use agent tasks, revealing… |
| §312 | Innata-0: A Native Embodied World System with Model-Agent Co-Design | Innata-0 is a native embodied world system that co-designs a world-action model and an agent to enable… |
| §313 | LeadVLA: Learning Follower-Aware Route Execution for Robot Leading | LeadVLA is a structured multimodal policy that separates route execution into explicit path, pace, and… |
| §314 | Lost in the Hallway: Benchmarking Persistent Spatial Memory Across Revisits | Persistent spatial understanding is essential for embodied agents to operate reliably in environments they… |
| §315 | Make Code as Policy Great Again: Frontier Agents Write, Call, and Evolve Robot Tools | URAI improves robot manipulation by having agents build reusable motion tools that execute locally while… |
| §316 | MOTIO: Agentic Skill Engineering for Reality-Grounded Humanoid Loco-Manipulation | MOTIO converts human videos and 3D assets into executable humanoid robot programs via agentic reasoning and… |
| §317 | Profiling a Frontier Agent with EBench: From Direct Control to Harness with Policy | A frontier multimodal language model controls robots directly and via post-trained vision-language-action or… |
| §318 | PyRUA-DataFarm: LLM Agent as a Cost-Efficient Teleoperator for Real-Ready Robot Data | A coding agent automates robot demonstration generation by simulating tasks, rendering photorealistic… |
| §319 | PyRUA-Dex: Learning Programmatic Policies for Dexterous Bimanual Manipulation with Coding Agents | A framework enables coding agents to develop dexterous manipulation policies without demonstrations by… |
| §320 | RAPID: Robot Agentic Programming from Demonstrations | RAPID automatically generates reusable robot programs from a single visual demonstration by inferring task… |
| §321 | Real2SimLab: A Unified Platform for Real-to-Simulation Transfer | Real-to-simulation transfer, which builds simulations from real-world observations, has long been studied in… |
| §322 | RLE-Bench: A Qualifying Exam for Coding Agents as Robot Learning Engineers | RLE-Bench evaluates coding agents across robot-learning workflows including control, policy learning,… |
| §323 | ROAM-Bench: Evaluating Embodied Active Spatial Intelligence through Evidence Verification | Embodied spatial intelligence requires agents to gather information through exploration and interaction,… |
| §324 | RoboAware: Learning to Coordinate Embodied Skills from Counterfactual Outcomes | RoboAware learns a state-conditioned coordinator to select between modular robot skills and frozen policies… |
| §325 | RoboEvo^2: Recursive Robot Self-Improvement via Harness-Policy Co-Evolution | RoboEvo$^2$ recursively co-evolves a coding-agent harness and a vision-language-action policy, using policy… |
| §326 | RUIBench: What Makes a Good Robot-Use Interface? | Foundation models can reason about complex physical tasks, yet translating this intelligence into reliable… |
| §327 | SEEK: Self-Evolution through Execution Knowledge for Agentic Robot Manipulation | SEEK retains executable manipulation procedures and measured action effects across attempts, enabling fixed… |
| §328 | SOLVE: Sparse, Ordered Keyposes Make LLM Agents Versatile and Efficient Robot Manipulator | LLM agents have made remarkable progress in robot manipulation, yet they suffer from expensive inference,… |
| §329 | Speak When You See It: Proactive Task Assistants Should Wait for Evidence, Not the Clock | Proactive assistants that guide people through physical tasks must decide, every few seconds, whether a step… |
| §330 | World Action Agent: Harnessing VLMs for Robot Manipulation via World Action Rehearsal | World Action Agent enables vision-language models to control robots within a visual workspace featuring… |
| §331 | WorldLeague: Benchmarking Physical Agency | WorldLeague benchmarks 13 AI systems on 60 simulated robot tasks spanning exploration, rearrangement, and… |


### [Agent Safety](bronnen.md#agent-safety)

| § | Titel | Over |
|---|--------|------|
| §275 | Attack Policy Selection can Mislead Monitor Evaluators | AI monitors, classifiers that flag dangerous behaviour by AI agents, are often evaluated against transcripts… |
| §276 | Can Latent Reasoning Drive LLM Outputs Without a Trace? | Models can use deep latent reasoning to pursue hidden objectives while generating chain-of-thought… |
| §277 | EvoUndo: Recoverability-Constrained Self-Evolution for LLM Agent Harnesses | EvoUndo evaluates recoverability of self-modifying LLM agents and shows that reliable recovery requires… |
| §278 | Forgetting is Not Always Bad: A Neuro-Inspired Memory Repair Mechanism for Poisoned LLM Agents | DREAM is a training-free framework that selectively suppresses poisoned memories in LLM agents via… |
| §279 | HarnessRisk: A Lifecycle-Oriented Benchmark for Agent Harness Safety | HarnessRisk evaluates agent harness safety across six operational phases, revealing that configuration… |
| §280 | HarnessSecurity-Bench: Do Security Mechanisms Really Protect Coding Agent Harnesses? | HarnessSecurity benchmarks coding agent harness security mechanisms, finding that auto-approve sharply… |
| §281 | Intent Contracts: Taking Tools Away from Agents | Intent contracts, in which a planner submits logged contracts and a trusted model writes tool calls, do not… |
| §282 | Names Are Not Objects: Object-Bound Confinement for Compromised AI Coding Agents | Coding agents read repositories and web pages that anyone can write, and then act with their user's… |
| §283 | Safe, Persistent, and Evolving Agent Harness for Understanding Partially Observable Worlds | A multi-agent execution framework with policy checks, persistent state, and abductive rule discovery… |
| §284 | Same Bytes, Different Authority: Reserved-Token Representations in Chat-Template Prompt Injection | Reserved control tokens in chat templates significantly amplify prompt injection attacks against LLM agents… |
| §285 | Step-Zero Attack: Agent Safety Before Observability | Existing attacks and defenses for coding agents act once content enters the model context: injected text… |

### [Graph Engineering](bronnen.md#graph-engineering)

| § | Titel | Over |
|---|--------|------|
| §28 | Graph Engineering Explained | Multi-agent DAG's, 100+ nodes, deep research |
| §332 | AsynCodeBench: Benchmarking Collaboration of Asynchronous Multi-Agent Systems in Software Engineering | AsynCodeBench introduces dependency-level metrics to evaluate cross-agent collaboration in multi-agent… |
| §333 | Evolving Agent Teams | Evolving Agent Teams uses a supervisor and persistent memory to restructure agent teams, escaping local… |
| §334 | Graph Engineering in the Era of LLM Agents: From Individual Intelligence to System Intelligence | Graph Engineering organizes multi-agent LLM systems through dynamic graph structures to coordinate… |
| §335 | MeterRouter: Budget-Aware Dynamic Routing for Multi-Agent Systems | (no abstract in dumps; budget-aware routing for multi-agent) |
| §336 | Not Every Input Needs Everything: Unifying Expert Gating, Model Cascades, and Agent Orchestration | (no abstract in dumps; expert gating / cascades) |
| §337 | OpenCollab: A Multi-Agent Coding Framework with Programmable Collaboration and Controllable Runtime | Multi-agent coding systems are designed to tackle complex software engineering tasks through collaboration.… |
| §338 | When Are Parallel Subagents Effective for Coding? An Empirical Study on Repository Construction | (no abstract in dumps; parallel subagents effectiveness) |


### [World models & generative video](bronnen.md#world-models--generative-video)

| § | Titel | Over |
|---|--------|------|
| §339 | 3D CoCa v3: Contrastive Learners with Scene Graphs for Urban Scene Understanding | Understanding large-scale 3D urban scenes requires representations that capture both multi-scale geometric… |
| §340 | A Mesh for Every Moment | We present MEMO (a Mesh for Every MOment), a method that reconstructs the geometry of complete dynamic… |
| §341 | Agentic LongLive: Asynchronous Agentic Memory for Long Video Generation | Real-time autoregressive video generators stream minutes of video and accept new prompts on the fly, but… |
| §342 | Autoregressive View Model | We present the Autoregressive View Model (AVM), which generates a scene as a stream of views without… |
| §343 | Beyond the Happy Path: Generalizing Robot World Models from Simulated Failures | Training world models on simulated manipulation failures with interaction alignment and surface… |
| §344 | Fast-JEPA: Advancing the Success-Latency Frontier for Latent World Models | Fast-JEPA is a latent world model planning framework that improves the success-latency trade-off of… |
| §345 | FoundSurface: Feedforward Ray-Based 3D Scene Surface Reconstruction from Unposed Images | A generalizable pipeline reconstructs continuous, high-fidelity 3D surfaces from unposed images by… |
| §346 | From Points to Trajectories: Rethinking Multimodal Alignment for Physical Events | Advancing physical artificial intelligence (Physical AI) requires moving beyond static object recognition to… |
| §347 | GameWM: Toward Next-Generation Video Games with Interaction-Centric World Models | GameWM divides game generation between an engine that preserves exact rules and state and a generative video… |
| §348 | Non-penetrating World Models | A benchmark and lightweight framework leverage hidden states from frozen diffusion transformers to detect… |
| §349 | Not all world models can doubt: how training objective and architecture shape epistemic uncertainty in JEPA and RSSM world models | World models predict how an environment responds to actions, so that candidate actions can be evaluated… |
| §350 | OmniPersist: Persistent Dynamic World Modeling via Coupled Panoramic Evolution | Action-conditioned world models play a vital role in robotics and autonomous driving, yet existing video… |
| §351 | Plan4D: Generative Plannable 4D Worlds | Most world models for future prediction prioritize aestetic quality of generated videos, but offer only weak… |
| §352 | Simulator-as-Proxy World Model for Robot Manipulation | SimPWM uses a parameter-free simulator as a proxy to generate robot videos and simulated states, revealing… |
| §353 | Video Generation Meets Agent Harness: Agentic Video Generation, Agentic World Modeling and Recursive Self-Improvement | Agent harnesses integrate video generation and world models to enable planning, tool use, and recursive… |
| §354 | World Models as Native Latent Action Models | Native LAM distills compact latent actions from a pretrained video diffusion transformer via learnable… |
| §355 | WorldLatent: A Unified 4D Latent Space for World Perception and Generation | WorldLatent unifies 4D perception and generation in a shared multimodal latent space, enabling a single… |
| §356 | π^4: A Foundation Model for 4D Scene Geometry and Motion | This unified foundation model enables the recovery of dense geometry, camera poses, and object tracking from… |

### [Workflow & Specs](bronnen.md#workflow--specs)

| § | Titel | Over |
|---|--------|------|
| §1 | Complete AI Coding Workflow | Grill → Spec → Tickets → Implement + sub-agent review |
| §4 | `/wayfinder` | Plannen zonder waterfall; beslissingsgrafiek |
| §6 | Why Software Factories Fail | Anti lights-off; pre-planning en code review |
| §7 | Full Walkthrough: Workflow for AI Coding | End-to-end masterclass (smart zone, vertical slices, AFK) |
| §37 | Karpathy's Method (Austin Marchese) | Spec → Verifier → Environment |
| §41 | Karpathy × Sequoia (AI Ascent) | Vibe coding → agentic engineering; Software 3.0 |
| §357 | AgentDiscover: Autonomous Discovery with Minimal Search Scaffolding | AgentDiscover enables a coding agent to plan and remember its own scientific search through a structured idea… |
| §358 | AgentSWE: Can Coding Agents Build the Agent You Actually Want? | AgentSWE evaluates whether coding agents build software that truly meets user requirements across creation,… |
| §359 | Automating ML for Science: Can Frontier Agents Climb Scientific Hills in the Wild? | Agent4Sci evaluates frontier coding agents on scientific ML benchmarks, finding they improve results mainly… |
| §360 | CodeMidas: Scaling Agentic Coding RL Environments from Code Itself | CodeMidas converts existing source code into executable reinforcement learning tasks for training coding… |
| §361 | Do Coding Agents Catch Their Own Bugs? (They Don't.) | Foresight-SWE is a benchmark that evaluates whether coding agents can anticipate and prevent unstated defects… |
| §362 | Doing More with Less Tokens: Hierarchical Reinforcement Learning for Efficient Coding Agents | HERO is a reinforcement learning framework that trains coding agents to resolve software engineering tasks… |
| §363 | Engineering Signals of Human-AI Collaboration in the Agentic Coding Era: A Longitudinal Analysis of 33,228 Pull Requests from vLLM and SGLang with Implications for Biomedical AI Agents and Bioinformatics Pipeline Developmen | Longitudinal analysis of vLLM and SGLang shows AI-assisted development correlates with sharply increased… |
| §364 | From Repositories to Training Environments: Scaling Long-Horizon Coding Agents with Environment Evolution Loop | RepoFactory converts real repositories into verifiable coding environments and optimizes them via an… |
| §365 | Handoff Debt: The Rediscovery Cost When Coding Agents Take Over Interrupted Tasks | Evaluating interrupted coding agents reveals that structured handoff notes significantly reduce successor… |
| §366 | How Much Do Coding Agents Over-Edit, and Why? An Empirical Study of Unneeded Edits in Repository-Level Agent Patches | Agent patches are larger than developers', which is widely read as over-editing. But patch size does not say… |
| §367 | Interpreting Coding Agents Through Their Behavioral Trajectories | Standard coding-agent benchmarks primarily evaluate binary task success, treating execution as a black box… |
| §368 | JevCoder: When Does Decision Delegation Pay Off in Code Repair? | A low-cost probabilistic judge guides repair decisions in a coding agent workflow, reducing token use while… |
| §369 | Moving Generality from Model to Modeler: LLM Agents for PHM on a Deployment-Style Benchmark | Coding agents built on large language models (LLMs) now help develop many models published as general… |
| §370 | MTAC-IFBench: Benchmarking Instruction-Following in Multi-Turn Agentic Coding | A new benchmark evaluates multi-turn instruction adherence for autonomous coding agents across complex,… |
| §371 | PaperCompiler: Faithful Paper-to-Code Generation via Repository-Level Specification Compilation | PaperCompiler converts research papers into structured repository specifications that preserve method logic… |
| §372 | Priming Base Models for Agentic Post-Training: An Open Midtraining Recipe | Midtraining on long-context software-engineering data improves agentic post-training performance and RL… |
| §373 | ProgramDistill: From Interactive Web Apps to Verifiable Reference-Guided SWE Tasks | ProgramDistill introduces a scalable benchmark that evaluates coding agents by requiring them to infer and… |
| §374 | ProgramGym: Scaling Training Environments for Long-Horizon Program Reproduction Agents | ProgramGym introduces scalable verifiable training environments and a role-isolated agent workflow to improve… |
| §375 | RealSWE: A Compositional Evaluation of Coding Agents under Realistic User Requests | Real-world coding requests are shorter and more casual than benchmark tasks, and explicitly stating desired… |
| §376 | SAIL: Scientific Agentic Intelligence via a Science-Aware Loop | SAIL is a 35B-parameter open model for scientific research and coding that improves via agent-driven failure… |
| §377 | Search From the Start: Search-Native Pretraining for Language Models | Modern language models (LMs) are increasingly deployed with access to search tools at inference. Yet… |
| §378 | SemaPLC: A Project-Grounded, Verification-Gated Agent Harness for PLC Code Generation | SemaPLC is a verification-gated agent harness that validates generated PLC logic through external compilation… |
| §379 | SpecEngineeringBench: Evaluating Coding Agents as Autonomous Specification Engineers | Autonomous specification engineering requires coding agents to translate functional requirements into… |
| §380 | SWEeper-Bench: Can Agents Discover Bugs in Interactive Software? | SWEeper-Bench evaluates coding agents on finding and fixing interaction-dependent bugs in web applications… |
| §381 | Teaching Agents to Code Reliably | Training policies to diversify repair locations and edits, and to verify patches against reverted code,… |
| §382 | The Agentic Scientist: Orchestrating Coding Agents for Automated Scientific (Co-)Discovery | The Agentic Scientist is a distributed pipeline that integrates coding agents with human researchers to… |
| §383 | What Makes Good Data for Training Coding Agents? A Systematic Study on SWE-Gym | Auditing reward labels in coding-agent reinforcement learning tasks shows many unsolved tasks are mislabeled,… |
| §384 | WideSWE: Can Coding Agents Coordinate Changes Across Repositories? | WideSWE introduces a benchmark for evaluating coding agents on cross-repository software tasks, finding that… |
| §385 | WitnessGym: Benchmarking Coding Agents on the Construction of Bug Witnesses | WitnessGym automates benchmark construction for bug validation by injecting bugs into real project paths and… |

### [Software design (AI-tijdperk)](bronnen.md#software-design-ai-tijdperk)

| § | Titel | Over |
|---|--------|------|
| §2 | Software Fundamentals in het AI-Tijdperk | Specs-to-code faalt; deep modules, TDD, ubiquitous language |
| §32 | How To De-Slop A Codebase | AI-slop / software-entropie; deep modules & seams |
| §144 | Open source is not enough | Rice; types-as-proxy; Trusting Trust; reproducible / hex0 bootstrap |

### [Agent-docs & docs-architectuur](bronnen.md#agent-docs--docs-architectuur)

| § | Titel | Over |
|---|--------|------|
| §13 | Cursor — Rules | Persistente instructies: project/user/team |
| §14 | AGENTS.md | Open formaat: README voor agents |
| §15 | llms.txt | Gecureerde Markdown-ingang voor LLM's |
| §16 | Aider — Repository map | Beknopte repo-kaart i.p.v. volledige dump |
| §20 | Evaluating AGENTS.md (ETH) | Empirische test: overzichten helpen nauwelijks |
| §21 | Coding Manifests & Agent READMEs | Wat teams wél in agent-bestanden zetten |
| §22 | Diátaxis | Vier docs-types; één behoefte per bestand |
| §23 | ADR | Besluiten vastleggen zonder ze te herschrijven |
| §24 | C4-model | Containerdiagram als nuttigste overzicht |
| §34 | Coldtea — 100 biggest AGENTS.md | Field study; "Score your own"-checklist (8 thema's) |
| §55 | Better Stack — AGENTS.md WRONG | Korte video bij §34; Next.js/Bun/VS Code/Neovim-voorbeelden |
| §87 | Technical writing in the agentic era | Lead with result; visuals first; inspect agent-prose |
| §123 | ModernizeSpec agent context | AGENTS.md + `.agents/` JSON dual; manifest |
| §124 | Anthropic Agent Skills format | YAML FM always; MD body on trigger; scripts |
| §125 | llms.txt v2 | Constrained MD; parsers + LLM; discoverability |
| §126 | Structured MADR | ADR MD body + YAML FM; CI/index |
| §127 | Cursor `.mdc` vs AGENTS.md | Frontmatter = load routing, not prose replace |
| §386 | Acquiring and Verifying Repository Norms for Coding Agents | RepoNorm extracts repository-specific contribution norms from source and version history to improve coding… |
| §387 | What Open-Source Projects Tell Their Coding Agents: A Census of AGENTS.md and CLAUDE.md | Coding agents can be guided with instruction files in a repository. We examine this emerging practice through… |

### [Ship quality](bronnen.md#ship-quality)

| § | Titel | Over |
|---|--------|------|
| §47 | Strix (AI pentest agents) | Gevalideerde exploits, CI/SARIF, bootstrap-kandidaat security |
| §48 | Observability (breed) | Logs→metrics→traces→correlatie→alerts→SLOs→cardinality + perf/security |
| §388 | AdaPRA: Process Reward Agents with Adaptive Rubrics for Data Science | AdaPRA improves data science agents via persistent knowledge accumulation and adaptive rubric-guided process… |
| §389 | ContractBench: Can LLM Agents Preserve Observation Contracts? | Observation contract compliance in tool-augmented LLM agents is an emergent, regression-prone capability… |
| §390 | Hearsay: Can an Auditor Trust the Record a Deployed Agent Harness Writes? | Agent harness records lack evidentiary reliability because they are self-written, but an external append-only… |
| §391 | Keyword Harnesses Fail Open: A Cheap Diagnostic Ladder for Tool-Use Claims in Small Language Models | A diagnostic ladder reveals false tool-use positives in small language models and shows targeted supervised… |
| §392 | Learning When and How to Intervene: A Hindsight-Distilled Sentinel for Coding Agents | A hindsight-distillation framework trains lightweight sentinels to decide pre-execution interventions and… |
| §393 | Skill-based Agentic Evaluation for Real-time Data Science Tasks | The framework evaluates data-science agents on live data by encoding ground truth as executable reference… |
| §394 | Soei: Structured Observability of Evidence and Intent for Multi-Agent AI Software Engineering | AI coding agents now do long, multi-step and multi-session software work with little supervision. When a… |
| §395 | SWE-Critix: Post-Training Generalist Verifiers for Assessing Coding-Agent Trajectories | SWE-Critix trains generalist verifiers via supervised fine-tuning and reinforcement learning to classify and… |
| §396 | SWE-VERIFIER: Selective Verification for Cost-Efficient Coding Agents | SWE-Verifier selectively verifies coding-agent actions to improve resolution with minimal overhead. |
| §397 | The reach of a verification tool decides its value: A controlled study of verification surface, artifact quality, and cost in AI coding agents | Modern artificial-intelligence coding agents can be equipped with tools for checking their own work e.g. a… |
| §398 | What Coding Agents Leave Unsaid: Measuring Task-State Gaps Between Execution and Reports | Human supervisors rely on coding agents' reports to assess progress, verify repairs, and decide when to… |


### [Evaluation & benchmarks](bronnen.md#evaluation--benchmarks)

| § | Titel | Over |
|---|--------|------|
| §399 | BabelArena: A Large-Scale Multilingual Benchmark for LLM Agents | BabelFlow adapts agent benchmarks to multiple languages via dependency-aware translation and verification,… |
| §400 | ChainSWE: Benchmarking Coding Agents on Multi-Bug Software Maintenance | ChainSWE introduces a benchmark for sequential, dependent bug fixes in shared codebases, revealing… |
| §401 | DAREBench: Deployment-Aware and Reliable Evaluation of Models as Agents | DAREBench evaluates large language models as agents across diverse multimodal workloads using a unified… |
| §402 | DRBench Pro: A Knowledge-Centric Benchmark for Professional Deep Research Agents | Deep research agents gather information from multiple sources and synthesize it into reports on complex,… |
| §403 | E2E-SWE: Benchmarking LLMs on Building Working Codebases from Scratch | E2E-SWE is a benchmark assessing whether coding agents can build complete, installable software repositories… |
| §404 | EGI-BENCH: An Enterprise General Intelligence Benchmark Suite | EGI-BENCH unifies eight enterprise agent benchmarks into a single suite with budgeted execution modes and… |
| §405 | LoLBench: Evaluating Coding Agents with Long-Horizon Proposals on Large Software Systems | LoLBench evaluates coding agents on large-scale modular development by requiring them to interpret… |
| §406 | Self-Evolving Evaluation Environments for Computer-Use Agents | CUA-SEE is a closed-loop evaluation environment that co-evolves tasks and executable verifiers to adaptively… |
| §407 | SWE-Duel: Towards a Self-Scaling Arena for Coding Agents | SWE-Duel is a self-scaling coding benchmark where agents alternately author and review repository tasks to… |
| §408 | SynthDCB: World Distillation for Scalable Device Control Benchmarking | Scaling device-control evaluation requires scaling both interactive worlds and the tasks agents must solve.… |
| §409 | ToolSpace: Scaling Tool-Centric Environment Synthesis for Long-Horizon Agents | ToolSpace constructs realistic multi-environment tool-use benchmarks by mining execution traces, clustering… |
| §410 | Zero2Repo: Can Coding Agents Build Repositories from Scratch? | Zero2Repo is a language-agnostic benchmark that evaluates coding agents on building complete repositories… |
| §411 | τ^τ-Bench: An Environment for End-To-End, Realistic Agent Construction | The τ^τ-bench benchmark evaluates coding agents on building real-world customer-service agents from business… |

### [Product / tooling-rand](bronnen.md#product--tooling-rand)

| § | Titel | Over |
|---|--------|------|
| §31 | Jev Explained | Smalle, snelle modellen voor deterministische automatisering |
| §44 | Open UI generative UI (Better Stack) | OpenUI-lang; stream vs JSON; token-efficiëntie |
| §64 | Rust for AI tools (Better Stack) | Copilot 5s→292ms; ownership vs GC; Python-on-Rust; agent port |
| §102 | Zite “best vibe coding” | Vendor #1 self; lage authority; naamkaart |
| §103 | DataCamp 13 agentic IDEs | Taxonomie dedicated/BYOK/CLI; matige authority |
| §104 | ItsOnMedia 7 IDEs/AI tools | Markt-snapshot; agency SEO; MCP/ACP trends |

---

## Fundament-spiegel

Diepte in [fundament/](fundament/INDEX.md).


### [Vision, docs & perception](bronnen.md#vision,-docs--perception)

| § | Titel | Over |
|---|--------|------|
| §412 | 3AGameFactory-Motion: Agentic Rigging and Reliable Complex Motion Generation for Diverse 3D Assets | A new benchmark evaluates rigging and motion generation across six 3D morphology categories, compares… |
| §413 | 3DCodeVerse: Exploring 3D Worlds as Code | 3DCodeVerse is a research ecosystem that provides datasets, automated verification harnesses, and empirical… |
| §414 | BOP-Refer: Benchmark for Monocular 3D and 2D Object Grounding | We introduce BOP-Refer, the first benchmark for monocular 3D and 2D grounding of everyday and industrial… |
| §415 | Building on Nemotron 3.5 Parse: Open Data, Fine-Tuning, and Faster Inference | (no abstract in dumps; document parsing; open data + fine-tuning) |
| §416 | Depth Pro 2: Sharp and Temporally Consistent Metric Monocular Depth | A single scalable network estimates dense metric depth for images and video at native resolution, jointly… |
| §417 | DocSEAM: Bidirectional Cross-Page Encoding for Multi-Page Document Understanding | DocSEAM is a lightweight module between a pretrained vision encoder and language model that enriches page… |
| §418 | GRAPE-Bench: When Vision Degrades, Does Video Reasoning Hold? | GRAPE-Bench jointly evaluates video reasoning under visual degradation and question difficulty, exposing… |
| §419 | Learning Video Foresight Reasoning from Unlabeled Videos via On-Policy Self-Distillation | Future-OPSD trains vision-language models via on-policy self-distillation and a contrastive privilege… |
| §420 | S-Mind: Internalizing Multi-View Geometry for Spatial Intelligence | Spatial intelligence, the ability to reason about 3D space from visual observations, becomes essential as… |
| §421 | SAVIOR: Sample-efficient Adaptation of Vision-Language Models for OCR Representation | A sample-efficient curation method and a structure-aware layout metric enable a fine-tuned vision-language… |
| §422 | StereoVLM: Binocular Vision-Language Models for Metric 3D Spatial Reasoning | StereoVLM is a geometry-aware binocular vision-language model trained with hierarchical supervision from… |
| §423 | VenusOCR2.0: Towards Efficient and Effective Document Parsing | We present VenusOCR2.0, a compact 1B-parameter vision-language recognizer designed for both high-accuracy… |

### [Inference](bronnen.md#inference)

| § | Titel | Over |
|---|--------|------|
| §29 | Inference Engines Explained | `vLLM`, `SGLang`, `llama.cpp`, KV-cache / VRAM |
| §45 | 1-Bit LLM / BitNet (bycloud) | Train-from-scratch 1–1.58-bit; a4.8 KV; vs post-hoc quant |
| §49 | Colibrì (MoE expert streaming) | 744B lokaal via disk-stream; JIT placement; les niet runtime |
| §56 | DeepSeek V4 so cheap (bycloud) | CSA+HCA+window; 1M context; Pro 1.6T/Flash 284B; Muon; distill |
| §57 | NVFP4 (bycloud) | MXFP4→NVFP4; train recipe; Nemotron Ultra; Rubin PFLOPS |
| §58 | DeepSeek V4.1 Flash (bycloud) | CSA2+CED+SWA replay; 552B; Engram; multimodal; 54× KV |
| §89 | DeepSeek Papers (HF collectie) | Index arXiv LLM→V4.1; ingang A3 |
| §90 | Fowler DeepSeek Series overview | LLM→V2→V3→R1; MLA/MoE/HPC/RL |
| §91 | DeepSeek V4 Model Card (officieel) | Pro/Flash sizes; CSA+HCA; mHC; Muon; MIT |
| §92 | DeepSeek Transparency Center | Cards + tech reports hub |
| §93 | DeepSeek-V4.1-Flash news | deepseek-flash; CED; KV 1/4; Pro→Flash route |
| §94 | V3 + V3.2 PDF (lokaal) | 671B/2.788M h; DSA + agentic synthesis |
| §134 | Kimi papers & lineage map | Parallel §89; K2→K3.1 mapping |
| §135 | Kimi K2 tech report | 1T/32B; MuonClip; agentic RL |
| §136 | Kimi K2.5 visual agentic | Multimodal; Agent Swarm; 256K |
| §137 | Kimi K3 + model card | 2.8T/104B; KDA; 1M ctx; open weights |
| §138 | Kimi K3.1 Pro blog | Post-train RL; API/Highspeed |
| §139 | MuonClip / Moonlight Muon | Optimizer-lijn parallel §65 |
| §140 | Kimi Linear (KDA) | Hybrid linear attn; −75% KV |
| §142 | AA Cyber Index | K3.1 Pro 64 vs DS Flash 1017 57 |
| §95 | AA provider Mistral | Live Index/price/speed; watchlist |
| §96 | Mistral Medium 3 news | Frontier @ ~8× cost; deploy ≥4 GPU |
| §97 | Mistral Docs models | Catalogus + deprecation; Large 4 card |
| §98 | BenchLM best Mistral | Ranking; Large 4 61.7 |
| §99 | Mistral Large 4 “le Chonk” | 1T/52B; EU GPUs; agent/cyber claims |
| §100 | Large 4 license countdown | $20M gate risk; weights pending |
| §101 | Mistral 7B (DAIR + paper) | GQA+SWA+rolling buffer; Apache |
| §60 | DeepSeek V4 infra (bycloud) | MegaMoE; TileLang; batch-invariance; on-disk KV; Muon; DSEC |
| §61 | DSpark (bycloud) | Semi-AR draft + confidence/load-aware verify; DeepSpec; ~50%+ thruput |
| §63 | 16GB local LLM (Kai) | Qwen3.8-27B GSQ-RCO; KV vs weights; prefill; bandwidth ROI |
| §145 | DeepInfer 3× GPU value (bycloud) | $12.91→$38/GPU-h; wide EP; 96% KV; 128-GPU drempel; InferX 4.3× |
| §191 | PagedAttention + FreeToken | vLLM-geheugen; edge MoE serving (niet BP-scope) |
| §192 | OCR/parsing-bundel + TimesFM | MinerU/PaddleOCR/…; meegenomen om PDF-map compleet |
| §424 | 180B Parameters, 32GB of RAM: Pushing MoE Inference to the Limit with Transformers | (no abstract in dumps; MoE inference on 32GB) |
| §425 | A Pipeline-Parallel System for Depth-Recurrent Models | Loop-PP schedules cyclic pipeline stages for depth-recurrent models, overlapping communication and compute… |
| §426 | AgSpec: Pushing the Limits of Retrieval-Based Speculative Decoding in Coding Agent Pipelines | AgSpec improves retrieval-based speculative decoding for coding agents by sourcing session and workspace… |
| §427 | Coda: Exploiting Admission Flexibility for Coding-Agent Serving | Coda improves coding-agent serving by using readiness-informed admission and routing to align reusable KV… |
| §428 | How Specializing the Vocabulary of SLMs Can Cut Inference Cost by 77% in Real Applications | (no abstract in dumps; vocabulary specialization cuts inference cost) |
| §429 | LaFlash: Capacity-Driven Acceleration for Coding Agent Workflows via QLC-HBF | As large language models (LLMs) evolve toward agentic AI, coding agents are emerging as memory-intensive… |
| §430 | The Other Half of the Memory Wall: Serving 35B MoEs from SSD with Trained Routing Prediction | Edge0 enables efficient mixture-of-experts inference on consumer hardware by predicting expert routing ahead… |

### [Reasoning](bronnen.md#reasoning)

| § | Titel | Over |
|---|--------|------|
| §35 | Hybrid Reasoning Agents | Latent ↔ text via HybridLink; HybridSFT/RL; HF HybridAgent-14B |
| §46 | HRM & TRM (bycloud 27M) | Video-naslag: ARC-illusie, HRM two-timescale, TRM 7M + recursie vs layers |
| §148 | Lacuna / alien space (Better Stack) | Idea atoms; zinnig∧onwaarschijnlijk; ICLR oral top-25; paywall-limiet |
| §431 | Adversarial Speculative Reasoning Improves Long Horizon Agents | Speculative decoding can be trained to reject critical reasoning tokens so they are verified by the target… |
| §432 | Beyond Self-Consistency: Recursive Self-Improvement at Test Time | A label-free test-time framework, TT-RSI, improves large language models by repeatedly re-solving questions… |
| §433 | Can image generation help visual reasoning? An empirical study | Language models think in words; then multimodal models might think in images. We test whether a generated… |
| §434 | Collect for Coverage, Replay with Evidence: Adaptive and Efficient On-Policy Distillation for Long-Horizon Agents | Fully online on-policy distillation (OPD) is costly for long-horizon agents because each update depends on… |
| §435 | Diverse Alternative Reasoning Traces for Hard Math Problems | Post-training large language models (LLMs) for mathematical reasoning often relies on accepted traces whose… |
| §436 | Lazy Agents Answer Against Their Own Beliefs: Reinforcement Learning with Verifiable Beliefs Teaches Them to Act on What They Believe | A reinforcement learning method rewards agents for delaying commitment until their inferred posterior over… |
| §437 | Solve Vision with Code: Coding Agents Are Stronger Visual Reasoners Than Video Models | Video generation models are increasingly evaluated as visual reasoners: given a first frame and a… |

### [Model internals](bronnen.md#model-internals)

| § | Titel | Over |
|---|--------|------|
| §36 | LLM-doorloop (bronnenbundel) | Token→blocks→head→KV-cache; overzicht + per-stap bronnen |
| §38 | NCM Just Killed LLM… | Next-Concept Modeling; vs AR/diffusion; anti-hype 31× |
| §40 | MIT Hard Limit LLM Scaling | Superposition → ~1/width; ceiling op width-loss |
| §42 | World Models explained (Caleb) | VAE+MDN-RNN+controller; LeCun/Cosmos/Marble |
| §43 | Limits of LLMs (Caleb) | Hallucinatie/AR; METR; filosofie vs nut |
| §53 | Byte models (Token Ceiling) | Distillatie token→byte; End-Of-Token; hoger plafond bij overtraining |
| §65 | Muon optimizer (bycloud) | Matrix-aware vs AdamW; Newton–Schulz; Kimi 52% FLOPs; Parallax |
| §66 | LeCun world models (ETH) | JEPA/EBM; vs LLM scaling; V-JEPA common sense; AMI Labs |
| §67 | LeCun $1B bet Pt.1 (Welch) | Cake/SSL; blur; Barlow Twins; DINO; JEPA intro |
| §68 | LeCun $1B bet Pt.2 (Welch) | V-/VL-JEPA; VLA critique; LeWorldModel+CEM; hierarchy |
| §147 | Attention Is Not What You Need (short) | Grassmann/Plücker; linear local pairs; toy 18M; repro-gap |
| §193 | Efficient Transformers Survey (Tay) | Taxonomie efficiënte attn; recurrent/sparse/low-rank/kernel |
| §438 | cmHC: Balancing Stream Mixing in Hyper-Connections via Geometric Contraction | Constraining residual stream mixing within the Birkhoff polytope via geometric contraction improves stability… |
| §439 | Distill to Loop: Turning Pretrained Diffusion Transformers into Looped Models with Adjustable Depth | A pretrained diffusion transformer is distilled into a weight-shared looped student that supports variable… |
| §440 | DyLoMo-DiT: Dynamic Looped Mixture-of-Experts Diffusion Transformers | A dynamic looped mixture-of-experts diffusion transformer reuses shared parameters and varies compute across… |
| §441 | Higher-order pruning of experts in mixture-of-experts language models | HOPE is a second-order pruning objective for Mixture-of-Experts language models that accounts for cooperative… |
| §442 | How Do Agentic LLMs Decide to Call Tools? A Tool-Call Vector Shaped by Suppression | Researchers identify a compact internal vector controlling tool-use decisions in agentic LLMs by contrasting… |
| §443 | LoopedWAM: Looped World Action Models for Elastic Inference | World action models (WAMs) couple generative video modeling with robotic action prediction but typically… |
| §444 | LoopTitan: What Does Parameter Revisit Buy a Mixture-of-Experts? | Looped Mixture-of-Experts (MoE) architectures revisit layer parameters across depths. This design increases… |
| §445 | Measuring Layer-wise Intrinsic Dimensionality of FFNs in LLMs via PCA | Large language models exhibit a middle-heavy intrinsic-dimensionality profile in their feed-forward layers,… |
| §446 | MemOnce: A Scalable Memory Architecture for Large Language Models | Deploying large language models (LLMs) in long-horizon and continual interactions requires maintaining… |
| §447 | Mixture-of-Loops Transformer | A Mixture-of-Loops Transformer reuses key-value memory across loops and depths, and its U-shaped variant… |
| §448 | Rewirable Circuits in Transformers with Loom Attention | We propose loom attention, which allows a Transformer to dynamically rewire its circuits at every token by… |
| §449 | Self-WSP: Can Language Models Improve Themselves Through Weight-Space Programming? | Language models can edit their own neural network weights to improve task performance, though the resulting… |
| §450 | Subquadratic Attention with a Hierarchical Tree-Structured Indexer | Zyphra Hierarchical Attention uses a tree-structured index over compressed key summaries to achieve… |
| §451 | Unlocking the Power of Loops in Pretrained LLMs with Loop Residuals | LoopRes enables pretrained large language models to benefit from looped computation by letting layers attend… |
| §452 | WeightCode: Installing New Capabilities into Neural Networks via Weight-Space Programming | Neural networks encode learned capabilities in their weights, yet extending those capabilities with explicit… |

### [Industrie](bronnen.md#industrie)

| § | Titel | Over |
|---|--------|------|
| §39 | AI Race Picks Its Losers | CoreWeave debt, chip-cyclus, profit- vs chip-backed |
| §59 | Xiaomi MiMo RL (bycloud) | Live $M agentic RL; grading; partial rollouts; eval caveat |
| §62 | DeepInfer open (WhatsWithAI) | 155T tok/dag; ~80% margin-claim; wide EP/EPLB; recipe; Ascend |
| §143 | DeepInfer 80% margins (Squintist) | 96% cache-hits; 13× lunch; 72u TTL; commoditize complement; SSD crunch |
| §88 | Switzerland AI research stays? | Papers/capita sterk; weinig VC/exits thuis |
| §453 | Antom 3-in-1 Transformer: A Payment Foundation Model | We report the development of Antom 3-in-1 Transformer, a payment foundation model that integrates sequence,… |
| §454 | Beam Model Technical Report | Beam is a sparse Mixture-of-Experts language model optimized for coding, reasoning, and agentic workloads,… |
| §455 | Beyond Benchmarks: Can Small Open-Weight Models Get Real Coding Work Done? | Empirical studies of open-weight coding agents reveal that verified code success depends on serving setup,… |
| §456 | IQuest-Q1: Advancing Foundation Capabilities for Agentic CLI Systems | IQuest-Q1 is a sparse Mixture-of-Experts foundation model trained via multi-stage pre-training, mid-training,… |
| §457 | K2-Horizon: A Frontier Fleet of Open Source Language Models | We present K2-Horizon, a fleet of six fully open language models, from a 0.9B dense model to a 375B-A23B MoE,… |
| §458 | Our Own Jev: Typed Decisions in One Forward Pass, from an In-House Judge to Open LoRA Models | A typed decision framework using frozen language model backbones with small LoRA adapters and pointer heads… |
| §459 | The Price of Intelligence: A Quality-Adjusted Price Index for AI Services | Quality-adjusted price indices reveal that AI inference costs have fallen far faster than standard methods… |
