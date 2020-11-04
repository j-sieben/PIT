#!/bin/bash
echo -n "Enter Connect-String for DBA account [ENTER] "
read SYSPWD
echo ${SYSPWD}

echo -n "Enter APEX workspace schema [ENTER] "
read APPUSER
echo ${APPUSER}

echo -n "Enter APEX workspace name [ENTER] "
read APPWS
echo ${APPWS}

echo -n "Enter application alias for PIT application [ENTER] "
read APPALIAS
echo ${APPALIAS}

echo -n "Enter application idfor the APEX application [ENTER] "
read APPID
echo ${APPID}

echo -n "Enter default language [ENTER] "
read DEFLANG
echo ${DEFLANG}

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG
sqlplus /nolog<<EOF
connect ${SYSPWD}a 
@pit_install_apex.sql ${APPUSER} ${APPWD} ${APPALIAS} ${APPID} ${DEFLANG}
pause
EOF

