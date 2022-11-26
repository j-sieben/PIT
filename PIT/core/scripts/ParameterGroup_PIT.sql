set define ~
    
begin

  param_admin.set_import_mode(true);
  

  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'ADAPTER_PREFERENCE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Order in which PIT tries to use adapter preferences (left ot right)',
    p_par_string_value => q'^PIT_APEX_ADAPTER:PIT_DEFAULT_ADAPTER^'
  );

  param_admin.edit_parameter(
    p_par_id => 'ALLOW_TOGGLE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Flag to indicate whether PIT utilizes toggle functionality',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'BROADCAST_CONTEXT_SWITCH',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Flag to indicate whether context switches are sent to all available modules (true) or to active modules only',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'CALL_STACK_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template to format call stack output',
    p_par_string_value => q'^* Call Stack
Zeile Schema          Objekt
----- --------------- ------------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_APEX',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Named context, switches logging on [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (1,0)|MODULE_LIST] [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]',
    p_par_string_value => q'^70|50|1|PIT_APEX:PIT_DRV:PIT_CONSOLE^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_DEBUG',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Named context, switches logging on [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (1,0)|MODULE_LIST] [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]',
    p_par_string_value => q'^70|50|1|PIT_CONSOLE^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_DEFAULT',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Named context, default values [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (1,0)|MODULE_LIST]',
    p_par_string_value => q'^30|10|0|PIT_DRV:PIT_APEX^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_DRV_LIMIT',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Named context, switches logging on [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (1, 0)|MODULE_LIST]',
    p_par_string_value => q'^70|50|1|PIT_APEX:PIT_CONSOLE:PIT_DRV^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_OFF',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Named context, switches logging off [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (1,0)|MODULE_LIST]',
    p_par_string_value => q'^10|10|0|^'
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_POSTFIX',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Optional postfix for exception constant names',
    p_par_string_value => q'^ERR^',
    p_par_validation_string => q'^coalesce(length('#STRING#'), 0) < 4^',
    p_par_validation_message => q'^Postfix length must not exceed 3 characters^'
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_PREFIX',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Optional prefix for exception constant names',
    p_par_validation_string => q'^coalesce(length('#STRING#'), 0) < 4^',
    p_par_validation_message => q'^Prefix length must not exceed 3 characters^'
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_STACK_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template to format call stack output',
    p_par_string_value => q'^* Error Stack
Level Fehler#   Meldung
----- --------- ------------------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'LOG_STATE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Severity of LOG_STATE messages, controls at which level this method starts to emit log information.',
    p_par_integer_value => 50
  );

  param_admin.edit_parameter(
    p_par_id => 'NAME_SPELLING',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Default spelling for database object names',
    p_par_string_value => q'^LOWER^',
    p_par_validation_string => q'^'#STRING#' in ('LOWER', 'UPER', 'UNCHANGED')^',
    p_par_validation_message => q'^Allowed values are LOWER|UPPER|UNCHANGED^'
  );

  param_admin.edit_parameter(
    p_par_id => 'OMIT_PIT_IN_STACK',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Flag to indicate whether PIT package method calls should be contained in the call and error stack',
    p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'OMIT_PKG_IN_STACK',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Colon-separated list of package names to ignore for the call stack calculation',
    p_par_string_value => q'^Z226L^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PACKAGE_STALE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Indicates changes to a message that requires the MSG package to be re-created.',
    p_par_boolean_value => false
  );


  param_admin.edit_parameter(
    p_par_id => 'ADAPTER_PREFERENCE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Order in which PIT tries to use adapter preferences (left ot right)',
    p_par_string_value => q'^PIT_APEX_ADAPTER:PIT_DEFAULT_ADAPTER^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_APEX',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log context for PIT_APEX if wstiched on by APEX debug settings [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]',
    p_par_string_value => '70|50|' || replace(1, '''') || '|PIT_APEX:PIT_CONSOLE'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Loglevel of output module PIT_APEX',
    p_par_integer_value => 70,
    p_par_validation_string => '#INTEGER# in (10,20,30,40,50,60,70)',
    p_par_validation_message => 'Allowed values: 10,20,30,40,50,60,70'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log level of output module PIT_APEX, if DEBUG was requested by APEX.',
    p_par_integer_value => 70,
    p_par_validation_string => '#INTEGER# in (10,20,30,40,50,60,70)',
    p_par_validation_message => 'Allowed values: 10,20,30,40,50,60,70'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_LOG_MODULES',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log modules to be used if DEBUG has been requested by APEX',
    p_par_string_value => q'^PIT_APEX^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_TWEET_REALMS',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Colon-separated list of REALM values that allow PIT.tweet',
    p_par_string_value => q'^ENTWICKLUNG^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Trace level of the module PIT_APEX, if DEBUG was requested by APEX.',
    p_par_integer_value => 50,
    p_par_validation_string => '#INTEGER# in (10,20,30,40,50)',
    p_par_validation_message => 'Allowed values: 10,20,30,40,50'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_TIMING',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Should timing be calculated if DEBUG was requested by APEX',
    p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CALL_STACK_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template that is used in Version 12 onwards to create a call stack string',
    p_par_string_value => q'^* Call Stack
Line    Schema          Object
------- --------------- ----------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_ENTER_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE# und #LEVEL# enthalten.',
    p_par_string_value => q'^#LEVEL#> #MESSAGE##POSTFIX#^',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Loglevel des Moduls PIT_CONSOLE',
    p_par_integer_value => 70,
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEAVE_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #TIMING# und #LEVEL# enthalten.',
    p_par_string_value => q'^#LEVEL#< #MESSAGE##POSTFIX##TIMING#^',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEVEL_INDICATOR',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.',
    p_par_string_value => q'^..^',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_MSG_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von Konsole-Ausgaben. Muss #MESSAGE# enthalten.',
    p_par_string_value => q'^... #MESSAGE#^',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_DRV_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Loglevel für das Modul PIT_TABLE',
    p_par_integer_value => 70,
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_DRV_LEVEL_INDICATOR',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.',
    p_par_string_value => q'^..^',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_DRV_MSG_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von Konsole-Ausgaben. Muss #MESSAGE# enthalten.',
    p_par_string_value => q'^--> #MESSAGE#^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_DRV_TIMING_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von Timing-Ausgaben.',
    p_par_string_value => q'^'[wc=#WC#; e=#E#; e_cpu=#E_CPU#; t=#T#; t_cpu=#T_CPU#]'^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_DRV_TRACE_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE# und #LEVEL# enthalten.',
    p_par_string_value => q'^#LEVEL#> #MESSAGE#^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_ERROR_STACK_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template that is used in Version 12 onwards to create a error stack string',
    p_par_string_value => q'^* Error Stack
Level Error#    Message
----- --------- ----------------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_STOP_BULK_ON_FATAL',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Legt fest, ob PIT im Collect-Message-Modus nach dem Auftreten eines fatalen Fehlers den Modus beendet und den Fehler wirft (TTUE) oder nicht (FALSE)',
    p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_TABLE_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log level for output module PIT_TABLE',
    p_par_integer_value => 70
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_WEB_SOCKET_SERVER',
    p_par_pgr_id => 'PIT',
    p_par_description => 'WebSocket server for pushing messages to PIT_APEX',
    p_par_string_value => q'^http://localhost:8880^'
  );

  param_admin.edit_parameter(
    p_par_id => 'WARN_IF_UNUSABLE_MODULES',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Flag to indicate whether PIT should emit a warning if an output module could not be instantiated',
    p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'XLIFF_SKELETON',
    p_par_pgr_id => 'PIT',
    p_par_description => 'template for XLIFF translation files for messages.',
    p_par_xml_value => xmltype(q'^<?xml version="1.0"?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file original="pit_message_translation.xml" source-language="en" target-language="de" datatype="html">
    <header/>
    <body/>
  </file>
</xliff>
^')
  );

  -- Local parameters

  param.set_boolean(
    p_par_id => 'ALLOW_TOGGLE',
    p_par_pre_id => 'ENTWICKLUNG',
    p_par_pgr_id => 'PIT',
    p_par_value => true
  );

  param.set_string(
    p_par_id => 'CONTEXT_DEBUG',
    p_par_pre_id => 'ENTWICKLUNG',
    p_par_pgr_id => 'PIT',
    p_par_value => q'^70|50|Y|PIT_CONSOLE^'
  );

  param.set_string(
    p_par_id => 'CONTEXT_DRV_LIMIT',
    p_par_pre_id => 'PNT',
    p_par_pgr_id => 'PIT',
    p_par_value => q'^40|20|Y|PIT_DRV:PIT_APEX^'
  );

  param.set_string(
    p_par_id => 'CONTEXT_DRV_LIMIT',
    p_par_pre_id => 'ENTWICKLUNG',
    p_par_pgr_id => 'PIT',
    p_par_value => q'^40|20|Y|PIT_DRV:PIT_APEX^'
  );

  param.set_string(
    p_par_id => 'CONTEXT_DRV_LIMIT',
    p_par_pre_id => 'FREIGABE',
    p_par_pgr_id => 'PIT',
    p_par_value => q'^40|20|Y|PIT_DRV:PIT_APEX^'
  );

  param.set_string(
    p_par_id => 'CONTEXT_DRV_LIMIT',
    p_par_pre_id => 'TEST',
    p_par_pgr_id => 'PIT',
    p_par_value => q'^40|20|Y|PIT_DRV:PIT_APEX^'
  );

  param.set_string(
    p_par_id => 'CONTEXT_DRV_LIMIT',
    p_par_pre_id => 'PRODUKTION',
    p_par_pgr_id => 'PIT',
    p_par_value => q'^40|10|Y|PIT_DRV:PIT_APEX^'
  );

  param.set_boolean(
    p_par_id => 'PACKAGE_STALE',
    p_par_pre_id => 'ENTWICKLUNG',
    p_par_pgr_id => 'PIT',
    p_par_value => false
  );

  param_admin.harmonize_parameter_group('PIT');
  
  param_admin.set_import_mode(false);
  commit;
end;
/
set define &
