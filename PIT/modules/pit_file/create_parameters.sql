
begin
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_FIRE_THRESHOLD', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Loglevel des Moduls PIT_FILE',
    p_integer_value => 70);
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_DIRECTORY', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Direcoty-Objekt des Moduls PIT_FILE',
    p_string_value => 'PIT_FILE_DIR');
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_DIRECTORY', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Direcoty-Objekt des Moduls PIT_FILE',
    p_string_value => 'PIT_FILE_DIR');
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_FILE_FILE_NAME', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Dateiname des Moduls PIT_FILE',
    p_string_value => 'pit_file.trc');     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_FILE_MSG_TEMPLATE',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Template zur Formatierung von Datei-Ausgaben. Muss #MESSAGE# enthalten.',
     p_string_value => q'ø--> #MESSAGE#ø');     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_FILE_ENTER_TEMPLATE',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE# und #LEVEL# enthalten.',
     p_string_value => q'ø#LEVEL#> #MESSAGE#ø');     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_FILE_LEAVE_TEMPLATE',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #TIMING# und #LEVEL# enthalten.',
     p_string_value => q'ø#LEVEL#< #MESSAGE##TIMING#ø');     
   param_admin.edit_parameter(
     p_parameter_id => 'PIT_FILE_LEVEL_INDICATOR',
     p_parameter_group_id => 'PIT',
     p_parameter_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.',
     p_string_value => q'ø..ø');
  pit_admin.create_message_package;
  commit;
end;
/


