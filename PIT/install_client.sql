alter session set current_schema=sys;
prompt
prompt &section.
prompt &h1.Checking whether required users exist
@check_users_exist.sql

alter session set current_schema=&INSTALL_USER.;

prompt
prompt &section.
prompt &h1.Installing PIT client &REMOTE_USER.
prompt &h2.Grant user rights
@set_client_grants.sql
prompt
prompt &h2.Grant access to PARAM installation
@core/parameters/install_client.sql
prompt
prompt &h2.Grant access to PIT core installation
@core/install_client.sql
prompt
prompt &h2.Grant access to PIT modules
prompt &s1.Output module PIT_TABLE
@modules/pit_table/install_client.sql
