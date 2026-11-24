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

command -v docker >/dev/null || die "Docker ontbreekt of staat niet in PATH. Start de daemon en installeer Docker."
docker info >/dev/null 2>&1 || die "Docker draait niet. Start de daemon en probeer opnieuw."

if ! command -v strix >/dev/null; then
  cat >&2 <<'EOF'
security-scan: `strix` staat niet in PATH.

Installeer (één van beide):
  curl -sSL https://strix.ai/install | bash
  pipx install strix-agent

Zet daarna een LLM-provider, bv.:
  export STRIX_LLM="openrouter/z-ai/glm-5.3"
  export LLM_API_KEY="…"

Skill voor coding agents (optioneel):
  npx skills add usestrix/strix

Uitleg: docs/architecture/security.md · docs/how-to/security-scan.md
EOF
  exit 1
fi

if [[ -z "${LLM_API_KEY:-}${ANTHROPIC_API_KEY:-}${OPENAI_API_KEY:-}" && -z "${STRIX_LLM:-}" ]]; then
  echo "security-scan: waarschuwing — geen LLM_API_KEY / STRIX_LLM zichtbaar in de omgeving." >&2
fi

echo "security-scan: alleen targets waar je toestemming voor hebt (eigen code / staging)."
args=(--target "$target")
if [[ "$mode" == quick ]]; then
  args+=(--scan-mode quick)
fi
if [[ ${#extra[@]} -gt 0 ]]; then
  args+=("${extra[@]}")
fi

exec strix "${args[@]}"
