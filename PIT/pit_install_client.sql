/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database user who owns PIT
  - REMOTE_USER:  database user who shall be enabled to use PIT
*/

@init_client.sql &1. &2.

@set_client_grants.sql

@install_client.sql

prompt &h1.Finished PIT-Installation

exit
