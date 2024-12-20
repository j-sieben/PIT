
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