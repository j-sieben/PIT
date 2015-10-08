
begin
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_TEST_FIRE_THRESHOLD',
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Loglevel für das Modul PIT_TABLE',
    p_integer_value => 70);

  commit;
end;
/

