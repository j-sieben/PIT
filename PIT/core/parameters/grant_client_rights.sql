prompt &s1.Grant execute on PARAM to &REMOTE_USER.
grant execute on &INSTALL_USER..param to &REMOTE_USER.;
prompt &s1.Grant execute on PARAM_ADMIN to &REMOTE_USER.
grant execute on &INSTALL_USER..param_admin to &REMOTE_USER.;

prompt &s1.Grant select and references rights on parameter tables to &REMOTE_USER.
grant select on &INSTALL_USER..parameter_tab to &REMOTE_USER.;
grant select on &INSTALL_USER..parameter_group to &REMOTE_USER.;
grant references on &INSTALL_USER..parameter_group to &REMOTE_USER.;
grant select on &INSTALL_USER..parameter_type to &REMOTE_USER.;
grant references on &INSTALL_USER..parameter_type to &REMOTE_USER.;

