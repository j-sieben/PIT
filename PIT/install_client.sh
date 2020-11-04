#!/bin/bash
echo -n "Enter Connect-String for DBA account [ENTER] "
read SYSPWD
echo ${SYSPWD}

echo -n "Enter owner schema for PIT [ENTER] "
read OWNER
echo ${OWNER}

echo -n "Enter user schema for PIT [ENTER] "
read USER
echo ${USER}

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG
sqlplus /nolog<<EOF
connect ${SYSPWD}
@pit_install_client.sql ${OWNER} ${USER}
pause
EOF

