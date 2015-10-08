prompt
prompt &section.
prompt &h1.Module PIT_TEST
prompt &h2.Delete existing types and packages
@modules/pit_test/sql/clean_up.sql

prompt &h2.Create tables for PIT_TEST
prompt &s1.Create table pit_test_table
@modules/pit_test/sql/pit_test_table.tbl

prompt &h2.Install types and packages for PIT_TEST
prompt &s1.Create type pit_test
@modules/pit_test/sql/pit_test.tps
show errors

prompt &s1.Create package PIT_TEST_PKG
@modules/pit_test/plsql/pit_test_pkg.pks
show errors

prompt &s1.Create type body pit_test
@modules/pit_test/sql/pit_test.tpb
show errors

prompt &s1.Create package body PIT_TEST_PKG
@modules/pit_test/plsql/pit_test_pkg.pkb
show errors

prompt &h2.Create PIT_TEST parameters and messages
@modules/pit_test/sql/create_parameters.sql
@modules/pit_test/sql/create_messages.sql