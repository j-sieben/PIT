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
  );

  param_admin.edit_parameter(
    p_par_id => 'ALLOW_TOGGLE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether PIT utilizes toggle functionality'
  );

  param_admin.edit_parameter(
    p_par_id => 'BROADCAST_CONTEXT_SWITCH'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether context switches are sent to all available modules (true) or to active modules only'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_DEBUG'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Named context, switches logging on [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_DEFAULT'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Named context, default values [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_OFF'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Named context, switches logging off [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_POSTFIX'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Optional postfix for exception constant names'
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_PREFIX'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Optional prefix for exception constant names'
  );

  param_admin.edit_parameter(
    p_par_id => 'NAME_SPELLING'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Default spelling for database object names'
  );

  param_admin.edit_parameter(
    p_par_id => 'OMIT_PIT_IN_STACK'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether PIT package method calls should be contained in the call and error stack'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CALL_STACK_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template that is used in Version 12 onwards to create a call stack string'
Line  Schema          Object
----- --------------- ----------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_ERROR_STACK_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template that is used in Version 12 onwards to create a error stack string'
Level Error#    Message
----- --------- ----------------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_TABLE_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel für das Modul PIT_TABLE'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_WEB_SOCKET_SERVER'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'WebSocket-Server zum Pushen von Nachrichten an PIT_APEX'
  );

  param_admin.edit_parameter(
    p_par_id => 'WARN_IF_UNUSABLE_MODULES'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether PIT should emit a warning if an output module could not be instantiated'
  );

  commit;
end;
/