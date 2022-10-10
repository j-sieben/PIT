/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameter:
  - REMOTE_USER:  database user who will be enabled to use PIT
*/


prompt
prompt &section.
prompt &h1.Registering PIT, found at &PIT_USER. at APEX client &REMOTE_USER.

@parameters/register_client.sql

@apex/register_client.sql

prompt
prompt &section.
prompt &h1.Registering PIT output modules
@modules/pit_console/register_client.sql
@modules/pit_table/register_client.sql
@modules/pit_apex/register_client.sql
--@modules/pit_test/register_client.sql
@modules/pit_file/register_client.sql
--@modules/pit_mail/register_client.sql

prompt &h1.Finished PIT client registration
