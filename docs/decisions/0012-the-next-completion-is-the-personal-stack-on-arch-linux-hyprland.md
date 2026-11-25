# 0012 — The next completion is the personal stack on Arch Linux Hyprland

- **Status:** accepted
- **Date:** 2026-11-17
- **Touches:** [PRODUCT.md](../product/PRODUCT.md), [CONTEXT.md](../context/CONTEXT.md), [README.md](../../README.md), [totaalproduct.md](../product/totaalproduct.md), [BACKLOG.md](../work/BACKLOG.md). Public repo after that: [0013](0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md). The shape stays [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md).

## Summary

In the context of a lab whose product shape is already settled, faced with the temptation to write the public guide and the packages before the own stack, we chose the personal application on Arch Linux Hyprland first — Zed, DeepSeek Harness, indexing and the structure from `kit/` — over the guide and the package manifests as the next work, in order to have a working stack before anything goes public, and we accept that the public repo therefore comes later.

## Context

- [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md) to [0011](0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md) fix the shape. The guide, the questions and the manifests do not exist yet.
- The user works on Arch Linux with Hyprland, laptop and desktop. Mac and Windows come later ([totaalproduct_naar_MAC_en_Win.md](../product/totaalproduct_naar_MAC_en_Win.md)).
- "The application" here is not an own editor and not an own loop. It is the stack he uses daily himself: upstream Zed, upstream DeepSeek Harness, indexing, and the structure from `kit/`.
- [RULES.md](../rules/RULES.md) keeps a public release out of the lab phase. This decision sets the order within that phase: that stack working first, the shop window after.

## Decision

- The next completion is the personal application on Arch Linux Hyprland.
- That application is Zed + DeepSeek Harness + indexing + the structure from `kit/`. Not an own editor. Not an own agent loop.
- Packages, guide text and a public release wait until that stack works for this user.
- [0002](0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) to [0011](0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md) still apply. This decision changes the order, not the shape. The public role is in [0013](0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md).

## Alternatives

| Option | Why not |
|-------|-------------|
| Write the public guide and the packages first | Then there is an explanation without a stack you use daily yourself |
| The personal stack on Mac and Windows straight away | Those hosts wait until Arch Linux Hyprland is usable day to day |
| An own binary as "the application" | The editor is upstream Zed and the loop is upstream DeepSeek Harness |

## Consequences

- **Easier:** one completion goal. Open work stays what the backlog already names: trying Zed itself, wiring up indexing, letting the structure from `kit/` come along, the key.
- **Harder or risky:** the guide and the manifests stay empty while the shape is already decided. That is intended until the stack works.
- **To do:** no new spec. The open pieces are already on the backlog.
