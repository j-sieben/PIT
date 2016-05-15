begin

  param_admin.edit_parameter_group(
    p_parameter_group_id => 'PIT',
    p_group_description => 'Parameter for PIT',
    p_is_modifiable => 'Y'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'ADAPTER_PREFERENCE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Reihenfolge der Adapterverwendung (Fallback auf weiter rechts stehende Adapter)'
   ,p_string_value => q'øAPEX_ADAPTER:DEFAULT_ADAPTERø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'ALLOW_TOGGLE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Schaltet die Fähigkeit, Context-Toggles zu verwenden'
   ,p_boolean_value => 'Y'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'CONTEXT_DEBUG'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Benannter Kontext, der das Debug-Logging einstellt [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
   ,p_string_value => q'ø70|50|Y|PIT_CONSOLEø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'CONTEXT_DEFAULT'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Benannter Kontext, der das Standard-Logging einstellt [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
   ,p_string_value => q'ø30|10|N|PIT_TABLE:PIT_APEXø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'CONTEXT_OFF'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Benannter Kontext, der das Logging abstellt [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
   ,p_string_value => q'ø10|10|N|ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_FIRE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Loglevel des Module PIT_APEX'
   ,p_integer_value => 30
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_FIRE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Loglevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'
   ,p_integer_value => 70
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_LOG_MODULES'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Zu verwendende Logmodule, falls DEBUG von APEX angefordert wurde'
   ,p_string_value => q'øPIT_APEXø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_TRACE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Tracelevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'
   ,p_integer_value => 70
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_TRACE_TIMING'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Soll Timing berechnet werden, falls DEBUG von APEX angefordert wurde'
   ,p_boolean_value => 'Y'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CONSOLE_ENTER_TEMPLATE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE# und #LEVEL# enthalten.'
   ,p_string_value => q'ø#LEVEL#> #MESSAGE#ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CONSOLE_FIRE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Loglevel des Moduls PIT_CONSOLE'
   ,p_integer_value => 70
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CONSOLE_LEAVE_TEMPLATE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #TIMING# und #LEVEL# enthalten.'
   ,p_string_value => q'ø#LEVEL#< #MESSAGE##TIMING#ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CONSOLE_LEVEL_INDICATOR'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.'
   ,p_string_value => q'ø..ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CONSOLE_MSG_TEMPLATE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Template zur Formatierung von Konsole-Ausgaben. Muss #MESSAGE# enthalten.'
   ,p_string_value => q'ø--> #MESSAGE#ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CTX_TYPE'
   ,p_parameter_group_id => 'CONTEXT'
   ,p_parameter_description => 'Typ des globalen PIT-Contextes (SESSION|PREFER_USER_CLIENT_ID etc.)'
   ,p_string_value => q'øPREFER_USER_CLIENT_IDø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_DIRECTORY'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Direcoty-Objekt des Moduls PIT_FILE'
   ,p_string_value => q'øPIT_FILE_DIRø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_ENTER_TEMPLATE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE# und #LEVEL# enthalten.'
   ,p_string_value => q'ø#LEVEL#> #MESSAGE#ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_FILE_NAME'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Dateiname des Moduls PIT_FILE'
   ,p_string_value => q'øpit_file.trcø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_FIRE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Loglevel des Moduls PIT_FILE'
   ,p_integer_value => 70
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_LEAVE_TEMPLATE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #TIMING# und #LEVEL# enthalten.'
   ,p_string_value => q'ø#LEVEL#< #MESSAGE##TIMING#ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_LEVEL_INDICATOR'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.'
   ,p_string_value => q'ø..ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_MSG_TEMPLATE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Template zur Formatierung von Datei-Ausgaben. Muss #MESSAGE# enthalten.'
   ,p_string_value => q'ø--> #MESSAGE#ø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_TABLE_FIRE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Loglevel für das Modul PIT_TABLE'
   ,p_integer_value => 70
  );

  param_admin.edit_parameter(
    p_parameter_id => 'TOGGLE_LOG_ON'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Switch, der das Logging für die übergebenen Module einstellt'
   ,p_string_value => q'øANONYMOUS:TEST.MY_PROC|DEBUGø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'XLIFF_SKELETON'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Rahmendokument einer XLIFF-Uebersetzungsdatei fuer Meldungen.'
   ,p_xml_value => xmltype(q'ø<?xml version="1.0"?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file original="pit_message_translation.xml" source-language="en" target-language="de" datatype="html">
    <header/>
    <body/>
  </file>
</xliff>
ø')
  );

  commit;
end;
/