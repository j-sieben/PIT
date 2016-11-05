begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'CONTEXT', 
    p_pgr_description => 'Parameter zur Kontextverwaltung',
    p_pgr_is_modifiable => true);
end;
/
