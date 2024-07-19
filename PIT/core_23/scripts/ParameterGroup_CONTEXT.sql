begin

  param_admin.edit_parameter_group(
    p_pgr_id => 'CONTEXT',
    p_pgr_description => 'Parameter zur Kontextverwaltung',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CTX_TYPE',
    p_par_pgr_id => 'CONTEXT',
    p_par_description => 'Type of the globally accessed PIT context (SESSION|PREFER_USER_CLIENT_ID etc.)',
    p_par_string_value => q'^PREFER_CLIENT_ID^',
    p_par_boolean_value => null,
    p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CTX_' || user || '_TYPE',
    p_par_pgr_id => 'CONTEXT',
    p_par_description => 'Type of the globally accessed PIT context (SESSION|PREFER_USER_CLIENT_ID etc.)',
    p_par_string_value => q'^PREFER_CLIENT_ID^',
    p_par_boolean_value => null,
    p_par_is_modifiable => null
  );

  commit;
end;
/
