# Stack c (`apps/native-c`)

> **Role:** Hot-path C + N-API and/or ctypes; only after a polyglot ADR.
> **Not here:** decision tree ([polyglot](polyglot.md)); Rust ([rust-stack](rust-stack.md)).

**Kit:** [kit/stacks/c](../kit/stacks/c/README.md) · P13, P23, P28

## When

Budget breach + ADR. Then:

```bash
mkdir -p apps/native-c
kit/new-project.sh . --stacks c --starter
```

## Filling in

1. Replace the example `native_c_add` with the measured path.
2. ADR: **N-API** (Nest), **ctypes** (analytics), or both.
3. Soft: `make check-native-c` (`.so` + optional JS/pytest). Hard: `NATIVE_STRICT=1` / `check-full` — see [native-ci](../kit/kern/docs/how-to/native-ci.md).

## Quick check

- [ ] `make native-c-check` and `make check-native-c` are green (`cc` or `clang`).
- [ ] `check-native-c` is in the soft `make check`; STRICT in `check-full`.
- [ ] With `--starter`: `package.json` **and** `native_c_fallback.py` present.
