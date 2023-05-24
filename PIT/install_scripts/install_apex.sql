/*
  Script to install PIT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Prerequisites:
  -- PIT must be accessible by the schema you install APEX into. Either becase it is directly installed into that schema
     or because you ran PIT_INSTALL_CLIENT.SQL to grant access to the target schema.
  -- UTL_TEXT must be accessible by the schema you install APEX into. Either becase it is directly installed into that schema
     or because you ran PIT_INSTALL_CLIENT.SQL to grant access to the target schema.
  -- UTL_APEX must be installed. As this installation needs access to PIT as well, requirement 1 is satisfied
  
  Parameters:
  -- 1: Owner of PIT
  -- 2. APEX schema
  -- 3: APEX workspace name, into which the APEX application will be installed. Needs access to Owner of PIT
  -- 4: APP_ID of the APEX-application.
*/

@init/init_apex.sql &1. &2. &3. &4.
@init/settings.sql

prompt &h1.Checking installation prerequisites
@install_scripts/check_apex_prerequisites.sql

prompt
prompt &h1.Registering granted objects
@install_scripts/create_apex_synonyms.sql

prompt
prompt &section.
prompt &h1.Installing APEX application

@apex/install.sql

-- After installation of APEX application restore view settings for SQL*Plus
set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit

prompt &h1.Finished PIT-Installation

exit