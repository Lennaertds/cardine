#!/usr/bin/env bash
# agent-engineering-status.sh — check de status van de Agent_Engineering kit.
#
# Gebruik:
#   bash scripts/agent-engineering-status.sh
#   bash scripts/agent-engineering-status.sh --json
#   bash scripts/agent-engineering-status.sh --verbose
set -euo pipefail

###############################################################################
# Configuratie
###############################################################################
AE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERBOSE=false
JSON=false

for arg in "$@"; do
  case "$arg" in
    --verbose|-v) VERBOSE=true ;;
    --json|-j)    JSON=true ;;
  esac
done

###############################################################################
# Helper-functies
###############################################################################
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
NC='\033[0m'

RESULTS=()
FAILED=0
WARNED=0

pass() {
  local label="$1" detail="${2:-}"
  RESULTS+=("{\"component\":\"${label}\",\"status\":\"ok\",\"detail\":\"${detail}\"}")
  if ! $JSON; then
    printf "  ${GREEN}✓${NC} %s" "$label"
    $VERBOSE && [ -n "$detail" ] && printf " — %s" "$detail"
    echo ""
  fi
}

fail() {
  local label="$1" detail="${2:-}"
  RESULTS+=("{\"component\":\"${label}\",\"status\":\"fail\",\"detail\":\"${detail}\"}")
  FAILED=$((FAILED + 1))
  if ! $JSON; then
    printf "  ${RED}✗${NC} %s" "$label"
    $VERBOSE && [ -n "$detail" ] && printf " — %s" "$detail"
    echo ""
  fi
}

warn() {
  local label="$1" detail="${2:-}"
  RESULTS+=("{\"component\":\"${label}\",\"status\":\"warn\",\"detail\":\"${detail}\"}")
  WARNED=$((WARNED + 1))
  if ! $JSON; then
    printf "  ${YELLOW}~${NC} %s" "$label"
    $VERBOSE && [ -n "$detail" ] && printf " — %s" "$detail"
    echo ""
  fi
}

header() {
  if ! $JSON; then
    echo ""
    echo "${BOLD}$1${NC}"
  fi
}

###############################################################################
# 1. Package version
###############################################################################
header "1. Package version"

AE_PKG="${AE_DIR}/package.json"
if [ -f "$AE_PKG" ]; then
  AE_VER=$(node -e "const p=require('${AE_PKG}'); console.log(p.version||'0.0.0')" 2>/dev/null || echo "0.0.0")
  pass "Agent_Engineering" "versie $AE_VER"
else
  fail "package.json" "niet gevonden in $AE_DIR"
fi

###############################################################################
# 2. Kit-lagen
###############################################################################
header "2. Kit-lagen"

for layer in kern solo team modules stacks; do
  LAYER_DIR="${AE_DIR}/kit/${layer}"
  if [ -d "$LAYER_DIR" ]; then
    COUNT=$(find "$LAYER_DIR" -type f 2>/dev/null | wc -l)
    pass "kit/${layer}" "$COUNT bestanden"
  else
    warn "kit/${layer}" "map niet gevonden"
  fi
done

###############################################################################
# 3. Standaard / sjablonen
###############################################################################
header "3. Standaard en sjablonen"

for dir in standaard sjablonen bron; do
  DIR_PATH="${AE_DIR}/${dir}"
  if [ -d "$DIR_PATH" ]; then
    COUNT=$(find "$DIR_PATH" -type f -name '*.md' 2>/dev/null | wc -l)
    pass "${dir}" "${COUNT} documenten"
  else
    warn "${dir}" "map niet gevonden"
  fi
done

###############################################################################
# 4. Make werkt
###############################################################################
header "4. Make check"

if [ -f "${AE_DIR}/Makefile" ]; then
  if make -C "$AE_DIR" check &>/dev/null; then
    pass "make check" "slaagt"
  else
    warn "make check" "faalt — draai make check voor details"
  fi
else
  fail "Makefile" "niet gevonden"
fi

###############################################################################
# Overzicht
###############################################################################
header ""
header "========================================"
if ! $JSON; then
  echo "${BOLD}Samenvatting:${NC}"
  echo "  $((${#RESULTS[@]})) checks — ${GREEN}$(( ${#RESULTS[@]} - FAILED - WARNED )) OK${NC}, ${YELLOW}${WARNED} warnings${NC}, ${RED}${FAILED} failures${NC}"
fi

if $JSON; then
  echo "["
  for i in "${!RESULTS[@]}"; do
    sep=","
    [ $i -eq $((${#RESULTS[@]} - 1)) ] && sep=""
    echo "  ${RESULTS[$i]}${sep}"
  done
  echo "]"
fi

exit $FAILED