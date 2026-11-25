# 0016 — Secrets live in `~/.secrets` and the filesystem tools are closed with a deny-only guard

- **Status:** accepted
- **Date:** 2026-11-22
- **Affected by:** [0017](0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md) — the cage writes to the host through a bind; the secrets masking and this guard stay. This decision was not rewritten.
- **Touches:** [security.md](../architecture/security.md), [0007](0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md), `.dsh/profiles/acp/cordis.patch.yml` (outside this repo), `packages/lab/cardine-secrets-guard/`, `packages/lab/scripts/check-secrets.sh`.

## Summary

In the context of an agent that reaches files both through the shell and through `read`/`write`, faced with the fact that the bwrap cage bounds **only the shell** while the filesystem tools run in the DSH host process, we chose two layers — `~/.secrets` outside every repo plus a `tools/pre-execute` guard that refuses secret paths — over symlinks or `chmod 000`, in order to make sure the agent never reads an API key, and we accept that a new guard rule only applies after a DSH restart.

## Context

Measured in a running session:

- `bash`, `grep` and `glob` run in `cardine-bwrap`: `~/.secrets` does not exist there, not even through `/proc/<pid>/root` or a symlink.
- `read`, `write` and `edit` run in the host process. `dsh-fs-local` says so itself: *"config.cwd is a resolution default, not a containment boundary."* So a `chmod 000` on a file does not help (the tool runs as the owner), and `read` does not follow symlinks while `bash`/`grep` do.
- The DeepSeek key sits in `~/.dsh/.env`; cardine needed no `.env` of its own (no app reads one) and `.env.example` already pointed at it.
- An earlier attempt to mask `.env` inside the cage through `bwrap` worked for the shell but touched the host file once something wrote outside the overlay. It is only durable if the tools are closed too.

## Decision

- **Secrets in one place.** Real values live in `~/.secrets/<repo>/.env` (directory 700, file 600), outside every repo. Repos contain only `.env.example`. No symlinks to them: a symlink is not a boundary.
- **Guard before the tools.** `cardine-secrets-guard` registers a `tools/pre-execute` listener (`prepend`) that refuses `read`, `read_image`, `write`, `edit`, `glob`, `grep` and `apply_patch` on a secret file pattern (`.env`, `*.env.*` except `*.example`, SSH keys, `*.pem`/`.p12`/`.pfx`) and on everything under `~/.secrets`, `~/.dsh`, `~/.ssh`, `~/.aws`, `~/.kube`. Deny-only: a guard cannot approve what another layer refuses. Paths are resolved (`realpath` with a parent walk for files that do not exist yet).
- **The cage stays for the shell.** `cardine-bwrap` masks `.env` and keys in the workspace as promised in 0007.
- **Proof in `make check`.** `sandbox-secrets` (cage and outside world) and `secrets-check`. Hard (red) are: a secret in git, a symlink pointing out, failing guard tests, a missing guard registration. Warnings are: the permissions of `~/.secrets` and a `.env` on disk, because those concern the local machine, not the repository.

## Alternatives

| Option | Why not |
|-------|-------------|
| Symlinks to `~/.secrets` | `bash` and `grep` follow them; not a boundary |
| `chmod 000` on `.env` | The tools run as the owner and read it anyway |
| `chmod 700` on every repo | Works, but makes the repo private to everyone and solves nothing for `~/.dsh` |
| RULES/`AGENTS.md` only | An instruction, not a boundary; one counterexample is enough to break it |
| bwrap for the filesystem tools too | The tools run in the DSH process, not in the cage; that would mean forking DSH |
| Workspace = "what git sees" | `.git` itself is then missing, and new or untracked work falls outside the boundary |

## Consequences

- **Easier:** the agent cannot display, commit or put a key into an answer, whether it goes through the shell or the tools.
- **Harder or risky:** a guard change only applies in a **new** DSH session; the profile line is in `install-lab.sh` so a reinstall does not drop it. Residual risk: running `env` or build processes can show variables from the shell — this decision covers file access, not the process environment.
- **To do:** a `.env.example` per app; fill in keys in `~/.secrets`. Permissions and the remaining risk are in [security.md](../architecture/security.md).
