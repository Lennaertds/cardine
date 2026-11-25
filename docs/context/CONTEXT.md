# Context

> **Role:** why this project exists (**Cardine**), for whom, and what counts as success.
> **Not here:** technical detail ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), substantive boundaries ([RULES.md](../rules/RULES.md)).

## Name and philosophy (Cardine)

- **Origin:** *Cardine* is the Latin ablative of *cardo* (the pivot, the hinge, the main axis a city or structure is built around). The ablative expresses the means and the starting point: *"whereby and from where everything hinges"*.
- **Philosophy:** Cardine builds no editor. The hinge is the project structure, with a guide to the editor and the agent someone already has. Shape: [PRODUCT.md](../product/PRODUCT.md), [ADR 0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md).
- **Design principle:** the structure is free and installs separately. Zed and DeepSeek Harness stay upstream on the lab path ([ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)). That path is described in [totaalproduct.md](../product/totaalproduct.md).

## User or customer

**Now:** a solo developer (Ventje) — a local lab, plus later a thesis reader who must be able to follow the measurements and choices.

**Later:** the same structure, free, for anyone starting a project or reordering an existing one. The guide points to Claude in Zed, ChatGPT in Zed, or Zed with an API key. No paid SaaS. Publishing waits until the lab phase allows it ([RULES.md](../rules/RULES.md)).

## Problem

A new project starts empty, and an existing project does not keep its docs and directories where both human and agent find them. People rarely write that text themselves, and a model then picks the most popular stack. The missing layer is a structure that is already in place, plus a guide to the editor and subscription someone already has.

## Goal and what counts as success

- **Lab (now):** the personal application working on Arch Linux Hyprland: Zed + DeepSeek Harness + indexing + the structure from `kit/` ([ADR 0012](../decisions/0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md)). Map: [totaalproduct.md](../product/totaalproduct.md).
- **Thesis:** a testable goal on the same lab, later.
- **Product:** Cardine as a public shop window — packages and guides — distributing the structure from `kit/` ([ADR 0013](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md)). Its shape is [ADR 0009](../decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md). Publish only after the personal stack works.
- No stack generator until the user approves a proposal from the catalogue ([ADR 0011](../decisions/0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md)). [0001](../decisions/0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) still governs our own app code.

## Scope

- Domains: `harness`, `structure`, `indexing` (and how they hinge with `ide-shell` Zed, `fs-events`, `tools`, `llm`, `agent-ui` and `session-spine` — see [GLOSSARY.md](GLOSSARY.md) and [PRODUCT.md](../product/PRODUCT.md)).
- Track 3 in the three-track model: now the personal stack on Arch Linux Hyprland; later the shop window that brings packages and guides together and distributes the structure from `kit/` ([ADR 0012](../decisions/0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md), [ADR 0013](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md)). Knowledge and standard stay in this repo.
- **Languages:** stack languages are in [ARCHITECTURE.md](../architecture/ARCHITECTURE.md) — still open there until the ADR choice (with a strong preference for native compilation into a single static binary such as Rust/Go). Extra systems languages for hot paths: allowed after measuring + an ADR — see [polyglot.md](../architecture/polyglot.md).

## Deliberately not

See [PRODUCT.md](../product/PRODUCT.md) § Deliberately not and [RULES.md](../rules/RULES.md): no product release or prod hosting for now; no feature bloat; no maintaining an own Zed fork; no heavy Docker requirement for the runtime itself; no duplication or taking over of data/secrets from other projects; lessons first as a § in `bron/`.
