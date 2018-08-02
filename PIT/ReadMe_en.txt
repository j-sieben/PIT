Script PIT_INSTALL will install the PL/SQL-Instrumentation Toolkit.

Please make sure that these points are covered before installation:

- Set environment variable NLS_LANG to AMERICAN_AMERICA.AL32UTF8 in order not to miss any unicode letters:

set nls_lang=AMERICAN_AMERICA.AL32UTF8

- connect to a database via sqlplus as SYS

sqlplus / as sysdba

- run pit_install.sql and pass the user where pit should go as parameter 1
- Provide an Oracle language name to define the default language of PIT
@pit_install.sql DOAG AMERICAN

- If you plan to use output module PIT_FILE make sure that you have created a 
  directory named PIT_FILE_DIR that points to a path the database has access to:

create or replace directory PIT_FILE_DIR as 'C:\tmp\trace';


Linux remarks:
set ORACLE_SID, PATH and ORACLE_HOME:

for information, see /etc/oratab.

ORACLE_HOME=<Info from Oratab-File>
PATH=$ORACLE_HOME/bin:$PATH
ORACLE_SID=<Info from Oratab-File>
export ORACLE_HOME
export PATH
export ORACLE_SID

Should install.sh don’t run:
chmod +x ./install.sh