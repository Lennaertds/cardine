# 0015 — Disable `tool-todo`, add `jarvis-check` to the Makefile, ban `indexRepo` in AGENTS.md

- **Status:** accepted
- **Date:** 2026-11-22
- **Touches:** `packages/lab/cardine-status.sh`, `packages/lab/install-lab.sh`, `packages/structure/kit/kern/Makefile`, `packages/structure/kit/kern/AGENTS.md`, root `Makefile`, root `AGENTS.md`, DSH ACP-profiel `cordis.patch.yml`

## Summary

In the context of a working Zed + DSH + Jarvis stack on Arch Linux / Hyprland, faced with (1) a persistent `400: Invalid structured outputs: 'triggers'` API error on DeepInfra (`deepseek-ai/DeepSeek-V4-Flash`) caused by the built-in DSH `tool-todo` plugin sending a non-OpenAI-compatible JSON schema (`triggers`), and (2) stalled Jarvis indexing inside `bwrap` (stale `.lock` files) when the agent called `mcp__jarvis__indexRepo`, we chose (a) disabling `tool-todo` permanently in the ACP profile and `install-lab.sh`, (b) a `make jarvis-check` target with lock PID checking in `cardine-status.sh`, and (c) a hard ban on `mcp__jarvis__indexRepo` in AGENTS.md, in order to guarantee reproducibly clean sessions without the agent starting destructive index actions inside the sandbox.

## Context

While working across several repositories with DeepSeek Harness (`dsh` 0.2.2-rc.1) and DeepSeek V4 Flash via DeepInfra, two recurring errors appeared:

1. **`400: Invalid structured outputs: 'triggers':`** Simple questions always worked; as soon as a task needed several steps or tool calls, DeepInfra returned a `400 invalid_request_error`. Inspecting the actual JSON payload DSH sent out showed that the built-in plugin `@deepseek-ai/dsh-tool-todo` (`todo_write`) sends a JSON schema containing a `triggers` field. DeepInfra's OpenAI-compatible endpoint validates more strictly than `deepseek.com` and does not allow `triggers` in schemas. After disabling `tool-todo` (`disabled: true` in the ACP profile) the `400` was gone, provided every old `dsh` background process had been stopped too (otherwise Zed reuses the old instance through *Resumed Sessions*).

2. **Jarvis index blockage inside `bwrap`:** the agent tried `mcp__jarvis__indexRepo` for repositories that were not indexed yet. Inside the `bwrap` sandbox the indexing process was cut off (the sandbox allows no forking or full subprocess management), after which stale `.lock` files in `~/.jarvis/` blocked every later attempt with `another index is already running`.

3. **No structural safeguard:** existing checks in `cardine-status.sh` detected whether the repo was indexed, but not whether there were stale locks. AGENTS.md held no ban on calling `mcp__jarvis__indexRepo`.

## Decision

### A. Disable `tool-todo` permanently

In the DSH ACP profile (`~/.dsh/profiles/acp/cordis.patch.yml`) there is a `- id: tool-todo` block with `disabled: true`. The change is also in `packages/lab/install-lab.sh` so every fresh install is correct right away. After a profile change all `dsh` processes must be restarted (`pkill -f "bin/dsh"`).

### B. `make jarvis-check` in the root and kit Makefile

The `jarvis-check` target:
- Checks whether `~/.jarvis/index-*.lock` files exist.
- For each lockfile: reads the PID and checks whether the process is still alive (`kill -0`). If not, it warns the user with the cleanup command.
- Checks whether the current git root is already known to `jarvis status <slug>`; if not, it suggests running `make index`.
- It is called from `env-status` and `context` (once per session at the start).

### C. The `make index` target

A simple target that runs `jarvis index "$(CURDIR)" --no-semantic` in the terminal — meant to be run outside the sandbox only.

### D. A hard ban on `mcp__jarvis__indexRepo` in AGENTS.md

In both the root `AGENTS.md` and the kit template `kit/kern/AGENTS.md` a line was added under `## Never`:
> Never call `mcp__jarvis__indexRepo` (it breaks in the sandbox and leaves stale `.lock` files); when the index is missing, ask the user to run `make index`.

### E. `cardine-status.sh` extended

Section 8 (repo indexing) was extended with a stale lock check before the index status check. On a stale lock the script warns with the `rm -f` command. In `--fix` mode it cleans up stale locks automatically.

## Alternatives

| Option | Why not |
|-------|-------------|
| Keep `tool-todo`, wait for DeepInfra to be tolerant | DeepInfra will not fix this — their schema validation is OpenAI-compatible and correct; `tool-todo` sends a non-standard field. We do not need `todo_write` in our workflow anyway. |
| Allow indexing through the agent with a wrapper | The `bwrap` sandbox forbids forking — any index attempt inside it will break or stay incomplete. Indexing entirely outside the sandbox is the only reliable route. |
| Check lockfiles only in cardine-status.sh without an AGENTS.md rule | The agent would still try `indexRepo` (it is an MCP tool), wasting time and tokens and creating confusion. The hard ban in AGENTS.md prevents that in the first place. |
| A separate jarvis-check script in packages/lab/scripts/ | It fits better in `cardine-status.sh` (all environment logic is there) plus a `Makefile` target for convenience. |

## Consequences

- **Easier:** no more mysterious `400` errors in longer sessions; `tool-todo` is off and the agent does not use `todo_write` anyway.
- **Easier:** every `make context` or `make env-status` automatically checks whether Jarvis locks are stale and whether the repo is indexed.
- **Easier:** new projects created through `npx cardine` get the `indexRepo` ban and the `jarvis-check` straight away.
- **Harder or risky:** the agent can no longer index a repo on its own — the user must run `make index` in the terminal. That is acceptable because it is a one-time action per repo.
- **To do:** update `install-lab.sh` with `tool-todo` `disabled: true` (already done).