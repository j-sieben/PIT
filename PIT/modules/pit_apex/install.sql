define apex_dir=modules/pit_apex/
define sql_dir=&apex_dir.sql/
define plsql_dir=&apex_dir.plsql/

prompt
prompt &section.
prompt &h1.Module PIT_APEX
prompt &h2.Clean up existing installation
@&apex_dir.clean_up_install.sql

prompt
prompt &h2.Install module PIT_APEX
prompt &s1.Create type PIT_APEX
@&sql_dir.types/pit_apex.tps
show errors

prompt &s1.Create type apex_adapter
@&sql_dir.types/apex_adapter.tps
show errors

prompt &s1.Create package PIT_APEX_PKG
@&plsql_dir.pit_apex_pkg.pks
show errors

prompt &s1.Create type body PIT_APEX
@&sql_dir.types/pit_apex.tpb
show errors

prompt &s1.Create type body apex_adapter
@&sql_dir.types/apex_adapter.tpb
show errors

prompt &s1.Create package body PIT_APEX_PKG
@&plsql_dir.pit_apex_pkg.pkb
show errors

prompt &s1.Create parameter for PIT_APEX
@&apex_dir.create_parameters.sql
