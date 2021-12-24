/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  None
*/

@init/init_client.sql

prompt &section.
prompt &h1.Revoking PIT client grants from &REMOTE_USER.

prompt
prompt &h2.Revoking grants on PIT output modules
@modules/pit_console/revoke_client.sql
@modules/pit_table/revoke_client.sql
@modules/pit_apex/revoke_client.sql
--@modules/pit_test/revoke_client.sql
@modules/pit_file/revoke_client.sql
@modules/pit_mail/revoke_client.sql

prompt
prompt &h2.Revoking grants on PIT objects
@core/revoke_client.sql

prompt
prompt &h2.Revoking grants on PARAM objects
@parameters/revoke_client.sql

prompt
prompt &h1.PIT client grants successfully revoked

exit;
