Der zentrale Einstieg in die Installation und Deinstallation erfolgt über `pit.sh` bzw. `pit.bat`.
Diese Skripte rufen die eigentlichen Installations- und Deinstallationsskripte mit einem
eindeutigen Kommando auf.

Verfügbare Kommandos sind:

- install: Installation der PIT-Core-Funktionalität
- install-client: Einrichtung eines Client-Schemas
- install-apex: Installation der APEX-Administrationsanwendung
- install-module: Nachinstallation eines einzelnen Ausgabemoduls im PIT-Schema
- install-module-client: Freischaltung eines einzelnen Ausgabemoduls für ein Client-Schema
- uninstall: Deinstallation der PIT-Core-Funktionalität
- uninstall-client: Entfernen eines Client-Schemas
- uninstall-module: Deinstallation eines einzelnen Ausgabemoduls im PIT-Schema
- uninstall-module-client: Entfernen eines einzelnen Ausgabemoduls aus einem Client-Schema

Beispiele:

- ./pit.sh install
- ./pit.sh install-client
- ./pit.sh install-apex
- ./pit.sh install-module
- ./pit.sh install-module-client
- ./pit.sh uninstall
- pit.bat install

Die darunterliegenden Batch-Dateien bzw. Shell-Skripte liegen in `install_scripts/` und
unterstützen weiterhin die folgenden Installationsausprägungen:

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

4. INSTALL_MODULE.BAT/SH und INSTALL_MODULE_CLIENT.BAT/SH: Nachinstallation von Ausgabemodulen
   Diese Skripte ergänzen eine bestehende PIT-Installation um ein einzelnes Ausgabemodul.
   INSTALL_MODULE.BAT/SH installiert das Modul im PIT-Owner-Schema.
   INSTALL_MODULE_CLIENT.BAT/SH erteilt einem Client-Schema anschließend nur die für dieses
   Modul erforderlichen Rechte und legt die zugehörigen Synonyme an.
   Dieser Installationspfad ist dann sinnvoll, wenn ein Modul nicht bereits bei der initialen
   PIT-Installation eingerichtet wurde, sondern später separat ergänzt werden soll.
   
Alle Skripte erfragen interaktiv die erforderlichen Parameter. Folgen Sie den Anweisungen der Skripte.

- Vor der Verwendung des Ausgabemoduls PIT_FILE muss ein Directory
  mit dem Namen PIT_FILE_DIR angelegt werden und auf einen Pfad zeigen,
  den die Datenbank beschreiben kann:

create or replace directory PIT_FILE_DIR as 'C:\tmp\trace';

Vor der Installation kann definiert werden, auf welche Weise boolesche Werte in der Datenbank abgelegt werden.
In der Datei init/settings.sql können hierfür Umgebungsvariablen angelegt werden. Ab Version 23c wird diese
Festlegung durch den Datentyp BOOLEAN ersetzt. Bitte stellen Sie sicher, dass bei einer eventuellen Neukompilierung
der Initialisierungsparameter PLSQL_IMPLICIT_CONVERSION_BOOL auf TRUE gesetzt wurde, damit die Konvertierung dieser
Typen mittels TO_CHAR in PL/SQL gelingt.


Anmerkungen für Linux:
ORACLE_SID, PATH und ORACLE_HOME auf Unix setzen:

Infos hierzu immer in /etc/oratab.

ORACLE_HOME=<Info aus Oratab-File>
PATH=$ORACLE_HOME/bin:$PATH
ORACLE_SID=<Info aus Oratab-File>
export ORACLE_HOME
export PATH
export ORACLE_SID

Direkte Ausführung der spezialisierten Skripte ist weiterhin möglich, z.B.:

- ./install_scripts/install_client.sh
- ./install_scripts/install_module_client.sh

Und natürlich nie vergessen, falls ein Shell-Skript nicht ausführbar sein sollte:
chmod +x ./pit.sh
