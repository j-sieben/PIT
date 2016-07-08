prompt &s1.Grant select and references rights on parameter tables to &REMOTE_USER.
grant select on &INSTALL_USER..parameter_tab to &REMOTE_USER.;
grant select on &INSTALL_USER..parameter_group to &REMOTE_USER.;
grant references on &INSTALL_USER..parameter_group to &REMOTE_USER.;
grant select on &INSTALL_USER..parameter_type to &REMOTE_USER.;
grant references on &INSTALL_USER..parameter_type to &REMOTE_USER.;

