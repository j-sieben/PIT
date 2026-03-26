#!/bin/bash

set -euo pipefail

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIT_DIR="$(cd "${COMMON_DIR}/.." && pwd)"

pit_init() {
  export NLS_LANG="${NLS_LANG:-GERMAN_GERMANY.AL32UTF8}"
  export PIT_LOG_DIR="${PIT_LOG_DIR:-${PIT_DIR}/logs}"
  mkdir -p "${PIT_LOG_DIR}"
}

pit_resolve_value() {
  local current_value="$1"
  local env_value="$2"

  if [ -n "${current_value}" ]; then
    printf '%s' "${current_value}"
    return
  fi

  printf '%s' "${env_value}"
}

pit_prompt_value() {
  local prompt="$1"
  local secret="${2:-false}"
  local value=""

  if [ "${secret}" = "true" ]; then
    read -r -s -p "${prompt}" value
    echo
  else
    read -r -p "${prompt}" value
  fi

  printf '%s' "${value}"
}

pit_require_value() {
  local current_value="$1"
  local env_value="$2"
  local prompt="$3"
  local secret="${4:-false}"
  local value

  value="$(pit_resolve_value "${current_value}" "${env_value}")"
  if [ -z "${value}" ]; then
    value="$(pit_prompt_value "${prompt}" "${secret}")"
  fi

  printf '%s' "${value}"
}

pit_log_path() {
  local file_name="$1"
  printf '%s/%s' "${PIT_LOG_DIR}" "${file_name}"
}

pit_prepare_log() {
  local log_file="$1"
  : > "${log_file}"
}

pit_run_sqlplus() {
  local connect_user="$1"
  local connect_password="$2"
  local service="$3"
  local script_path="$4"
  local log_file="$5"
  shift 5

  (
    cd "${PIT_DIR}"
    sqlplus -s -L /nolog <<EOF
whenever oserror exit failure rollback
whenever sqlerror exit failure rollback
connect ${connect_user}/"${connect_password}"@${service}
@${script_path} $*
exit
EOF
  ) | tee -a "${log_file}"
}
