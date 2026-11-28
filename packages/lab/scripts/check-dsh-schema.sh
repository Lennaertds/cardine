#!/usr/bin/env bash
# check-dsh-schema.sh — answers the questions a wider boundary needs, from the
# installed DSH package (the upstream code itself, never a copy of it).
#
# Run it on the host. Inside the cage the @deepseek-ai package is not mounted;
# the script then stops with exit 2. Point it at a specific install with
# DSH_PKG_ROOT=/path/to/node_modules, or at a fixture in tests.
#
# Usage: bash packages/lab/scripts/check-dsh-schema.sh
# Exit: 0 = every question answered, 1 = a question is still open, 2 = no package found.
set -uo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../lib/dsh-schema.sh
. "$LAB_DIR/lib/dsh-schema.sh"

if [ -z "$(dsh_pkg_roots)" ]; then
  echo "check-dsh-schema: @deepseek-ai not found from here." >&2
  dsh_pkg_hint >&2
  d="$(readlink -f "$(command -v dsh 2>/dev/null)" 2>/dev/null || true)"
  echo "  Find it yourself, then point the probe at it:" >&2
  echo "    d=\$(readlink -f \"\$(command -v dsh)\")" >&2
  echo "    find \"\$(dirname \"\$(dirname \"\$d\")\")\" -maxdepth 4 -type d -name '@deepseek-ai'" >&2
  echo "    DSH_PKG_ROOT=<that dir's parent> bash ${BASH_SOURCE[0]}" >&2
  exit 2
fi

echo "check-dsh-schema: package at $(dsh_pkg_roots | head -1)"

open=0
q() { printf '\n== %s\n' "$1"; }
show() { sed 's/^/  /'; }

q "Q1 — dsh-sandbox-policy: is there a field for extra (writable) roots?"
keys="$(exact_key dsh-sandbox-policy writableRoots; exact_key dsh-sandbox-policy extraRoots; \
        exact_key dsh-sandbox-policy readOnlyRoots; exact_key dsh-sandbox-policy denyRead)"
if [ -n "$keys" ]; then
  echo "$keys" | show
  echo "  => one boundary can take a hole: the DSH sandbox itself covers the system zone"
else
  echo "  no root field — only mode/workspaceRoot"; open=$((open + 1))
fi

q "Q2 — dsh-user-approval: is the policy per path/target, or once per profile?"
keys="$(exact_key dsh-user-approval byPath; exact_key dsh-user-approval rules; \
        exact_key dsh-user-approval perPath; exact_key dsh-user-approval target)"
if [ -n "$keys" ]; then echo "$keys" | show; else echo "  no per-path policy key"; fi
echo "  => ask only in the system zone needs a plugin unless a key above exists"

q "Q3 — can the ask reach Zed over ACP (request_permission)?"
hits="$(text_hits dsh-acp-app 'request_permission|requestPermission'; \
        text_hits dsh-user-approval 'request_permission|requestPermission')"
if [ -n "$hits" ]; then
  echo "$hits" | cut -c1-180 | show
  echo "  => the dialog can be shown in Zed"
else
  echo "  no request_permission in the ACP app or the approval plugin"
  echo "  => not proven: until shown in Zed, a system write fails closed (named refusal)"
fi

q "Q4 — dsh-tool-fs: is edit its own key?"
keys="$(exact_key dsh-tool-fs write; exact_key dsh-tool-fs edit)"
echo "$keys" | show
if [ -n "$(exact_key dsh-tool-fs edit)" ]; then
  echo "  => write and edit are separate: a profile can register write without edit"
else
  echo "  no edit key: write covers both"
fi

printf '\n'
if [ "$open" -gt 0 ]; then
  echo "check-dsh-schema: $open question(s) still open — the mechanism in the spec depends on them"
  exit 1
fi
echo "check-dsh-schema: every question answered"
