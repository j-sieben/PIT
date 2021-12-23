#!/bin/bash

echo -n "Enter owner schema for PIT [ENTER] "
read OWNER
echo ${OWNER}

echo -n "Enter password for ${OWNER} [ENTER] "
read CLIENTPWD

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE
echo ${SERVICE}

echo -n "Enter client schema name [ENTER] "
read REMOTEOWNER
echo ${REMOTEOWNER}

echo -n "Enter password for ${REMOTEOWNER} [ENTER] "
read REMOTEPWD

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

echo @install_scripts/grant_client_access.sql ${USER} | sqlplus ${OWNER}/${CLIENTPWD}@${SERVICE}

echo @install_scripts/create_client_synonyms.sql | sqlplus ${REMOTEOWNER}/${REMOTEPWD}@${SERVICE}

pause
EOF

