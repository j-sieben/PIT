begin

  pit_admin.merge_message(
    p_message_name => 'ASSERT_EXISTS',
    p_message_text => q'øA statement was expected to return rows, but did not.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERT_EXISTS',
    p_message_text => q'øEine Anweisung soll Zeilen liefern, tut es aber nicht.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'ASSERTION_FAILED',
    p_message_text => q'øAssertion failed.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERTION_FAILED',
    p_message_text => q'øAssertion schlug fehl.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'ASSERT_IS_NULL',
    p_message_text => q'øA value was expected to be null, but was [#1#].ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERT_IS_NULL',
    p_message_text => q'øEin Nullwert wurde erwartet, geliefert wurde jedoch [#1#]ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'ASSERT_IS_NOT_NULL',
    p_message_text => q'ø#1# was expected, but was null.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERT_IS_NOT_NULL',
    p_message_text => q'ø"#1#" wurde erwartet, war jedoch NULL.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'ASSERT_NOT_EXISTS',
    p_message_text => q'øA statement was expected to return no rows, but did.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERT_NOT_EXISTS',
    p_message_text => q'øEine Anweisung soll keine Zeilen liefern, tut es aber dennoch.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'ASSERT_TRUE',
    p_message_text => q'øA value was expected to be equal, but was not.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERT_TRUE',
    p_message_text => q'øEin gleicher Wert wurde erwartet, war es aber nicht.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_CODE_ENTER',
    p_message_text => q'øEntering: #1#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_CODE_ENTER',
    p_message_text => q'øRufe auf: #1#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_CODE_ENTER_W_PARAM',
    p_message_text => q'øEntering: #1#, Params: #2#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_CODE_ENTER_W_PARAM',
    p_message_text => q'øRufe auf: #1#, Parameter: #2#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_CODE_LEAVE',
    p_message_text => q'øLeaving: #1#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_CODE_LEAVE',
    p_message_text => q'øVerlasse: #1#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CTX_CHANGED',
    p_message_text => q'øContext set to ##1#.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CTX_CHANGED',
    p_message_text => q'øKontext auf #1# gesetzt.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CTX_CREATED',
    p_message_text => q'øContext ##1# created and added to the available contexts list.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CTX_CREATED',
    p_message_text => q'øKontext #1# erzeugt und zur Liste der Kontexte hinzugefügt.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CTX_CREATION_ERROR',
    p_message_text => q'øError initializing a new context.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CTX_CREATION_ERROR',
    p_message_text => q'øFehler bei der Initialisierung eines neuen Kontextes.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CTX_MISSING',
    p_message_text => q'øTried to call context ##1# but it is not existing.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CTX_MISSING',
    p_message_text => q'øVersuch, den nicht vorhandenen Kontext #1# zu laden.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CTX_INVALID_CONTEXT',
    p_message_text => q'øContext #1# does not exist. Please provide a valid context name that is controlled by #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'CTX_INVALID_CONTEXT',
    p_message_text => q'øDer Kontext #1# existiert nicht. Bitte geben Sie den namen eines Kontextes an, der durch Package #2# verwaltet wird.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CTX_NO_CONTEXT',
    p_message_text => q'øContext cannot be null. Please provide a valid context name.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'CTX_NO_CONTEXT',
    p_message_text => q'øDer Name des Kontextes darf nicht fehlen. Bitte geben Sie einen gültigen Kontextnamen an.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CTX_DEFAULT_CREATION_ERROR',
    p_message_text => q'øDefault Context could not be created.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'CTX_DEFAULT_CREATION_ERROR',
    p_message_text => q'øDer Default-Kontext konnte nicht erzeugt werden.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_DUPLICATE_MESSAGE',
    p_message_text => q'øThe message #1# you entered already exists.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_DUPLICATE_MESSAGE',
    p_message_text => q'øDie Nachricht "#1#", die Sie einfügen möchten, existiert bereits.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_INITIALIZED',
    p_message_text => q'øFinished initialization at #1#. Loaded modules: [#2#]ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_INITIALIZED',
    p_message_text => q'øInitialisierung beendet am #1#. Geladene Module: [#2#]ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_message_text => q'øLog message "#1#" could not be created.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_message_text => q'øLog-Nachricht "#1#" konnte nicht erzeugt werden.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_message_text => q'øError purging the message stack.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_message_text => q'øFehler beim Löschen des Nachrichten-Stacks.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_FAIL_MODULE_INIT',
    p_message_text => q'øModule #1# received an error during installation: #2#ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_FAIL_MODULE_INIT',
    p_message_text => q'øModul "#1#" konnte aufgrund eines Fehlers nicht installiert werden: #2#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_MODULE_INSTANTIATED',
    p_message_text => q'øModule #1# has been succesfully instantiated.ø',
    p_severity => 50,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_MODULE_INSTANTIATED',
    p_message_text => q'øModul "#1#" wurde erfolgreich instantiiert.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_MODULE_LIST_LOADED',
    p_message_text => q'øModule list has been successfully loaded.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_MODULE_LIST_LOADED',
    p_message_text => q'øDie Modulliste wurde erfolgreich geladen.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_MODULE_UNAVAILABLE',
    p_message_text => q'øModule #1# has been requested, but is not available.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_MODULE_UNAVAILABLE',
    p_message_text => q'øModul "#1#" wurde angefordert, ist aber nicht verfügbar.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_MODULE_TERMINATED',
    p_message_text => q'øModule #1# was terminated due to an error.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_MODULE_TERMINATED',
    p_message_text => q'øModul "#1#" wurde wegen eines Fehlers terminiert.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_message_text => q'øRequested change requires admin mode.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_message_text => q'øDiese Änderung ist nur im ADMIN-Modus möglich.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PARAM_IS_NULL',
    p_message_text => q'øThe requested parameter #1# doesn't exist.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PARAM_IS_NULL',
    p_message_text => q'øDer angeforderte Parameter "#1#" existiert nicht.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PARAM_NOT_EXTENDABLE',
    p_message_text => q'øParameter-Group does not allow for new parameters.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PARAM_NOT_EXTENDABLE',
    p_message_text => q'øDie Erweiterung dieser Parametergruppe ist nicht erlaubt.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PARAM_NOT_FOUND',
    p_message_text => q'øParameter #1# does not exist.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PARAM_NOT_FOUND',
    p_message_text => q'øDer Parameter #1# existiert nicht.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PARAM_NOT_MODIFIABLE',
    p_message_text => q'øParameter #1# is not allowed to be changed.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PARAM_NOT_MODIFIABLE',
    p_message_text => q'øDie Änderung des Parameters #1# ist nicht erlaubt.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_PASS_MESSAGE',
    p_message_text => q'ø#SQLERRM#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_READ_MODULE_LIST',
    p_message_text => q'øModule list read succesfully.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_READ_MODULE_LIST',
    p_message_text => q'øListe der Module erfolgreich gelesen.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_message_text => q'øError reading the list of modules.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_message_text => q'øFehler beim Lesen der Liste der Module.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SQL_ERROR',
    p_message_text => q'øSQL Error occurred: #1#ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'SQL_ERROR',
    p_message_text => q'øEin SQL-Fehler ist aufgetreten: #1#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_message_text => q'øNamed context #1# does not exist.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_message_text => q'øDer benannte Kontext #1# existiert nicht.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_message_text => q'øParameter #1# was expected to be in (#2#) but was #3#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_message_text => q'øParameter #1# soll in (#2#) enthalten sein, war aber #3#.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_MODULE_PARAM_MISSING',
    p_message_text => q'øAt least one output module must be specified.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_MODULE_PARAM_MISSING',
    p_message_text => q'øZumindest ein Ausgabemodul muss angegeben werden.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'PIT_MSG_NOT_EXISTING',
    p_message_text => q'øMessage #1# does not exist. Call PIT using Package MSG to avoid this error.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'PIT_MSG_NOT_EXISTING',
    p_message_text => q'øNachricht #1# existiert nicht. Verwenden Sie das Package MSG, um dieses Problem zu umgehen.ø',
    p_message_language => 'GERMAN'
  );

  commit;
end;
/