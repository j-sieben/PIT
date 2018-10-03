/*
  Script to uninstall PIT
  
  Parameters:
  -- 1: PIT_OWNER: database user who own PIT
  -- 2: DEFAULT LANGUAGE: Default language of the APEX messages
*/

@init/init.sql &1. &2.

prompt &h2.grant user rights
@set_grants.sql

alter session set current_schema=&INSTALL_USER.;

prompt &section.

prompt &h1.PL/SQL INSTRUMENTATION TOOLKIT (PIT) Deinstallation

prompt &h1.Deinstall OUTPUT-MODULES
prompt &h2.Module PIT_CONSOLE
@modules/pit_console/clean_up_install.sql
prompt &h2.Module PIT_TABLE
@modules/pit_table/clean_up_install.sql
prompt &h2.Module PIT_APEX
@modules/pit_apex/clean_up_install.sql
prompt &h2.Module PIT_FILE
@modules/pit_file/clean_up_install.sql
prompt &h2.Module PIT_MAIL
@modules/pit_mail/clean_up_install.sql
prompt &h2.Module PIT_TEST
@modules/pit_test/clean_up_install.sql

prompt &h1.Deinstall CORE Functionality
@core/clean_up_install.sql

prompt &h1.Deinstall CONTEXT Framework
@core/context/clean_up.sql

prompt &h1.Deinstall PARAMETER Framework
@core/parameters/clean_up_install.sql

prompt &h2.Revoke user rights
@revoke_grants.sql

prompt &h1.Finished PIT De-Installation

exit