# Product

> **Role:** what the product does, seen from the user's side.
> **Not here:** how it is built ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), the lab path in detail ([totaalproduct.md](totaalproduct.md)).

## What someone takes away

The product is the **project structure**, free. A guide is the front end: whoever searches for an IDE with a harness and a subscription lands there and can take the structure with them. Decision: [ADR 0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md).

One meta package explains what you install and what you leave out. The packages beneath it install separately. Decision: [ADR 0010](../decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md).

| Package | For whom |
|---------|----------|
| Structure | Everyone. VS Code and any other editor too. Empty project: the tree is there. Existing project: the same structure reorders docs and files. |
| Claude in Zed | Claude Pro or Max, via Claude Code in the Zed panel |
| ChatGPT in Zed | ChatGPT Plus or Pro, via Codex or Zed's ChatGPT login |
| Zed + DeepSeek Harness | Anyone who wants an API key. This is the path the lab measures on |

The chat on claude.ai or chatgpt.com does not change the directory. The subscription that edits files is Claude Code or Codex.

## Day 0

The structure lays down the tree. What the project is, a conversation fills in. Decision: [ADR 0011](../decisions/0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md).

- Questions steer the conversation. Decisions record the outcome: `PRODUCT.md`, `BUSINESSMODEL.md`, `GOALS.md` and the docs that must be able to explain a later choice.
- The user fills them in, or walks through them with the agent. A sentence lands in a decision file when they approve it.
- The agent then names two or three options from a catalogue of languages and software, each tied to a sentence from `PRODUCT.md`. The user approves or rejects. A generator runs only after that.

## Phases

| Phase | What | Status |
|-------|------|--------|
| Lab | The personal stack working: Zed + DeepSeek Harness + indexing + the structure from `kit/`, on Arch Linux Hyprland | now — [0012](../decisions/0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md) |
| Thesis | The same lab, readable for an assessor | later |
| Product | Public repo as the shop window: packages, guides, structure mirrored from `kit/` | shape decided ([0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md), [0013](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md)); only after the personal stack works |

## Lab path

The Zed + DeepSeek Harness path remains the path you measure on. Relations: [totaalproduct.md](totaalproduct.md). One file per part below.

| # | Part | Product doc | Spec |
|---|------|-------------|------|
| 1 | IDE shell | [ide-shell.md](ide-shell.md) | done — [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) |
| 2 | FS/events | [fs-events.md](fs-events.md) | done — Zed's tree, no own watcher (no ADR) |
| 8 | Agent UI | [agent-ui.md](agent-ui.md) | done — Zed Agent Panel via ACP (no ADR) |
| 5 | Harness | [harness.md](harness.md) | decided — [ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) |
| 4 | Tools | [tools.md](tools.md) | decided — [ADR 0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md) |
| 6 | LLM | [llm.md](llm.md) | decided for this path — [ADR 0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) |
| 3 | Indexing | [indexing.md](indexing.md) | decided, agent path — [ADR 0006](../decisions/0006-the-agent-searches-via-jarvis-as-mcp-zed-search-and-lsp-stay-with-the-editor.md) |
| 7 | Structure | [structure.md](structure.md) | decided — [ADR 0004](../decisions/0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md) |
| 9 | Session/spine | [session-spine.md](session-spine.md) | skipped — [ADR 0005](../decisions/0005-the-conversation-remains-the-zed-and-dsh-session-without-repo-spine.md) |

On this path: shell, FS and agent UI = Zed. Harness = DeepSeek Harness. The model is `deepseek-flash`, with Claude as second provider via your own key ([0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md)). The subscription paths pick their own model ([0010](../decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md)).

## Deliberately not

- No own editor and no mandatory Zed install ([0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md)).
- No IDE fork: if the path is Zed, Zed stays upstream ([0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)).
- No silent stack choice by the agent ([0011](../decisions/0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md)).
- No paid SaaS. Subscriptions are those of Claude or ChatGPT. API keys stay with the user.
- No public release during the lab phase ([RULES.md](../rules/RULES.md)).
- No taking over or duplicating data, secrets or source content from other projects or from `kit/`.
- No own inference serving.

## Deliberately later

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Guide text and one page per path | The shape is in [0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md) and [0010](../decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md); the pages wait until the personal stack works ([0012](../decisions/0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md)) | the guide needs writing |
| Questions, decision docs and the language catalogue in the structure package | [0011](../decisions/0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md); the kit changes only after a bridge and a yes | those files belong in the kit |
| Package manifests and mirroring the structure | Publishing waits until the personal stack works ([0012](../decisions/0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md), [0013](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md)) | the packages must really be installable |
