#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo -n "Enter owner schema for PIT [ENTER] "
read OWNER

echo -n "Enter password for ${OWNER} [ENTER] "
read -s OWNERPWD
echo

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE

echo -n "Enter default language for messages (GERMAN or AMERICAN) [ENTER] "
read DEFAULT_LANGUAGE

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

cd "${PIT_DIR}" || exit 1

sqlplus -L /nolog <<EOF
connect ${OWNER}/"${OWNERPWD}"@${SERVICE}
@./install_scripts/install.sql ${DEFAULT_LANGUAGE}
EOF
