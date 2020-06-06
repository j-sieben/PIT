begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Loglevel des Moduls PIT_MAIL'
   ,p_par_integer_value => 70
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_FROM_ADDRESS'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Absender des Moduls PIT_MAIL'
   ,p_par_string_value => q'^pit_MAIL.trc^'
   ,p_par_boolean_value => null
   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_HOST'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Host-Adresse des Moduls PIT_MAIL'   ,p_par_string_value => q'^PIT_MAIL_DIR^'   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_SUBJECT'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Thema der Mail des Moduls PIT_MAIL'   ,p_par_string_value => q'^pit_MAIL.trc^'   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_TEMPLATE'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Email-Template des Moduls PIT_MAIL'   ,p_par_string_value => q'^PIT_MAIL_DIR^'   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_TO_ADDRESS'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Adressat des Moduls PIT_MAIL'   ,p_par_string_value => q'^pit_MAIL.trc^'   ,p_par_boolean_value => null   ,p_par_is_modifiable => null
  );

  commit;
end;
/

