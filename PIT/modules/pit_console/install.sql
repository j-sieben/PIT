prompt
prompt &section.
prompt &h1.Module PIT_CONSOLE
prompt &h2.Delete existing types and packages
@modules/pit_console/sql/clean_up.sql

prompt
prompt &h2.Install module PIT_CONSOLE
prompt &s1.Create type PIT_CONSOLE
@modules/pit_console/sql/pit_console.tps
show errors

prompt &s1.Create package PIT_CONSOLE_PKG
@modules/pit_console/plsql/pit_console_pkg.pks
show errors

prompt &s1.Create type body PIT_CONSOLE
@modules/pit_console/sql/pit_console.tpb
show errors

prompt &s1.Create package body PIT_CONSOLE_PKG
@modules/pit_console/plsql/pit_console_pkg.pkb
show errors

prompt &s1.Create PIT_CONSOLE parameters
@modules/pit_console/sql/create_parameters.sql
