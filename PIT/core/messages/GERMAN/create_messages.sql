begin

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_EXISTS',
    p_pms_text => q'^Eine Anweisung soll Zeilen liefern, tut es aber nicht.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERTION_FAILED',
    p_pms_text => q'^Assertion schlug fehl.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NULL',
    p_pms_text => q'^Ein Nullwert wurde erwartet, geliefert wurde jedoch [#1#]^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NOT_NULL',
    p_pms_text => q'^"#1#" wurde erwartet, war jedoch NULL.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_NOT_EXISTS',
    p_pms_text => q'^Eine Anweisung soll keine Zeilen liefern, tut es aber dennoch.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_TRUE',
    p_pms_text => q'^Ein gleicher Wert wurde erwartet, war es aber nicht.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER',
    p_pms_text => q'^Rufe auf: #1#^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER_W_PARAM',
    p_pms_text => q'^Rufe auf: #1#, Parameter: #2#^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_LEAVE',
    p_pms_text => q'^Verlasse: #1#^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CHANGED',
    p_pms_text => q'^Kontext auf #1# gesetzt.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATED',
    p_pms_text => q'^Kontext #1# erzeugt und zur Liste der Kontexte hinzugefügt.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATION_ERROR',
    p_pms_text => q'^Fehler bei der Initialisierung eines neuen Kontextes.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_MISSING',
    p_pms_text => q'^Versuch, den nicht vorhandenen Kontext #1# zu laden.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_INVALID_CONTEXT',
    p_pms_text => q'^Der Kontext #1# existiert nicht. Bitte geben Sie den namen eines Kontextes an, der durch Package #2# verwaltet wird.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'CTX_NO_CONTEXT',
    p_pms_text => q'^Der Name des Kontextes darf nicht fehlen. Bitte geben Sie einen gültigen Kontextnamen an.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_DEFAULT_CREATION_ERROR',
    p_pms_text => q'^Der Default-Kontext konnte nicht erzeugt werden.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_DUPLICATE_MESSAGE',
    p_pms_text => q'^Die Nachricht "#1#", die Sie einfügen möchten, existiert bereits.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_INITIALIZED',
    p_pms_text => q'^Initialisierung beendet am #1#. Geladene Module: [#2#]^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_pms_text => q'^Log-Nachricht "#1#" konnte nicht erzeugt werden.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_pms_text => q'^Fehler beim Löschen des Nachrichten-Stacks.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MODULE_INIT',
    p_pms_text => q'^Modul "#1#" konnte aufgrund eines Fehlers nicht installiert werden: #2#^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_INSTANTIATED',
    p_pms_text => q'^Modul "#1#" wurde erfolgreich instantiiert.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 50,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_LIST_LOADED',
    p_pms_text => q'^Die Modulliste wurde erfolgreich geladen.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_UNAVAILABLE',
    p_pms_text => q'^Modul "#1#" wurde angefordert, ist aber nicht verfügbar.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_TERMINATED',
    p_pms_text => q'^Modul "#1#" wurde wegen eines Fehlers terminiert.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_pms_text => q'^Diese Änderung ist nur im ADMIN-Modus möglich.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_IS_NULL',
    p_pms_text => q'^Der angeforderte Parameter "#1#" existiert nicht.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_EXTENDABLE',
    p_pms_text => q'^Die Erweiterung dieser Parametergruppe ist nicht erlaubt.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_FOUND',
    p_pms_text => q'^Der Parameter #1# existiert nicht.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_MODIFIABLE',
    p_pms_text => q'^Die Änderung des Parameters #1# ist nicht erlaubt.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_PASS_MESSAGE',
    p_pms_text => q'^#SQLERRM#^',
    p_pms_pse_id => 70,
    p_pms_pml_name => '&DEFAULT_LANGUAGE.',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_READ_MODULE_LIST',
    p_pms_text => q'^Liste der Module erfolgreich gelesen.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_pms_text => q'^Fehler beim Lesen der Liste der Module.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SQL_ERROR',
    p_pms_text => q'^Ein SQL-Fehler ist aufgetreten: #1#^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_pms_text => q'^Der benannte Kontext #1# existiert nicht.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_pms_text => q'^Parameter #1# soll in (#2#) enthalten sein, war aber #3#.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_PARAM_MISSING',
    p_pms_text => q'^Zumindest ein Ausgabemodul muss angegeben werden.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MSG_NOT_EXISTING',
    p_pms_text => q'^Nachricht #1# existiert nicht. Verwenden Sie das Package MSG, um dieses Problem zu umgehen.^',
    p_pms_pml_name => 'GERMAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  commit;
end;
/