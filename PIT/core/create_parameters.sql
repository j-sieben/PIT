begin
  param_admin.edit_parameter_group('PIT', 'Parameter for PIT', 'Y');
  param_admin.edit_parameter(
    p_parameter_id => 'ADAPTER_PREFERENCE', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Reihenfolge der Adapterverwendung (Fallback auf weiter rechts stehende Adapter)',
    p_string_value => 'APEX_ADAPTER:DEFAULT_ADAPTER');
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_CTX_TYPE', 
    p_parameter_group_id => 'CONTEXT', 
    p_parameter_description => 'Typ des globalen PIT-Contextes (SESSION|PREFER_USER_CLIENT_ID etc.)',
    p_string_value => 'PREFER_USER_CLIENT_ID');
  param_admin.edit_parameter(
    p_parameter_id => 'XLIFF_SKELETON',
    p_parameter_group_id => 'PIT',
    p_parameter_description => 'Rahmendokument einer XLIFF-Uebersetzungsdatei fuer Meldungen.',
    p_xml_value => xmltype(q'[<?xml version="1.0" ?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file original="pit_message_translation.xml" source-language="en" target-language="de" datatype="html">
    <header/>
    <body/>
  </file>
</xliff>]'));
  param_admin.edit_parameter(
    p_parameter_id => 'ALLOW_TOGGLE', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Schaltet die Fähigkeit, Context-Toggles zu verwenden',
    p_boolean_value => 'Y');
  pit_admin.create_named_context(
    p_context_name => 'DEFAULT',
    p_settings => '30|10|N|PIT_TABLE:PIT_APEX',  
    p_comment => 'Benannter Kontext, der das Standard-Logging einstellt');
  pit_admin.create_named_context(
    p_context_name => 'DEBUG',
    p_settings => '70|50|Y|PIT_CONSOLE',  
    p_comment => 'Benannter Kontext, der das Debug-Logging einstellt');
  pit_admin.create_named_context(
    p_context_name => 'OFF',
    p_settings => '10|10|N|',
    p_comment => 'Benannter Kontext, der das Logging abstellt');
  pit_admin.create_context_toggle(
    p_toggle_name => 'TOGGLE_LOG_ON',
    p_module_list => 'ANONYMOUS:TEST.MY_PROC',
    p_context_name => 'DEBUG',
    p_comment => 'Switch, der das Logging für die übergebenen Module einstellt');
end;
/

commit;
