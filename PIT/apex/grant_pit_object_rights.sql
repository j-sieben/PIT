
grant select on &INSTALL_USER..parameter_group to &APP_USER.;
grant select on &INSTALL_USER..parameter_tab to &APP_USER.;
grant select on &INSTALL_USER..parameter_type to &APP_USER.;

grant select on &INSTALL_USER..pit_message to &APP_USER.;
grant select on &INSTALL_USER..pit_message_language to &APP_USER.;
grant select on &INSTALL_USER..pit_message_severity to &APP_USER.;
grant select on &INSTALL_USER..pit_trace_level to &APP_USER.;

grant execute on &INSTALL_USER..pit_admin to &APP_USER.;
create or replace synonym pit_admin for &INSTALL_USER..pit_admin;

grant execute on &INSTALL_USER..param_admin to &APP_USER.;
create or replace synonym param_admin for &INSTALL_USER..param_admin;
