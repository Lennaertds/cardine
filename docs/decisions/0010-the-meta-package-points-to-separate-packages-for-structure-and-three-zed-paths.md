# 0010 — The meta package points to separate packages for the structure and three Zed paths

- **Status:** accepted
- **Date:** 2026-11-17
- **Touches:** [PRODUCT.md](../product/PRODUCT.md), [llm.md](../product/llm.md), [0008](0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md), [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md). Product shape: [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md).

## Summary

In the context of users with a Claude subscription, a ChatGPT subscription or an API key, and of users who stay on VS Code, we chose one meta package that points to separate packages over one mandatory bundle of Zed, harness and structure, in order to install each combination separately, and we accept that three Zed paths must line up with the same structure at once.

## Context

- Zed shows the conversation. The agent that edits files is a separate process and handles its own login, through the Agent Client Protocol.
- Claude Pro or Max talks inside Zed as Claude Agent, or as the `claude` command in a Zed terminal, with the same login as Claude Code. ChatGPT Plus or Pro talks as Codex, or via "Sign in with ChatGPT" in Zed's own agent. An API key talks as DeepSeek Harness ([0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)).
- The chat on claude.ai or chatgpt.com does not change the project directory. The subscription that edits files is Claude Code or Codex.
- DeepSeek Harness is a second agent in the same panel. It does not stack on Claude.
- [0008](0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) (`deepseek-flash`, Claude as second provider) applies to the API-key path. The subscription paths choose their model inside that agent.

## Decision

One meta package explains what you install and what you leave out. Separate packages hang beneath it. Each installs on its own. None of the four is mandatory.

| Package | For whom | Login |
|---------|----------|-------|
| Structure | Everyone, including VS Code and any other editor | none |
| Claude in Zed | Claude Pro or Max | Claude Code |
| ChatGPT in Zed | ChatGPT Plus or Pro | ChatGPT account |
| Zed + DeepSeek Harness | Anyone who wants an API key | key in `.env` |

The guide from [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md) explains these four. The structure is the package every reader can take with them.

## Alternatives

| Option | Why not |
|-------|-------------|
| One installer that always brings Zed and DeepSeek Harness | Forces an editor and a key many people do not want |
| A separate product per subscription, without a meta package | The explanation splinters and the structure would exist three times |
| Drop Zed from the offer | The three paths in Zed are the reason the guide exists |

## Consequences

- **Easier:** someone with only VS Code installs only the structure. Someone with a subscription need not buy an API key.
- **Harder or risky:** the same docs must be readable for Claude Code, Codex and DeepSeek Harness. Two windows (Zed to read, Claude Code to write) remain possible; the panel in Zed is the shorter path, because the diff is already there.
- **To do:** the manifests and the guide page per path. Not written yet. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) stays for our own app code.
