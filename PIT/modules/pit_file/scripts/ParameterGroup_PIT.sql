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
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_ENTER_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template zur Formatierung von ENTER-Ausgaben. Muss #MESSAGE# und #LEVEL# enthalten.'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_FILE_NAME'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Dateiname des Moduls PIT_FILE'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel des Moduls PIT_FILE'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_LEAVE_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template zur Formatierung von LEAVE-Ausgaben. Muss #MESSAGE#, #TIMING# und #LEVEL# enthalten.'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_LEVEL_INDICATOR'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Zeichenfolge, die für den Level des Aufrufstacks verwendet wird.'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_FILE_MSG_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Template zur Formatierung von Datei-Ausgaben. Muss #MESSAGE# enthalten.'
  );
     
  commit;
end;
/

