begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_DAILY_LEVEL'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Severity level up to which mail notifications are sent daily'
   ,p_par_integer_value => 30
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_LIVE_LEVEL'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Severity level up to which mail notifications are sent immediately'
   ,p_par_integer_value => 20
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_FIRE_THRESHOLD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Log level of the module PIT_MAIL'
   ,p_par_integer_value => 30
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_FROM_ADDRESS'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Sender of the module PIT_MAIL'
   ,p_par_string_value => q'^administration@foo.de^'
   ,p_par_pat_id => 'STRING'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_PURGE_PERIOD'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Number of days to be kept as log duration in the queue table'
   ,p_par_integer_value => 7
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_SUBJECT'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Mail subject of the module PIT_MAIL'
   ,p_par_string_value => q'^Automatic error report^'
   ,p_par_pat_id => 'STRING'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_TO_ADDRESS'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Addressee of the module PIT_MAIL'
   ,p_par_string_value => q'^notification@some_server.de^'
   ,p_par_pat_id => 'STRING'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_MAIL_FILE_NAME'
   ,p_par_pgr_id => 'PIT'
   ,p_par_description => 'Name of the attachment file with the error list'
   ,p_par_string_value => q'^ErrorReport.html^'
   ,p_par_pat_id => 'STRING'
  );
  
  commit;
end;
/

