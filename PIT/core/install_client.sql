define core_dir=core/


prompt
prompt &h2.Granting access to PIT to &REMOTE_USER.

prompt &h3.Clean up schema &REMOTE_USER.
@&core_dir.clean_up_client.sql

@grant_access.sql execute PIT
@grant_access.sql execute PIT_ADMIN
@grant_access.sql execute MSG
@grant_access.sql execute MSG_ARGS
@grant_access.sql execute MSG_PARAM
@grant_access.sql execute MSG_PARAMS
