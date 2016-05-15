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
    p_message_name => 'ASSERT_IS_NOT_NULL',
    p_message_text => q'øA value was expected to be null, but was [#1#].ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERT_IS_NOT_NULL',
    p_message_text => q'øEin Nullwert wurde erwartet, geliefert wurde jedoch [#1#]ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'ASSERT_IS_NULL',
    p_message_text => q'ø#1# was expected to be not null, but was not.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'ASSERT_IS_NULL',
    p_message_text => q'ø"#1#" wurde als Nullwert erwartet, war es aber nicht.ø',
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
    p_message_name => 'CODE_ENTER',
    p_message_text => q'øEntering: #1#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CODE_ENTER',
    p_message_text => q'øRufe auf: #1#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CODE_ENTER_W_PARAM',
    p_message_text => q'øEntering: #1#, Params: #2#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CODE_ENTER_W_PARAM',
    p_message_text => q'øRufe auf: #1#, Parameter: #2#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CODE_LEAVE',
    p_message_text => q'øLeaving: #1#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CODE_LEAVE',
    p_message_text => q'øVerlasse: #1#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CONTEXT_CHANGED',
    p_message_text => q'øContext set to ##1#.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CONTEXT_CHANGED',
    p_message_text => q'øKontext auf #1# gesetzt.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CONTEXT_CREATED',
    p_message_text => q'øContext ##1# created and added to the available contexts list.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CONTEXT_CREATED',
    p_message_text => q'øKontext #1# erzeugt und zur Liste der Kontexte hinzugefügt.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CONTEXT_CREATION_ERROR',
    p_message_text => q'øError initializing a new context.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CONTEXT_CREATION_ERROR',
    p_message_text => q'øFehler bei der Initialisierung eines neuen Kontextes.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'CONTEXT_MISSING',
    p_message_text => q'øTried to call context ##1# but it is not existing.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'CONTEXT_MISSING',
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
    p_message_name => 'DEFAULT_CTX_CREATION_ERROR',
    p_message_text => q'øDefault Context could not be created.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'DEFAULT_CTX_CREATION_ERROR',
    p_message_text => q'øDer Default-Kontext konnte nicht erzeugt werden.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'DUPLICATE_MESSAGE_ENTERED',
    p_message_text => q'øThe message #1# you entered already exists.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'DUPLICATE_MESSAGE_ENTERED',
    p_message_text => q'øDie Nachricht "#1#", die Sie einfügen möchten, existiert bereits.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'FATAL_ERROR_OCCURRED',
    p_message_text => q'øA fatal error has occured: #1#. The application cannot continue.ø',
    p_severity => 20,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'FATAL_ERROR_OCCURRED',
    p_message_text => q'øEin schwerwiegender Fehler ist aufgetreten: #1#. Die Anwendung kann nicht fortgesetzt werden.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'LOGGING_PACKAGE_INITIALIZED',
    p_message_text => q'øFinished initialization at #1#. Loaded modules: [#2#]ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'LOGGING_PACKAGE_INITIALIZED',
    p_message_text => q'øInitialisierung beendet am #1#. Geladene Module: [#2#]ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'MESSAGE_CREATION_ERROR',
    p_message_text => q'øLog message "#1#" could not be created.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'MESSAGE_CREATION_ERROR',
    p_message_text => q'øLog-Nachricht "#1#" konnte nicht erzeugt werden.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'MESSAGE_PURGE_ERROR',
    p_message_text => q'øError purging the message stack.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'MESSAGE_PURGE_ERROR',
    p_message_text => q'øFehler beim Löschen des Nachrichten-Stacks.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'MODULE_INITIALIZATION_ERROR',
    p_message_text => q'øModule #1# received an error during installation: #2#ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'MODULE_INITIALIZATION_ERROR',
    p_message_text => q'øModul "#1#" konnte aufgrund eines Fehlers nicht installiert werden: #2#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'MODULE_INSTANTIATED',
    p_message_text => q'øModule #1# has been succesfully instantiated.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'MODULE_INSTANTIATED',
    p_message_text => q'øModul "#1#" wurde erfolgreich instantiiert.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'MODULE_LIST_LOADED',
    p_message_text => q'øModule list has been successfully loaded.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'MODULE_LIST_LOADED',
    p_message_text => q'øDie Modulliste wurde erfolgreich geladen.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'MODULE_NOT_AVAILABLE',
    p_message_text => q'øModule #1# has been requested, but is not available.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'MODULE_NOT_AVAILABLE',
    p_message_text => q'øModul "#1#" wurde angefordert, ist aber nicht verfügbar.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'MODULE_TERMINATED',
    p_message_text => q'øModule #1# was terminated due to an error.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'MODULE_TERMINATED',
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
    p_message_name => 'PARAMETER_IS_NULL',
    p_message_text => q'øThe requested parameter #1# doesn't exist.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'PARAMETER_IS_NULL',
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
    p_message_name => 'PASS_MESSAGE',
    p_message_text => q'ø#SQLERRM#ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_message_name => 'READ_MODULE_LIST',
    p_message_text => q'øModule list read succesfully.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'READ_MODULE_LIST',
    p_message_text => q'øListe der Module erfolgreich gelesen.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'READ_MODULE_LIST_ERROR',
    p_message_text => q'øError reading the list of modules.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'READ_MODULE_LIST_ERROR',
    p_message_text => q'øFehler beim Lesen der Liste der Module.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'REPORT_SQL_PARSE_ERROR',
    p_message_text => q'øSQL-Statement for Report ##1# failed to parse.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'REPORT_SQL_PARSE_ERROR',
    p_message_text => q'øSQL-Anweisung für Bericht #1# konnte nicht geparst werden.ø',
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

  commit;
  pit_admin.create_message_package;
end;
/