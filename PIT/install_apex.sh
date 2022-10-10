#!/bin/bash

echo -n "Enter owner schema for PIT [ENTER] "
read OWNER
echo ${OWNER}

echo -n "Enter password for ${OWNER} [ENTER] "
read -s CLIENTPWD

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE
echo ${SERVICE}

echo -n "Enter database user that is accessible by the APEX workspace [ENTER] "
read REMOTEOWNER
echo ${REMOTEOWNER}

echo -n "Enter password for ${REMOTEOWNER} [ENTER] "
read -s REMOTEPWD

echo -n "Enter APEX workspace where this application should be installed at [ENTER] "
read APPWS
echo ${APPWS}

echo -n "Enter application alias for the PIT application [ENTER] "
read APPALIAS
echo ${APPALIAS}

echo -n "Enter application id for the PIT application [ENTER] "
read APPID
echo ${APPID}

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

sqlplus ${OWNER}/${CLIENTPWD}@${SERVICE} @./install_scripts/grant_apex_access.sql ${OWNER} ${REMOTEOWNER}

sqlplus ${REMOTEOWNER}/${REMOTEPWD}@${SERVICE} @./install_scripts/install_apex.sql ${OWNER} ${REMOTEOWNER} ${APPWD} ${APPALIAS} ${APPID}
