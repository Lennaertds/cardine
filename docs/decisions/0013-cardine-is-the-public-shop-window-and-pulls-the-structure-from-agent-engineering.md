# 0013 — Cardine is the public shop window and mirrors the structure

- **Status:** **superseded** (2026-11-24) — the two repos were merged; `kit/` is now the source in this repo and there is no pull or pin anymore. The note below stays as history.
- **Date:** 2026-11-17
- **Touches:** [PRODUCT.md](../product/PRODUCT.md), [structure.md](../product/structure.md), [README.md](../../README.md), [CONTEXT.md](../context/CONTEXT.md), [ARCHITECTURE.md](../architecture/ARCHITECTURE.md). Order: [0012](0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md). Shape: [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md), [0010](0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md).

## Summary

In the context of three tracks, faced with the question where the structure lives once Cardine goes public, we chose Cardine as the public shop window that brings packages and guides together and mirrors the structure from its source repo, over a second copy of the structure in this repo, in order to update the structure in one place, and we accept that the public package needs a pin on what it mirrors.

## Context

- The structure that lays down a project lives as kit and bootstrap. [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md) already says Cardine distributes it and does not copy the standard. It did not yet say that Cardine is the shop window, nor that updates stay in the source repo.
- The user wants to keep the structure there and update it as needed. Cardine pulls that version. It does not become the second source.
- [0010](0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md) keeps the four packages. This decision fixes which of the four is a mirror, and what the public repo itself is.
- [0012](0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md) puts this public repo after the personal stack. This decision fixes the shape. It publishes nothing yet.

## Decision

- Cardine becomes the public repo. It brings packages and guides together. It is the shop window, not the source of the structure.
- The structure stays with its source repo. It is updated there as needed.
- The public structure package mirrors that source. It does not copy the standard into a second text in this repo.
- [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md) and [0010](0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md) stay the product shape. This decision fixes the origin and the role of the public repo.

## Alternatives

| Option | Why not |
|-------|-------------|
| Maintain the structure text in Cardine and merge it back | Two places. The kit lags behind what you just updated |
| Make only the source repo public | Then there is no shop window bringing packages and guides together |
| Fork the structure into the public repo | An update as needed would have to touch two trees |

## Consequences

- **Easier:** one place to update the structure. Cardine explains and points. It does not rewrite the standard.
- **Harder or risky:** the mirror needs a pin. Without one, Cardine publishes a structure that was already changed locally, or one that was not.
- **To do:** the mirror mechanism and the pin, only once the public repo exists ([0012](0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md)). No kit edit from this lab.
