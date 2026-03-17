/*
  Script to install a PIT module client
  Usage:
  Grants must be executed in the PIT owner schema and registration
  must be executed in the client schema. Use the shell script
  install_module_client.sh for the complete workflow.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - REMOTE_USER:  database user who shall be enabled to use PIT
  - MODULE:  Module to grant access to
*/

prompt
prompt &section.
prompt &h1.Use install_scripts/grant_module_access.sql and
prompt &h1.install_scripts/register_module_client.sql instead.
prompt &s1.For interactive execution use install_module_client.sh.

exit
