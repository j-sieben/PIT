#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/common.sh"

pit_init

OWNER="$(pit_require_value "${OWNER:-}" "${PIT_OWNER:-}" "Enter owner schema for PIT: ")"
OWNERPWD="$(pit_require_value "${OWNERPWD:-}" "${PIT_OWNER_PW:-}" "Enter password for ${OWNER}: " true)"
SERVICE="$(pit_require_value "${SERVICE:-}" "${PIT_SERVICE:-}" "Enter service name for the database or PDB: ")"
REMOTEOWNER="$(pit_require_value "${REMOTEOWNER:-}" "${PIT_CLIENT:-}" "Enter client schema name: ")"
REMOTEPWD="$(pit_require_value "${REMOTEPWD:-}" "${PIT_CLIENT_PW:-}" "Enter password for ${REMOTEOWNER}: " true)"
MODULE="$(pit_require_value "${MODULE:-}" "${PIT_MODULE:-}" "Enter module name to grant: ")"
LOG_FILE="$(pit_log_path "Install_PIT_module_${MODULE}_client_${REMOTEOWNER}.log")"

pit_prepare_log "${LOG_FILE}"
pit_run_sqlplus "${OWNER}" "${OWNERPWD}" "${SERVICE}" "./install_scripts/grant_module_access.sql" "${LOG_FILE}" "${OWNER}" "${REMOTEOWNER}" "${MODULE}"
pit_run_sqlplus "${REMOTEOWNER}" "${REMOTEPWD}" "${SERVICE}" "./install_scripts/register_module_client.sql" "${LOG_FILE}" "${OWNER}" "${REMOTEOWNER}" "${MODULE}"
