Das Skript PIT_INSTALL installiert das PL/SQL-Instrumentation Toolkit.

Beachten Sie bitte folgendes vor der Installation:

- Setzen Sie die Umgebungsvariable NLS_LANG auf den Wert GERMAN_GERMANY.AL32UTF8, 
  um keine Umlaute zu verlieren:

set nls_lang=GERMAN_GERMANY.AL32UTF8

- Melden Sie sich anschließend an sqlplus als SYS an

sqlplus / as sysdba

- Fuehren Sie das Skript pit_install.sql aus, uebergeben Sie den Schemanamen, 
  in dem das Package installiert werden soll, als Parameter

@pit_install.sql DOAG DOAG

- Vor der Verwendung des Ausgabemoduls PIT_FILE muss ein Directory
  mit dem Namen PIT_FILE_DIR angelegt werden und auf einen Pfad zeigen,
  den die Datenbank beschreiben kann:

create or replace directory PIT_FILE_DIR as 'C:\tmp\trace';


Anmerkungen für Linux:
ORACLE_SID, PATH und ORACLE_HOME auf Unix setzen:

Infos hierzu immer in /etc/oratab.

ORACLE_HOME=<Info aus Oratab-File>
PATH=$ORACLE_HOME/bin:$PATH
ORACLE_SID=<Info aus Oratab-File>
export ORACLE_HOME
export PATH
export ORACLE_SID

Und natürlich nie vergessen, falls install.sh nicht ausführbar sein sollte:
chmod +x ./install.sh