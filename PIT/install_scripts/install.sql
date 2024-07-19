/*
  Script to install PIT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameter:
  - DEFAULT_LANGUAGE: Oracle language name of the default language for all messages.
*/

clear screen
@init/init.sql &1.

define install_script_dir=install_scripts/
define tool_dir=tools/
define init_dir=init/

prompt
prompt &section.
prompt &h1.PL/SQL INSTRUMENTATION TOOLKIT (PIT) Installation

prompt &section.
prompt &h1.Checking required system privileges
@&install_script_dir.check_prerequisites.sql

prompt &s1.Set Compiler-Flag for APEX installation to FALSE
alter session set plsql_ccflags = 'pit_installed:FALSE';
@&tool_dir.set_compiler_flags.sql

prompt
prompt &section.
prompt &h1.Installing parameter framework
@parameters&FOLDER_EXTENSION./install.sql

prompt &section.
prompt &h1.Installing context framework
@&install_script_dir.check_context_prerequisites.sql

prompt &section.
prompt &h1.Installing core functionality
@core&FOLDER_EXTENSION./install.sql

prompt &s1.Set Compiler-Flag for APEX installation to TRUE
alter session set PLSQL_CCFLAGS = 'pit_installed:TRUE';

prompt
prompt &section.
prompt &h1.Installing PIT output modules
@modules/pit_console/install.sql
@modules/pit_table/install.sql
@&tools.check_has_apex modules/pit_apex/install.sql
@modules/pit_file&FOLDER_EXTENSION./install.sql
-- PIT_MAIL may be installed after installing UTL_TEXT
-- Please use this script with the given information
--@pit_install_module pit_mail

prompt
prompt &section.
prompt &h1.Finished PIT-Installation

exit