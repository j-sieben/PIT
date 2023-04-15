#!/bin/bash
echo -n "Enter owner schema for PIT [ENTER] "
read OWNER
echo ${OWNER}

echo -n "Enter password for ${OWNER} [ENTER] "
read PWD

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE
echo ${SERVICE}

echo -n "Enter default language for messages (GERMAN or AMERICAN) [ENTER] "
read DEFAULT_LANGUAGE
echo ${DEFAULT_LANGUAGE}

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

sqlplus ${OWNER}/"${PWD}"@${SERVICE} @./install_scripts/install ${DEFAULT_LANGUAGE}