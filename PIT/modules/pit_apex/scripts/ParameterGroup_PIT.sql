begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'ADAPTER_PREFERENCE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Order in which PIT tries to use adapter preferences (left ot right)'
   ,p_par_string_value => q'^PIT_APEX_ADAPTER:PIT_DEFAULT_ADAPTER^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_APEX'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Log context for PIT_APEX that switches on according to the sessions debug settings [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]'   ,p_par_string_value => q'^70|50|Y|PIT_APEX:PIT_CONSOLE^'   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel des Module PIT_APEX'   ,p_par_integer_value => 70   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'   ,p_par_integer_value => 70   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_LOG_MODULES'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Zu verwendende Logmodule, falls DEBUG von APEX angefordert wurde'   ,p_par_string_value => q'^PIT_APEX^'   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Tracelevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'   ,p_par_integer_value => 70   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_TIMING'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Soll Timing berechnet werden, falls DEBUG von APEX angefordert wurde'   ,p_par_boolean_value => true   ,p_par_is_modifiable => null
  );

  commit;
end;
/
