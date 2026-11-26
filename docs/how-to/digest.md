# How-to — digest (inbound)

> **Live digest:** `make digest-day`, feeds in `bron/digest/`, weekly briefs in `bron/weken/`. All of it in this repo.
>
> **Role (legacy lab):** fetch feeds, draft proposals, curate into the radar — without a dump as the SSOT.
> **Not here:** ring choices ([radar.md](../research/radar.md)); the content of feeds.

## Requirement

The `research` module (`docs/research/digest/`). Without it, Make explains how to add the module.

## Check / reminder

```bash
make digest-check
make digest-reminder
```

## Fetch

```bash
# 1. Sources
cp docs/research/digest/SOURCES.example.md docs/research/digest/SOURCES.md
# fill in real https://… feeds

make digest-fetch                          # live HTTP (curl/wget)
DIGEST_DRY_RUN=1 make digest-fetch         # only show URLs
DIGEST_FIXTURE=docs/research/digest/fixtures/example.rss make digest-fetch   # offline
```

Output: `data/external/digest/<date>-<slug>/{source.txt,raw.xml|raw.json,items.md}`.

## Proposal (no auto radar)

```bash
make digest-propose
DIGEST_DRY_RUN=1 make digest-propose
```

Writes `docs/research/digest/proposals/<date>-draft.md`. Copy accepted rows **by hand** into `radar.md` (P5).

Team CI: `.github/workflows/digest.yml` (dispatch/cron) → a draft PR containing only `proposals/`.

## Weekly + systemd (papers)

The arXiv RSS feed refreshes **daily** (no weekend). HF Daily Papers go through a JSON API (`/api/daily_papers`, topic `/api/papers/search`). Hence:

| When | Command | Effect |
|------|---------|--------|
| Mon–Fri ~07:00 | `make digest-fetch` | Dumps in `data/external/digest/` |
| Mon ~07:30 | `make digest-week` | Fetch + propose + weekly brief in `bron/weken/YYYY-Www.md` |

By hand:

```bash
make digest-week                         # today: current week (on Mon: previous week)
DIGEST_WEEK=2026-W44 make digest-week    # a specific ISO week
DIGEST_WEEK_SKIP_FETCH=1 make digest-week
```

Scheduling: **systemd user timers** (no `cronie` on this machine). Once:

```bash
bash packages/lab/scripts/install-digest-timers.sh
systemctl --user list-timers 'digest-*'
```

Units live in `packages/lab/systemd/`; log: `data/external/digest/cron.log`.
The timers run while your user session is active (`Persistent=true` catches up missed runs). Without a login session: `loginctl enable-linger "$USER"`.

A weekly brief is **not** an automatic source entry. Curating stays below.

## Curating

1. Review the proposal (`proposals/`) or the weekly brief (`bron/weken/`).
2. Relevant to the lab → Trial/Assess on `radar.md`, or an ADR / `wantlist.md`.
3. Chosen hits → `bron/bronnen.md` (a new §) plus the index; update the status in the weekly brief.
4. YouTube etc.: to the inbox, or straight to a § with a short note in the weekly brief.

## Promote: week letter → § per theme (agent-assisted)

`digest-triage` only answers *keep or skip*. Promoting does the rest in three
steps. **P5 still holds: nothing lands in `bronnen.md` without a filled-in decision.**

| Step | Command | Effect |
|------|---------|--------|
| 1 | `make digest-promote` | Keep rows → `bron/weken/<WEEK>-promote/<theme>.md`, one file per theme, each entry with link, source, proposed theme, abstract + HF `ai_summary` |
| 2 | *(agent or you)* | Fill `decision`, `theme`, `kern` and `relevance` per entry |
| 3 | `make digest-place` | Accepted entries → end of their theme, with a real `§`, an index row and the `Bronnen tot §N` counter |
| 4 | `make digest-verify` | Read-only gate: drafts, § numbers, index and counter agree |

```bash
make digest-promote                       # current ISO week
make digest-promote WEEK=2026-W48 FORCE=1 # regenerate (refuses if drafts exist, to protect in-progress work)
make digest-place WEEK=2026-W48 DRY_RUN=1 # print the plan, write nothing
make digest-place ALLOW_PARTIAL=1         # place valid entries, report the rest
make digest-verify WEEK=2026-W48
```

**The agent procedure.** `digest-promote` proposes a theme from title + abstract,
but that is a *starting point*, not a classifier. Measured against the 263
human-reviewed W48 placements, the keyword router agrees on ~45% of candidates;
when it commits it is right ~2/3 of the time, and ~1/3 it answers `uncertain`.
Treat a proposal as a hint, never as the answer. So the agent:

1. reads the drafts (the abstract is in each entry — no need to fetch the paper);
2. judges worthiness against the bachelorproef / the theme;
3. sets `theme:` to an **exact H1** from `bronnen.md`, writes `kern` (Dutch, 2–3
   factual sentences) and `relevance` (one line), or `decision: skip`;
4. runs `make digest-place`, then `make digest-verify`.

`digest-place` refuses — and writes nothing — when a theme is not an exact H1, a
`kern` is empty or still a template, a decision is missing, or the link is
already in `bronnen.md` (so a re-run never creates a second §). It inserts per
theme **bottom-up** (each insert shifts every later line) and aborts if any §
would land outside a theme. `make digest-verify` flags missing/duplicate §, index
drift, a wrong counter and a paper in two §§.

New themes start life as a shell (`# Title`, one `>` line, `---`) so that
`digest-place` has a target; add a matching `### [Title]` table to
`bronnen-index.md` or `digest-verify` reports the missing rows.

Putting an accepted hit in the weekly brief's status column stays a manual choice.
