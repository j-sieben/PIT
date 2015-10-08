prompt
prompt &section.
prompt &h1.Module PIT_APEX
prompt &h2.Clean existing installation
@modules/pit_apex/sql/clean_up.sql

prompt
prompt &h2.Install module PIT_APEX
prompt &s1.Create type PIT_APEX
@modules/pit_apex/sql/pit_apex.tps
show errors

prompt &s1.Create type apex_adapter
@modules/pit_apex/sql/apex_adapter.tps
show errors

prompt &s1.Create package PIT_APEX_PKG
@modules/pit_apex/plsql/pit_apex_pkg.pks
show errors

prompt &s1.Create type body PIT_APEX
@modules/pit_apex/sql/pit_apex.tpb
show errors

prompt &s1.Create type body apex_adapter
@modules/pit_apex/sql/apex_adapter.tpb
show errors

prompt &s1.Create package body PIT_APEX_PKG
@modules/pit_apex/plsql/pit_apex_pkg.pkb
show errors

prompt &s1.Create parameter for PIT_APEX
@modules/pit_apex/sql/create_parameters.sql
