/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameter:
  - REMOTE_USER:  database user who will be enabled to use PIT
*/


prompt
prompt &section.
prompt create APEX synonyms
@core/register_client.sql

prompt &h1.Finished PIT apex registration
