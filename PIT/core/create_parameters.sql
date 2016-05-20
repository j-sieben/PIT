begin

  param_admin.edit_parameter_group(
    p_parameter_group_id => 'PIT',
    p_group_description => 'Parameter for PIT',
    p_is_modifiable => 'Y'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'ADAPTER_PREFERENCE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Order in which PIT tries to use adapter preferences (left ot right)'
   ,p_string_value => q'øAPEX_ADAPTER:DEFAULT_ADAPTERø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'ALLOW_TOGGLE'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Flag to indicate whether PIT utilizes toggle functionality'
   ,p_boolean_value => 'Y'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CTX_TYPE'
   ,p_parameter_group_id => 'CONTEXT'
   ,p_parameter_description => 'Type of the globally accessed PIT context (SESSION|PREFER_USER_CLIENT_ID etc.)'
   ,p_string_value => q'øPREFER_USER_CLIENT_IDø'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'BROADCAST_CONTEXT_SWITCH'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Flag to indicate whether context switches are sent to all available modules (true) or to active modules only'
   ,p_boolean_value => 'N'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'XLIFF_SKELETON'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'template for XLIFF translation files for messages.'
   ,p_xml_value => xmltype(q'ø<?xml version="1.0"?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file original="pit_message_translation.xml" source-language="en" target-language="de" datatype="html">
    <header/>
    <body/>
  </file>
</xliff>
ø')
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