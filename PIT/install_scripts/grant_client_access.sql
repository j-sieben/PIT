/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameter:
  - REMOTE_USER:  database user who will be enabled to use PIT
*/
@init/init_client.sql &1

prompt Connected &PIT_USER.

prompt
prompt &section.
prompt &h1.Grant access to PIT to client &REMOTE_USER.

prompt
prompt &h2.Grant access to PARAM installation
@parameters/grant_client.sql

prompt
prompt &h2.Grant access to PIT core installation
@core/grant_client.sql

prompt
prompt &section.
prompt &h1.Grant access to PIT output modules
@modules/pit_console/grant_client.sql
@modules/pit_table/grant_client.sql
@modules/pit_apex/grant_client.sql
--@modules/pit_test/grant_client.sql
@modules/pit_file/grant_client.sql
--@modules/pit_mail/grant_client.sql

prompt &h1.Finished PIT client grants

exit
