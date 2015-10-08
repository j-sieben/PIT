prompt &s1.Grant select and references rights on parameter tables to &REMOTE_USER.
grant select on parameter_tab to &REMOTE_USER.;
grant select on parameter_group to &REMOTE_USER.;
grant references on parameter_group to &REMOTE_USER.;
grant select on parameter_type to &REMOTE_USER.;
grant references on parameter_type to &REMOTE_USER.;

