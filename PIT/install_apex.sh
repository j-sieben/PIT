#!/bin/bash
echo -n "Enter Connect-String without 'as sysdba' for SYS account [ENTER] "
read SYSPWD
echo ${SYSPWD}

echo -n "Enter owner schema for PIT [ENTER] "
read OWNER
echo ${OWNER}

echo -n "Enter default language for the APEX application [ENTER] "
read DEFLANG
echo ${USER}

echo -n "Enter APEX workspace name [ENTER] "
read WORKSPACE
echo ${OWNER}

echo -n "Enter APEX workspace schema [ENTER] "
read APPUSER
echo ${OWNER}

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG
sqlplus /nolog<<EOF
connect ${SYSPWD} as sysdba 
@pit_install_client.sql ${OWNER} ${APPUSER} ${DEFLANG} ${APPUSER}
pause
EOF

