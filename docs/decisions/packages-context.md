# Packages — context

> **Role:** explains why Cardine consists of several packages, how the meta, lab and structure packages relate, and which architecture decisions (ADRs) underpin them.
>
> It supplies the background to the READMEs. The READMEs point here for the reasoning behind each choice. The actual research — sources, experiments and paragraph references — lives in [`bron/`](../../bron/INDEX.md) (the Single Source of Truth). This document only summarises the synthesis relevant to this repo.

---

## Why a project structure?

AI agents work best when they have a stable project tree to steer by. Without such a fixed structure they drift: they guess at directories, miss conventions, and every new session starts from zero. The solution is twofold (**dual**): a short AGENTS.md states the intent, and hard checks in `make check` and the git hooks enforce the rules where needed. That decision is recorded in [ADR 0004](../decisions/0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md).

## Why a free product?

The product Cardine distributes is the project structure itself — and it is free. The guide explaining how to use that structure with your editor and subscription is the front end. Building a paid service or an own IDE is not the intent. This decision is in [ADR 0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md).

## Why packages instead of one bundle?

Not everyone uses the same editor, the same subscription or the same workflow. Someone with only VS Code does not need a Zed package. Someone with a Claude subscription does not need the API-key path. By offering separate packages instead of one mandatory bundle, each user can install only what is relevant. The decision is in [ADR 0010](../decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md).

## Why is Zed the IDE on the lab path?

The lab path — the combination the team itself measures and develops on — uses Zed, and specifically the official upstream version (no fork of our own). But why Zed rather than Cursor, VS Code or something else?

The choice for Zed rests on three criteria:

1. **A good agent path with a GUI.** An editor for AI-driven work needs a rich agent protocol, a built-in conversation panel, and diffs where the agent proposes changes. Zed ships all of it out of the box: an ACP client (Agent Client Protocol), a conversation panel and built-in diffs. Neovim and Helix drop out because they offer no GUI editing.

2. **Not wanting to maintain a fork.** Cursor is a fork of VS Code with its own agent integrations — but a fork means keeping the whole editor updated and synced with upstream. Forking Zed would give the same problem, with GPL obligations on top. By using unmodified upstream Zed, we avoid that maintenance entirely. Our own processes — harness, indexing, structure and LLM — remain separate components that couple through ACP, and need not be part of the editor.

3. **A broadly applicable guide, not a mandatory editor.** The product imposes no editor. Zed is one path in the guide, not a requirement. Anyone who wants to stay on VS Code or Cursor can install only the structure package and follow the agent paths that fit their own editor. The lab chooses Zed because it currently offers the best ratio between a rich agent path and a minimal footprint of our own.

In practice this means the meta package pulls a pinned upstream release of Zed straight from zed.dev. We do not fork, we do not host the binary ourselves, and we accept that any gaps in Zed's core are closed only through ACP, extensions or a later reconsideration of this decision. See also [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md).

## Why DeepSeek Harness and not an own loop?

As with Zed, we use an existing upstream product for the agent loop too: DeepSeek Harness (DSH). It is not a fork and we build no loop of our own. See [ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md). DSH ships as a pinned profile (ACP profile) through the meta package, so the version is fixed and reproducible.

## Why a sandbox (bwrap)?

The agent shell runs under a tight bwrap cage (bubblewrap). That means the agent has write access only to the project directory and an approved allowlist — not to the rest of the system. This limits the damage from a mistake or a malicious instruction. See [ADR 0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md).

## Why deepseek-flash as the model?

DeepSeek Flash is the primary choice for the lab path: cheap and fast enough to develop iteratively. Claude serves as second provider for anyone with their own API key who wants a different model. It is not an exclusive choice — the guide also explains the subscription paths (Claude in Zed, ChatGPT in Zed), which pick their own model through the corresponding agent. This decision applies to the API-key path; see [ADR 0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md).

## Why does the structure live in the same repo?

The project standard — the kit, the bootstrap, the rules and the agent instructions — lives in **`kit/`** of this repo. That is the Single Source of Truth. `cardine-structure` contains a literal copy of it, made with `sync_kit.sh`, so one source suffices.

The standard used to live in a separate private repo (`Agent_Engineering`) and was pulled on pinned commits ([ADR 0013](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md), **superseded** on 2026-11-24). The pin drifted out of step with the published kit in practice; two repos turned out to be more work than profit.

## Why SemVer and separate versions per package?

Each package gets its own SemVer version, independent of the others. The meta package gets a new version only when the meta's own structure changes — not on every update of an underlying package. This fits the separate-packages model from [ADR 0010](../decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md): anyone who only uses the structure is not affected by a version jump in the Zed package. See [VERSIONING.md](../packages/VERSIONING.md) for the full scheme.

---

## Overview

| Question | ADR |
|----------|-----|
| Why a dual standard (docs + code)? | [0004](../decisions/0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md) |
| Why a free product? | [0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md) |
| Why separate packages instead of one bundle? | [0010](../decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md) |
| Why Zed and not Cursor or VS Code? | [0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) |
| Why DSH and no own loop? | [0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) |
| Why a bwrap sandbox? | [0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md) |
| Why deepseek-flash as the model? | [0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) |
| Why does the structure live in the same repo? | [0013 (superseded)](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md) |
