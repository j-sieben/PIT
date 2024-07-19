begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'PIT',
    p_pgr_description => 'Parameter for PIT',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'ADAPTER_PREFERENCE',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Order in which PIT tries to use adapter preferences (left ot right)',
    p_par_string_value => q'^PIT_APEX_ADAPTER:PIT_DEFAULT_ADAPTER^'
  );

  param_admin.edit_parameter(
    p_par_id => 'CONTEXT_APEX',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log context for PIT_APEX if wstiched on by APEX debug settings [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]',
    p_par_string_value => '70|50|' || replace(to_char(&C_TRUE.), '''') || '|PIT_APEX:PIT_CONSOLE'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Loglevel of output module PIT_APEX',
    p_par_integer_value => 70,
    p_par_validation_string => '#INTEGER# in (10,20,30,40,50,60,70)',
    p_par_validation_message => 'Allowed values: 10,20,30,40,50,60,70'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_FIRE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log level of output module PIT_APEX, if DEBUG was requested by APEX.',
    p_par_integer_value => 70,
    p_par_validation_string => '#INTEGER# in (10,20,30,40,50,60,70)',
    p_par_validation_message => 'Allowed values: 10,20,30,40,50,60,70'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_LOG_MODULES',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Log modules to be used if DEBUG has been requested by APEX',
    p_par_string_value => q'^PIT_APEX^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_THRESHOLD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Trace level of the module PIT_APEX, if DEBUG was requested by APEX.',
    p_par_integer_value => 50,
    p_par_validation_string => '#INTEGER# in (10,20,30,40,50)',
    p_par_validation_message => 'Allowed values: 10,20,30,40,50'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_TRG_TRACE_TIMING',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Should timing be calculated if DEBUG was requested by APEX',
    p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_WS_URL',
    p_par_pgr_id => 'PIT',
    p_par_description => 'URL of the WebSocket server used by the notify procedure',
    p_par_string_value => 'http://0.0.0.0:8000/notify'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_WS_USER_NAME',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Username of the websocket server account, used by the notify procedure. NULL if no authentication required',
    p_par_string_value => 'PIT_APEX'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_WS_USER_PWD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Password of the websocket server account, used by the notify procedure. NULL if no authentication required',
    p_par_string_value => 'PIT_APEX_PWD'
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_WS_WALLET_PATH',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Path to the wallet, if websocket over https is used. Leave NULL if http is used',
    p_par_string_value => ''
  );

  param_admin.edit_parameter(
    p_par_id => 'PIT_APEX_WS_WALLET_PWD',
    p_par_pgr_id => 'PIT',
    p_par_description => 'Password to the wallet, if websocket over https is used. NULL if http is used',
    p_par_string_value => ''
  );

  commit;
end;
/
