
begin
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_TEST_FIRE_THRESHOLD',
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Loglevel für das Modul PIT_TABLE',
    p_integer_value => 70);
    
  pit_admin.create_named_context(
    p_context_name => 'TEST_FULL',
    p_settings => '70|50|Y|PIT_TEST:PIT_CONSOLE',
    p_comment => 'Vollständiges Logging für Testzwecke');
    
  pit_admin.create_named_context(
    p_context_name => 'TEST_LOG_ONLY',
    p_settings => '70|10|N|PIT_TEST:PIT_CONSOLE',
    p_comment => 'Vollständiges Logging für Testzwecke');
    
  pit_admin.create_named_context(
    p_context_name => 'TEST_OFF',
    p_settings => '10|10|N|PIT_TEST:PIT_CONSOLE',
    p_comment => 'Abgeschaltetes Logging für Testzwecke');
    
  pit_admin.create_context_toggle(
    p_toggle_name => 'TEST_ON',
    p_module_list => 'TEST.MY_PROC',
    p_context_name => 'TEST_FULL',
    p_comment => 'Toggles Debugging on for testing');
    
  pit_admin.create_context_toggle(
    p_toggle_name => 'TEST_OFF',
    p_module_list => 'TEST.MY_OTHER_PROC',
    p_context_name => 'TEST_OFF',
    p_comment => 'Toggles Debugging on for testing');

  commit;
end;
/

