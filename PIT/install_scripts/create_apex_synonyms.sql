/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameter:
  - REMOTE_USER:  database user who will be enabled to use PIT
*/


prompt
prompt &section.
prompt &h1.Registering PIT_APP_API, found at &PIT_USER. at APEX client &REMOTE_USER.

@parameters/register_apex.sql

prompt &h1.Finished PIT apex registration
