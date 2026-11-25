# Stack rust (`apps/native`)

> **Role:** Hot-path Rust + napi and/or PyO3; only after a polyglot ADR.
> **Not here:** decision tree ([polyglot](polyglot.md)).

**Kit:** [kit/stacks/rust](../kit/stacks/rust/README.md) · P13, P23, P28

## When

Budget breach + ADR. Then:

```bash
mkdir -p apps/native
kit/new-project.sh . --stacks rust --starter
```

## Filling in

1. Replace the example `add` with the measured path.
2. ADR: **napi** (Nest), **PyO3** (analytics), or both seams.
3. Nest: `.node` behind an interface + test. Analytics: see `apps/analytics/AGENTS.md` § Native.
4. Soft: `make check-native` (fallback allowed). Hard: `NATIVE_STRICT=1` / `make check-full` — see [native-ci](../kit/kern/docs/how-to/native-ci.md).

## Quick check

- [ ] `make native-check` and `make check-native` are green (`cargo` installed).
- [ ] `check-native` is in the soft `make check`; STRICT in `check-full`.
- [ ] With `--starter`: `package.json` **and** `pyproject.toml` present.
- [ ] AGENTS.md links to polyglot; analytics names the PyO3 seam.
