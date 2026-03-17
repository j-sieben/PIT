#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo -n "Enter owner schema for PIT [ENTER] "
read OWNER
echo ${OWNER}

echo -n "Enter password for ${OWNER} [ENTER] "
read -s OWNERPWD
echo

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE

echo -n "Enter client schema name [ENTER] "
read REMOTEOWNER
echo ${REMOTEOWNER}

echo -n "Enter password for ${REMOTEOWNER} [ENTER] "
read -s REMOTEPWD
echo

echo -n "Enter module name to revoke [ENTER] "
read MODULE
echo ${MODULE}

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

cd "${PIT_DIR}" || exit 1

sqlplus -L /nolog <<EOF
connect ${OWNER}/"${OWNERPWD}"@${SERVICE}
@./install_scripts/revoke_module_client.sql ${OWNER} ${REMOTEOWNER} ${MODULE}
EOF

sqlplus -L /nolog <<EOF
connect ${REMOTEOWNER}/"${REMOTEPWD}"@${SERVICE}
@./install_scripts/unregister_module_client.sql ${OWNER} ${REMOTEOWNER} ${MODULE}
EOF
