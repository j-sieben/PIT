begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel des Module PIT_APEX'
   ,p_par_integer_value => 30
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'
   ,p_par_integer_value => 70
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Tracelevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'
   ,p_par_integer_value => 70
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_TIMING'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Soll Timing berechnet werden, falls DEBUG von APEX angefordert wurde'
   ,p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_LOG_MODULES'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Zu verwendende Logmodule, falls DEBUG von APEX angefordert wurde'
   ,p_par_string_value => 'PIT_APEX'
  );

  commit;
end;
/
