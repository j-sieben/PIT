begin
  param_admin.edit_parameter_group(
    p_parameter_group_id => 'PIT',
    p_group_description => 'Parameter for PIT',
    p_is_modifiable => 'Y'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_FIRE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Loglevel des Module PIT_APEX'
   ,p_integer_value => 30
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_FIRE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Loglevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'
   ,p_integer_value => 70
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_TRACE_THRESHOLD'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Tracelevel des Module PIT_APEX, falls DEBUG von APEX angefordert wurde'
   ,p_integer_value => 70
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_TRACE_TIMING'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Soll Timing berechnet werden, falls DEBUG von APEX angefordert wurde'
   ,p_boolean_value => 'Y'
  );

  param_admin.edit_parameter(
    p_parameter_id => 'PIT_APEX_TRG_LOG_MODULES'
   ,p_parameter_group_id => 'PIT'
   ,p_parameter_description => 'Zu verwendende Logmodule, falls DEBUG von APEX angefordert wurde'
   ,p_string_value => 'PIT_APEX'
  );

  commit;
end;
/
