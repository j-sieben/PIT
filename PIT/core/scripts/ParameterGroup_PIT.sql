begin

  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'ADAPTER_PREFERENCE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Order in which PIT tries to use adapter preferences (left ot right)'
   ,p_par_string_value => q'^PIT_DEFAULT_ADAPTER^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'ALLOW_TOGGLE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether PIT utilizes toggle functionality'
   ,p_par_boolean_value => false
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'BROADCAST_CONTEXT_SWITCH'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether context switches are sent to all available modules (true) or to active modules only'
   ,p_par_boolean_value => false
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_DEBUG'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Named context, switches logging on [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
   ,p_par_string_value => q'^70|50|Y|PIT_CONSOLE^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_DEFAULT'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Named context, default values [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
   ,p_par_string_value => q'^30|10|N|PIT_TABLE:PIT_APEX^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_OFF'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Named context, switches logging off [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
   ,p_par_string_value => q'^10|10|N|^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_POSTFIX'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Optional postfix for exception constant names'
   ,p_par_string_value => q'^&ERROR_POSTFIX.^'
   ,p_par_validation_string => q'^length(#STRING_VALUE#) < 4^'
   ,p_par_validation_message => q'^Postfix length must not exceed 3 characters^'
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_PREFIX'
   ,p_par_pgr_id => 'PIT'
   ,p_par_string_value => q'^&ERROR_PREFIX.^'
   ,p_par_description => 'Optional prefix for exception constant names'
   ,p_par_validation_string => q'^length(#STRING_VALUE#) < 4^'
   ,p_par_validation_message => q'^Prefix length must not exceed 3 characters^'
  );

  param_admin.edit_parameter(
    p_par_id => 'LOG_STATE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Severity of LOG_STATE messages, controls at which level this method starts to emit log information.'
   ,p_par_integer_value => 50 -- Level INFO
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'NAME_SPELLING'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Default spelling for database object names'
   ,p_par_string_value => q'^LOWER^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
   ,p_par_validation_string => q'^#STRING_VALUE# in ('LOWER', 'UPER', 'UNCHANGED')^'
   ,p_par_validation_message => q'^Allowed values are LOWER|UPPER|UNCHANGED^'
  );

  param_admin.edit_parameter(
    p_par_id => 'OMIT_PIT_IN_STACK'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether PIT package method calls should be contained in the call and error stack'
   ,p_par_boolean_value => true
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CALL_STACK_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template that is used in Version 12 onwards to create a call stack string'
   ,p_par_string_value => q'^* Call Stack
Line    Schema          Object
------- --------------- ----------------------------------------------^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_ERROR_STACK_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template that is used in Version 12 onwards to create a error stack string'
   ,p_par_string_value => q'^* Error Stack
Level Error#    Message
----- --------- ----------------------------------------------------^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_TABLE_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel für das Modul PIT_TABLE'
   ,p_par_integer_value => 70
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_WEB_SOCKET_SERVER'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'WebSocket-Server zum Pushen von Nachrichten an PIT_APEX'
   ,p_par_string_value => q'^http://localhost:8880^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'WARN_IF_UNUSABLE_MODULES'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether PIT should emit a warning if an output module could not be instantiated'
   ,p_par_boolean_value => false
   ,p_par_is_modifiable => null
  );

  commit;
end;
/