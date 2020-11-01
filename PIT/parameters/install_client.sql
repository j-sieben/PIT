define param_dir=core/parameters/

prompt
prompt &h2.Granting access to parameter package to &REMOTE_USER.

prompt &h3.Clean up schema &REMOTE_USER.
@&param_dir.clean_up_client.sql

prompt &h3.Grant access rights to &REMOTE_USER.
@&param_dir.grant_client_rights.sql

prompt &h3.Change current schema to &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;

prompt &h3.Create PIT user tables and views
prompt &s1.Create table PARAMETER_LOCAL
@&param_dir.tables/parameter_local.tbl

prompt &s1.Create view PARAMETER_VW
@&param_dir.views/parameter_vw.vw

prompt &h3.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;
