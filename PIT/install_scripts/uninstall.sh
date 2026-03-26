#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/common.sh"

pit_init

OWNER="$(pit_require_value "${OWNER:-}" "${PIT_OWNER:-}" "Enter owner schema for PIT: ")"
OWNERPWD="$(pit_require_value "${OWNERPWD:-}" "${PIT_OWNER_PW:-}" "Enter password for ${OWNER}: " true)"
SERVICE="$(pit_require_value "${SERVICE:-}" "${PIT_SERVICE:-}" "Enter service name for the database or PDB: ")"
LOG_FILE="$(pit_log_path "Uninstall_PIT.log")"

pit_prepare_log "${LOG_FILE}"
pit_run_sqlplus "${OWNER}" "${OWNERPWD}" "${SERVICE}" "./install_scripts/uninstall.sql" "${LOG_FILE}" "${OWNER}" "${USER}"
