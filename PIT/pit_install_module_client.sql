/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - REMOTE_USER:  database user who shall be enabled to use PIT
  - MODULE:  Module to grant access to
*/

@init/init_module_client.sql &1. &2. &3.
define module_dir=modules/&MODULE./

prompt
prompt &section.
prompt &h1.Granting acces to PIT module &MODULE. for client &REMOTE_USER.
prompt
prompt &section.
prompt &h1.Checking whether required users exist
@tools/check_users_exist.sql

@set_client_grants.sql

alter session set current_schema=&INSTALL_USER.;

prompt
prompt &h2.Grant access to PIT module installation
@&module_dir.install_client.sql

prompt &h1.Finished PIT-Grant for module &MODULE. to &REMOTE_USER.

exit
