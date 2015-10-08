#!/bin/bash
echo -n "Geben Sie den Connect-String ohne 'as sysdba' fuer SYS ein [ENTER] "
read SYSPWD
echo ${SYSPWD}
NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG
sqlplus /nolog<<EOF
connect ${SYSPWD} as sysdba 
@pit_install doag doag
pause
EOF

