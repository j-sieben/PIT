#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/common.sh"

pit_init

OWNER="$(pit_require_value "${OWNER:-}" "${PIT_OWNER:-}" "Enter owner schema for PIT: ")"
OWNERPWD="$(pit_require_value "${OWNERPWD:-}" "${PIT_OWNER_PW:-}" "Enter password for ${OWNER}: " true)"
SERVICE="$(pit_require_value "${SERVICE:-}" "${PIT_SERVICE:-}" "Enter service name for the database or PDB: ")"
DEFAULT_LANGUAGE="$(pit_require_value "${DEFAULT_LANGUAGE:-}" "${PIT_DEFAULT_LANGUAGE:-}" "Enter default language for messages (GERMAN or AMERICAN): ")"
LOG_FILE="$(pit_log_path "Install_PIT.log")"

pit_prepare_log "${LOG_FILE}"
pit_run_sqlplus "${OWNER}" "${OWNERPWD}" "${SERVICE}" "./install_scripts/install.sql" "${LOG_FILE}" "${DEFAULT_LANGUAGE}"
