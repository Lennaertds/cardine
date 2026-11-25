# Backlog

> **Role:** an **index** of open work: one short line per item plus a link to the spec. No plan, slices or essay here.
> **Not here:** the plan ([specs/](specs/)), finished work (git and `logs/`), decisions (`decisions/`).

A new item under **Now** (or Parked with a plan): only through `make spec s=<slug>` — that writes both the index line and the spec. Pasting a long row into this table by hand is wrong. **Later** allows one short line without a spec (until you promote it with `make spec`). The category is a column, not a directory.

Finished items have been removed from this index; the documentation lives in [product/](../product/) and [decisions/](../decisions/).

## Order (whole product)

Work **one step at a time**. Relations and groups: [totaalproduct.md](../product/totaalproduct.md). The next completion is the personal stack on Arch Linux Hyprland, not the guide ([ADR 0012](../decisions/0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md), [ADR 0013](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md)).

| Step | Spec / doc | Why here |
|------|------------|------------------|
| — | [bootstrap-no-stack-until-adr](specs/bootstrap-no-stack-until-adr.md) | Continuous: no `apps` or generators until an ADR |

Finished steps 0–8 (framework through session spine) are in [product/](../product/) and [totaalproduct.md](../product/totaalproduct.md#order-of-deciding-no-code-before-an-adr). No code and no `--starter` until a runtime ADR. [0001](../decisions/0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) stands; [0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) is the harness import, not an app stack.

## Now

| Order | Item | Category | Status |
|------|------|-----------|--------|
| — | [bootstrap-no-stack-until-adr](specs/bootstrap-no-stack-until-adr.md) | bootstrap | open (guardrail) |
| 1 | [lab-and-structure-test-round](specs/lab-and-structure-test-round.md) | packages | Test and fix towards the next versions — prove it works first, extend only after that |
| — | [FIX-OMGEVING](specs/FIX-ENVIRONMENT.md) | harness | Code landed (bind, never, write tools off). Zed/DSH restart still needed |
| — | [lab-macos](specs/lab-macos.md) | packages | packages/lab/ working on macOS (Intel + Apple Silicon) |
| — | [lab-other-linux](specs/lab-other-linux.md) | packages | extend packages/lab/ to Debian, Fedora, openSUSE |

## Later

| Item | Category | Why later |
|------|-----------|--------------|
| Try Zed itself, as the pinned upstream | product | Before indexing. The complaints are in [ide-shell](../product/ide-shell.md) |
| A new Zed thread sees `mcp__jarvis__searchCode` | harness | The mount is in place. A thread from before the insert is not |
| The A5 H×M matrix (after enough harness and LLM direction) | research | Feeds ADR step 4/6 |
| Indexing baseline against `rg` | product | Described in [indexing.md](../product/indexing.md). |
| Runtime + `--starter` and generators | apps | After the ADRs; bootstrap guards it |
| Put the API key into `~/.dsh/.env` yourself | harness | How-to [lab install](../how-to/zed-dsh.md); the value is still missing |
| [tokenlogger](specs/tokenlogger.md) | harness | Per-turn token tracking for cost insight and H×M measurements |
| Seam tests | architecture | Only after the stack |
| OTel / `make obs-*` | observability | No app |
| Performance budgets + `bench.sh` | performance | No measurement path without a runtime |
| Strix install + key | security | No network-facing app yet |

## Parked

| Item | Category | Waiting on |
|------|-----------|----------|
| Thesis deliverable as a testable goal | product | A measurable lab + runtime |
| Pi fork | apps | An explicit runtime choice = Pi |
| Productisation: portfolio + free release (OS or closed) | product | Lab quality "genuinely good" + an explicit choice |
| Prod hosting / multi-user auth | architecture | A productisation ADR |
| Repo spine (`.agent/`) | product | A coupling that does solve the chat's path binding |
