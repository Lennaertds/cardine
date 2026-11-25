# Language migration — Dutch to English

> **Role:** the plan and live status of moving the whole repo to English. One row per phase, updated as work lands.
> **Not here:** the decision itself ([ADR 0018](docs/decisions/0018-english-is-the-only-project-language.md)); the day-to-day rules ([AGENTS.md](AGENTS.md)).

## Goal

Every doc, every code comment, and every user-facing string in this repo is in English.
No Dutch, no French. The only exception is `bron/`, which stays Dutch as a source archive.

## Decision record

- [ADR 0018](docs/decisions/0018-english-is-the-only-project-language.md) — English is the only project language.
- Supersedes the `Taal: Nederlands` line that used to sit in `AGENTS.md`.

## Phases

| # | Phase | Scope | Status |
|---|-------|-------|--------|
| 0 | Guardrails | ADR, `AGENTS.md` rule, `make lang-check`, directory renames | **done** |
| 1 | Public face | `README.md`, `packages/*/README.md`, `packages/*/docs/`, CLI help | **done** |
| 2 | `docs/` | 97 files, subfolder by subfolder | **done** |
| 3 | Standard + kit | `standard/`, `sjablonen/`, `kit/` (+ mirror), three-place per topic | **done** |
| 4 | Code | ~80 scripts: comments, output, error strings | **done** |
| 5 | Cleanup | leftover Dutch, link sweep, final `make check` | **done** — see the notes on ADR filenames and npm |

## Out of scope

- **`bron/`** — source notes and snapshots stay Dutch. They are an archive of material read in Dutch; translating them would rewrite cited sentences. Revisit only on explicit request.

  One exception, applied in Phase 0: **link targets inside `bron/` were updated** to the renamed directories (`../meten/` → `../measurement/`). That is not a rewrite of source text — it is keeping the archive navigable. Prose, headings and link labels stay Dutch.

## Rules during the migration

1. **One phase per commit.** A phase that fails `make check` does not get committed.
2. **`make links` after every folder.** A translated link is a broken link.
3. **History is not translated.** Old entries in `docs/work/logs/` and released CHANGELOG sections keep the language they were written in. New entries are English.
   ADRs are translated to English, because they are read as current rules, not as a diary.
4. **`bron/` untouched**, except one kind of change: the *paths* of files that were renamed
   (link targets and code spans). Renaming a file would otherwise leave the archive pointing
   at a file that no longer exists. Prose, headings and labels stay Dutch.
5. **The kit mirror stays identical.** After any `kit/` change, run `make sync-kit` and confirm with `bash packages/structure/sync_kit.sh --check`.

## Status

### Phase 0 — guardrails

- [x] ADR 0018 written
- [x] `AGENTS.md` language rule changed to English
- [x] `make lang` added (`packages/lab/scripts/check-language.sh`)
- [x] `make lang` wired into `make check` (Phase 5, `check: lang links $(CHECK)`)
- [x] Directories renamed: `nieuw-project/` → `new-project/`, `bestaand-project/` → `existing-project/`, `meten/` → `measurement/`, `standaard/` → `standard/`
- [x] Every path reference to the renamed directories updated (75 files)
- [x] `make check` green

#### Counting method

The counts during the migration were taken with the guard, which walked the repo
outside `bron/` and history. Phase 0 started at **6466 hits**. The number went down
per phase as folders landed; the last full sweep brought it to **0** (see Phase 5).

### Phase 1 — public face

- [x] `README.md` (root) — plus a stale version table corrected
- [x] `packages/lab/README.md`
- [x] `packages/structure/README.md`
- [x] `packages/lab/docs/` (`cardine-lab.md`, `VERSIONING.md`)
- [x] `packages/structure/docs/` (`cardine-structure.md`, `VERSIONING.md`)
- [x] `docs/packages/` (`INDEX`, `cardine-meta`, `cardine-lab`, `cardine-structure`, `VERSIONING`, `IMPLEMENTATION`)
- [x] `docs/decisions/packages-context.md` — anchor source for the READMEs
- [x] CLI help in `bin/cardine`, `packages/lab/bin/cardine-lab`, `kit/new-project.sh`
- [x] Version bumps: meta 0.4.1, lab 0.5.2, structure 0.5.1, each with a CHANGELOG entry

**Anchor dependency:** `packages-context.md` had five Dutch heading anchors that
eight other files linked to. `make links` does not check anchors, only file
existence, so a translated heading breaks links silently. Translated together
with all eight referrers. **Do this for every file others link into.**

**Not translated, on purpose:** profile names (`studie`, `schoolwerk`) and the
`sjablonen/` directory name. Profile names are data — the `.profile` files are
named after them and renaming them is a behaviour change, not a translation.

### Phase 2 — `docs/` (done)

- [x] `architecture/` — plus the four check scripts that assert on its headings
- [x] `product/`
- [x] `how-to/`
- [x] `context/`
- [x] `rules/`
- [x] `packages/` (done in Phase 1)
- [x] `agent/`
- [x] `decisions/` — all 19 ADRs, bodies translated, filenames kept
- [x] `work/` — templates and BACKLOG; historical logs untouched

**What made Phase 2 risky — and the rule it produced**

Several scripts assert on exact Dutch headings in docs and `die` when one is
missing:

| Script | Asserts on |
|--------|------------|
| `deps-audit.sh` | `## Relaties tot andere docs`, `## Ritueel`, `## Bewust later`, … |
| `perf-check.sh` | `## Lagen (prioriteit)`, `## Anti-patronen`, … |
| `polyglot-check.sh` | `## Beslisboom`, `## Integratievormen`, … |
| `digest-check.sh` | `## Bronnenlijst`, `## Commando's`, `## Bewust later` |

**Rule: a doc with an asserted heading is translated in the same commit as its
script, and in both copies** (`docs/…` and `kit/…/docs/…`). Verified each time by
running the script.

Other code-coupled strings translated with their consumers:
- `cardine-secrets-guard/index.js` — the refusal message; `index.test.js` asserts on it (8 tests green).
- `docs/architecture/test_prompt.md` — asserts on the refusal text `outside the workspace` and on the `sandbox-check` output prefix.
- `Makefile` `finish` — writes under `## Done` now; `docs/work/logs/_template.md` matches.

**New anchor checker.** `make links` validates file existence, never `#fragments`.
A translated heading breaks anchors silently. `tmp/langtools/anchors.py` checks
every in-repo fragment against the actual heading slugs. Before Phase 2 it found
21 broken anchors; the 8 research anchors were fixed on the way.

### Phase 3 — standard + kit (done)

- [x] `standard/` — all 14 files translated (433 → 0 hits)
- [x] `sjablonen/` — all 42 guides translated (518 → 0 hits); shared section vocabulary
      (When · Filling in · Example · Quick check) applied file-wide first, then prose
- [x] `kit/` — every file translated (`kern/`, `solo/`, `team/`, `logging/`, `profiles/`,
      `stacks/`, all modules including the 44 craft files of `design/`): 1266 → 0 hits
- [x] Directory rename inside the kit: `kit/logging/logs/onderwerpen/` → `topics/`
- [x] File renames whose names carried Dutch words: `standard/bestanden.md` → `per-file.md`,
      `standard/loggen.md` → `logging.md`, `standard/waar-hoort-dit.md` → `where-does-this-belong.md`,
      `sjablonen/loggen.md` → `logging.md`, module `herordening/` → `reorganise/` (+ CLI argument in
      the docs that pass `--modules`), example ADR `0000-voorbeeld-…` → `0000-example-…` in all three trees
- [x] `stacks.md` headings renumbered to English (`## 1. Every app`, …); all eight anchors and their ~20 referrers updated in the same commit
- [x] Content drift found while translating and fixed: `profielen.md` claimed `make finish` logs to
      `work/sessies/` (it writes `docs/work/logs/<date>.md`) and that `make deadline` is a project
      target (it comes from the profile's `local.mk`); `kit/modules/design/.../type.md` was missing a
      title; `kit/kern/docs/architecture/ARCHITECTURE.md` was still this repo's own lab architecture —
      now a generic template, so a generated project no longer ships dead links
- [x] P28 heading is `## Deliberately later` everywhere (the five check scripts assert it); the P28
      note sits in the section body
- [x] Renamed `make meeting met=` → `with=` and the studie profile's `make deadline DATUM/TAAK/VAK` → `DATE/TASK/COURSE`
- [x] Lab/kit script copies reconciled: ten `packages/lab/scripts/*.sh` were stale Dutch copies of
      `kit/kern/scripts/*` (same logic, older wording); the clean kit version is now in the lab
      package, which is what `make perf-check`, `deps-audit`, `radar-check` and friends run
- [x] `make test-kit` green (17 failures at the start of the phase), `make sync-kit --check` identical,
      `make check`, `make links` green

**History not rewritten.** A global rename briefly reached one dated entry in `bron/status-log.md`;
that line was reverted. `bron/` changes remain link targets only.

**Dead anchors found, to fix in Phase 5.** `tmp/langtools/anchors.py` (Phase 2) skips `./`-prefixed
targets and links inside code fences in tables, so it misses a few: `existing-project/3-feedbacklus.md`
→ `#stap-g-1-…` (Phase 2 renamed the heading in `gymfreak.md` but not the referrer),
`existing-project/7-measure-and-record.md` and `new-project/1-copy-the-kit.md` →
`standard/INDEX.md#de-standaard-veranderen`, `sjablonen/agents-root.md` →
`new-project/4-agent.md#test-with-a-fresh-agent`, plus three inside `bron/` and
`docs/product/totaalproduct.md`.

**Guard fix (Phase 3).** `make lang` scanned with `grep` and `2>/dev/null`; an invalid pattern
made the scan return nothing, so the guard said "green" while thousands of Dutch lines remained.
The scan now runs in Python with Unicode-aware word boundaries, the same word list, exclusions and
output format. Verified both ways: a Dutch probe line is caught, English decoys ("All in one pager",
"snowflake", "profile") pass. The first honest count was **4407**; the earlier per-area tables
(6081, 6335) were undercounts from the same blind spot.

### Phase 4 — code (done)

- [x] `scripts/` — test-kit, bootstrap, tag-kit, the digest scripts, installers
- [x] `packages/lab/*.sh` — `cardine-status.sh`, `install-lab.sh`
- [x] `packages/lab/scripts/*` — the sandbox/secrets checkers, `secrets-apply`, `digest-week`, the timers stub
- [x] `packages/lab/cardine-*/*.js` — secrets guard, slice check (guard tests: 8/8 green)
- [x] `packages/structure/sync_kit.sh`
- [x] Lab/kit copes reconciled (see Phase 3); `make check`, all checkout scripts parse, `node --test` green
- [x] Root `Makefile`: every `## help` line, section header and error message; `make help` is fully English

### Phase 5 — cleanup (done)

- [x] `new-project/`, `existing-project/`, `measurement/`, `BOOTSTRAP.md`, root files, `.github/`, `data/`
- [x] **ADR filenames translated.** Phase 2 had kept them; a guard that treats a file name
      as Dutch text cannot pass while they stay Dutch. All 17 renamed by a word map
      (`0001-runtime-stack-bewust-uitgesteld-…` → `0001-runtime-stack-deliberately-deferred-…`,
      …), every reference updated in one pass (45 files), `make links` and the anchor checker green.
      **This changes the URL of every ADR.** Old GitHub links and old bookmarks to
      `docs/decisions/NNNN-<dutch-slug>.md` break; the number still identifies the ADR.
- [x] Other file renames in the sweep: `new-project/{1-kit-kopieren,2-context-en-grenzen,
      3-apps-en-feedbacklus,6-onderhoud,minimaal}.md`, `existing-project/{1-nulmeting-en-inventaris,
      5-verhuizen,6-router-en-kaart,7-meten-en-vastleggen}.md`, `measurement/4-review-en-analyse.md`,
      `docs/research/{onderzoek-programma,ideeen-en-vragen}.md`, `docs/work/specs/{FIX-OMGEVING → FIX-ENVIRONMENT,
      RECENTE_FIXES → RECENT-FIXES, lab-en-structure-testronde, lab-andere-linux, bootstrap-geen-stack-tot-adr}`,
      `existing-project/voorbeelden/` → `existing-project/examples/`
- [x] **Anchor sweep.** Every translated heading broke the anchors that pointed at it.
      Mapped each to its new slug (`#wat-je-kopieert` → `#what-you-copy`,
      `#de-standaard-veranderen` → `#changing-the-standard`, `#toets-met-een-frisse-agent` →
      `#test-with-a-fresh-agent`, `#stap-g-1-…` → `#step-g-1-…`, `#dekking-coldtea-bron-34` →
      `#coverage-coldtea-source-34`, …). `tmp/langtools/anchors.py` now reports **0** broken
      anchors outside `bron/`.
- [x] The four stack guides' links to `standard/stacks.md` were relative paths that can never
      resolve from inside `kit/`; they are now absolute from the repo root. `make links` still
      skips the kit layers on purpose (they only line up once copied).
- [x] **Guard green.** `make check` runs `lang` first. The guard ignores what legitimately
      stays: `bron/` and links into it, historical logs, released CHANGELOG entries, the
      guard's own word list, one example-project file name, and old wording under a
      `_LEGACY_WORDING` line in a test that asserts it is gone.
- [x] `make check`, `make links`, `make test-kit`, `make lang` and `node --test` all green;
      `make sync-kit --check` reports the mirror identical

**Open: npm verification.** The README and package pages are verified on npm at publish
time; nothing in this migration was published, so Phase 1's version bumps (meta 0.4.1,
lab 0.5.2, structure 0.5.1) still need a release to appear there.

**Found but not fixed (outside the migration's scope):**

- `make links` never checks `#fragments`; the anchor checker lives in `tmp/langtools/anchors.py`
  and is not in `make check`. Promoting it would have caught the anchors above automatically.
- The lab package carries its own checkers next to `kit/kern/scripts/`; ten pairs are identical and
  four differ on purpose (`check-links.sh`, `digest-rss.py`, `digest-check.sh` adds the lab's triage
  check, `digest-week.sh` is lab-only). Nothing makes the identical ones stay in step.
- `configs` in `profielen.md` was right that `make deadline` comes from the profile, but the
  `EXTRA_DIRS` variable is read by nothing: the extra files are copied from
  `kit/profiles/extra/<name>/` regardless.
- `ADR 0018` asks for English everywhere and names directory renames as the risky step; it says
  nothing about ADR file names. Phase 5 translated those too, so the decision still holds and
  no ADR needed changing.
