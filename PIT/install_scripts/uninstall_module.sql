/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - REMOTE_USER:  database user who shall be enabled to use PIT
  - MODULE_NAME: Name of the module to install. Must match one of the folder names in /modules/
*/

@init/init_module.sql &1. &2. &3.
define module_dir=modules/&MODULE./

prompt &section.Uninstalling PIT Client &REMOTE_USER.

prompt
prompt &section.
prompt &h1.Uninstalling PIT module &MODULE.
@&module_dir.clean_up_client.sql

prompt
prompt &h1.PIT module &MODULE. successfully deinstalled

exit;
