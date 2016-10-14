
begin
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_MAIL_FIRE_THRESHOLD', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Loglevel des Moduls PIT_MAIL',
    p_integer_value => 70);
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_MAIL_TEMPLATE', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Email-Template des Moduls PIT_MAIL',
    p_string_value => 'PIT_MAIL_DIR');
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_MAIL_HOST', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Host-Adresse des Moduls PIT_MAIL',
    p_string_value => 'PIT_MAIL_DIR');
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_MAIL_FROM_ADDRESS', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Absender des Moduls PIT_MAIL',
    p_string_value => 'pit_MAIL.trc');
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_MAIL_TO_ADDRESS', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Adressat des Moduls PIT_MAIL',
    p_string_value => 'pit_MAIL.trc');
  param_admin.edit_parameter(
    p_parameter_id => 'PIT_MAIL_SUBJECT', 
    p_parameter_group_id => 'PIT', 
    p_parameter_description => 'Thema der Mail des Moduls PIT_MAIL',
    p_string_value => 'pit_MAIL.trc');
  
  pit_admin.merge_message(
    p_message_name => 'PIT_MAIL_ERROR',
    p_message_text => 'Error sending a mail: #1#, #2#',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => null);
  pit_admin.merge_message(
    p_message_name => 'PIT_MAIL_ERROR',
    p_message_text => 'Fehler beim Versenden einer Email: #1#, #2#',
    p_severity => 30,
    p_message_language => 'GERMAN',
    p_error_number => null);
  pit_admin.create_message_package;

  commit;
end;
/

