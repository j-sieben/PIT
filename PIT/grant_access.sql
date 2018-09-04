
prompt &s1.Granting &1. on &2. to &REMOTE_USER.
grant &1. on &INSTALL_USER..&2. to &REMOTE_USER.;

alter session set current_schema=&REMOTE_USER.;

prompt &s1.Create synonym &2. for &INSTALL_USER..&2. at &REMOTE_USER.
create synonym &2. for &INSTALL_USER..&2.;

alter session set current_schema=&INSTALL_USER.;