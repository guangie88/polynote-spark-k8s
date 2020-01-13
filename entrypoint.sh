#!/usr/bin/env bash
set -euo pipefail

if [[ ! -v ENTRYPOINT_DISABLE_CONF_INJECT ]]; then
    python inject.py "POLYNOTE___" > "${POLYNOTE_HOME}/config.yml"
fi

exec python "${POLYNOTE_HOME}/polynote.py"
