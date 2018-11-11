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
   ,p_par_string_value => q'^APEX_ADAPTER:DEFAULT_ADAPTER^'
  );

  param_admin.edit_parameter(
    p_par_id => 'ALLOW_TOGGLE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether PIT utilizes toggle functionality'
   ,p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CTX_TYPE'
   ,p_par_pgr_id => 'CONTEXT'
   ,p_par_description => 'Type of the globally accessed PIT context (SESSION|PREFER_USER_CLIENT_ID etc.)'
   ,p_par_string_value => q'^PREFER_USER_CLIENT_ID^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CTX_&INSTALL_USER._TYPE'
   ,p_par_pgr_id => 'CONTEXT'
   ,p_par_description => 'Type of the globally accessed PIT context (SESSION|PREFER_USER_CLIENT_ID etc.)'
   ,p_par_string_value => q'^PREFER_USER_CLIENT_ID^'
  );

  param_admin.edit_parameter(
    p_par_id => 'BROADCAST_CONTEXT_SWITCH'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Flag to indicate whether context switches are sent to all available modules (true) or to active modules only'
   ,p_par_boolean_value => false
  );

  param_admin.edit_parameter(
    p_par_id => 'XLIFF_SKELETON'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'template for XLIFF translation files for messages.'
   ,p_par_xml_value => xmltype(q'^<?xml version="1.0"?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file original="pit_message_translation.xml" source-language="en" target-language="de" datatype="html">
    <header/>
    <body/>
  </file>
</xliff>
^')
  );

  param_admin.edit_parameter(
    p_par_id => 'ERROR_PREFIX'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Optional prefix for exception constant names'
   ,p_par_string_value => q'^^'
   ,p_par_validation_string => 'length(#STRING_VALUE#) < 4'
   ,p_par_validation_message => 'Prefix length must not exceed 3 characters'
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ERROR_POSTFIX'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Optional postfix for exception constant names'
   ,p_par_string_value => q'^ERR^'
   ,p_par_validation_string => 'length(#STRING_VALUE#) < 4'
   ,p_par_validation_message => 'Postfix length must not exceed 3 characters'
  );
  param_admin.edit_parameter(
    p_par_id => 'PIT_WEB_SOCKET_SERVER',
    p_par_pgr_id => 'PIT',
    p_par_description => 'WebSocket-Server zum Pushen von Nachrichten an PIT_APEX',
    p_par_string_value => 'http://localhost:8880'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CALL_STACK_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description =>'Template that is used in Version 12 onwards to create a call stack string',
    p_par_string_value => q'^* Call Stack
Line  Schema          Object
----- --------------- ----------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_ERROR_STACK_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description =>'Template that is used in Version 12 onwards to create a error stack string',
    p_par_string_value => q'^* Error Stack
Level Error#    Message
----- --------- ----------------------------------------------------^'
  );

  param_admin.edit_parameter(
    p_par_id => 'NAME_SPELLING'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Default spelling for database object names'
   ,p_par_string_value => q'^LOWER^'
   ,p_par_validation_string => q'^#STRING_VALUE# in ('LOWER', 'UPER', 'UNCHANGED')^'
   ,p_par_validation_message => 'Allowed values are LOWER|UPPER|UNCHANGED'
  );
  
  pit_admin.create_named_context(
    p_context_name => 'CONTEXT_DEBUG',
    p_settings => '70|50|Y|PIT_CONSOLE',
    p_comment => 'Named context, switches logging on [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]');

  pit_admin.create_named_context(
    p_context_name => 'CONTEXT_DEFAULT',
    p_settings => '30|10|N|PIT_TABLE:PIT_APEX',
    p_comment => 'Named context, default values [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]');

  pit_admin.create_named_context(
    p_context_name => 'CONTEXT_OFF',
    p_settings => '10|10|N|',
    p_comment => 'Named context, switches logging off [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]');

    
  commit;
end;
/