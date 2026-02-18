#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

# Try to activate conda env if available (Git Bash / MSYS2 style paths)
if [[ -f "/c/Users/Lenovo/anaconda3/etc/profile.d/conda.sh" ]]; then
  # shellcheck source=/dev/null
  source "/c/Users/Lenovo/anaconda3/etc/profile.d/conda.sh"
  conda activate clarena || true
fi

python "${SCRIPT_DIR}/rerun_missing_acc_dd.py" "$@"
