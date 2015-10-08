prompt
prompt &section.
prompt &h1.Module PIT_TABLE
prompt &h2.Delete existing types and packages
@modules/pit_table/sql/clean_up.sql

prompt &h2.Install module PIT_TABLE

prompt &s1.Create table PIT_LOG
@modules/pit_table/sql/pit_log.tbl

prompt &s1.Create trigger TRG_PIT_LOG_BRI
@modules/pit_table/plsql/trg_pit_log_bri.trg
show errors

prompt &s1.Create sequence PIT_LOG_SEQ
@modules/pit_table/sql/pit_log_seq.seq

prompt &s1.Create table pit_call_stack
@modules/pit_table/sql/pit_call_stack.tbl

prompt &s1.Create trigger TRG_PIT_CALL_STACK_BRI
@modules/pit_table/plsql/trg_pit_call_stack_bri.trg
show errors

prompt &s1.Create type PIT_TABLE
@modules/pit_table/sql/pit_table.tps
show errors

prompt &s1.Create package PIT_TABLE_PKG
@modules/pit_table/plsql/pit_table_pkg.pks
show errors

prompt &s1.Create type body PIT_TABLE
@modules/pit_table/sql/pit_table.tpb
show errors

prompt &s1.Create package body PIT_TABLE_PKG
@modules/pit_table/plsql/pit_table_pkg.pkb
show errors

prompt &s1.Create PIT_TABLE parameters
@modules/pit_table/sql/create_parameters.sql
