#!/usr/bin/env bash
# Strix-wrapper: eigen targets only. Nooit in make check.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

mode=full
target="."
extra=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --quick) mode=quick; shift ;;
    --target) target="${2:?}"; shift 2 ;;
    *) extra+=("$1"); shift ;;
  esac
done

die() { echo "security-scan: $*" >&2; exit 1; }

command -v docker >/dev/null || die "Docker is missing or not in PATH. Start the daemon and install Docker."
docker info >/dev/null 2>&1 || die "Docker is not running. Start the daemon and try again."

if ! command -v strix >/dev/null; then
  cat >&2 <<'EOF'
security-scan: `strix` is not in PATH.

Install (either one):
  curl -sSL https://strix.ai/install | bash
  pipx install strix-agent

Then set an LLM provider, e.g.:
  export STRIX_LLM="openrouter/z-ai/glm-5.3"
  export LLM_API_KEY="…"

Skill for coding agents (optional):
  npx skills add usestrix/strix

Uitleg: docs/architecture/security.md · docs/how-to/security-scan.md
EOF
  exit 1
fi

if [[ -z "${LLM_API_KEY:-}${ANTHROPIC_API_KEY:-}${OPENAI_API_KEY:-}" && -z "${STRIX_LLM:-}" ]]; then
  echo "security-scan: warning — no LLM_API_KEY / STRIX_LLM visible in the environment." >&2
fi

echo "security-scan: only targets you have permission for (your own code / staging)."
args=(--target "$target")
if [[ "$mode" == quick ]]; then
  args+=(--scan-mode quick)
fi
if [[ ${#extra[@]} -gt 0 ]]; then
  args+=("${extra[@]}")
fi

exec strix "${args[@]}"
