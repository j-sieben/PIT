#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_usage() {
  cat <<'EOF'
Usage:
  ./pit.sh <command> [options]

Commands:
  install
  install-client
  install-apex
  install-module
  install-module-client
  uninstall
  uninstall-client
  uninstall-module
  uninstall-module-client
  help

Options:
  --owner <schema>              PIT owner schema
  --client <schema>             Client schema or APEX-accessible schema
  --service <service>           Database service or PDB
  --default-language <lang>     Message language, e.g. GERMAN or AMERICAN
  --module <name>               PIT module name
  --apex-workspace <name>       APEX workspace for install-apex
  --apex-app-id <id>            APEX application id for install-apex
  -h, --help                    Show this help

Environment variables:
  PIT_OWNER
  PIT_OWNER_PW
  PIT_CLIENT
  PIT_CLIENT_PW
  PIT_SERVICE
  PIT_DEFAULT_LANGUAGE
  PIT_MODULE
  PIT_APEX_WORKSPACE
  PIT_APEX_APP_ID
  PIT_LOG_DIR

Input priority:
  1. CLI options
  2. Environment variables
  3. Interactive prompts

Passwords are intentionally not accepted as CLI options. Use PIT_OWNER_PW and PIT_CLIENT_PW.
EOF
}

require_option_value() {
  local option_name="$1"
  local option_value="${2:-}"

  if [ -z "${option_value}" ]; then
    echo "Missing value for ${option_name}" >&2
    exit 1
  fi
}

COMMAND="${1:-}"

if [ -z "${COMMAND}" ]; then
  print_usage
  exit 1
fi

shift

while [ $# -gt 0 ]; do
  case "$1" in
    --owner)
      require_option_value "$1" "${2:-}"
      export OWNER="$2"
      shift 2
      ;;
    --client)
      require_option_value "$1" "${2:-}"
      export REMOTEOWNER="$2"
      shift 2
      ;;
    --service)
      require_option_value "$1" "${2:-}"
      export SERVICE="$2"
      shift 2
      ;;
    --default-language)
      require_option_value "$1" "${2:-}"
      export DEFAULT_LANGUAGE="$2"
      shift 2
      ;;
    --module)
      require_option_value "$1" "${2:-}"
      export MODULE="$2"
      shift 2
      ;;
    --apex-workspace)
      require_option_value "$1" "${2:-}"
      export APPWS="$2"
      shift 2
      ;;
    --apex-app-id)
      require_option_value "$1" "${2:-}"
      export APPID="$2"
      shift 2
      ;;
    --owner-password|--client-password|--password)
      echo "Passwords must not be passed via CLI. Use PIT_OWNER_PW and PIT_CLIENT_PW." >&2
      exit 1
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      print_usage
      exit 1
      ;;
  esac
done

case "${COMMAND}" in
  install)
    exec "${SCRIPT_DIR}/install_scripts/install.sh"
    ;;
  install-client)
    exec "${SCRIPT_DIR}/install_scripts/install_client.sh"
    ;;
  install-apex)
    exec "${SCRIPT_DIR}/install_scripts/install_apex.sh"
    ;;
  install-module)
    exec "${SCRIPT_DIR}/install_scripts/install_module.sh"
    ;;
  install-module-client)
    exec "${SCRIPT_DIR}/install_scripts/install_module_client.sh"
    ;;
  uninstall)
    exec "${SCRIPT_DIR}/install_scripts/uninstall.sh"
    ;;
  uninstall-client)
    exec "${SCRIPT_DIR}/install_scripts/uninstall_client.sh"
    ;;
  uninstall-module)
    exec "${SCRIPT_DIR}/install_scripts/uninstall_module.sh"
    ;;
  uninstall-module-client)
    exec "${SCRIPT_DIR}/install_scripts/uninstall_module_client.sh"
    ;;
  help|-h|--help)
    print_usage
    ;;
  *)
    echo "Unknown command: ${COMMAND}" >&2
    print_usage
    exit 1
    ;;
esac
