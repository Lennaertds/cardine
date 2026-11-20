# Ideeën en open vragen (niet kwijtraken)

> **Rol:** Jouw ruwe vragen/hypothesen voor spoor 3 — vastgelegd vóór ze in § of ADR landen.
> **Niet hier:** feiten met URL (§ in Agent_Engineering `bron/`); harde keuzes (`docs/decisions/`); uitvoerplan (`specs/`).

Stand: 2026-11-07 (A4/B-richting: lichte non-Electron IDE + indexing-first; A6–A9 nog vorm). Bron van **volgorde**: [onderzoek-programma.md](onderzoek-programma.md). Status: `open` / `deels (§…)` / `vorm` (decision-candidate, nog geen ADR) / `later B`.

## A — Onderzoek (feiten → AE `bron/`)

| # | Jouw vraag (parafrase) | Slice | Status | Opmerking |
|---|------------------------|-------|--------|-----------|
| 1 | Wat heeft Cursor; hergebruik vs verbeteren vs niet sturen? | A1 | deels (§9, §13, **§69–§75**) | Werkantwoord ↓; Cloud/Router blogs optioneel |
| 2 | Andere harnesses (DeepSeek Harness, Pi, peers); hergebruik/verbeteren? | A2 | deels (**§76–§79**, **§105–§112**, §33) | Werkantwoord ↓; enforcement > prompts (§107) |
| 3 | Mistral + open-source modellen / efficiëntie? | A3 | deels (**§89–§101**, **§134–§142**) | Werkantwoord ↓; Large 4 LICENSE; Kimi peer |
| 4 | Hoe zit een IDE in elkaar: talen, fork, integraties? | A4 | open (namen §102–§104) | Richting: non-Electron shortlist — zie [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| 5 | IDEs/harnesses tot op het bot vergelijken | A5 | deels (**§80–§86**, **§133**) | Werkantwoord ↓; PKU Harness-Bench Table 2; matrix nog |
| 6 | Standaard in **docs** vs in **code/harness**? | A6 | **vorm** (§113–§117 + §107) | Decision-candidate + docs/code-tabel ↓ |
| 7 | Welke **kwaliteitsgates** wanneer + rood? | A7 | **vorm** (§118–§122 + §117) | Lab-ladder + revert-zin ↓ |
| 8 | Welk **formaat** per documentsoort? | A8 | **vorm** (§123–§127) | Dual-regel + formaat-tabel ↓ |
| 9 | Waar leeft **session/spine** bij map-wissel? | A9 | **vorm** (§128–§132 + §117) | Scope C′ + pad/gitignore ↓ |

---

## Werkantwoorden A1–A5 (nog geen ADR)

Synthese uit bestaande § — genoeg om B te *richten*, niet om te forken.

### A1 — Cursor

- **Hergebruik (ideeën, niet code):** exact/regex-first search (§69) > embeddings-dogma; dynamic context discovery / files-as-tools (§72); path-scoped rules (§13/§127); keep-rate / tool-error als meetlens (§74).  
- **Niet sturen:** feature-pariteit met Composer/Cloud Agents; Cursor-fork.  
- **Verbeteren t.o.v. Cursor (lab-hoek):** `structure` (policy afdwingen, A6) + kwaliteitsladder (A7) + spine die padwissel overleeft (A9) — precies waar Cursor-history faalt (§132).

### A2 — Andere harnesses

- **Pi (§76/§33):** minimale TS-oppervlakte, sessions/tree, packages — sterkste *leer*-basis voor “smalle harness”.  
- **DSH (§77):** plugin-grenzen, session log = model-visible — goed voor seams, niet per se fork.  
- **Cline/OpenCode (§78–§79):** peers voor permissions/AGENTS, niet default stack.  
- **Bouwlessen (§105–§112, §107):** task–harness fit; instructions ≠ enforcement; long-running = progress/handoff.  
- **Richting B (hypothese):** lean TS-harness *à la* Pi-oppervlakte, niet full IDE; plugins later.

### A3 — Open models / Mistral

- **Default lab-LLM:** DeepSeek API (cost-frontier §80; lineage §89–§94) — eigen key.  
- **Kimi/Moonshot peer:** lineage **§134–§142** (K2→K3.1 Pro; MuonClip; KDA; Kimi Code). AA Cyber: K3.1 Pro ~64% vs DS Flash 1017 ~57% (§142); DeepSeek blijft goedkoper/sneller. Meet later H×M met beide.  
- **Mistral:** EU/stage-motivatie + Large 4 watch (§95–§101); geen sole-model tot LICENSE/weights.  
- **Lokaal:** optioneel later (inference-§); lab-dag-0 = API.

### A4 — IDE-anatomie

- **editor ≠ harness ≠ indexing.** Lab-primair = **indexing / Project-Understanding**; harness hergebruiken; IDE-shell = upstream Zed, pinned release, geen fork ([ide-shell](../product/ide-shell.md), [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)).
- Componentkaart: [totaalproduct.md](../product/totaalproduct.md) (9 onderdelen). Shortlist-criteria: vastgelegd in [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md). Indexing: [indexing.md](../product/indexing.md).  
- Listicles (§102–§104) = namenkaart, lage authority. Diepte = native/TUI architecture + plugin/RPC-surface (wantlist), niet VS Code-first.

### A5 — Vergelijking

- **Binding Constraint (§81):** scores zonder harness-disclosure misleiden — altijd H×M noemen.  
- **SWE-Pro / Meta-Harness (§83):** ranking-transfer ≈0; harness wint vaak meer dan model-swap.  
- **HarnessTax (§85):** cost-dominant op sommige benches; Pi vaak Pareto-interessant.  
- **PKU Harness-Bench (§133, arXiv:2605.27922):** 106×6×8; NanoBot **76.2** vs OpenClaw **52.4** (−23.8 pp) op dezelfde model-pool; NanoBot ook laagste tokens; Codex* apart (model-bound). Sterkere models → minder H-variance. Bevestigt “smalle loop” + meet H×M. ≠ TheLime1 §84.  
- **Lab-meetplan later:** vaste H, wissel M (DeepSeek vs Kimi vs frontier); C4 “zonder check” als baseline (A7). Matrixbestand `vergelijking-harness-ide.md` nog te maken.

---

## A6 — verduidelijkt + vorm

### Wat de vraag *niet* / wél is

- Niet: welke P’s; niet “betere prose AGENTS”; niet stack (B).  
- Wel: waar de standaard *executeert* in domein `structure` — docs / code / dual.

### Spectrum

| Pool | Voorbeeld | Kost | Faalwijze |
|------|-----------|------|-----------|
| **A — Docs-only** | Lange AGENTS/RULES | Tokens + drift | Negeren (§20, §107) |
| **B — Code-only** | Alleen hooks/checks | Onderhoud; starheid (§108) | Intent onleesbaar voor mens |
| **C — Dual** | Korte intent-MD + runtime | Beide, docs dun | Drift als docs ≠ code |

### Decision-candidate (nog geen ADR)

> **structure = dual (C):** `AGENTS.md` ≤ ~100 regels = TOC/intent; harde regels in `make check` / path-allowlist / hooks; detail in `docs/` JIT. Nooit “Never X” alleen in prose als het checkbaar is (§113–§115).

### Lab v1 — wat leeft waar

| Soort regel | Docs (MD) | Code / check / hook | Beide |
|-------------|-----------|---------------------|-------|
| Intent, “waarom”, navigatie | ✓ (kort) | | |
| Build/test-commando’s | ✓ (pointer) | ✓ (`make …`) | ✓ |
| Lint/style | pointer | ✓ (linter) | |
| Geen secrets in git / raw | ✓ (RULES) | ✓ (gitignore, hooks) | ✓ |
| Pad-allowlist / geen write buiten apps | kort verbod | ✓ (PreToolUse / later seam-test) | |
| Architectuur-seams | ARCHITECTURE | later structural test | ✓ |
| “Done” / verify | “run make check” | ✓ Stop/check (A7) | ✓ |

### Meten (na stack)

Beide: tokens (AGENTS-size × turns) + naleving (RULES-breuk / check-rood). Lichte sample.

---

## A7 — verduidelijkt + vorm

### Wat wél

Gates **wanneer** + gedrag bij **rood** — niet unit-test-inventaris of CI-vendor.

### Lab v1-ladder

| Gate | Lab v1 | Agent bij rood |
|------|--------|----------------|
| In-loop (LSP / gerichte test) | **Aanbevolen** tijdens slice | Fix of stop; geen “klaar” |
| `make check` | **Verplicht** einde slice / vóór afronden | Niet afronden; fix of **restore slice** |
| pre-commit | **Verplicht** als subset van check (als hooks aan) | Commit weigeren |
| `make check-full` | Pre-merge / pre-release | Niet mergen |
| Opt-in (Strix, obs, perf, …) | Pre-prod / bij risico | Apart; **nooit** always-on in `check` (P25) |

### Revert-beleid (één zin)

> Rood `make check` → geen push; geen “klaar”; fix of `git restore`/`checkout` van de slice — harness mag later Stop-hook op `make check` zetten (§118–§121).

### Commit-default (voorstel)

Geen push zonder groen check. Commit op feature-branch ok als pre-commit groen (WIP toegestaan lokaal).

---

## A8 — verduidelijkt + vorm

### Decision-candidate

> **Publiek bepaalt formaat:** mens-facing = Markdown; agent-/tool-only (logs, traces, metrics, ledger) = schema’d JSON/JSONL/YAML + check/tool. Geen secrets in MD; geen mens-intent alleen in JSON zonder korte MD-samenvatting (§123–§126).

### Lab v1 — pad → formaat

| Pad / glob | Formaat | Wie leest | Agent mag schrijven? |
|------------|---------|-----------|----------------------|
| `docs/product|rules|architecture|how-to/**/*.md` | MD | Mens (+ JIT) | Ja (slice); check links |
| `AGENTS.md`, `.cursorrules` | MD (dun) | Agent (+ mens skim) | Beperkt; geen oracle-edits |
| `docs/decisions/*.md` | MD (+ later optionele YAML FM) | Mens | Ja via `make adr` |
| `docs/work/**` (BACKLOG, specs, logs) | MD | Mens | Ja via make-targets |
| `.pre-commit-config.yaml`, `**/tasks.yaml`, compose | YAML | Tools | Zelden; mens/CI |
| `data/runtime/**`, agent transcripts | JSON/JSONL / binair | Agent + debug | Ja; **gitignore** |
| Skills / `.mdc` | MD + YAML FM | Loader + agent | Ja waar skill-pad |
| Spine (A9): `.agent/` of `.planning/` | JSONL + korte `STATUS.md` | Agent (+ mens STATUS) | Ja; zie A9 ignore |

ADR: MD blijft SoR; optionele FM/index later (§126) — geen parallelle YAML-canon.

---

## A9 — verduidelijkt + vorm

### Productpijn

Cursor-history hangt aan **workspace-pad** (§132). Omhoog / andere root = lege of verkeerde chat. P27: spine buiten chat.

### Spectrum → keuze-kandidaat

| Pool | Oordeel lab v1 |
|------|----------------|
| A — IDE-chat only | **Afgewezen** als enige bron (§132) |
| B — Eén SESSION in repo-root | Te grof voor multi-app |
| C — Per folder / worktree | **Gekozen kern** (§129, §131) |
| D — Expliciete session-id | **Complement** (tool-sessions Pi/Claude in `~/…`, §128/§130) — niet i.p.v. repo-spine |

**C′ (voorstel):** actieve werkmap (app/cwd of git worktree) draagt spine-files; IDE-chat mag leeg na padwissel.

### Conventie (lab v1, nog geen ADR)

| Item | Voorstel |
|------|----------|
| Pad | `<cwd>/.agent/` (of `.planning/` als skill dat afdwingt) |
| Inhoud | `status.md` (mens, kort) + `ledger.jsonl` (machine) + optioneel `progress.md` |
| Git | **gitignore** `.agent/` / `.planning/` (ephemeral); bewust bewaren → `make log` / `docs/work/logs/` |
| Chat | Mag samenvatting houden; SoR voor “wat geprobeerd/werkte” = spine (§117, §131) |
| Tool-sessions | Claude/Pi under home keyed on cwd blijven bestaan; lab vertrouwt ze niet over workspace-grenzen |

---

## B — Keuzes op papier (ná genoeg A)

Niet nu uitvoeren. Pas na A1–A2–A5 (minimaal) + expliciete ja. A6–A9 **voeden** deze lijst:

| B-vraag | Nu gerichte hypothese (nog geen ADR) |
|---------|--------------------------------------|
| Stack | Eigen **indexing** + hergebruikte harness (Pi-/DSH-achtig) + lichte **non-Electron** IDE-shell |
| Basis | Fork of koppeling na A4-score (Zed/Lapce/Helix/Neovim/Kate); geen Electron; geen IDE from-scratch; Cursor mag tijdelijk host blijven tot ADR |
| Verbeteren t.o.v. Cursor | **Indexing** exact-first (§69) als kern; + structure (A6) + check-ladder (A7) + folder-spine (A9) + dual formats (A8); geen Cloud/Composer-pariteit |
| Meetplan | Vaste H, wissel M; C4 zonder check vs check+revert; tokens×naleving (A6); indexing-kwaliteit apart meten |
| Default LLM | DeepSeek API (cost); Kimi peer (§142); frontier optioneel; **geen** eigen inference-serving |

Vastleggen als ADR’s in `docs/decisions/` — zie programma § B.

## Overige ideeën (park)

| Idee | Waarheen later |
|------|----------------|
| Eigen API-keys (DeepSeek e.d.) | CONTEXT/RULES; harness-config na stack |
| Gratis product / portfolio / OS vs closed | BACKLOG Geparkeerd productisatie |
| Thesis-lezer als tweede persona | CONTEXT |
| Stage Mistral (Parijs) / EU AI | Motivatie A3; §95–§101 — geen solicit-plan hier |

## Hoe we dit aanpakken (kort)

Zie [onderzoek-programma.md](onderzoek-programma.md). A6–A9 hebben decision-candidates; A4 + A5-matrix + experimenten na stack blijven open. Geen kit-edit / geen ADR zonder ja.
