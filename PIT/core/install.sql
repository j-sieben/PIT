define sql_dir=core/sql/
define plsql_dir=core/plsql/

prompt &h2.Installing parameter package
@core/parameters/install.sql

prompt &h2.Installing context package
@core/context/install.sql

prompt &h3.Check installation prerquisites
@core/check_prerequisites.sql

prompt &h3.Remove existing installation
@core/clean_up_install.sql

prompt &h3.Setting compile flags
@core/set_compile_flags.sql

prompt &h3.Create sequences
prompt &s1.Create sequence PIT_LOG_SEQ
@&sql_dir.pit_log_seq.seq

prompt &h3.Create tables and initial data
prompt &s1.Create table MESSAGE_LANGUAGE
@&sql_dir.message_language.tbl

prompt &s1.Create view V_MESSAGE_LANGUAGE
@&sql_dir.v_message_language.vw

prompt &s1.Create table MESSAGE
@&sql_dir.message.tbl

prompt &s1.Create trigger TRG_MESSAGE_BRIU
@&plsql_dir.trg_message_briu.trg
show errors

prompt &s1.Create view V_MESSAGE
@&sql_dir.v_message.vw

prompt &s1.Copy available languages from V$NLS_PARAMETERS
@core/create_message_languages.sql

prompt &s1.Create internal messages
@core/create_default_messages.sql

prompt &h3.Create type declarations
prompt &s1.Create type ARGS
@&sql_dir.args.tps
show errors

prompt &s1.Create type MSG_ARGS
@&sql_dir.msg_args.tps
show errors

prompt &s1.Create type MSG_PARAM
@&sql_dir.msg_param.tps
show errors

prompt &s1.Create type MSG_PARAMS
@&sql_dir.msg_params.tps
show errors

prompt &s1.Create type MESSAGE_TYPE
@&sql_dir.message_type.tps
show errors

prompt &s1.Create type CALL_STACK_TYPE
@&sql_dir.call_stack_type.tps
show errors

prompt &s1.Create type DEFAULT_ADAPTER
@&sql_dir.default_adapter.tps
show errors

prompt &s1.Create type PIT_CONTEXT
@&sql_dir.pit_context.tps
show errors

prompt &s1.Create type PIT_MODULE
@&sql_dir.pit_module.tps
show errors

prompt &h3.Create package declarations
prompt &s1.Create package PIT_ADMIN
@&plsql_dir.pit_admin.pks
show errors

prompt &s1.Create package Body PIT_ADMIN
@&plsql_dir.pit_admin.pkb
show errors

prompt &s1.Create package MSG
@&plsql_dir.msg.pks
show errors

prompt &s1.Recompile package params
alter package param compile;
show errors
alter package param compile body;
show errors

prompt &s1.Create default parameters
@core/create_parameters.sql

prompt &s1.Create package PIT
@&plsql_dir.pit.pks
show errors

prompt &s1.Create package PIT_PKG
@&plsql_dir.pit_pkg.pks
show errors  

prompt &s1.Create package PIT_TEST
@&plsql_dir.pit_test.pks
show errors 

prompt &s1.Create global context PIT_CTX
@core/create_global_context.sql

prompt &h3.Create type bodies
prompt &s1.Create type body MESSAGE_TYPE
@&sql_dir.message_type.tpb
show errors

prompt &s1.Create type body CALL_STACK_TYPE
@&sql_dir.call_stack_type.tpb
show errors

prompt &s1.Create type body DEFAULT_ADAPTER
@&sql_dir.default_adapter.tpb
show errors

prompt &s1.Create type body PIT_MODULE
@&sql_dir.pit_module.tpb
show errors

prompt &h3.Create package bodies
prompt &s1.Create package body PIT
@&plsql_dir.pit.pkb
show errors

prompt &s1.Create package body PIT_PKG
@&plsql_dir.pit_pkg.pkb
show errors

prompt &s1.Create package body PIT_TEST
@&plsql_dir.pit_test.pkb
show errors

prompt &h2.Enable remote PIT access
@core/enable_remote_access.sql
