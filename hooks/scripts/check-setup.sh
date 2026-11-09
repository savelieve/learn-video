#!/usr/bin/env bash
# Advisory only: config parsing and permissions belong to the shared Python code.
set -u
PLUGIN_DIR="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/../.." && pwd)}"
SETUP_SCRIPT="$PLUGIN_DIR/skills/learn-video/scripts/setup.py"
for interpreter in python3 python; do
  if command -v "$interpreter" >/dev/null 2>&1 && "$interpreter" -c 'import sys; sys.exit(sys.version_info < (3, 10))' >/dev/null 2>&1; then
    if "$interpreter" "$SETUP_SCRIPT" --check >/dev/null 2>&1; then
      exit 0
    fi
    echo '/learn-video: setup needs attention. Invoke the learn-video skill to check dependencies and configuration.'
    exit 0
  fi
done
echo '/learn-video: Python 3.10+ is needed. Install a working Python interpreter and invoke the learn-video skill.'
exit 0
