#!/usr/bin/env bash
# Verhuisd: digest draait in Agent_Engineering.
set -euo pipefail
echo "install-digest-timers: verhuisd → ../Agent_Engineering/scripts/install-digest-timers.sh" >&2
exec bash "$(cd "$(dirname "${BASH_SOURCE[0]}")/../../Agent_Engineering" && pwd)/scripts/install-digest-timers.sh"
