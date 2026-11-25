# Security

> **Role:** which sensitive data exists, where it lives, and how it is protected.
> **Not here:** the "never" rules for the agent ([AGENTS.md](../../AGENTS.md)); the privacy policy in plain language (`business/`).

## Personal data

| Data | Where | Who reads it | Retention |
|------|-------|--------------|-----------|
| <email, password hash> | <Postgres, table `user`> | <API> | <until the account is deleted> |

## Secrets

| Secret | Where it lives | Who needs it |
|--------|----------------|--------------|
| <`JWT_SECRET`> | <`.env` locally, an environment variable at the host in production> | <API> |

## Authentication and authorisation

<How a user signs in, how long a session lasts, who may see what.>

## Threats and measures

| Threat | Measure | Guarded by |
|--------|---------|------------|
| <Upload of a malicious file> | <check type and size, never execute> | <test `upload.spec.ts`> |
| Supply chain: npm/pip/cargo install scripts read SSH keys, .env, files | Containers isolate the install: `make container-setup`, then use `npm-safe`/`pip-safe`/`cargo-safe`. See [how-to](../how-to/container-safe.md). | `AGENTS.md` command rule + `make container-setup` at project start |

## Active security validation (Strix)

Autonomous pentest agents that validate findings with a **working PoC** (not just SAST warnings). Default tool: [Strix](https://strix.ai/) (CLI + optional coding-agent skills). Reference in the source repo: §47.

| What | Agreement |
|------|-----------|
| When | Before a release / after auth or API changes; not on every micro-fix |
| Command | `make security-scan-quick` or `make security-scan` (see [how-to](../how-to/security-scan.md)) |
| Scope | Your own code only, staging, or targets with explicit permission |
| Requirements | Docker + `strix` + an LLM API key |
| Not in | `make check` (too slow, non-deterministic, costs tokens) |
| Skills | Optional: `npx skills add usestrix/strix` |

Missing install or key: the target fails with an explanation → an item in `docs/work/BACKLOG.md` (§ Later), while the docs remain the truth about *how*. Deliberate omissions: [Deliberately later](#deliberately-later) (P28).

## Deliberately later

Fixed heading (P28): ask about it or file a BACKLOG item when this becomes needed.

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Strix/Docker/LLM key always installed in CI | The runtime is a project choice; docs + Make stay | Scans must run in nightly CI without manual work |
| An alternative scanner instead of Strix | One default prevents tool chaos | Strix does not fit (policy, air-gap) → ADR |
| DPA / GDPR operational checklist in the core | Partly in security + the business module | A school/customer demands a fixed privacy checklist |
| Secrets manager module (Vault etc.) | `security.md` + `.env.example` suffice locally | Production no longer shares env vars safely |
