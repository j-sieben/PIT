begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );
  
  param_admin.edit_parameter(
    p_par_id => 'PIT_TABLE_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT', 
    p_par_description => 'Loglevel für das Modul PIT_TABLE',
    p_par_integer_value => 70);
  commit;
end;
/

