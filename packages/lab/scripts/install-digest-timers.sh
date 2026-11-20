#!/usr/bin/env bash
# LAB-PRIVÉ: install-digest-timers is verhuisd naar Agent_Engineering.
# Deze stub bestaat alleen voor backwards compat. Op een publieke checkout
# zonder Agent_Engineering als sibling geeft dit een duidelijke fout.
set -euo pipefail
AE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../Agent_Engineering" 2>/dev/null && pwd)" || {
  echo "LAB-PRIVÉ: install-digest-timers vereist Agent_Engineering als sibling-repo." >&2
  echo "Die repo is niet publiek. Installeer hem naast cardine of sla dit script over." >&2
  exit 1
}
echo "install-digest-timers: verhuisd → ../Agent_Engineering/scripts/install-digest-timers.sh" >&2
exec bash "${AE_DIR}/scripts/install-digest-timers.sh"
