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

echo -n "Enter database user that is accessible by the APEX workspace [ENTER] "
read REMOTEOWNER
echo ${REMOTEOWNER}

echo -n "Enter password for ${REMOTEOWNER} [ENTER] "
read -s REMOTEPWD
echo

echo -n "Enter APEX workspace where this application should be installed at [ENTER] "
read APPWS
echo ${APPWS}

echo -n "Enter application id for the PIT application [ENTER] "
read APPID
echo ${APPID}

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

cd "${PIT_DIR}" || exit 1

sqlplus -L /nolog <<EOF
connect ${OWNER}/"${OWNERPWD}"@${SERVICE}
@./install_scripts/grant_apex_access.sql ${OWNER} ${REMOTEOWNER}
EOF

sqlplus -L /nolog <<EOF
connect ${REMOTEOWNER}/"${REMOTEPWD}"@${SERVICE}
@./install_scripts/install_apex.sql ${OWNER} ${REMOTEOWNER} ${APPWS} ${APPID}
EOF
