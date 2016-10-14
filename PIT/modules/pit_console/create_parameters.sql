
begin 
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_CONSOLE_FIRE_THRESHOLD',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Loglevel des Moduls PIT_CONSOLE',
     p_integer_value => 70);
     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_CONSOLE_MSG_TEMPLATE',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Template zur Formatierung von Konsole-Ausgaben. Muss #MESSAGE# enthalten.',
     p_string_value => q'ø--> #MESSAGE#ø');
     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_CONSOLE_ENTER_TEMPLATE',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE# und #LEVEL# enthalten.',
     p_string_value => q'ø#LEVEL#> #MESSAGE#ø');
     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_CONSOLE_LEAVE_TEMPLATE',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #TIMING# und #LEVEL# enthalten.',
     p_string_value => q'ø#LEVEL#< #MESSAGE##TIMING#ø');
     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_CONSOLE_LEVEL_INDICATOR',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.',
     p_string_value => q'ø..ø');
     
  commit;
end;
/


