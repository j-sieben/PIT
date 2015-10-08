begin
  param_admin.edit_parameter_group('PIT', 'Parameter for PIT', 'Y');
         
  param_admin.edit_parameter(
    p_parameter_id => 'DEFAULT_LOG_MODULES', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Module, die als Default für das Logging verwendet werden',
    p_string_value => 'PIT_TABLE:PIT_APEX');
  param_admin.edit_parameter(
    p_parameter_id => 'DEFAULT_LOG_LEVEL',  
    p_parameter_group_id => 'PIT',  
    p_parameter_description => 'Maximaler Logging-Level als Voreinstellung für alle Module',
    p_integer_value => 30,
    p_validation_string => '#INTEGER# in (10,20,30,40,50,60,70)',
    p_validation_message => 'Erlaubte Werte: 10|20|30|40|50|60|70'
	);
  param_admin.edit_parameter(
    p_parameter_id => 'DEFAULT_TRACE_LEVEL',  
    p_parameter_group_id => 'PIT',  
    p_parameter_description => 'Maximaler Trace-Level als Voreinstellung für alle Module',
    p_integer_value => 10,
    p_validation_string => '#INTEGER# in (10,20,30,40,50)',
    p_validation_message => 'Erlaubte Werte: 10|20|30|40|50'
	);
  param_admin.edit_parameter(
    p_parameter_id => 'DEFAULT_TRACE_TIMING',  
    p_parameter_group_id => 'PIT',  
    p_parameter_description => 'Flag, das anzeigt, ob Zeitinformationen gestoppt werden sollen',
    p_boolean_value => 'N');
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
end;
/

commit;
