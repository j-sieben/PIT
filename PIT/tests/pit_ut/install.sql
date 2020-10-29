define ut_dir=modules/pit_ut/
define script_dir=&ut_dir.scripts/
define plsql_dir=&ut_dir.packages/
define type_dir=&ut_dir.types/

prompt
prompt &section.
prompt &h1.Module PIT_ut
prompt &h2.Clean up existing installation
@&ut_dir.clean_up_install.sql

prompt
prompt &h2.Install module PIT_UT
prompt &s1.Create type PIT_UT
@&type_dir.pit_ut.tps
show errors

prompt &s1.Create package PIT_UT_PKG
@&plsql_dir.pit_ut_pkg.pks
show errors

prompt &s1.Create test package UT_PIT for PIT
@&plsql_dir.ut_pit.pks
show errors

prompt &s1.Create test package UT_PIT_PKG for PIT_PKG
@&plsql_dir.ut_pit_pkg.pks
show errors

prompt &s1.Create type body PIT_UT
@&type_dir.pit_ut.tpb
show errors

prompt &s1.Create package body PIT_UT_PKG
@&plsql_dir.pit_ut_pkg.pkb
show errors

prompt &s1.Create package body UT_PIT
@&plsql_dir.ut_pit.pkb
show errors

prompt &s1.Create package body UT_PIT_PKG
@&plsql_dir.ut_pit_pkg.pkb
show errors

prompt &s1.Create PIT_ut parameters
@&script_dir.ParameterGroup_PIT.sql
