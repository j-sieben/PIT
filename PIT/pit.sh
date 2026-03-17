#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_usage() {
  cat <<'EOF'
Usage:
  ./pit.sh <command>

Commands:
  install                Install PIT core
  install-client         Install PIT client access
  install-apex           Install PIT APEX administration
  install-module         Install a PIT output module
  install-module-client  Grant a PIT output module to a client schema
  uninstall              Uninstall PIT core
  uninstall-client       Remove PIT client access
  uninstall-module       Uninstall a PIT output module
  uninstall-module-client Remove a PIT output module from a client schema
  help                   Show this help
EOF
}

if [ $# -eq 0 ]; then
  print_usage
  exit 1
fi

case "$1" in
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
    echo "Unknown command: $1" >&2
    print_usage
    exit 1
    ;;
esac
