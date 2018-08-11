/*
  Script to install PIT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameters:
  - INSTALL_USER: database schema that owns PIT
  - APP_USER: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
  - DEFAULT_LANGUAGE: Oracle language name of the default language for all messages.
  - APEX_WORKSPACE: Name of the APEX workspace INSTALL_USER has granted all rights to admin PIT to
*/

@init_apex.sql &1. &2. &3. &4.

prompt &h1.Set installation grants
@set_apex_grants.sql

prompt
prompt &section.
prompt &h1.Installing APEX application
@apex/install.sql

set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit

prompt
prompt &section.
prompt &h1.Finalize installation

prompt &h2.Revoke user rights
@revoke_grants.sql

prompt &h1.Finished PIT-Installation

exit