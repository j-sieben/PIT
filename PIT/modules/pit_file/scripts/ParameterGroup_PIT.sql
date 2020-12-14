begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_DIRECTORY'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Directory object for output module PIT_FILE'
   ,p_par_string_value => q'^PIT_FILE_DIR^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_ENTER_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template for formatting ENTER outputs. Must contain #MESSAGE# and #LEVEL#.'
   ,p_par_string_value => q'^#LEVEL#> #MESSAGE#^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_FILE_NAME'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'File name of the module PIT_FILE'
   ,p_par_string_value => q'^pit_file.trc^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Log level of the output module PIT_FILE'
   ,p_par_integer_value => 70
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_LEAVE_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template for formatting LEAVE outputs. Must contain #MESSAGE#, #TIMING# and #LEVEL#.'
   ,p_par_string_value => q'^#LEVEL#< #MESSAGE##TIMING#^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_LEVEL_INDICATOR'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'String used for the level of the call stack.'
   ,p_par_string_value => q'^..^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_MSG_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template for formatting file outputs. Must contain #MESSAGE#.'
   ,p_par_string_value => q'^--> #MESSAGE#^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_STATE_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template for formatting file outputs. Must contain #STATE#.'
   ,p_par_string_value => q'^--> State:#STATE#^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );
     
  commit;
end;
/


