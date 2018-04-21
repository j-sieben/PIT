/*
  Script to install PIT-APEX Application
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database schema that owns PIT
  - APP_USER: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
  - DEFAULT_LANGUAGE: Oracle language name of the default language for all messages.
  - APEX_WORKSPACE: Name of the APEX workspace INSTALL_USER has granted all rights to admin PIT to
*/

@init_apex.sql &1. &2. &3. &4.

prompt &section.Uninstalling PIT APEX Application

prompt
prompt &h1.Uninstalling PIT objects in schema &APP_USER.
alter session set current_schema=&APP_USER.;
@apex/clean_up_apex.sql

prompt
prompt &h1.PIT APEX application successfully deinstalled

exit;
