# docs/architecture/security.md

> **Role:** Which sensitive data exists, where it lives, and how it is protected.
> **Not here:** the "Never" rules for the agent ([agents-root](agents-root.md)), the privacy policy in plain language (`docs/business/`).

**Kit file:** [kit/kern/docs/architecture/security.md](../kit/kern/docs/architecture/security.md) · layer kern · P17

## When

Day 0 with the first row in every table. With every new kind of data, every new secret and every new external service.

## Filling in

1. **Personal data:** what, where, who reads it, how long. Also what sits locally in `data/runtime/` or `data/raw/`.
2. **Secrets:** name (never the value), where it lives locally and in production, who needs it. Every secret appears with a safe example value in the app's `.env.example`.
3. **Auth:** how to sign in, how long a session lasts, who may see what.
4. **Threats and measures:** with what the measure guards (test, hook, header).
5. **Active validation (Strix):** keep the section from the kit; add project-specific targets or staging URLs if needed. Scans via `make security-scan*`, not via `make check`. How-to: `docs/how-to/security-scan.md`.
6. **`## Deliberately incomplete` (P28):** keep the kit rows or extend them (P28).

## Example (GymFreak)

```markdown
## Personal data

| Data | Where | Who reads | Retention |
|------|-------|-----------|-----------|
| Sleep, heart rate (Health export) | `data/runtime/user/<id>/`, table `sleep_night` | api | until the user deletes |
| Email, password hash | table `user` | api | until the account is deleted |

## Threats and measures

| Threat | Measure | Guarded by |
|--------|---------|------------|
| A 500 MB Health XML takes the API down | streaming parser, 200 MB limit | `upload.e2e-spec.ts` |
| A secret in a commit | gitleaks in pre-commit | `.pre-commit-config.yaml` |
| Supply chain: install scripts from npm/pip/cargo | Containers isolate them via `make container-setup`; use `npm-safe`/`pip-safe`/`cargo-safe` | `AGENTS.md` command line |
```

## Quick check

- [ ] Not a single secret value in this file or in an example.
- [ ] Every piece of personal data has a retention period.
- [ ] The Strix section is in there; a missing install/key lands in BACKLOG, not silently left out.
- [ ] `## Deliberately incomplete` has at least one extension row (P28).
- [ ] `AGENTS.md` § Never links here.
