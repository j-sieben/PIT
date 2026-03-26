# Umbauplan: Konsistente Library-Installer

## Ziel

Die Installer in Repositories wie `PIT`, `FSM` und `UTL_TEXT` sollen künftig:

- interaktiv weiter nutzbar bleiben
- nicht-interaktiv aus Ansible/CI aufrufbar sein
- konsistente Kommandos, Exit-Codes und Fehlerbehandlung besitzen
- Owner-Installation und Client-Installation sauber trennen
- pro Aktion nachvollziehbare Logs erzeugen

## Zielbild

Jede Library stellt einen stabilen Shell-Entrypoint bereit, z. B.:

- `pit.sh`
- `fsm.sh`
- `utl_text.sh`

Dieser Entrypoint unterstützt ein konsistentes Kommandomodell:

- `install`
- `install-client`
- optional `install-apex`
- optional `uninstall`
- optional `uninstall-client`
- `help`

Die Kommandos sollen sowohl interaktiv als auch nicht-interaktiv funktionieren.

## Eingabemodell

### Priorität der Eingaben

Alle Skripte sollen Eingaben in dieser Reihenfolge auflösen:

1. CLI-Optionen
2. Environment-Variablen
3. interaktive Eingabe per `read` / `read -s`

### Nicht-geheime Werte

Nicht-geheime Werte dürfen per CLI übergeben werden, z. B.:

- `--service`
- `--client`
- `--default-language`

### Geheime Werte

Passwörter sollen nicht über CLI-Argumente übergeben werden, sondern:

- über Environment-Variablen
- oder interaktiv per `read -s`

## Empfohlene Environment-Variablen

### PIT

- `PIT_OWNER`
- `PIT_OWNER_PW`
- `PIT_CLIENT`
- `PIT_CLIENT_PW`
- `PIT_SERVICE`
- `PIT_DEFAULT_LANGUAGE`

### FSM

- `FSM_OWNER`
- `FSM_OWNER_PW`
- `FSM_CLIENT`
- `FSM_CLIENT_PW`
- `FSM_SERVICE`

### UTL_TEXT

- `UTL_TEXT_OWNER`
- `UTL_TEXT_OWNER_PW`
- `UTL_TEXT_CLIENT`
- `UTL_TEXT_CLIENT_PW`
- `UTL_TEXT_SERVICE`

## Arbeitspakete

### 1. Dispatcher standardisieren

Für jede Library einen zentralen Entrypoint pflegen, z. B. `pit.sh`.

Aufgaben:

- Kommandos validieren
- CLI-Optionen parsen
- normalisierte Variablen aufbereiten
- interne Implementierungsskripte aufrufen

Wichtig:

- keine fachliche Installationslogik im Dispatcher
- nur Routing und Input-Normalisierung

### 2. Interne Installskripte nicht-interaktiv-fähig machen

Vorhandene Skripte wie `install.sh`, `install_client.sh` umbauen.

Ziel:

- Werte aus CLI / Env übernehmen
- nur fehlende Werte interaktiv erfragen

Muster:

```bash
OWNER="${OWNER:-${PIT_OWNER:-}}"
if [ -z "${OWNER}" ]; then
  read -r -p "Enter owner schema: " OWNER
fi
```

Für Passwörter:

```bash
OWNER_PW="${OWNER_PW:-${PIT_OWNER_PW:-}}"
if [ -z "${OWNER_PW}" ]; then
  read -r -s -p "Enter password for ${OWNER}: " OWNER_PW
  echo
fi
```

### 3. SQL*Plus-Aufrufe robust machen

Alle SQL*Plus-Aufrufe müssen bei Fehlern den Prozess fehlschlagen lassen.

Shell-Standard:

```bash
set -euo pipefail
```

SQL*Plus-Standard:

```bash
sqlplus -s /nolog <<SQL
whenever oserror exit failure rollback
whenever sqlerror exit failure rollback
connect ...
@script.sql
exit
SQL
```

Wichtig:

- kein `exit 0`, wenn dadurch Fehler maskiert werden
- keine stillen Folgeaufrufe nach SQL-Fehlern

### 4. Logging vereinheitlichen

Jede Aktion soll ein eigenes Log erzeugen, z. B.:

- `Install_PIT.log`
- `Install_PIT_client_<client>.log`
- `Install_FSM.log`
- `Install_UTL_TEXT.log`

Ziele:

- Log pro Aktion
- konsistente Benennung
- einfache Fehlersuche

Optional:

- Logpfad über Variable konfigurierbar machen

### 5. Owner- und Client-Installation trennen

Jede Library soll mindestens zwei fachlich getrennte Pfade haben:

- `install`
  - installiert die Library im Owner-Schema
- `install-client`
  - vergibt Grants und registriert Synonyme für genau ein Client-Schema

Wichtig:

- keine Schleife über mehrere Clients innerhalb der Library
- Mehrfachausführung übernimmt später der Orchestrator oder Ansible

### 6. Idempotenz bewerten und absichern

Für `install-client` prüfen und absichern:

- wiederholte Aufrufe sind tolerierbar
- bestehende Synonyme werden ersetzt oder vorher entfernt
- Grants verursachen bei Wiederholung keinen harten Fehler

Für `install` bewerten:

- ist Wiederholung erlaubt?
- falls nein: klar dokumentieren
- optional `reinstall` oder `uninstall && install` ergänzen

### 7. Hilfe / Usage verbessern

Die `help`-Ausgabe jedes Entrypoints soll enthalten:

- verfügbare Kommandos
- unterstützte CLI-Optionen
- relevante Environment-Variablen
- Verhalten im interaktiven Fallback

### 8. README dokumentieren

Für jede Library Nutzungsbeispiele ergänzen.

Interaktiv:

```bash
./pit.sh install
./pit.sh install-client
```

Nicht-interaktiv:

```bash
PIT_OWNER=... \
PIT_OWNER_PW=... \
PIT_SERVICE=... \
PIT_CLIENT=... \
PIT_CLIENT_PW=... \
./pit.sh install-client
```

### 9. Orchestrator-Repositories vereinfachen

Nach dem Umbau der Basis-Repositories kann ein Orchestrator wie `b3m_utils` vereinfacht werden.

Ziel:

- keine direkte SQL-Detailorchestrierung im `b3m_utils/install.sh`
- stattdessen Aufrufe wie:
  - `pit.sh install`
  - `pit.sh install-client`
  - `utl_text.sh install`
  - `utl_text.sh install-client`
  - `fsm.sh install`
  - `fsm.sh install-client`

### 10. Vorbereitung für Ansible

Die neuen Library-Skripte sollen so gestaltet sein, dass Ansible:

- Passwörter über Environment übergeben kann
- nicht interaktiv aufrufen kann
- RC ungleich 0 als echten Fehler bekommt
- Logs pro Schritt auswerten kann

## Akzeptanzkriterien

Der Umbau gilt als abgeschlossen, wenn:

- dieselbe Library interaktiv und nicht-interaktiv installierbar ist
- SQL-Fehler zuverlässig zu einem Shell-Fehler führen
- `install` und `install-client` klar getrennt sind
- keine Passwörter per CLI-Argument übergeben werden müssen
- Logs pro Aktion vorhanden sind
- wiederholte `install-client`-Aufrufe stabil funktionieren
- die CLI-Dokumentation vollständig ist

## Empfohlene Reihenfolge

1. CLI-Vertrag definieren
2. Dispatcher pro Library standardisieren
3. interne Skripte auf CLI/Env/Read-Fallback umbauen
4. Fehlerbehandlung in SQL*Plus und Shell härten
5. Logging vereinheitlichen
6. `install-client`-Idempotenz absichern
7. README und Help ergänzen
8. erst danach Orchestrator-Repositories wie `b3m_utils` anpassen
