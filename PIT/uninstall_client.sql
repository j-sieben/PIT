prompt &section.Uninstalling PIT Client &REMOTE_USER.

prompt &h1.Revoking Grants to &REMOTE_USER.
alter session set current_schema=&INSTALL_USER.;
@core/revoke_client_grants.sql

prompt
prompt &h1.Uninstalling PIT objects in schema &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;
@core/remove_client.sql

prompt
prompt &h1.PIT client successfully deinstalled

exit;
