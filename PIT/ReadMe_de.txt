Die Batch-Dateien bzw. Shell-Skripte installieren PIT in drei unterschiedlichen Ausprägungen:

1. INSTALL.BAT/SH: Core-Funktionalität.
   Diese muss als erstes installiert werden. Empfohlen wird, einen dedizierten Benutzer hierfür 
   zu verwenden, z.B. UTILS, und an die Schemata, die PIT anschließend nutzen möchten, einen
   Zugriff über einen Client zu gewähren.
   Alternativ kann aber auch auf diesen Client verzichtet werden, falls nur ein Schema mit PIT
   ausgestattet werden soll. In diesem Fall ist PIT nach der Installation einsatzbereit,
   besitzt aber keine administrative Oberfläche. Dies ist z.B. für Test- oder Produktionsumgebungen 
   ausreichend.

2. INSTALL_CLIENT.BAT/SH: Client-Zugriff
   Dieses Skript richtet den Zugriff auf eine PIT-Installation in einem anderen Schema ein.
   Es werden alle erforderlichen Rechte erteilt und entsprechende Synonyme im Client-Schema erstellt.
   Dieses Skript umfasst keine administrative Oberfläche. Wird PIT in einem mehrschichtigen
   Schemakonzept eingesetzt, ist die Installation eines Clients für alle Schemata außer dem
   APEX-Schema ausreichend. Nur im APEX-Schema sollte die Administrationsanwendung installiert werden.
   
3. INSTALL_APEX.BAT/SH: Administrationsanwendung
   Dieses Skript richtet die Administrationsoberfläche für PIT ein. Die Installation
   umfasst die Einrichtung aller erforderlichen Rechte und die Erstellung lokaler Synonyme. 
   Daher ist es nicht erforderlich, vorab Clientberechtigungen für das APEX-Schema einzurichten.
   Die Administrationsanwendung setzt zwei weitere Tools voraus:
   - UTL_TEXT: Dieses Tool stellt Textfunktionen zur Verfügung, z.B. einen Code-Generator
   - UTL_APEX: Dieses Tool stellt APEX-bezogene Funktionen zur Verfügung
   Diese Tools müssen vorab installiert werden, bevor die Installation der Administrationsanwendung
   erfolgreich ausgeführt werden kann.
   
Alle Skripte erfragen interaktiv die erforderlichen Parameter. Folgen Sie den Anweisungen der Skripte.

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