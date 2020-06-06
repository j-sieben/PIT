
begin 
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_ENTER_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE#, #POSTFIX# und #LEVEL# enthalten.'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel des Moduls PIT_CONSOLE'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEAVE_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #POSTFIX#, #TIMING# und #LEVEL# enthalten.'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_LEVEL_INDICATOR'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CONSOLE_MSG_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template zur Formatierung von Konsole-Ausgaben. Muss #MESSAGE# enthalten.'
  );
  
  commit;
end;
/

