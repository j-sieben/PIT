
merge into message m
using (
select 'FATAL_ERROR_OCCURRED' message_name,
       'AMERICAN' message_language,
       'A fatal error has occured: #1#. The application cannot continue.' message_text,
       20 severity,
       null custom_error_number
  from dual union all
select 'FATAL_ERROR_OCCURRED','GERMAN','Ein schwerwiegender Fehler ist aufgetreten: #1#. Die Anwendung kann nicht fortgesetzt werden.',20,null from dual union all
select 'MODULE_NOT_AVAILABLE','AMERICAN','Module #1# has been requested, but is not available.',40, null from dual union all
select 'MODULE_NOT_AVAILABLE','GERMAN','Modul "#1#" wurde angefordert, ist aber nicht verfügbar.',40, null from dual union all
select 'MODULE_LIST_LOADED','AMERICAN','Module list has been successfully loaded.',70, null from dual union all
select 'MODULE_LIST_LOADED','GERMAN','Die Modulliste wurde erfolgreich geladen.',70, null from dual union all
select 'MODULE_INSTANTIATED','AMERICAN','Module #1# has been succesfully instantiated.',40, null from dual union all
select 'MODULE_INSTANTIATED','GERMAN','Modul "#1#" wurde erfolgreich instantiiert.',40, null from dual union all
select 'MODULE_TERMINATED','AMERICAN','Module #1# was terminated due to an error.',30,null from dual union all
select 'MODULE_TERMINATED','GERMAN','Modul "#1#" wurde wegen eines Fehlers terminiert.',30,null from dual union all
select 'MODULE_INITIALIZATION_ERROR','AMERICAN','Module #1# received an error during installation: #2#',40, null from dual union all
select 'MODULE_INITIALIZATION_ERROR','GERMAN','Modul "#1#" konnte aufgrund eines Fehlers nicht installiert werden: #2#',40, null from dual union all
select 'LOGGING_PACKAGE_INITIALIZED','AMERICAN','Finished initialization at #1#. Loaded modules: [#2#]',70, null from dual union all
select 'LOGGING_PACKAGE_INITIALIZED','GERMAN','Initialisierung beendet am #1#. Geladene Module: [#2#]',70, null from dual union all
select 'CONTEXT_CREATED','AMERICAN','Context ##1# created and added to the available contexts list.',70, null from dual union all
select 'CONTEXT_CREATED','GERMAN','Kontext #1# erzeugt und zur Liste der Kontexte hinzugefügt.',70, null from dual union all
select 'CONTEXT_CHANGED','AMERICAN','Context set to ##1#.',70, null from dual union all
select 'CONTEXT_CHANGED','GERMAN','Kontext auf #1# gesetzt.',70, null from dual union all
select 'CONTEXT_CREATION_ERROR','AMERICAN','Error initializing a new context.',70, null from dual union all
select 'CONTEXT_CREATION_ERROR','GERMAN','Fehler bei der Initialisierung eines neuen Kontextes.',70, null from dual union all
select 'CONTEXT_MISSING','AMERICAN','Tried to call context ##1# but it is not existing.',40, null from dual union all
select 'CONTEXT_MISSING','GERMAN','Versuch, den nicht vorhandenen Kontext #1# zu laden.',40, null from dual union all
select 'DEFAULT_CTX_CREATION_ERROR','AMERICAN','Default Context could not be created.',30,null from dual union all
select 'DEFAULT_CTX_CREATION_ERROR','GERMAN','Der Default-Kontext konnte nicht erzeugt werden.',30,null from dual union all
select 'READ_MODULE_LIST_ERROR','AMERICAN','Error reading the list of modules.',30,null from dual union all
select 'READ_MODULE_LIST_ERROR','GERMAN','Fehler beim Lesen der Liste der Module.',30,null from dual union all
select 'READ_MODULE_LIST','AMERICAN','Module list read succesfully.',70, null from dual union all
select 'READ_MODULE_LIST','GERMAN','Liste der Module erfolgreich gelesen.',70, null from dual union all
select 'MESSAGE_CREATION_ERROR','AMERICAN','Log message "#1#" could not be created.',30,null from dual union all
select 'MESSAGE_CREATION_ERROR','GERMAN','Log-Nachricht "#1#" konnte nicht erzeugt werden.',30,null from dual union all
select 'MESSAGE_PURGE_ERROR','AMERICAN','Error purging the message stack.',30,null from dual union all
select 'MESSAGE_PURGE_ERROR','GERMAN','Fehler beim Löschen des Nachrichten-Stacks.',30,null from dual union all
select 'DUPLICATE_MESSAGE_ENTERED','AMERICAN','The message #1# you entered already exists.',30,null from dual union all
select 'DUPLICATE_MESSAGE_ENTERED','GERMAN','Die Nachricht "#1#", die Sie einfügen möchten, existiert bereits.',30,null from dual union all
select 'ASSERTION_FAILED','AMERICAN','Assertion failed.',30,null from dual union all
select 'ASSERTION_FAILED','GERMAN','Assertion schlug fehl.',30,null from dual union all
select 'ASSERT_IS_NOT_NULL','AMERICAN','A value was expected to be null, but was [#1#].',30,null from dual union all
select 'ASSERT_IS_NOT_NULL','GERMAN','Ein Nullwert wurde erwartet, geliefert wurde jedoch [#1#]',30,null from dual union all
select 'ASSERT_IS_NULL','AMERICAN','#1# was expected to be not null, but was not.',30,null from dual union all
select 'ASSERT_IS_NULL','GERMAN','"#1#" wurde als Nullwert erwartet, war es aber nicht.',30,null from dual union all
select 'ASSERT_TRUE','AMERICAN','A value was expected to be equal, but was not.',30,null from dual union all
select 'ASSERT_TRUE','GERMAN','Ein gleicher Wert wurde erwartet, war es aber nicht.',30,null from dual union all
select 'ASSERT_EXISTS','AMERICAN','A statement was expected to return rows, but did not.',30,null from dual union all
select 'ASSERT_EXISTS','GERMAN','Eine Anweisung soll Zeilen liefern, tut es aber nicht.',30,null from dual union all
select 'ASSERT_NOT_EXISTS','AMERICAN','A statement was expected to return no rows, but did.',30,null from dual union all
select 'ASSERT_NOT_EXISTS','GERMAN','Eine Anweisung soll keine Zeilen liefern, tut es aber dennoch.',30,null from dual union all
select 'REPORT_SQL_PARSE_ERROR','AMERICAN','SQL-Statement for Report ##1# failed to parse.',30,null from dual union all
select 'REPORT_SQL_PARSE_ERROR','GERMAN','SQL-Anweisung für Bericht #1# konnte nicht geparst werden.',30,null from dual union all
select 'CODE_ENTER','AMERICAN','Entering: #1#',70,null from dual union all
select 'CODE_ENTER','GERMAN','Rufe auf: #1#',70,null from dual union all
select 'CODE_LEAVE','AMERICAN','Leaving: #1#',70,null from dual union all
select 'CODE_LEAVE','GERMAN','Verlasse: #1#',70,null from dual union all
select 'CODE_ENTER_W_PARAM','AMERICAN','Entering: #1#, Params: #2#',70,null from dual union all
select 'CODE_ENTER_W_PARAM','GERMAN','Rufe auf: #1#, Parameter: #2#',70,null from dual union all
select 'SQL_ERROR','AMERICAN','SQL Error occurred: #1#',30,null from dual union all
select 'SQL_ERROR','GERMAN','Ein SQL-Fehler ist aufgetreten: #1#',30,null from dual union all
select 'PARAMETER_IS_NULL','AMERICAN','The requested parameter #1# doesn''t exist.',40,null from dual union all
select 'PARAMETER_IS_NULL','GERMAN','Der angeforderte Parameter "#1#" existiert nicht.',40,null from dual union all
-- MESSAGES TO EXTEND THE PARAMETER PACKAGE
select 'PARAM_ADMIN_MODE_REQUIRED','AMERICAN','Requested change requires admin mode.',30,null from dual union all
select 'PARAM_ADMIN_MODE_REQUIRED','GERMAN','Diese Änderung ist nur im ADMIN-Modus möglich.',30,null from dual union all
select 'PARAM_NOT_EXTENDABLE','AMERICAN','Parameter-Group does not allow for new parameters.',30,null from dual union all
select 'PARAM_NOT_EXTENDABLE','GERMAN','Die Erweiterung dieser Parametergruppe ist nicht erlaubt.',30,null from dual union all
select 'PARAM_NOT_MODIFIABLE','AMERICAN','Parameter #1# is not allowed to be changed.',30,null from dual union all
select 'PARAM_NOT_MODIFIABLE','GERMAN','Die Änderung des Parameters #1# ist nicht erlaubt.',30,null from dual union all
select 'PARAM_NOT_FOUND','AMERICAN','Parameter #1# does not exist.',30,null from dual union all
select 'PARAM_NOT_FOUND','GERMAN','Der Parameter #1# existiert nicht.',30,null from dual union all
select 'CTX_NO_CONTEXT','AMERICAN','Context cannot be null. Please provide a valid context name.',30,null from dual union all
select 'CTX_NO_CONTEXT','GERMAN','Der Name des Kontextes darf nicht fehlen. Bitte geben Sie einen gültigen Kontextnamen an.',30,null from dual union all
select 'CTX_INVALID_CONTEXT','AMERICAN','Context #1# does not exist. Please provide a valid context name that is controlled by #2#.',30,null from dual union all
select 'CTX_INVALID_CONTEXT','GERMAN','Der Kontext #1# existiert nicht. Bitte geben Sie den namen eines Kontextes an, der durch Package #2# verwaltet wird.',30,null from dual
) v
    on (m.message_name = v.message_name and m.message_language = v.message_language)
  when not matched then insert (message_name, message_language, message_text, severity, custom_error_number)
       values(v.message_name, v. message_language, v.message_text, v.severity, v.custom_error_number);

commit;
