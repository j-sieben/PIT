define console_dir=modules/pit_console/
define sql_dir=&console_dir.sql/
define plsql_dir=&console_dir.plsql/

prompt
prompt &section.
prompt &h1.Module PIT_CONSOLE
prompt &h2.Clean up existing installation
@&console_dir.clean_up_install.sql

prompt
prompt &h2.Install module PIT_CONSOLE
prompt &s1.Create type PIT_CONSOLE
@&sql_dir.types/pit_console.tps
show errors

prompt &s1.Create package PIT_CONSOLE_PKG
@&plsql_dir.pit_console_pkg.pks
show errors

prompt &s1.Create type body PIT_CONSOLE
@&sql_dir.types/pit_console.tpb
show errors

prompt &s1.Create package body PIT_CONSOLE_PKG
@&plsql_dir.pit_console_pkg.pkb
show errors

prompt &s1.Create PIT_CONSOLE parameters
@&console_dir.create_parameters.sql
