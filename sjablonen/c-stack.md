# Stack c (`apps/native-c`)

> **Rol:** Hot-path C + N-API en/of ctypes; alleen na polyglot-ADR.
> **Niet hier:** beslisboom ([polyglot](polyglot.md)); Rust ([rust-stack](rust-stack.md)).

**Kit:** [kit/stacks/c](../kit/stacks/c/README.md) · P13, P23, P28

## Wanneer

Budget-breuk + ADR. Daarna:

```bash
mkdir -p apps/native-c
kit/new-project.sh . --stacks c --starter
```

## Invullen

1. Vervang voorbeeld-`native_c_add` door het gemeten pad.
2. ADR: **N-API** (Nest), **ctypes** (analytics), of beide.
3. Soft: `make check-native-c` (`.so` + optionele JS/pytest). Hard: `NATIVE_STRICT=1` / `check-full` — zie [native-ci](../kit/kern/docs/how-to/native-ci.md).

## Snelle toets

- [ ] `make native-c-check` en `make check-native-c` groen (`cc` of `clang`).
- [ ] `check-native-c` zit in soft `make check`; STRICT in `check-full`.
- [ ] Met `--starter`: `package.json` **en** `native_c_fallback.py` aanwezig.
