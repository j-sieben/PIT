define test_dir=modules/pit_test/
define sql_dir=&test_dir.sql/
define plsql_dir=&test_dir.plsql/

prompt
prompt &section.
prompt &h1.Module PIT_TEST
prompt &h2.Clean up existing installation
@&test_dir.clean_up_install.sql


prompt &h2.Create tables for PIT_TEST
prompt &s1.Create table pit_test_table
@&sql_dir.tables/pit_test_table.tbl
@&sql_dir.tables/pit_test_table_result.tbl

prompt &h2.Install types and packages for PIT_TEST
prompt &s1.Create type pit_test
@&sql_dir.types/pit_test.tps
show errors

prompt &s1.Create package PIT_TEST_PKG
@&plsql_dir.pit_test_pkg.pks
show errors

prompt &s1.Create package PIT_TEST_CASES
@&plsql_dir.pit_test_cases.pks
show errors

prompt &s1.Create type body pit_test
@&plsql_dir.pit_test.tpb
show errors

prompt &s1.Create package body PIT_TEST_PKG
@&plsql_dir.pit_test_pkg.pkb
show errors

prompt &s1.Create package body PIT_TEST_CASES
@&plsql_dir.pit_test_cases.pkb
show errors

prompt &h2.Create PIT_TEST parameters and messages
@&test_dir.create_parameters.sql
@&test_dir.messages/&DEFAULT_LANGUAGE./create_messages.sql
@&test_dir.create_test_results.sql