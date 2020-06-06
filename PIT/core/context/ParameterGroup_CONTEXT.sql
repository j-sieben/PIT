begin

  param_admin.edit_parameter_group(
    p_pgr_id => 'CONTEXT',
    p_pgr_description => 'Parameter zur Kontextverwaltung',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CTX_TYPE'
   ,p_par_pgr_id => 'CONTEXT'
   ,p_par_description => 'Type of the globally accessed PIT context (SESSION|PREFER_USER_CLIENT_ID etc.)'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_CTX_UTILS_TYPE'
   ,p_par_pgr_id => 'CONTEXT'
   ,p_par_description => 'Type of the globally accessed PIT context (SESSION|PREFER_USER_CLIENT_ID etc.)'
  );

  commit;
end;
/