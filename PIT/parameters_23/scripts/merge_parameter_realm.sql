begin

  param_admin.edit_parameter_realm(
    p_pre_id => 'DEV',
    p_pre_description => 'Development environment',
    p_pre_is_active => true
  );

  param_admin.edit_parameter_realm(
    p_pre_id => 'TEST',
    p_pre_description => 'Test environment',
    p_pre_is_active => true
  );

  param_admin.edit_parameter_realm(
    p_pre_id => 'PRE',
    p_pre_description => 'Pre production environment',
    p_pre_is_active => true
  );

  param_admin.edit_parameter_realm(
    p_pre_id => 'PROD',
    p_pre_description => 'Production envioronment',
    p_pre_is_active => true
  );
  
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );
  
  param_admin.edit_parameter(
    p_par_id => 'REALM',
    p_par_pgr_id => 'PIT',
    p_par_string_value => 'DEV',
    p_par_description => 'Global Parameter to define the actual realm'
  );

  commit;
end;
/
