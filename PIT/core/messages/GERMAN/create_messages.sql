begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => 'Core PIT messages'
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Eine Anweisung soll Zeilen liefern, tut es aber nicht.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERTION_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Assertion schlug fehl.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ein Nullwert wurde erwartet, geliefert wurde jedoch [#1#]^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NOT_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^"#1#" wurde erwartet, war jedoch NULL.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_NOT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Eine Anweisung soll keine Zeilen liefern, tut es aber dennoch.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_TRUE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ein gleicher Wert wurde erwartet, war es aber nicht.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Rufe auf: #1#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion aufgerufen wird.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER_W_PARAM',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Rufe auf: #1#, Parameter: #2#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion aufgerufen wird.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_LEAVE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Verlasse: #1#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion verlassen wird.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CHANGED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Kontext auf #1# gesetzt.^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Kontext #1# erzeugt und zur Liste der Kontexte hinzugefügt.^',
    p_pms_description => q'^Ein Kontext sammelt Logeinstellungen unter einem Namen.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler bei der Initialisierung eines neuen Kontextes.^',
    p_pms_description => q'^Ein Kontext kann im Regelfall dann nicht initialisiert werden, wenn ungültige Einstellungen für die einzelnen Parameter übergeben wurden.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Versuch, den nicht vorhandenen Kontext #1# zu laden.^',
    p_pms_description => q'^Erzeugen Sie einen Kontext über PIT_ADMIN.CREATE_NAMED_CONTEXT, bevor Sie ihn verwenden^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_INVALID_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Kontext #1# existiert nicht. Bitte geben Sie den namen eines Kontextes an, der durch Package #2# verwaltet wird.^',
    p_pms_description => q'^Erzeugen Sie einen Kontext über UTL_CONTEXT.CREATE_CONTEXT, bevor Sie ihn verwenden^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'CTX_NO_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Name des Kontextes darf nicht fehlen. Bitte geben Sie einen gültigen Kontextnamen an.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_DEFAULT_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Default-Kontext konnte nicht erzeugt werden.^',
    p_pms_description => q'^Der Default-Kontext wird durch Initialisierungsparameter erzeugt. Stellen Sie sicher, dass dort keine ungültigen Angaben enthalten sind.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_DUPLICATE_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Nachricht "#1#", die Sie einfügen möchten, existiert bereits.^',
    p_pms_description => q'^Offensichtlich^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_INITIALIZED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Initialisierung beendet am #1#. Geladene Module: [#2#]^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Log-Nachricht "#1#" konnte nicht erzeugt werden.^',
    p_pms_description => q'^Keine weiteren Angaben^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler beim Löschen des Nachrichten-Stacks.^',
    p_pms_description => q'^Keine weiteren Angaben^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MODULE_INIT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" konnte aufgrund eines Fehlers nicht installiert werden: #2#^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_INSTANTIATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" wurde erfolgreich instantiiert.^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 50,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_LIST_LOADED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Modulliste wurde erfolgreich geladen.^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" wurde angefordert, ist aber nicht verfügbar.^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_TERMINATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Modul "#1#" wurde wegen eines Fehlers terminiert.^',
    p_pms_description => q'^Wenn während der Initialisierung eines Modules ein Fehler auftritt, wird das Modul deaktiviert. Andere Module arbeiten normal weiter.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Diese Änderung ist nur im ADMIN-Modus möglich.^',
    p_pms_description => q'^Um Änderungen vorzunehmen, müssen Sie als Administrator angemeldet sein.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der angeforderte Parameter "#1#" existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_EXTENDABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Erweiterung dieser Parametergruppe ist nicht erlaubt.^',
    p_pms_description => q'^Parametergruppen können die Änderungen durch den Endanwender untersagen. Dies ist hier der Fall, die Parameter sind nicht änderbar.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_FOUND',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Parameter #1# existiert nicht.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_MODIFIABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Die Änderung des Parameters #1# ist nicht erlaubt.^',
    p_pms_description => q'^Ein Parameter kann, abweichend von den Einstellungen der Parametergruppe, als nicht änderbar festgelegt werden. Dies ist hier der Fall.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_PASS_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => '&DEFAULT_LANGUAGE.',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Liste der Module erfolgreich gelesen.^',
    p_pms_description => q'^^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Fehler beim Lesen der Liste der Module.^',
    p_pms_description => q'^Die Liste der Module umfasst alle installierten, initialisierten oder aktiven Ausgabemodule. Diese Liste war hier leer.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SQL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Ein SQL-Fehler ist aufgetreten: #SQLERRM#^',
    p_pms_description => q'^Allgemeine Fehlermeldung. Nähere Informationen siehe im Meldungsparameter.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der benannte Kontext #1# existiert nicht.^',
    p_pms_description => q'^Ein Kontext soll vervwendet werden, der nicht existiert. Verwenden Sie PIT_ADMIN.CREATE_NAMED_CONTEXT, um einen Kontext zu erstellen^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# soll in (#2#) enthalten sein, war aber #3#.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Zumindest ein Ausgabemodul muss angegeben werden.^',
    p_pms_description => q'^Wenn im aktuellen Kontext kein Ausgabemodul definiert wurde, das initialisierbar ist, kann PIT keine Meldungen ausgeben. Stellen Sie sicher, dass mindestens ein Modul erreichbar ist.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MSG_NOT_EXISTING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Nachricht #1# existiert nicht. Verwenden Sie das Package MSG, um dieses Problem zu umgehen.^',
    p_pms_description => q'^Eine Meldung muss durch die Prozedur PIT_ADMIN.MERGE_MESSAGE angelegt werden. Anschließend muss die Methode PIT_ADMIN.CREATE_MESSAGE_PACKAGE aufgerufen werden, um das Package MSG zu aktualisieren.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  commit;
end;
/