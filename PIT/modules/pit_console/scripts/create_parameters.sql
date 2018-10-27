
begin 
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );
  
  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Loglevel des Moduls PIT_CONSOLE',
    p_par_integer_value => 70);
  
  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_MSG_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von Konsole-Ausgaben. Muss #MESSAGE# enthalten.',
    p_par_string_value => q'^--> #MESSAGE#^');
  
  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_ENTER_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE#, #POSTFIX# und #LEVEL# enthalten.',
    p_par_string_value => q'^#LEVEL#> #MESSAGE##POSTFIX#^');
  
  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEAVE_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #POSTFIX#, #TIMING# und #LEVEL# enthalten.',
    p_par_string_value => q'^#LEVEL#< #MESSAGE##POSTFIX##TIMING#^');
  
  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEVEL_INDICATOR',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.',
    p_par_string_value => q'^..^');
  
  commit;
end;
/


