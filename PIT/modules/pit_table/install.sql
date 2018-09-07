define table_dir=modules/pit_table/

prompt
prompt &section.
prompt &h1.Module PIT_TABLE
prompt &h2.Clean up existing installation
@&TABLE_DIR.clean_up_install.sql

prompt &h2.Install module PIT_TABLE

prompt &s1.Create table PIT_LOG
@&table_dir.tables/pit_log.tbl

prompt &s1.Create sequence PIT_LOG_SEQ
@&table_dir.sequences/pit_log_seq.seq

prompt &s1.Create table pit_call_stack
@&table_dir.tables/pit_call_stack.tbl

prompt &s1.Create type PIT_TABLE
@&table_dir.types/pit_table.tps
show errors

prompt &s1.Create package PIT_TABLE_PKG
@&table_dir.packages/pit_table_pkg.pks
show errors

prompt &s1.Create type body PIT_TABLE
@&table_dir.types/pit_table.tpb
show errors

prompt &s1.Create package body PIT_TABLE_PKG
@&table_dir.packages/pit_table_pkg.pkb
show errors

prompt &s1.Create PIT_TABLE parameters
@&TABLE_DIR.scripts/create_parameters.sql
