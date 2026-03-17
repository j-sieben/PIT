/*
  Script to uninstall a PIT module from the PIT owner schema
  Usage:
  Call this script directly or by using a shell script wrapper.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - LANGUAGE: Oracle language name used for prompts
  - MODULE_NAME: Name of the module to uninstall. Must match one of the folder names in /modules/
*/

@init/init_module.sql &1. &2. &3.
define module_dir=modules/&MODULE./

prompt
prompt &section.
prompt &h1.Uninstalling PIT module &MODULE.
alter session set current_schema=&INSTALL_USER.;
@&module_dir.clean_up_install.sql

prompt
prompt &h1.PIT module &MODULE. successfully deinstalled

exit;
