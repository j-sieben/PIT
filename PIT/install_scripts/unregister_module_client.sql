/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - REMOTE_USER:  database user who shall be enabled to use PIT
  - MODULE:  Module to revoke access from
*/

@init/init_module_client.sql &1. &2.
define module_dir=modules/&MODULE./

prompt &section.Revoking access of PIT module &MODUEL. from client &REMOTE_USER.
@&module_dir.unregister_client.sql

prompt
prompt &h1.Grant to PIT module &MODULE. from client successfully unregistered

exit;
