define table_dir=modules/pit_table/
define sql_dir=&table_dir.sql/
define plsql_dir=&table_dir.plsql/

prompt
prompt &section.
prompt &h1.Module PIT_TABLE
prompt &h2.Clean up existing installation
@&TABLE_DIR.clean_up_install.sql

prompt &h2.Install module PIT_TABLE

prompt &s1.Create table PIT_LOG
@&SQL_DIR.tables/pit_log.tbl

prompt &s1.Create sequence PIT_LOG_SEQ
@&SQL_DIR.sequences/pit_log_seq.seq

prompt &s1.Create table pit_call_stack
@&SQL_DIR.tables/pit_call_stack.tbl

prompt &s1.Create type PIT_TABLE
@&SQL_DIR.types/pit_table.tps
show errors

prompt &s1.Create package PIT_TABLE_PKG
@&PLSQL_DIR.pit_table_pkg.pks
show errors

prompt &s1.Create type body PIT_TABLE
@&SQL_DIR.types/pit_table.tpb
show errors

prompt &s1.Create package body PIT_TABLE_PKG
@&PLSQL_DIR.pit_table_pkg.pkb
show errors

prompt &s1.Create PIT_TABLE parameters
@&TABLE_DIR.create_parameters.sql
