/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameter:
  - PIT_USER: Owner of PIT
  - REMOTE_USER:  database user who will be enabled to use PIT
*/
@init/init_client.sql &1. &2.

prompt Connected &PIT_USER., granting access to &REMOTE_USER.

prompt
prompt &section.
prompt &h1.Install additional packages required for APEX application

prompt &s1.Package PIT_APP_API
@core/packages/pit_app_api.pks
@core/packages/pit_app_api.pkb

prompt
prompt &section.
prompt &h1.Grant access to PIT to APEX client &REMOTE_USER.

@parameters/grant_client.sql

@apex/grant_client.sql

prompt
prompt &section.
prompt &h1.Grant access to PIT output modules
@modules/pit_console/grant_client.sql
@modules/pit_table/grant_client.sql
@modules/pit_apex/grant_client.sql
--@modules/pit_test/grant_client.sql
@modules/pit_file/grant_client.sql
--@modules/pit_mail/grant_client.sql

prompt &h1.Finished PIT APEX grants

exit