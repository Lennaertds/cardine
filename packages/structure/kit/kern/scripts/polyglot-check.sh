#!/usr/bin/env bash
# Checklist polyglot-docs. Niet in make check. Geen Rust-stack (v1).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/architecture/polyglot.md
example_adr=docs/decisions/0000-example-native-module-after-budget-breach.md
die() { echo "polyglot-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "missing $file (kit: kern)."
[[ -f "$example_adr" ]] || die "missing example ADR $example_adr (kit: kern)."

for heading in "## Relation to other docs" "## Decision tree" "## Integration forms" "## What the agent may do" "## Commands" "## Deliberately later"; do
  grep -qF "$heading" "$file" || die "section missing in $file: $heading"
done

awk '
  /^## Deliberately later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Extension/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "table under ## Deliberately later has no extension rows (P28)"

grep -qF 'example' "$example_adr" || die "$example_adr must carry status/role 'example'"
grep -qE 'FFI|sidecar|separate process' "$file" || die "$file must name the integration forms FFI/sidecar/process"

echo "ok    $file (vaste secties aanwezig, incl. Bewust later)"
echo "ok    $example_adr (example ADR present)"
echo "Tip: before native code — measure (bench/obs), then make adr t=\"…\", and only then the crate/folder."
echo "polyglot-check: groen"
