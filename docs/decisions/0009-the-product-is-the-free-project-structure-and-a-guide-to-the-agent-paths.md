# 0009 — The product is the free project structure and a guide to the agent paths

- **Status:** accepted
- **Date:** 2026-11-17
- **Touches:** [PRODUCT.md](../product/PRODUCT.md), [README.md](../../README.md), [CONTEXT.md](../context/CONTEXT.md), [totaalproduct.md](../product/totaalproduct.md). Packaging: [0010](0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md). Day 0: [0011](0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md).

## Summary

In the context of a lab that had already chosen Zed and DeepSeek Harness as upstream, faced with a plan to distribute an editor or a mandatory bundle, we chose the project structure as the free product and a guide as the entrance to the agent paths, over an own IDE and over a mandatory Zed install, in order to ease starting a project for anyone who already has an editor and a subscription, and we accept that the guide and the packages are not published yet and that the lab itself keeps measuring on the Zed plus API-key path.

## Context

- People search for a combination they already have: Claude and Zed, ChatGPT and Zed, or an API key with a harness. They rarely write the project text themselves.
- An own editor was already rejected ([0002](0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)). The loop on the API path is upstream DeepSeek Harness ([0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)).
- [RULES.md](../rules/RULES.md) keeps a public release out of the lab phase and rules out a paid SaaS. This decision fixes the shape. Publishing follows later.
- The structure that lays down a new project and reorders an existing one lives as kit and bootstrap. Cardine distributes it and does not copy the standard.

## Decision

- The product someone takes away is the project structure, free. For an empty project the tree is there immediately. For an existing project the same structure reorders docs and files, as bootstrap does now.
- The guide is the front end. Whoever searches for an IDE with a harness and a subscription lands on the guide and can take the structure with them.
- We build no editor. Zed is one path in the guide, not an obligation.
- [0002](0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) to [0008](0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) still apply to the path they cover. The lab measures on Zed plus DeepSeek Harness with an API key.

## Alternatives

| Option | Why not |
|-------|-------------|
| An own IDE or a `cardine-core` binary as the product | The editor is upstream Zed. An own loop binary is the work [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) already declines |
| Distribute the personal Zed plus DSH path only | Anyone on VS Code or a subscription then has no entrance |
| A guide without the structure | Then starting a project stays the user's work |

## Consequences

- **Easier:** one thing to explain. Search traffic for Claude plus Zed belongs to the guide, and the structure comes with it.
- **Harder or risky:** the guide must explain the paths without writing the standard a second time. Publishing waits until the lab-phase rule allows it.
- **To do:** the guide text and the packages do not exist yet. The packaging is in [0010](0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md). Filling it in on day 0 is in [0011](0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md).
