/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  -- 1: PIT_OWNER: database user who own PIT
  -- 2: APP_USER: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
  -- 3: APEX workspace name, into which the APEX application will be installed. Needs access to Owner of PIT
  -- 4: ALIAS of the APEX-application. 
*/

@init/init_apex_uninstall.sql &1. &2. &3. &4.

prompt
prompt &h1.Uninstalling PIT objects in schema &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;
@apex/clean_up_install.sql

prompt
prompt &section.
prompt &h1.Unnstalling PIT output modules
@modules/pit_console/clean_up_client.sql
@modules/pit_table/clean_up_client.sql
@modules/pit_apex/clean_up_client.sql
--@modules/pit_test/clean_up_client.sql
@modules/pit_file/clean_up_client.sql
@modules/pit_mail/clean_up_client.sql

@core/parameters/clean_up_client.sql
@core/clean_up_client.sql

prompt
prompt &h1.PIT APEX application successfully deinstalled

exit;
