#!/usr/bin/env bash
# cardine-status.sh — check de status van DSH, Jarvis en aanverwante tooling.
#
# Gebruik:
#   bash packages/lab/cardine-status.sh              (standaard check)
#   bash packages/lab/cardine-status.sh --json       (machineleesbare output)
#   bash packages/lab/cardine-status.sh --verbose    (extra detail)
#   bash packages/lab/cardine-status.sh --fix        (herstel sandbox-paden in DSH-profiel)
#
# Dit script is idempotent. --fix schrijft alleen naar het DSH-profiel.
set -euo pipefail

###############################################################################
# Configuratie
###############################################################################
DSH_BIN="${HOME}/.local/bin/dsh"
JARVIS_SERVER="${HOME}/.local/bin/jarvis-server"
JARVIS_CLI="${HOME}/.local/bin/jarvis"
JARVIS_BIN_DIR="${HOME}/.jarvis/bin"
DSH_ENV_FILE="${HOME}/.dsh/.env"
DSH_PROFILE="${HOME}/.dsh/profiles/acp/cordis.patch.yml"
ZED_SETTINGS="${HOME}/.config/zed/settings.json"
NODE_MIN_MAJOR=24
NODE_MIN_MINOR=9
# Twee verschillende roots, en dat onderscheid is essentieel:
#
#   PROJECT_DIR — het project waar je in werkt (workspaceRoot, index, scripts/).
#                 De git-root van $PWD, zoals install-lab.sh dat ook doet.
#   LAB_DIR     — de map van dit script: de lab-package zelf. In de repo is dat
#                 <repo>/packages/lab/; via `npm i -g @lennaertds/cardine-lab`
#                 is het <prefix>/lib/node_modules/@lennaertds/cardine-lab/.
#
# Nooit LAB_DIR uit PROJECT_DIR afleiden (`${PROJECT_DIR}/packages/lab`): die
# bestaat niet in een willekeurig project of in een npm-installatie, en dan
# vindt de status cardine-bwrap en de slice-check niet terug.
SELF="$(readlink -f "${BASH_SOURCE[0]}")"
LAB_DIR="$(cd "$(dirname "${SELF}")" && pwd)"
PROJECT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
VERBOSE=false
JSON=false
FIX=false
# Detecteer of we in een DSH/bwrap sandbox zitten
IN_SANDBOX=false
if [ -n "${DSH_SESSION_ID:-}" ] && [ -n "${DSH_SHELL:-}" ]; then
  IN_SANDBOX=true
fi

# Parse flags
for arg in "$@"; do
  case "$arg" in
    --verbose|-v) VERBOSE=true ;;
    --json|-j)    JSON=true ;;
    --fix|-f)     FIX=true ;;
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

# Resultaten opslaan voor JSON-output
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
# 0. Sandbox status
###############################################################################
header "0. Sandbox / bwrap"

if $IN_SANDBOX; then
  pass "sandbox" "actief (DSH_SESSION_ID=${DSH_SESSION_ID:0:8}...)"
  # Check of ~/.dsh persistent is
  if [ -d "${HOME}/.dsh" ] && [ -f "${HOME}/.dsh/profiles/acp/cordis.patch.yml" ]; then
    pass "~/.dsh persistent" "profiel bereikbaar binnen sandbox"
  else
    warn "~/.dsh persistent" "niet gevonden — bwrap mount werkt nog niet"
  fi
else
  warn "sandbox" "niet gedetecteerd (geen DSH_SESSION_ID/DSH_SHELL)"
fi

if [ "$(ps -p 1 -o comm= 2>/dev/null || true)" = "bwrap" ]; then
  pass "PID 1" "bwrap"
elif $IN_SANDBOX; then
  fail "PID 1" "niet bwrap"
else
  warn "PID 1" "deze shell zit niet in de kooi"
fi

mount_line="$(awk -v dir="$PROJECT_DIR" '$5 == dir { print $0; exit }' /proc/self/mountinfo 2>/dev/null || true)"
case "$mount_line" in
  *overlay*)
    fail "schrijfroute" "overlay — een write verdwijnt (ADR 0017 verwacht bind)"
    ;;
  "")
    if $IN_SANDBOX; then
      warn "schrijfroute" "geen mountinfo voor $PROJECT_DIR"
    else
      warn "schrijfroute" "niet in de kooi"
    fi
    ;;
  *)
    pass "schrijfroute" "bind"
    ;;
esac

if [ -f "$DSH_PROFILE" ]; then
  if grep -q 'policy: never' "$DSH_PROFILE" \
    && grep -q 'write: false' "$DSH_PROFILE" \
    && grep -q 'edit: false' "$DSH_PROFILE" \
    && grep -q 'mode: workspace-write' "$DSH_PROFILE" \
    && ! grep -q 'process.cwd()' "$DSH_PROFILE"; then
    pass "profiel" "workspace-write, approval never, write/edit uit"
  else
    warn "profiel" "wijkt af van ADR 0017 — install-lab.sh en daarna DSH herstarten"
  fi
else
  warn "profiel" "niet gevonden ($DSH_PROFILE)"
fi

###############################################################################
# 1. DSH — DeepSeek Harness
###############################################################################
header "1. DSH (DeepSeek Harness)"

if [ -x "$DSH_BIN" ]; then
  DSH_VER=$("$DSH_BIN" --version 2>/dev/null | head -1 || echo "onbekend")
  if echo "$DSH_VER" | grep -qE '[0-9]+\.[0-9]+\.[0-9]+'; then
    pass "dsh" "versie $DSH_VER op $DSH_BIN"
  else
    warn "dsh" "binary ok maar versie niet herkend: $DSH_VER"
  fi
else
  fail "dsh" "binary niet gevonden op $DSH_BIN — run packages/lab/install-lab.sh"
fi

###############################################################################
# 2. jarvis-server & jarvis CLI
###############################################################################
header "2. Jarvis"

if [ -x "$JARVIS_SERVER" ]; then
  JARVIS_VER=$("$JARVIS_CLI" --version 2>/dev/null || true)
  pass "jarvis-server" "gevonden op $JARVIS_SERVER${JARVIS_VER:+ — $JARVIS_VER}"
else
  # Check via uv tool
  if command -v uv &>/dev/null && uv tool list 2>/dev/null | grep -q jarvis-mcp; then
    warn "jarvis-server" "binary niet op $JARVIS_SERVER, maar wel geïnstalleerd via uv"
  else
    fail "jarvis-server" "niet gevonden — run packages/lab/install-lab.sh"
  fi
fi

if [ -x "$JARVIS_CLI" ]; then
  pass "jarvis CLI" "gevonden op $JARVIS_CLI"
else
  fail "jarvis CLI" "niet gevonden"
fi

###############################################################################
# 3. Zoekt + SCIP binaries
###############################################################################
header "3. Zoekt + SCIP binaries"

ZOEKT_OK=true
for bin in zoekt-git-index zoekt-webserver; do
  if [ -x "${JARVIS_BIN_DIR}/${bin}" ]; then
    pass "${bin}" "gevonden in $JARVIS_BIN_DIR"
  else
    fail "${bin}" "niet gevonden in $JARVIS_BIN_DIR"
    ZOEKT_OK=false
  fi
done

SCIP_OK=true
for bin in scip; do
  if [ -x "${JARVIS_BIN_DIR}/${bin}" ]; then
    pass "${bin}" "gevonden in $JARVIS_BIN_DIR"
  else
    warn "${bin}" "niet gevonden — alleen nodig voor SCIP-indexing"
    SCIP_OK=false
  fi
done

if [ -x "${JARVIS_BIN_DIR}/scip-python" ]; then
  pass "scip-python" "gevonden"
else
  warn "scip-python" "niet gevonden — optioneel voor Python SCIP-indexing"
fi

###############################################################################
# 4. DSH ACP-profiel
###############################################################################
header "4. DSH ACP-profiel"

# DSH laadt profiel van DSH_HOME, niet per se ~/.dsh
DSH_HOME_DIR="${DSH_HOME:-${HOME}/.dsh}"
DSH_PROFILE_ACTUAL="${DSH_HOME_DIR}/profiles/acp/cordis.patch.yml"

if [ -f "$DSH_PROFILE_ACTUAL" ]; then
  if grep -q 'deepinfra' "$DSH_PROFILE_ACTUAL" 2>/dev/null && \
     grep -q 'jarvis-server' "$DSH_PROFILE_ACTUAL" 2>/dev/null && \
     grep -q 'sandbox-policy' "$DSH_PROFILE_ACTUAL" 2>/dev/null; then
    pass "DSH profiel" "$DSH_PROFILE_ACTUAL (deepinfra + jarvis + sandbox)"
  else
    warn "DSH profiel" "$DSH_PROFILE_ACTUAL bestaat maar mist componenten"
  fi
elif [ -f "$DSH_PROFILE" ]; then
  # Fallback naar ~/.dsh voor als DSH_HOME niet gezet is
  if grep -q 'deepinfra' "$DSH_PROFILE" 2>/dev/null && \
     grep -q 'jarvis-server' "$DSH_PROFILE" 2>/dev/null && \
     grep -q 'sandbox-policy' "$DSH_PROFILE" 2>/dev/null; then
    pass "DSH profiel" "$DSH_PROFILE (deepinfra + jarvis + sandbox)"
  else
    warn "DSH profiel" "$DSH_PROFILE bestaat maar mist componenten"
  fi
else
  fail "DSH profiel" "niet gevonden in $DSH_PROFILE_ACTUAL of $DSH_PROFILE — run packages/lab/install-lab.sh"
fi

###############################################################################
# 5. API-key
###############################################################################
header "5. API-key (credentials)"

if [ -f "$DSH_ENV_FILE" ]; then
  if grep -q '^DEEPSEEK_API_KEY=' "$DSH_ENV_FILE" 2>/dev/null; then
    KEY_VAL=$(grep '^DEEPSEEK_API_KEY=' "$DSH_ENV_FILE" | head -1 | cut -d= -f2)
    if [ -n "$KEY_VAL" ]; then
      KEY_PREVIEW="${KEY_VAL:0:8}...${KEY_VAL: -4}"
      pass "API-key" "$DSH_ENV_FILE ($KEY_PREVIEW)"
    else
      fail "API-key" "$DSH_ENV_FILE bestaat maar DEEPSEEK_API_KEY is leeg"
    fi
  else
    fail "API-key" "$DSH_ENV_FILE heeft geen DEEPSEEK_API_KEY"
  fi
else
  fail "API-key" "$DSH_ENV_FILE niet gevonden — run packages/lab/install-lab.sh"
fi

###############################################################################
# 6. Node-versie
###############################################################################
header "6. Node.js"

if command -v node &>/dev/null; then
  NODE_VER="$(node --version | sed 's/^v//')"
  NODE_MAJOR="${NODE_VER%%.*}"
  NODE_MINOR="${NODE_VER#*.}"
  NODE_MINOR="${NODE_MINOR%%.*}"
  if [ "$NODE_MAJOR" -lt "$NODE_MIN_MAJOR" ] || \
     { [ "$NODE_MAJOR" -eq "$NODE_MIN_MAJOR" ] && [ "$NODE_MINOR" -lt "$NODE_MIN_MINOR" ]; }; then
    fail "node" "v$NODE_VER — minimum is v$NODE_MIN_MAJOR.$NODE_MIN_MINOR"
  else
    pass "node" "v$NODE_VER (≥ v$NODE_MIN_MAJOR.$NODE_MIN_MINOR)"
  fi
else
  fail "node" "niet op PATH"
fi

###############################################################################
# 7. Node-packages van cardine zelf
###############################################################################
header "7. Cardine packages"

CARDINE_PKG="${LAB_DIR}/package.json"
if [ -f "$CARDINE_PKG" ]; then
  CARDINE_VER=$(node -e "const p=require('${CARDINE_PKG}'); console.log(p.version||'onbekend')" 2>/dev/null || echo "onbekend")
  pass "cardine" "versie $CARDINE_VER"
else
  warn "cardine" "geen package.json in $LAB_DIR"
fi

# Check cardine-slice-check package
SLICE_PKG="${LAB_DIR}/cardine-slice-check/package.json"
if [ -f "$SLICE_PKG" ]; then
  SLICE_VER=$(node -e "const p=require('${SLICE_PKG}'); console.log(p.version||'onbekend')" 2>/dev/null || echo "onbekend")
  pass "cardine-slice-check" "versie $SLICE_VER"
else
  warn "cardine-slice-check" "geen package.json"
fi

###############################################################################
# 8. Stale Jarvis lockfiles?
###############################################################################
header "8. Stale Jarvis locks"

STALE_LOCKS=false
if [ -d "${HOME}/.jarvis" ]; then
  for lock in "${HOME}/.jarvis"/index-*.lock; do
    [ -e "$lock" ] || continue
    pid=$(cat "$lock" 2>/dev/null || true)
    if [ -n "$pid" ] && ! kill -0 "$pid" 2>/dev/null; then
      STALE_LOCKS=true
      if $FIX; then
        rm -f "$lock"
        pass "stale lock opgeruimd" "$lock (PID $pid bestaat niet meer)"
      else
        fail "stale lock" "$lock (PID $pid bestaat niet meer — run met --fix om op te ruimen)"
      fi
    else
      pass "lock actief" "$lock (PID $pid)"
    fi
  done
fi
if ! $STALE_LOCKS; then
  $VERBOSE && pass "jarvis locks" "geen stale locks in ${HOME}/.jarvis/"
fi

###############################################################################
# 9. Is de repo geïndexeerd?
###############################################################################
header "9. Repo-indexering"

if [ -x "$JARVIS_CLI" ]; then
  INDEX_STATUS=$("$JARVIS_CLI" get-index-status "$PROJECT_DIR" 2>/dev/null || true)
  if echo "$INDEX_STATUS" | grep -qiE 'indexed.*true|freshness.*fresh' 2>/dev/null; then
    pass "jarvis index" "cardine repo is geïndexeerd"
  elif echo "$INDEX_STATUS" | grep -qi 'indexed.*false' 2>/dev/null; then
    warn "jarvis index" "cardine repo is nog niet geïndexeerd — draai: make index"
  else
    warn "jarvis index" "status niet bepaald (run: make index)"
  fi
else
  warn "jarvis index" "jarvis CLI niet beschikbaar om index-status te checken"
fi

###############################################################################
# 10. DSH integratietest (optioneel)
###############################################################################
header "10. DSH integratietest (snel)"

if [ -x "$DSH_BIN" ]; then
  echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}' | \
    "$DSH_BIN" --profile acp 2>&1 | head -5 | grep -q 'session/new' && \
    pass "dsh integratietest" "DSH start correct op met --profile acp" || \
    warn "dsh integratietest" "kon DSH niet kort starten — check of de API-key en config kloppen"
else
  warn "dsh integratietest" "overgeslagen — DSH niet beschikbaar"
fi

###############################################################################
# 11. Sandbox-configuratie en fixes
###############################################################################
header "11. Sandbox-configuratie"

CARDINE_BWRAP_EXPECTED="${LAB_DIR}/cardine-bwrap"
SLICE_CHECK_EXPECTED="${LAB_DIR}/cardine-slice-check/index.js"
SANDBOX_OK=true

# 11a. Bestaat cardine-bwrap op de verwachte plek?
if [ -f "$CARDINE_BWRAP_EXPECTED" ]; then
  pass "cardine-bwrap" "gevonden op $CARDINE_BWRAP_EXPECTED"
else
  fail "cardine-bwrap" "niet gevonden op $CARDINE_BWRAP_EXPECTED"
  SANDBOX_OK=false
fi

# 11a2. Bewaakt cardine-bwrap de .env-grens?
# ADR 0017 kiest --bind (geen overlay) en maskeert geheimen met een ro-bind van
# een leeg bestand. De vroegere 'overlay-src'-check keek naar de oude opzet.
if [ -f "$CARDINE_BWRAP_EXPECTED" ]; then
  SECRET_CHECK="${LAB_DIR}/scripts/check-bwrap-secrets.sh"
  BWRAP_HAS_BIND=false
  BWRAP_MASKS=false
  grep -q -- '--bind "\$src"' "$CARDINE_BWRAP_EXPECTED" 2>/dev/null && BWRAP_HAS_BIND=true
  grep -q -- '--ro-bind "\$mask_file"' "$CARDINE_BWRAP_EXPECTED" 2>/dev/null && BWRAP_MASKS=true
  if $BWRAP_HAS_BIND && $BWRAP_MASKS && [ -f "$SECRET_CHECK" ]; then
    pass "secrets-grens" "cardine-bwrap bindt de workspace en maskeert .env/keys (bewijs: make sandbox-secrets)"
  else
    if ! $BWRAP_HAS_BIND; then
      fail "secrets-grens" "cardine-bwrap bindt de workspace niet met --bind (ADR 0017)"
    elif ! $BWRAP_MASKS; then
      fail "secrets-grens" "cardine-bwrap maskeert .env/keys niet — oude versie? (make sandbox-secrets)"
    else
      fail "secrets-grens" "bewijs ontbreekt: $SECRET_CHECK niet gevonden"
    fi
    SANDBOX_OK=false
  fi
fi

# 11b. Bestaat slice-check op de verwachte plek?
if [ -f "$SLICE_CHECK_EXPECTED" ]; then
  pass "cardine-slice-check" "gevonden op $SLICE_CHECK_EXPECTED"
else
  fail "cardine-slice-check" "niet gevonden op $SLICE_CHECK_EXPECTED"
  SANDBOX_OK=false
fi

# 11c. Check DSH-profiel: staat het juiste pad naar cardine-bwrap?
if [ -f "$DSH_PROFILE" ]; then
  BWRAP_IN_PROFILE=$(grep -o '/[^"]*cardine-bwrap' "$DSH_PROFILE" 2>/dev/null || head -1)
  if [ -n "$BWRAP_IN_PROFILE" ]; then
    if [ "$BWRAP_IN_PROFILE" = "$CARDINE_BWRAP_EXPECTED" ]; then
      pass "DSH profiel → cardine-bwrap" "pad klopt: $BWRAP_IN_PROFILE"
    elif [ -f "$BWRAP_IN_PROFILE" ]; then
      # Een andere, wél bestaande installatie (repo naast npm) is geen fout:
      # het profiel start een werkende wrapper. Alleen een dood pad is rood.
      pass "DSH profiel → cardine-bwrap" "andere geldige installatie: $BWRAP_IN_PROFILE"
    else
      fail "DSH profiel → cardine-bwrap" "pad bestaat niet: ${BWRAP_IN_PROFILE}"$'\n'"    verwacht: ${CARDINE_BWRAP_EXPECTED}"
      SANDBOX_OK=false
      if $FIX; then
        if $JSON; then
          echo "  {\"fix\":\"DSH profiel cardine-bwrap pad\"},"
        else
          echo "    ${BOLD}─── ${GREEN}FIXEN${NC} met sed ...${NC}"
        fi
        sed -i "s|${BWRAP_IN_PROFILE}|${CARDINE_BWRAP_EXPECTED}|g" "$DSH_PROFILE"
        echo "    ${GREEN}✓${NC} gepatched"
        SANDBOX_OK=true
      fi
    fi
  else
    warn "DSH profiel → cardine-bwrap" "geen cardine-bwrap pad gevonden in profiel"
  fi

  # 11d. Check DSH-profiel: staat het juiste pad naar cardine-slice-check?
  SLICE_IN_PROFILE=$(grep -o '/[^"]*cardine-slice-check/index\.js' "$DSH_PROFILE" 2>/dev/null || head -1)
  if [ -n "$SLICE_IN_PROFILE" ]; then
    if [ "$SLICE_IN_PROFILE" = "$SLICE_CHECK_EXPECTED" ]; then
      pass "DSH profiel → slice-check" "pad klopt: $SLICE_IN_PROFILE"
    elif [ -f "$SLICE_IN_PROFILE" ]; then
      pass "DSH profiel → slice-check" "andere geldige installatie: $SLICE_IN_PROFILE"
    else
      fail "DSH profiel → slice-check" "pad bestaat niet: ${SLICE_IN_PROFILE}"$'\n'"    verwacht: ${SLICE_CHECK_EXPECTED}"
      SANDBOX_OK=false
      if $FIX; then
        if ! $JSON; then
          echo "    ${BOLD}─── ${GREEN}FIXEN${NC} met sed ...${NC}"
        fi
        sed -i "s|${SLICE_IN_PROFILE}|${SLICE_CHECK_EXPECTED}|g" "$DSH_PROFILE"
        echo "    ${GREEN}✓${NC} gepatched"
        SANDBOX_OK=true
      fi
    fi
  else
    # slice-check kan optioneel zijn — alleen warn als we in verbose mode zijn
    $VERBOSE && warn "DSH profiel → slice-check" "geen slice-check pad in profiel (optioneel)"
  fi
else
  fail "DSH profiel" "niet gevonden — kan sandbox-configuratie niet verifiëren"
  SANDBOX_OK=false
fi

# 11e. Check DSH_HOME environment variable
DSH_HOME_VAL="${DSH_HOME:-}"
if [ -n "$DSH_HOME_VAL" ]; then
  if [ "$DSH_HOME_VAL" = "${HOME}/.dsh" ]; then
    pass "DSH_HOME" "correct: $DSH_HOME_VAL"
  else
    warn "DSH_HOME" "afwijkend: $DSH_HOME_VAL (verwacht: ${HOME}/.dsh)"
  fi
else
  $VERBOSE && pass "DSH_HOME" "niet gezet (default ~/.dsh wordt gebruikt)"
fi

# 11f. Test of bwrap zelf werkt
if command -v bwrap &>/dev/null; then
  if bwrap --version &>/dev/null; then
    pass "bwrap" "geïnstalleerd ($(bwrap --version 2>&1))"
  else
    warn "bwrap" "binary gevonden maar werkt niet (seccomp? user namespaces?)"
  fi
else
  fail "bwrap" "niet geïnstalleerd — run: sudo pacman -S bubblewrap"
  SANDBOX_OK=false
fi

# 11g. Check of er nog oude scripts/ paden bestaan buiten het DSH-profiel
OLD_PATTERN="${PROJECT_DIR}/scripts/"
if [ -d "$OLD_PATTERN" ] 2>/dev/null; then
  warn "oude scripts/" "er bestaat nog een map ${OLD_PATTERN} — zou leeg moeten zijn"
fi

# 11h. Als SANDBOX_OK false is, toon een samenvattende fix-opdracht
if ! $SANDBOX_OK && ! $FIX && ! $JSON; then
  echo ""
  echo "  ${YELLOW}─── Sandbox-configuratie heeft problemen.${NC}"
  echo "  Herstel met: ${BOLD}cardine-lab status --fix${NC}${NC}"
fi

###############################################################################
# 11. `kit/` status
###############################################################################
###############################################################################
# Overzicht
###############################################################################
header ""
header "========================================"
if ! $JSON; then
  echo "${BOLD}Samenvatting:${NC}"
  echo "  $((${#RESULTS[@]})) checks — ${GREEN}$(( ${#RESULTS[@]} - FAILED - WARNED )) OK${NC}, ${YELLOW}${WARNED} warnings${NC}, ${RED}${FAILED} failures${NC}"
  if [ "$FAILED" -gt 0 ]; then
    echo ""
    if ! $SANDBOX_OK; then
      echo "${RED}Aanbevolen:${NC} run ${BOLD}cardine-lab status --fix${NC} om sandbox-paden te herstellen"
      echo "           Of ${BOLD}cardine-lab install${NC} voor volledige herinstallatie"
    else
      echo "${RED}Aanbevolen:${NC} run ${BOLD}bash packages/lab/install-lab.sh${NC} om te herstellen"
    fi
  fi
  echo ""
  echo "${BOLD}Volle versie:${NC} draai met ${BOLD}--verbose${NC} of ${BOLD}--json${NC}"
fi

# JSON output
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
