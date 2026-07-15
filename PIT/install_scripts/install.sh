#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/common.sh"

pit_init

OWNER="$(pit_require_value "${OWNER:-}" "${PIT_OWNER:-}" "Enter owner schema for PIT: ")"
OWNERPWD="$(pit_require_value "${OWNERPWD:-}" "${PIT_OWNER_PW:-}" "Enter password for ${OWNER}: " true)"
SERVICE="$(pit_require_value "${SERVICE:-}" "${PIT_SERVICE:-}" "Enter service name for the database or PDB: ")"
DEFAULT_LANGUAGE="$(pit_require_value "${DEFAULT_LANGUAGE:-}" "${PIT_DEFAULT_LANGUAGE:-}" "Enter default language for messages (GERMAN or AMERICAN): ")"
DEFAULT_LANGUAGE="$(printf '%s' "${DEFAULT_LANGUAGE}" | tr '[:lower:]' '[:upper:]')"
case "${DEFAULT_LANGUAGE}" in
  GERMAN|AMERICAN)
    ;;
  *)
    echo "Unsupported default language: ${DEFAULT_LANGUAGE}. Expected GERMAN or AMERICAN." >&2
    exit 1
    ;;
esac
PIT_INSTALL_MODE="$(pit_require_value "${PIT_INSTALL_MODE:-}" "" "Enter install mode (I18N or MONOLINGUAL, default I18N): ")"
PIT_INSTALL_MODE="${PIT_INSTALL_MODE:-I18N}"
PIT_INSTALL_MODE="$(printf '%s' "${PIT_INSTALL_MODE}" | tr '[:lower:]' '[:upper:]')"
case "${PIT_INSTALL_MODE}" in
  I18N|MONOLINGUAL)
    ;;
  *)
    echo "Unsupported install mode: ${PIT_INSTALL_MODE}. Expected I18N or MONOLINGUAL." >&2
    exit 1
    ;;
esac
LOG_FILE="$(pit_log_path "Install_PIT.log")"

pit_prepare_log "${LOG_FILE}"
pit_run_sqlplus "${OWNER}" "${OWNERPWD}" "${SERVICE}" "./install_scripts/install.sql" "${LOG_FILE}" "${DEFAULT_LANGUAGE}" "${PIT_INSTALL_MODE}"
