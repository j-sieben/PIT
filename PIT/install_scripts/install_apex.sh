#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/common.sh"

pit_init

OWNER="$(pit_require_value "${OWNER:-}" "${PIT_OWNER:-}" "Enter owner schema for PIT: ")"
OWNERPWD="$(pit_require_value "${OWNERPWD:-}" "${PIT_OWNER_PW:-}" "Enter password for ${OWNER}: " true)"
SERVICE="$(pit_require_value "${SERVICE:-}" "${PIT_SERVICE:-}" "Enter service name for the database or PDB: ")"
REMOTEOWNER="$(pit_require_value "${REMOTEOWNER:-}" "${PIT_CLIENT:-}" "Enter database user that is accessible by the APEX workspace: ")"
REMOTEPWD="$(pit_require_value "${REMOTEPWD:-}" "${PIT_CLIENT_PW:-}" "Enter password for ${REMOTEOWNER}: " true)"
APPWS="$(pit_require_value "${APPWS:-}" "${PIT_APEX_WORKSPACE:-}" "Enter APEX workspace where this application should be installed: ")"
APPID="$(pit_require_value "${APPID:-}" "${PIT_APEX_APP_ID:-}" "Enter application id for the PIT application: ")"
LOG_FILE="$(pit_log_path "Install_PIT_apex_${REMOTEOWNER}.log")"

pit_prepare_log "${LOG_FILE}"
pit_run_sqlplus "${OWNER}" "${OWNERPWD}" "${SERVICE}" "./install_scripts/grant_apex_access.sql" "${LOG_FILE}" "${OWNER}" "${REMOTEOWNER}"
pit_run_sqlplus "${REMOTEOWNER}" "${REMOTEPWD}" "${SERVICE}" "./install_scripts/install_apex.sql" "${LOG_FILE}" "${OWNER}" "${REMOTEOWNER}" "${APPWS}" "${APPID}"
