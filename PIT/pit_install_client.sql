/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - REMOTE_USER:  database user who shall be enabled to use PIT
*/

@init/init_client.sql &1. &2.

prompt
prompt &section.
prompt &h1.Installing PIT client &REMOTE_USER.

@set_client_grants.sql

prompt
prompt &section.
prompt &h1.Checking whether required users exist
@tools.check_users_exist.sql

alter session set current_schema=&INSTALL_USER.;

prompt
prompt &h2.Grant access to PARAM installation
@core/parameters/install_client.sql

prompt
prompt &h2.Grant access to PIT core installation
@core/install_client.sql

prompt
prompt &section.
prompt &h1.Installing PIT output modules
@modules/pit_console/install_client.sql
@modules/pit_table/install_client.sql
@modules/pit_apex/install_client.sql
--@modules/pit_test/install_client.sql
@modules/pit_file/install_client.sql
@modules/pit_mail/install_client.sql


prompt
prompt &h2.Grant access to PIT modules
prompt &s1.Output module PIT_TABLE
@modules/pit_table/install_client.sql

prompt &h1.Finished PIT-Installation

exit
