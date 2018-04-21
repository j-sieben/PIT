
revoke select on &INSTALL_USER..parameter_group from &APP_USER.;
revoke select on &INSTALL_USER..parameter_tab from &APP_USER.;
revoke select on &INSTALL_USER..parameter_type from &APP_USER.;

revoke select on &INSTALL_USER..pit_message from &APP_USER.;
revoke select on &INSTALL_USER..pit_message_language from &APP_USER.;
revoke select on &INSTALL_USER..pit_message_severity from &APP_USER.;
revoke select on &INSTALL_USER..pit_trace_level from &APP_USER.;

revoke execute on &INSTALL_USER..pit_admin from &APP_USER.;
revoke execute on &INSTALL_USER..param_admin from &APP_USER.;
