/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  None
*/

@init/init_client.sql

prompt &section.
prompt &h1.Uninstalling PIT Client &REMOTE_USER.

prompt
prompt &h2.Uninstalling PIT output modules
@modules/pit_console/unregister_client.sql
@modules/pit_table/unregister_client.sql
@modules/pit_apex/unregister_client.sql
--@modules/pit_test/unregister_client.sql
@modules/pit_file/unregister_client.sql
@modules/pit_mail/unregister_client.sql

prompt
prompt &h2.Uninstalling PIT objects in schema &REMOTE_USER.
@core/unregister_client.sql

prompt
prompt &h2.Uninstalling PARAM objects in schema &REMOTE_USER.
@parameters/unregister_client.sql

prompt
prompt &h1.PIT client successfully unregistered

exit;
