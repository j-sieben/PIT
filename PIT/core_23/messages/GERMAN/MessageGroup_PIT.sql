begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => q'^Core PIT messages and translatable items^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_DATATYPE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# ist nicht vom Datentyp #2#.^',
    p_pms_description => q'^Es wurde erfolglos versucht, einen Wert in den angegebenen Datentyp zu konvertieren. Prüfen Sie den Wert.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Eine Anweisung soll Zeilen liefern, tut es aber nicht.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERTION_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Assertion schlug fehl.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_IS_NOT_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^"#1#" wurde erwartet, war jedoch NULL.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ein Nullwert wurde erwartet, geliefert wurde jedoch [#1#]^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_NOT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Eine Anweisung soll keine Zeilen liefern, tut es aber dennoch.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_TRUE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ein gleicher Wert wurde erwartet, war es aber nicht.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CHANGED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Kontext auf #1# gesetzt.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CREATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Kontext #1# erzeugt und zur Liste der Kontexte hinzugefügt.^',
    p_pms_description => q'^Ein Kontext sammelt Logeinstellungen unter einem Namen.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler bei der Initialisierung eines neuen Kontextes.^',
    p_pms_description => q'^Ein Kontext kann im Regelfall dann nicht initialisiert werden, wenn ungültige Einstellungen für die einzelnen Parameter übergeben wurden.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_DEFAULT_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Default-Kontext konnte nicht erzeugt werden.^',
    p_pms_description => q'^Der Default-Kontext wird durch Initialisierungsparameter erzeugt. Stellen Sie sicher, dass dort keine ungültigen Angaben enthalten sind.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_INVALID_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Kontext #1# existiert nicht. Bitte geben Sie den namen eines Kontextes an, der durch Package #2# verwaltet wird.^',
    p_pms_description => q'^Erzeugen Sie einen Kontext über UTL_CONTEXT.CREATE_CONTEXT, bevor Sie ihn verwenden^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Versuch, den nicht vorhandenen Kontext #1# zu laden.^',
    p_pms_description => q'^Erzeugen Sie einen Kontext über PIT_ADMIN.CREATE_NAMED_CONTEXT, bevor Sie ihn verwenden^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_NO_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Name des Kontextes darf nicht fehlen. Bitte geben Sie einen gültigen Kontextnamen an.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_IMPOSSIBLE_CONVERSION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ungültige Konvertierung von Elementwert "#1#" und Formatmaske "#2#2" zum Typ #3#.^',
    p_pms_description => q'^Bei der automatisierten Ermittlung eines Datums- oder Zahlenwertes konnte der Elementwert nicht korrekt konvertiert werden.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_LONG_OP_WO_TRACE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Verwendung von PIT.LONG_OP setzt einen vorherigen Aufruf von PIT.ENTER/LEAVE voraus.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Während einer Mengenverarbeitung trat mindestens ein Fehler auf.^',
    p_pms_description => q'^Wenn PIT im collect-modus ist, wird dieser Fehler geworfen, wenn der schwerwiegenste Fehler den Schweregrad ERROR hatte.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_FATAL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Während einer Mengenverarbeitung trat mindestens ein fataler Fehler auf.^',
    p_pms_description => q'^Wenn PIT im collect-modus ist, wird dieser Fehler geworfen, wenn der schwerwiegenste Fehler den Schweregrad FATAL hatte.^',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Rufe auf: #1#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion aufgerufen wird.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER_W_PARAM',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Rufe auf: #1#, Parameter: #2#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion aufgerufen wird.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_LEAVE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Verlasse: #1#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion verlassen wird.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CONTEXT_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Kontext #1# existiert nicht. Bitte legen Sie diesen vorab an.^',
    p_pms_description => q'^Ein Toggle muss einen existierenden Kontext referenzieren, da ansonsten die Ausgabe nicht funktioniert.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_DUPLICATE_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Nachricht "#1#", die Sie einfügen möchten, existiert bereits.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Log-Nachricht "#1#" konnte nicht erzeugt werden.^',
    p_pms_description => q'^Keine weiteren Angaben^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler beim Löschen des Nachrichten-Stacks.^',
    p_pms_description => q'^Keine weiteren Angaben^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MODULE_INIT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" konnte aufgrund eines Fehlers nicht installiert werden: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler beim Lesen der Liste der Module.^',
    p_pms_description => q'^Die Liste der Module umfasst alle installierten, initialisierten oder aktiven Ausgabemodule. Diese Liste war hier leer.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INITIALIZED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Initialisierung beendet am #1#. Geladene Module: [#2#]^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_INSTANTIATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" wurde erfolgreich instantiiert.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_LIST_LOADED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Modulliste wurde erfolgreich geladen.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Zumindest ein Ausgabemodul muss angegeben werden.^',
    p_pms_description => q'^Wenn im aktuellen Kontext kein Ausgabemodul definiert wurde, das initialisierbar ist, kann PIT keine Meldungen ausgeben. Stellen Sie sicher, dass mindestens ein Modul erreichbar ist.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_TERMINATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" wurde wegen eines Fehlers terminiert.^',
    p_pms_description => q'^Wenn während der Initialisierung eines Modules ein Fehler auftritt, wird das Modul deaktiviert. Andere Module arbeiten normal weiter.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" wurde angefordert, ist aber nicht verfügbar.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MSG_NOT_EXISTING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Nachricht #1# existiert nicht. Verwenden Sie das Package MSG, um dieses Problem zu umgehen.^',
    p_pms_description => q'^Eine Meldung muss durch die Prozedur PIT_ADMIN.MERGE_MESSAGE angelegt werden. Anschließend muss die Methode PIT_ADMIN.CREATE_MESSAGE_PACKAGE aufgerufen werden, um das Package MSG zu aktualisieren.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_NAME_TOO_LONG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Bezeichner überschreitet die Maximallänge von #1# Zeichen.^',
    p_pms_description => q'^Für einen Bezeichner ist eine Maximallänge vorgegeben. Diese Länge wird aktuell überschritten.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_NO_CONTEXT_SETTINGS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Es konnten keine Einstellungen für das Logging gefunden werden.^',
    p_pms_description => q'^Es wurde versucht, Werte für das Logging aus dem gloablen Kontext zu lesen. Das misslang aber. Prüfen Sie, ob PIT korrekt initialisiert ist.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Das Element #LABEL# ist ein Pflichtelement.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# soll in (#2#) enthalten sein, war aber #3#.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PASS_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMG_ERROR_MARKER_INVALID',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Länge von Präfix und Postfix darf zusammen nicht mehr als 12 Zeichen betragen und mindestens Präfix oder Postfix muss definiert werden.^',
    p_pms_description => q'^Das Präfix und/oder das Postfix für Fehlernamen müssen unter einer maximalen Länge bleiben, um Probleme bei mit der Namenskonvention auszuweichen.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMG_ERROR_MARKER_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Weder Präfix noch Postfix für Fehlermeldungen wurden angegeben.^',
    p_pms_description => q'^Eine Meldungsgruppe benötigt eine Kennzeichnung für Fehler. Diese werden aus dem Default genommen, dürfen aber nicht NULL sein. Mindestens ein Wert muss belegt sein.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMS_PREDEFINED_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Fehlernummer #1# ist ein vordefinierter Oracle-Fehler namens #2# in #3#.#4#. Bitte überschreiben Sie keine von Oracle vordefinierten Fehler.^',
    p_pms_description => q'^Durch das Überschreiben eines vordefinierten Fehlers wird dieser unter seinem Namen nicht mehr gefangen.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMS_TOO_LONG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Nachricht "#1#" darf nicht länger als #2# Zeichen sein, hat aber die Länge #3#.^',
    p_pms_description => q'^Die Längenbeschränkung gilt wegen der hinzuzurechnenden Länge der Exception Pre- und Postfixes.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Liste der Module erfolgreich gelesen.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der benannte Kontext #1# existiert nicht.^',
    p_pms_description => q'^Ein Kontext soll vervwendet werden, der nicht existiert. Verwenden Sie PIT_ADMIN.CREATE_NAMED_CONTEXT, um einen Kontext zu erstellen^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_SQL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ein SQL-Fehler ist aufgetreten: #SQLERRM#^',
    p_pms_description => q'^Allgemeine Fehlermeldung. Nähere Informationen siehe im Meldungsparameter.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INVALID_SQL_NAME',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ungültiger SQL-Name. #1#. Bitte geben Sie einen Namen an, der den Oracle-Namenskonventionen entspricht^',
    p_pms_description => q'^Da einige Bezeichner auch als Oracle-Namen verwendet werden (zum Beispiel als Konstanten), müssen sie den Oracle-Namenskonventionen entsprechen.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_TWEET',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Tweet => #1#^',
    p_pms_description => q'^Generissche Ausgabe für einen Tweet^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  commit;
  pit_admin.create_message_package;
end;
/