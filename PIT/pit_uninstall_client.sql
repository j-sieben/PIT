/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - REMOTE_USER:  database user who shall be enabled to use PIT
*/

@init_client.sql &1. &2.

prompt &section.Uninstalling PIT Client &REMOTE_USER.

prompt &h1.Revoking Grants to &REMOTE_USER.
alter session set current_schema=&INSTALL_USER.;
@core/revoke_client_rights.sql

prompt
prompt &h1.Uninstalling PIT objects in schema &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;
@core/clean_up_client.sql

prompt
prompt &h1.Uninstalling PARAM objects in schema &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;
@core/parameters/clean_up_client.sql

prompt
prompt &h1.PIT client successfully deinstalled

exit;
