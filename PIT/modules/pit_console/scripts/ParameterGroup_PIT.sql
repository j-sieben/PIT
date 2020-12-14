
begin 
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_ENTER_TEMPLATE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Template for formatting ENTER outputs. Must contain #MESSAGE#, #POSTFIX# and #LEVEL#.',
    p_par_string_value => q'^#LEVEL#> #MESSAGE##POSTFIX#^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log level of the output module PIT_CONSOLE',
    p_par_integer_value => 70
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEAVE_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template for formatting LEAVE outputs. Must contain #MESSAGE#, #POSTFIX#, #TIMING# and #LEVEL#.'
   ,p_par_string_value => q'^#LEVEL#< #MESSAGE##POSTFIX##TIMING#^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEVEL_INDICATOR'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'String used for the level of the call stack.'
   ,p_par_string_value => q'^..^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_MSG_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template for formatting console output. Must contain #MESSAGE#.'
   ,p_par_string_value => q'^--> #MESSAGE#^'
  );
  
  commit;
end;
/


