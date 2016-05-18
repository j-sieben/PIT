set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen

define INSTALL_USER = &1.;
define REMOTE_USER = &2.;
define INSTALL_ON_DEV = true

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

alter session set current_schema=sys;
prompt
prompt &section.
prompt &h1.Checking whether required users exist
@check_users_exist.sql

prompt &h2.grant user rights
@set_grants.sql
@set_client_grants.sql

alter session set current_schema=&INSTALL_USER.;
prompt &s1.Set Compiler-Flags
alter session set plsql_ccflags = 'development:&INSTALL_ON_DEV., pit_installed:FALSE';
alter session set plsql_optimize_level = 3;
alter session set plsql_code_type='NATIVE';
alter session set plscope_settings='IDENTIFIERS:ALL';

prompt
prompt &section.
prompt &h1.PL/SQL INSTRUMENTATION TOOLKIT (PIT) Installation at user &INSTALL_USER.
prompt &h2.Installing core functionality
@core/install.sql

prompt &s1.Set Compiler-Flags
alter session set PLSQL_CCFLAGS = 'development:&INSTALL_ON_DEV., pit_installed:TRUE';

prompt
prompt &section.
prompt &h1.Installing PIT output modules
@modules/pit_console/install.sql
@modules/pit_table/install.sql
@modules/pit_apex/install.sql
@modules/pit_test/install.sql
@modules/pit_file/install.sql
--@modules/pit_mail/install.sql

prompt
prompt &section.
prompt &h1.Finalize installation
prompt &h2.Revoke user rights
@revoke_grants.sql

prompt &h1.Finished PIT-Installation

exit
