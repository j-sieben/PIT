
@init/init_client.sql &1. &2.

prompt
prompt &section.
prompt &h1.Grant access to PIT to client &REMOTE_USER.
prompt &section.
prompt
prompt &h2.Check prerequisites and initialize settings
prompt
prompt &h2.Grant access to PARAM installation
@parameters/grant_client.sql

prompt
prompt &h2.Grant access to PIT core installation
@core/grant_client.sql

prompt
prompt &h2.Grant access to PIT output modules
@modules/pit_console/grant_client.sql
@modules/pit_table/grant_client.sql
@modules/pit_apex/grant_client.sql
--@modules/pit_test/grant_client.sql
@modules/pit_file/grant_client.sql
--@modules/pit_mail/grant_client.sql

prompt
prompt &section.
prompt &h1.Finished PIT client grants
prompt &section.

exit
