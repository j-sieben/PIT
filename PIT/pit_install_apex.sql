/*
  Script to install PIT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Prerequisites:
  -- PIT must be accessible by the schema you install APEX into. Either becase it is directly installed into that schema
     or because you ran PIT_INSTALL_CLIENT.SQL to grant access to the target schema.
  -- UTL_APEX must be installed. As this installation needs access to PIT as well, requirement 1 is satisfied
  
  Parameters:
  -- 1: APP_USER: database user who owns PIT_UI (Schema of the APEX-Workspace you install into)
  -- 2: APEX workspace name, into which the APEX application will be installed. Needs access to Owner of PIT
  -- 3: ALIAS of the APEX-application. 
  -- 4: APP_ID of the APEX-application.
  -- 5: Default language of the messages
*/

@init/init_apex.sql &1. &2. &3. &4. &5.

prompt &h1.Set installation grants
@set_apex_grants.sql

prompt
prompt &section.
prompt &h1.Installing APEX application
-- Make sure all necessary grants to access PIT as a client are existing
-- (More grants will be created later)
@core/install_client.sql
@core/parameters/install_client.sql

@apex/install.sql

-- After installation of APEX application restore view settings for SQL*Plus
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