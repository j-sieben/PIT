/*
  Script to install PIT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - DEFAULT_LANGUAGE: Oracle language name of the default language for all messages.
  - MODULE_NAME: Name of the module to install. Must match one of the folder names in /modules/
*/

@init/init_module.sql &1. &2. &3.

define module_dir = modules/&MODULE./

alter session set current_schema=sys;

prompt
prompt &section.
prompt &h1.PL/SQL INSTRUMENTATION TOOLKIT (PIT) output module installation at user &PIT_USER.

prompt
prompt &section.
prompt &h1.Checking whether required users exist
@tools/check_users_exist.sql &PIT_USER.

prompt &h2.grant user rights
@set_grants.sql

alter session set current_schema=&PIT_USER.;
prompt &s1.Set Compiler-Flags
alter session set plsql_ccflags = 'development:&INSTALL_ON_DEV., pit_installed:FALSE';
alter session set plsql_optimize_level = 3;
alter session set plsql_code_type='NATIVE';
alter session set plscope_settings='IDENTIFIERS:ALL';

prompt
prompt &section.
prompt &h1.Installing module &MODULE.
@&module_dir./install.sql


prompt
prompt &section.
prompt &h1.Finished installation of PIT module &MODULE.

exit