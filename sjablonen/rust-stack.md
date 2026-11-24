# Stack rust (`apps/native`)

> **Rol:** Hot-path Rust + napi en/of PyO3; alleen na polyglot-ADR.
> **Niet hier:** beslisboom ([polyglot](polyglot.md)).

**Kit:** [kit/stacks/rust](../kit/stacks/rust/README.md) · P13, P23, P28

## Wanneer

Budget-breuk + ADR. Daarna:

```bash
mkdir -p apps/native
kit/new-project.sh . --stacks rust --starter
```

## Invullen

1. Vervang voorbeeld-`add` door het gemeten pad.
2. ADR: **napi** (Nest), **PyO3** (analytics), of beide seams.
3. Nest: `.node` achter interface + test. Analytics: zie `apps/analytics/AGENTS.md` § Native.
4. Soft: `make check-native` (fallback mag). Hard: `NATIVE_STRICT=1` / `make check-full` — zie [native-ci](../kit/kern/docs/how-to/native-ci.md).

## Snelle toets

- [ ] `make native-check` en `make check-native` groen (`cargo` geïnstalleerd).
- [ ] `check-native` zit in soft `make check`; STRICT in `check-full`.
- [ ] Met `--starter`: `package.json` **en** `pyproject.toml` aanwezig.
- [ ] AGENTS.md verwijst naar polyglot; analytics noemt PyO3-seam.