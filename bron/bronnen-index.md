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

### 4. [Loop Engineering](bronnen.md#loop-engineering)

| § | Titel | Over |
|---|--------|------|
| §26 | What Is Loop Engineering? (IBM) | Self-prompting, triggers, risico's (*comprehension debt*) |
| §27 | Loop Engineering Explained (Caleb) | Stack Prompt → Context → Harness → Loop |

---

## Kernpraktijk

### [Graph Engineering](bronnen.md#graph-engineering)

| § | Titel | Over |
|---|--------|------|
| §28 | Graph Engineering Explained | Multi-agent DAG's, 100+ nodes, deep research |

### [Workflow & Specs](bronnen.md#workflow--specs)

| § | Titel | Over |
|---|--------|------|
| §1 | Complete AI Coding Workflow | Grill → Spec → Tickets → Implement + sub-agent review |
| §4 | `/wayfinder` | Plannen zonder waterfall; beslissingsgrafiek |
| §6 | Why Software Factories Fail | Anti lights-off; pre-planning en code review |
| §7 | Full Walkthrough: Workflow for AI Coding | End-to-end masterclass (smart zone, vertical slices, AFK) |
| §37 | Karpathy's Method (Austin Marchese) | Spec → Verifier → Environment |
| §41 | Karpathy × Sequoia (AI Ascent) | Vibe coding → agentic engineering; Software 3.0 |

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

### [Ship quality](bronnen.md#ship-quality)

| § | Titel | Over |
|---|--------|------|
| §47 | Strix (AI pentest agents) | Gevalideerde exploits, CI/SARIF, bootstrap-kandidaat security |
| §48 | Observability (breed) | Logs→metrics→traces→correlatie→alerts→SLOs→cardinality + perf/security |

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

### [Reasoning](bronnen.md#reasoning)

| § | Titel | Over |
|---|--------|------|
| §35 | Hybrid Reasoning Agents | Latent ↔ text via HybridLink; HybridSFT/RL; HF HybridAgent-14B |
| §46 | HRM & TRM (bycloud 27M) | Video-naslag: ARC-illusie, HRM two-timescale, TRM 7M + recursie vs layers |
| §148 | Lacuna / alien space (Better Stack) | Idea atoms; zinnig∧onwaarschijnlijk; ICLR oral top-25; paywall-limiet |

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

### [Industrie](bronnen.md#industrie)

| § | Titel | Over |
|---|--------|------|
| §39 | AI Race Picks Its Losers | CoreWeave debt, chip-cyclus, profit- vs chip-backed |
| §59 | Xiaomi MiMo RL (bycloud) | Live $M agentic RL; grading; partial rollouts; eval caveat |
| §62 | DeepInfer open (WhatsWithAI) | 155T tok/dag; ~80% margin-claim; wide EP/EPLB; recipe; Ascend |
| §143 | DeepInfer 80% margins (Squintist) | 96% cache-hits; 13× lunch; 72u TTL; commoditize complement; SSD crunch |
| §88 | Switzerland AI research stays? | Papers/capita sterk; weinig VC/exits thuis |
