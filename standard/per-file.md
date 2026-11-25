# Per file: reader, content, limits

> **Role:** For every fixed file: who it is for, what belongs in it, what does not, and how long it may be.
> **Not here:** how to fill it in and examples ([sjablonen](../sjablonen/INDEX.md)).

| File | Reader | What is in it | What is **not** in it | Target length |
|------|--------|---------------|-----------------------|---------------|
| `README.md` | Human | What the project is, why, quickstart, link to `docs/INDEX.md`, demo link | Status, backlog, folder tree, agent instructions | 30–80 lines |
| `AGENTS.md` | Agent | Daily: hard boundaries, short command table, hard read routes (UI → `DESIGN.md`, feature → `PRODUCT.md`, architecture → `ARCHITECTURE.md`, research → `RESEARCH.md`), one sentence on opt-in → INDEX/`make help`, when to use subagents, intent/seams/slice/reporting in short form, finishing | Repo overview, keyword catalogue of rarely used docs, eight rows of opt-in Make targets, numbered always-on routes for obs/perf/…, polyglot always-on under Never, style rules a linter enforces, status, write-permission table (`write-rules`), long role essays | 35–70 lines |
| `.cursor/agents/<role>.md` | Cursor subagent | Frontmatter (`name`, `description`, optional `model`/`readonly`) + short working method and which docs/code that role opens | A copy of `AGENTS.md`, status, folder tree | ≤ 40 lines |
| Nested `AGENTS.md` | Agent | What differs only in this app: commands, patterns, one example file | Repetition of the root | 10–40 lines |
| `.cursorrules` (solo) | Cursor | Reference to `AGENTS.md`, personal preferences (language, tone, browser check), Cursor-specific agreements | Anything that is in `AGENTS.md`: Cursor loads both, so every repetition counts twice and can clash | ≤ 15 lines |
| `.cursor/rules/*.mdc` | Cursor (glob/description) | Only what nested `AGENTS.md` cannot do: path- or type-scoped rules | A copy of AGENTS, human docs, `alwaysApply: true` for what applies to every task (that belongs in AGENTS); no mass docs→mdc move | As short as nested AGENTS; audit in [cursor-rule](../sjablonen/cursor-rule.md) |
| `apps/<app>/README.md` | Human | What the app does, how to run it on its own, link to the root | Architecture, repetition of the root README | 10–30 lines |
| `docs/INDEX.md` | Both | Per file: which question it answers, and when **not** | The content itself | 1–2 lines per file |
| `context/CONTEXT.md` | Both | Domain, user or client, goal, scope, what we deliberately do not | Technical detail | 30–100 lines |
| `context/GLOSSARY.md` | Both | Term → meaning → name in the code (table, module, type). Also project codes and the list of domains ([stacks](stacks.md)) | Explanations of general concepts | As long as needed |
| `context/vision.md` | Both | Why it exists in the long term, the direction, what it might one day become | What is being built now (`product/`), planning (`work/`) | 30–150 lines |
| `context/assignment.md` | Both | Assignment, assessment criteria, deadlines, contacts, with a link to the original source | How you solve it | As short as the assignment |
| `rules/RULES.md` | Both | Content boundaries ("no medical advice", "Postgres is the only writer") | Code style (linter), working method (`AGENTS.md`) | Short; every rule counts |
| `product/PRODUCT.md` | Both | The domains in one table (name, one sentence, link) and a "Deliberately not" section | Behaviour of one domain, technical detail | 30–80 lines |
| `product/<domain>.md` | Both | What the user can do, the rules (intent + why + test), edge cases, acceptance from the user's side | Implementation, status; a test that weakens the rule does not count as a guard | Free |
| `design/DESIGN.md` | Both | Entry point for every UI task: principles, what is never allowed, tokens, map to one craft file | A copy of the token values (those live in the code); the whole craft folder at once | 40–120 lines |
| `design/shared/<x>.md` | Both | Floor for all surfaces: a11y, never, glass (module `design` delivers the house standard) | Product IA, token values | Free |
| `design/desktop/**` | Both | Showcase gate, performance, landing page craft | Product logger, project chrome | Free |
| `design/iphone/**` | Both | Touch, motion, materials, application craft (controls, surfaces, overlays) | lat/session chrome (project) | Free |
| `design/<topic>.md` | Both | Extra craft outside the house-standard folders | Other topics | Free |
| `architecture/ARCHITECTURE.md` | Both | Containers, their connections, stack, dataflow, invariants, **seams** (the seams + what AI may do without approval), gates, hosting, what is in git and what is not | File listing, code details, route lists, PWA/offline/push catalogue, auth-flow dump, feature lists (→ `architecture/<subsystem>.md`) | 60–100 lines (thicker = split) |
| `architecture/security.md` | Both | Data, secrets, auth, Strix; **`## Deliberately incomplete` (P28)** (P28) | The "never" rules themselves (`AGENTS.md`) | 40–150 lines |
| `architecture/observability.md` | Both | Signals, LGTM, correlation, Make; **`## Deliberately incomplete` (P28)** (P28) | Security threats, container diagram, budgets | 40–120 lines |
| `architecture/performance.md` | Both | Budgets, anti-patterns, bench; **`## Deliberately incomplete` (P28)** (P28) | Dashboards (`observability.md`) | 40–120 lines |
| `architecture/dependencies.md` | Both | CVE audits, ritual, faster deps; **`## Deliberately incomplete` (P28)** (P28) | Strix (`security.md`) | 40–120 lines |
| `architecture/polyglot.md` | Both | Decision tree for an extra/native language, FFI/sidecar, agent boundaries; **`## Deliberately incomplete` (P28)** (P28) | Budgets (`performance.md`); STRICT CI (`how-to/native-ci.md`) | 40–120 lines |
| `decisions/0000-example-native-module-after-budget-breach.md` | Both | Example ADR shape for native after a budget breach (status *example*) | Active project ADRs (`make adr`) | Short |
| `how-to/security-scan.md` | Both | Installing and running Strix | Threat list (`security.md`) | Short |
| `how-to/perf-bench.md` | Both | `perf-check` / `bench` and `scripts/bench.sh` per app | The budgets themselves (`performance.md`) | Short |
| `how-to/deps-audit.md` | Both | `deps-audit` and audit tools | Policy/ritual (`dependencies.md`) | Short |
| `how-to/native-ci.md` | Both | Soft vs `NATIVE_STRICT` / `check-full` / `native.yml` | Decision tree (`polyglot.md`) | Short |
| `architecture/data-model.md` | Both | Entities, relations, who writes what, retention periods | Column by column, if that is readable in the migrations | Free |
| `architecture/<x>.md` | Both | Contracts, schemas, algorithms, edge cases of one subsystem | Other subsystems | Free |
| `research/RESEARCH.md` | Both | Research questions, how you judge sources, map of the folder | The content per topic | 20–60 lines |
| `research/<topic>.md` | Both | What the literature or the domain says, with sources, and which product rule rests on it | How it is implemented | Free |
| `research/wantlist.md` | Both | Sources you still want to acquire, with why | The sources themselves (`data/external/`); stack choices (`radar.md`) | Keep it short |
| `research/radar.md` | Both | Tech radar Adopt/Trial/Assess/Hold; ritual; **`## Deliberately incomplete` (P28)** (P28) | Always-on AGENTS; live scrapers | 40–120 lines |
| `research/digest/README.md` | Both | Inbound digest, fetch/propose, P5; **`## Deliberately incomplete` (P28)** (P28) | Ring content (`radar.md`); auto-merge | 40–100 lines |
| `how-to/radar.md` | Both | `radar-check` / `radar-reminder` and the monthly pass | Ring content (`radar.md`) | Short |
| `how-to/digest.md` | Both | `digest-check` / fetch / propose | The feed content itself | Short |
| `research/experiments/*.md` | Both | Question, setup, data (path and date), result, conclusion, what the product does with it | Code (in `apps/<x>/experiments/`) | 20–80 lines |
| `business/*.md` | Human | Business plan, pricing, terms, privacy policy in plain language | The technical implementation of privacy (`security.md`) | Free |
| `how-to/<task>.md` | Both | Numbered steps with commands and the expected outcome | Background (that is explanation or an ADR) | Short |
| `decisions/DECISIONS.md` | Both | Active decisions: number, title, link. Superseded decisions at the bottom or removed | The content of the decisions | 1 line per decision |
| `decisions/NNNN-*.md` | Both | Status, context, decision, alternatives, consequences | Implementation steps, work status | 15–60 lines |
| `agent/write-rules.md` | Agent, when writing | Which paths are free, which need permission, which never | Working method and read routes that apply to every task (`AGENTS.md`) | One table |
| `agent/doc-conventions.md` | Agent, when writing | Notation, tone, tables, structure of a doc | Content | 20–60 lines |
| `agent/lessons.md` | Agent, on meta tasks | Lessons after failures that do not apply to every task | What applies to every task (one line in `AGENTS.md`) | Short |
| `agent/prompts/*.md` | Human | Prompts you reuse | Explanation about the agent | Per prompt |
| `deliverables/*` | Human | What you delivered, as you delivered it | Truth: a deliverable links to docs, never the other way round | — |
| `work/BACKLOG.md` | Both | **Index** of open work (Now / Later / Parked): a short line + link to the spec; a new Now item only via `make spec` | Plan, slices, essay, finished work (→ specs / logs / git) | Keep it short |
| `work/specs/*.md` | Agent | Plan per work item: goal, scope, out of scope, touchpoints (incl. seams), slices (one session each), acceptance on intent + `make check` | After merge: nothing left, so deleted; no replacement of the BACKLOG index | Per task |
| `work/logs/*.md` | Human | What happened, what went wrong | Truth (that lives in docs) | Free; not read up front |
| `work/meetings/*.md` | Human | Who was there, what was decided, actions | The decision itself (that becomes an ADR) | Short |
| `archive/*` | Human | Replaced docs, with what replaces them and why at the top | — | — |
| `data/README.md` | Both | Per dataset: path, origin, licence, personal data, in git yes or no, how to recreate it | Schema in detail (`data-model.md`), pipeline (`architecture/`) | One table |

---
