
prompt
prompt &section.
prompt &h1.Grant access to PIT to client &REMOTE_USER.
prompt &section.
prompt
prompt &h2.Check prerequisites and initialize settings
@init/init_client.sql &1. &2.

prompt &h2.Install additional packages required for APEX application

prompt &s1.Package PIT_APP_API
@core/packages/pit_app_api.pks
@core/packages/pit_app_api.pkb

prompt
prompt &h2.Grant access to PIT to APEX client &REMOTE_USER.

@tools/grant_access.sql execute pit_app_api

prompt
prompt &section.
prompt &h1.Finished PIT APEX grants
prompt &section.

exit