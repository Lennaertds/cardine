#!/usr/bin/env bash
# test-kit: stelt in tmp/test-kit/ projecten samen met de kit en controleert of ze kloppen.
# Draait in `make check`. Gebruikt geen netwerk; de stacks krijgen lege app-mappen in plaats van een generator.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
work="$PWD/tmp/test-kit"
# Een vorige run kan een onverwijderbaar restant achterlaten (bv. een bind-mount
# in tmp/); dan valt de test terug op een verse tijdelijke map in plaats van te
# falen op de opruiming.
if ! rm -rf "$work" 2>/dev/null || ! mkdir -p "$work" 2>/dev/null; then
  work="$(mktemp -d "${TMPDIR:-/tmp}/cardine-test-kit.XXXXXX")"
  trap 'rm -rf "$work"' EXIT
fi

failures=0
ok() { echo "ok    $*"; }
fail() { echo "FOUT  $*" >&2; failures=$((failures + 1)); }
check() { local label="$1"; shift; if "$@" >/dev/null 2>&1; then ok "$label"; else fail "$label"; fi; }
refute() { local label="$1"; shift; if "$@" >/dev/null 2>&1; then fail "$label"; else ok "$label"; fi; }

all_modules="$(find kit/modules -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort | paste -sd, -)"
all_stacks="$(find kit/stacks -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort | paste -sd, -)"

solo="$work/solo"
team="$work/team"
kern="$work/kern"
starter="$work/starter"

assemble() {
  case "$(basename "$1")" in
    solo) bash kit/new-project.sh "$1" --no-git --modules "$all_modules" --stacks "$all_stacks" ;;
    team) bash kit/new-project.sh "$1" --no-git --team --name "Team Demo" ;;
    kern) bash kit/new-project.sh "$1" --no-git ;;
    starter) bash kit/new-project.sh "$1" --no-git --stacks python,sql,rust,c --starter ;;
  esac
}
second_run_creates_nothing() { assemble "$1" | grep 'aangemaakt: 0 ' >/dev/null; }
output_contains() { local text="$1"; shift; { "$@" 2>&1 || true; } | grep -F -- "$text" >/dev/null; }

mkdir -p "$solo/apps"/{web,api,analytics,pipeline,native,native-c} "$starter/apps"/{analytics,pipeline,native,native-c}
for project in "$solo" "$team" "$kern" "$starter"; do assemble "$project" >/dev/null; done

echo "Samenstellen"
for project in "$solo" "$team" "$kern" "$starter"; do
  name="$(basename "$project")"
  refute "$name: geen {{…}} of <!-- als: … --> meer" \
    grep -rnE --exclude=check-links.sh '\{\{(PROJECT|DATE)\}\}|<!-- als:' "$project"
  check "$name: make help" make -C "$project" help
  check "$name: geen dode links" bash "$project/scripts/check-links.sh" "$project"
  check "$name: check-links.sh is uitvoerbaar" test -x "$project/scripts/check-links.sh"
  check "$name: Makefile en app.mk zijn geldig" make -C "$project" -n setup check check-full data seed clean
  check "$name: tweede run maakt niets aan" second_run_creates_nothing "$project"
done

echo "Solo, team en kern"
refute "kern: make check is niet groen zonder app" make -C "$kern" check
check "kern: make check zegt waarom" output_contains 'controleert nog geen app' make -C "$kern" check
check "solo: AGENTS.md noemt make finish" grep -q 'make finish' "$solo/AGENTS.md"
check "solo: AGENTS.md noemt make spec" grep -q 'make spec' "$solo/AGENTS.md"
check "solo: BACKLOG is index (geen essay-rol)" grep -qE 'Index|index' "$solo/docs/work/BACKLOG.md"
refute "solo: AGENTS.md noemt de PR-template niet" grep -q 'PR-template' "$solo/AGENTS.md"
check "team: AGENTS.md noemt de PR-template" grep -q 'PR-template' "$team/AGENTS.md"
check "team: projectnaam ingevuld" grep -q '^# Team Demo' "$team/README.md"
check "team: CI-workflow" test -f "$team/.github/workflows/check.yml"
check "team: native.yml aanwezig" test -f "$team/.github/workflows/native.yml"
check "team: module meetings automatisch" test -f "$team/docs/work/meetings/_template.md"
refute "team: geen backlog in de repo" test -e "$team/docs/work/BACKLOG.md"
check "solo: CLAUDE.md is een symlink naar AGENTS.md" test "$(readlink "$solo/CLAUDE.md")" = AGENTS.md
refute "solo: apps/.gitkeep weg zodra er apps zijn" test -e "$solo/apps/.gitkeep"
refute "solo: how-to/.gitkeep weg naast security-scan.md" test -e "$solo/docs/how-to/.gitkeep"
check "solo: how-to/security-scan.md aanwezig" test -f "$solo/docs/how-to/security-scan.md"
check "solo: lege vaste map houdt .gitkeep" test -f "$solo/data/interim/.gitkeep"
check "solo: help toont de app-targets" output_contains check-web make -C "$solo" help
check "solo: help toont check-native" output_contains check-native make -C "$solo" help
check "solo: help toont check-native-c" output_contains check-native-c make -C "$solo" help
check "solo: native Cargo.toml aanwezig" test -f "$solo/apps/native/Cargo.toml"
check "solo: native-c add.c aanwezig" test -f "$solo/apps/native-c/src/add.c"
check "solo: native-check groen" make -C "$solo" native-check
check "solo: native-c-check groen" make -C "$solo" native-c-check
check "solo: check-native-c groen" make -C "$solo" check-native-c
check "solo: help toont security-scan" output_contains security-scan make -C "$solo" help
check "solo: help toont perf-check" output_contains perf-check make -C "$solo" help
check "solo: help toont deps-audit" output_contains deps-audit make -C "$solo" help
check "solo: help toont polyglot-check" output_contains polyglot-check make -C "$solo" help
check "solo: help toont native-bindings-strict" output_contains native-bindings-strict make -C "$solo" help
check "solo: observability.md in kern" test -f "$solo/docs/architecture/observability.md"
check "solo: performance.md in kern" test -f "$solo/docs/architecture/performance.md"
check "solo: dependencies.md in kern" test -f "$solo/docs/architecture/dependencies.md"
check "solo: polyglot.md in kern" test -f "$solo/docs/architecture/polyglot.md"
check "solo: voorbeeld-ADR polyglot aanwezig" test -f "$solo/docs/decisions/0000-voorbeeld-native-module-na-budget-breuk.md"
check "solo: how-to/deps-audit.md aanwezig" test -f "$solo/docs/how-to/deps-audit.md"
check "solo: how-to/native-ci.md aanwezig" test -f "$solo/docs/how-to/native-ci.md"
check "solo: native-ffi.sh uitvoerbaar" test -x "$solo/scripts/native-ffi.sh"
check "solo: perf-check groen" make -C "$solo" perf-check
check "solo: deps-audit groen" make -C "$solo" deps-audit
check "solo: polyglot-check groen" make -C "$solo" polyglot-check
check "solo: AGENTS noemt polyglot (opt-in-zin)" grep -q 'polyglot' "$solo/AGENTS.md"
check "solo: AGENTS opt-in via make help/INDEX" grep -qE 'docs via INDEX|make help' "$solo/AGENTS.md"
refute "solo: AGENTS heeft geen keyword-catalogus-sectie" grep -q 'Alleen als de opdracht het noemt' "$solo/AGENTS.md"
refute "solo: AGENTS Nooit linkt niet always-on naar polyglot.md" grep -qE 'polyglot\.md' "$solo/AGENTS.md"
refute "solo: AGENTS heeft always-on Security-scan commandorij" grep -qE '^\| Security-scan' "$solo/AGENTS.md"
refute "solo: AGENTS Nooit heeft always-on Observability+Performance-links" grep -qE 'Observability:.*observability\.md.*Performance:.*performance\.md' "$solo/AGENTS.md"
refute "solo: polyglot.md verwijst naar kit/stacks/" grep -q 'kit/stacks/' "$solo/docs/architecture/polyglot.md"
refute "solo: observability.md verwijst naar Agent Engineering bron" grep -qE 'Agent Engineering `bron' "$solo/docs/architecture/observability.md"
check "solo: help toont radar-check" output_contains radar-check make -C "$solo" help
check "solo: radar.md aanwezig" test -f "$solo/docs/research/radar.md"
check "solo: how-to/radar.md aanwezig" test -f "$solo/docs/how-to/radar.md"
check "solo: radar-check groen" make -C "$solo" radar-check
check "solo: radar-reminder draait" make -C "$solo" radar-reminder
check "solo: help toont digest-check" output_contains digest-check make -C "$solo" help
check "solo: help toont digest-propose" output_contains digest-propose make -C "$solo" help
check "solo: digest README aanwezig" test -f "$solo/docs/research/digest/README.md"
check "solo: digest how-to aanwezig" test -f "$solo/docs/how-to/digest.md"
check "solo: digest fixture aanwezig" test -f "$solo/docs/research/digest/fixtures/example.rss"
check "solo: digest-check groen" make -C "$solo" digest-check
check "solo: digest-reminder draait" make -C "$solo" digest-reminder
refute "solo: digest-fetch zonder SOURCES faalt" make -C "$solo" digest-fetch
check "solo: SOURCES voor offline-fetch" cp "$solo/docs/research/digest/SOURCES.example.md" "$solo/docs/research/digest/SOURCES.md"
check "solo: digest-fetch dry-run" env DIGEST_DRY_RUN=1 make -C "$solo" digest-fetch
check "solo: digest-fetch fixture" env DIGEST_FIXTURE="$solo/docs/research/digest/fixtures/example.rss" make -C "$solo" digest-fetch
check "solo: digest-propose groen" make -C "$solo" digest-propose
check "solo: proposal draft bestaat" test -f "$solo/docs/research/digest/proposals/$(date +%F)-draft.md"
refute "solo: propose raakt radar.md niet" grep -q 'Fixture Tool Alpha' "$solo/docs/research/radar.md"
check "team: digest.yml aanwezig" test -f "$team/.github/workflows/digest.yml"
check "kern: radar-check wijst naar research-module" output_contains research make -C "$kern" radar-check
check "kern: digest-check wijst naar research-module" output_contains research make -C "$kern" digest-check
refute "kern: geen research/radar zonder module" test -e "$kern/docs/research/radar.md"
refute "kern: geen research/digest zonder module" test -e "$kern/docs/research/digest/README.md"
check "solo: .cursorrules verwijst naar AGENTS.md" grep -q '\[AGENTS.md\](AGENTS.md)' "$solo/.cursorrules"
check "solo: .cursorrules blijft dun" test "$(wc -l <"$solo/.cursorrules")" -le 15
refute "team: geen .cursorrules" test -e "$team/.cursorrules"
check "solo: cursor-agents (rollen)" test -f "$solo/.cursor/agents/reviewer.md" -a -f "$solo/.cursor/agents/architecture.md" -a -f "$solo/.cursor/agents/clarify.md" -a -f "$solo/.cursor/agents/ui.md" -a -f "$solo/.cursor/agents/product.md" -a -f "$solo/.cursor/agents/research.md"
check "solo: AGENTS.md noemt clarify" grep -q 'clarify' "$solo/AGENTS.md"
check "solo: AGENTS.md noemt subagents" grep -q 'subagents' "$solo/AGENTS.md"
check "solo: AGENTS.md noemt RESEARCH-leesroute" grep -q 'RESEARCH.md' "$solo/AGENTS.md"
refute "kern: geen .cursor/agents zonder module cursor" test -e "$kern/.cursor/agents"
refute "kern: AGENTS.md zonder cursor-module geen subagents-regel" grep -q '\.cursor/agents' "$kern/AGENTS.md"
echo "Startcode"
refute "zonder --starter: geen startcode in een bestaande app" test -e "$solo/apps/analytics/src"
check "zonder --starter: lege testmap houdt .gitkeep" test -f "$solo/apps/analytics/tests/unit/.gitkeep"
check "met --starter: config en test (python)" test -f "$starter/apps/analytics/src/analytics/config.py" -a -f "$starter/apps/analytics/tests/unit/test_config.py"
check "met --starter: config en test (sql)" test -f "$starter/apps/pipeline/src/pipeline/config.py" -a -f "$starter/apps/pipeline/tests/unit/test_config.py"
check "met --starter: rust napi + PyO3 scaffolds" test -f "$starter/apps/native/package.json" -a -f "$starter/apps/native/pyproject.toml" -a -f "$starter/apps/native/native_fallback.py"
check "met --starter: rust native-check groen" make -C "$starter" native-check
check "met --starter: c N-API + ctypes scaffolds" test -f "$starter/apps/native-c/package.json" -a -f "$starter/apps/native-c/native_c_fallback.py"
check "met --starter: c check-native-c groen" make -C "$starter" check-native-c
check "met --starter: STRICT ctypes groen" env NATIVE_STRICT=1 NATIVE_FFI=ctypes make -C "$starter" check-native-c
check "kern: native-bindings-strict overslaat zonder stack" output_contains overgeslagen make -C "$kern" native-bindings-strict
refute "met --starter: .gitkeep weg naast de test" test -e "$starter/apps/analytics/tests/unit/.gitkeep"

echo "Docs-targets"
(
  cd "$solo"
  make adr t="Postgres is de enige writer" >/dev/null
  make adr t="Één lockfile" >/dev/null
  make spec s=diet-budget >/dev/null
  make log >/dev/null
  make meeting met=coach >/dev/null
  make experiment s=sleep-baseline >/dev/null
)
today="$(date +%F)"
check "adr: genummerd en met slug" test -f "$solo/docs/decisions/0002-een-lockfile.md"
check "adr: titel en datum ingevuld" grep -q "^# 0001 — Postgres is de enige writer" "$solo/docs/decisions/0001-postgres-is-de-enige-writer.md"
check "spec: regel bovenaan de backlog" grep -q '| \[diet-budget\](specs/diet-budget.md) |' "$solo/docs/work/BACKLOG.md"
check "log, meeting, experiment" test -f "$solo/docs/work/logs/$today.md" -a -f "$solo/docs/work/meetings/$today-coach.md" -a -f "$solo/docs/research/experiments/$today-sleep-baseline.md"
check "na de docs-targets: geen dode links" bash "$solo/scripts/check-links.sh" "$solo"

echo ".gitignore"
git -C "$kern" init -q
(
  cd "$kern"
  mkdir -p data/raw/x data/processed/full data/processed/demo data/runtime apps/web/.next
  touch .env .env.example local.mk a.sync-conflict-1.md data/raw/x/a.csv data/processed/full/a.csv \
    data/processed/demo/a.csv data/reference/a.csv data/runtime/a.png apps/web/.next/a.js
)
for path in .env local.mk a.sync-conflict-1.md data/raw/x/a.csv data/processed/full/a.csv data/runtime/a.png apps/web/.next/a.js; do
  check "genegeerd: $path" git -C "$kern" check-ignore -q "$path"
done
for path in .env.example data/README.md data/raw/.gitkeep data/processed/demo/a.csv data/reference/a.csv; do
  refute "in git: $path" git -C "$kern" check-ignore -q "$path"
done

echo "Opstartpakket"
bestaand="$work/bestaand"
mkdir -p "$bestaand/docs"
git -C "$bestaand" init -q
echo "# Bestaand" >"$bestaand/README.md"
bash scripts/bootstrap.sh "$bestaand" >/dev/null
pkg="$bestaand/_bootstrap"
check "bootstrap: BOOTSTRAP.md en kit aanwezig" test -f "$pkg/BOOTSTRAP.md" -a -x "$pkg/kit/new-project.sh" -a -x "$pkg/scripts/bootstrap.sh"
refute "bootstrap: geen tmp/ of .git/ meegekopieerd" test -e "$pkg/tmp" -o -e "$pkg/.git"
check "bootstrap: symlinks blijven symlinks" test -L "$pkg/kit/modules/claude/CLAUDE.md"
check "bootstrap: genegeerd door git" git -C "$bestaand" check-ignore -q _bootstrap/BOOTSTRAP.md
refute "bootstrap: niet in git status" output_contains _bootstrap git -C "$bestaand" status --porcelain --untracked-files=all
refute "bootstrap: tweede keer weigert" bash scripts/bootstrap.sh "$bestaand"
(cd "$bestaand" && bash _bootstrap/kit/new-project.sh . --no-git --modules herordening >/dev/null)
check "bootstrap: kit uit het pakket werkt" test -f "$bestaand/docs/work/specs/herordening.md" -a -f "$bestaand/AGENTS.md"
check "bootstrap: bestaand bestand niet overschreven" grep -qx '# Bestaand' "$bestaand/README.md"
check "bootstrap: link-check slaat het pakket over" bash "$bestaand/scripts/check-links.sh" "$bestaand"
(cd "$bestaand" && bash _bootstrap/scripts/bootstrap.sh --remove . >/dev/null)
refute "bootstrap --remove: pakket weg" test -e "$pkg"
refute "bootstrap --remove: exclude-regel weg" grep -q _bootstrap "$bestaand/.git/info/exclude"
refute "bootstrap --remove: weigert zonder pakket" bash scripts/bootstrap.sh --remove "$bestaand"

leeg="$work/leeg"
bash scripts/bootstrap.sh "$leeg" >/dev/null
check "bootstrap leeg: eigen repo en genegeerd" git -C "$leeg" check-ignore -q _bootstrap/BOOTSTRAP.md
check "bootstrap leeg: git init in de map zelf" test -d "$leeg/.git"

mono="$work/mono"
mkdir -p "$mono/sub"
git -C "$mono" init -q
echo x >"$mono/sub/a.txt"
bash scripts/bootstrap.sh "$mono/sub" >/dev/null
check "bootstrap submap: exclude met prefix" grep -qx '/sub/_bootstrap/' "$mono/.git/info/exclude"
refute "bootstrap submap: geen eigen repo" test -e "$mono/sub/.git"
check "bootstrap submap: genegeerd door git" git -C "$mono" check-ignore -q sub/_bootstrap/BOOTSTRAP.md
bash scripts/bootstrap.sh --remove "$mono/sub" >/dev/null
refute "bootstrap submap --remove: exclude-regel weg" grep -q _bootstrap "$mono/.git/info/exclude"

if command -v python3 >/dev/null && python3 -c 'import yaml' 2>/dev/null; then
  echo "YAML"
  while IFS= read -r -d '' file; do
    check "geldig: ${file#kit/}" python3 -c 'import sys, yaml; yaml.safe_load(open(sys.argv[1]))' "$file"
  done < <(find kit meten/kit \( -name '*.yml' -o -name '*.yaml' \) -print0)
fi

echo
if ((failures)); then
  echo "test-kit: $failures fout(en)" >&2
  exit 1
fi
echo "test-kit: alles groen"
