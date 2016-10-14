
prompt
prompt &h1.Installing parameter package
@core/parameters/install.sql

prompt
prompt &h1.Installing context package
@core/context/install.sql

define sql_dir=core/sql/
define plsql_dir=core/plsql/

prompt
prompt &h1.Installing PIT core
prompt &h2.Check installation prerequisites
@core/check_prerequisites.sql

prompt &h2.Remove existing installation
@core/clean_up_install.sql

prompt &h2.Setting compile flags
@core/set_compile_flags.sql

prompt &h2.Create sequences
prompt &s1.Create sequence PIT_LOG_SEQ
@&sql_dir.sequences/pit_log_seq.seq

prompt &h2.Create tables and initial data
prompt &s1.Create table MESSAGE_LANGUAGE
@&sql_dir.tables/message_language.tbl

prompt &s1.Create view V_MESSAGE_LANGUAGE
@&sql_dir.views/v_message_language.vw

prompt &s1.Create table MESSAGE
@&sql_dir.tables/message.tbl

prompt &s1.Create trigger TRG_MESSAGE_BRIU
@&sql_dir.triggers/trg_message_briu.trg
show errors

prompt &s1.Create view V_MESSAGE
@&sql_dir.views/v_message.vw

prompt &s1.Copy available languages from V$NLS_PARAMETERS
@core/create_message_languages.sql

prompt &h2.Create type declarations
prompt &s1.Create type CHAR_TABLE
@&sql_dir.types/char_table.tps
show errors

prompt &s1.Create type MSG_ARGS
@&sql_dir.types/msg_args.tps
show errors

prompt &s1.Create type MSG_ARGS_CHAR
@&sql_dir.types/msg_args_char.tps
show errors

prompt &s1.Create type MSG_PARAM
@&sql_dir.types/msg_param.tps
show errors

prompt &s1.Create type MSG_PARAMS
@&sql_dir.types/msg_params.tps
show errors

prompt &s1.Create type MESSAGE_TYPE
@&sql_dir.types/message_type.tps
show errors

prompt &s1.Create type CALL_STACK_TYPE
@&sql_dir.types/call_stack_type.tps
show errors

prompt &s1.Create type DEFAULT_ADAPTER
@&sql_dir.types/default_adapter.tps
show errors

prompt &s1.Create type PIT_CONTEXT
@&sql_dir.types/pit_context.tps
@&sql_dir.types/pit_context.tpb
show errors

prompt &s1.Create type PIT_MODULE
@&sql_dir.types/pit_module.tps
show errors

prompt &h2.Create package declarations
prompt &s1.Create package PIT_ADMIN
@&plsql_dir.pit_admin.pks
show errors

prompt &s1.Create package PIT_UTIL
@&plsql_dir.pit_util.pks
show errors

prompt &s1.Create package Body PIT_ADMIN
@&plsql_dir.pit_admin.pkb
show errors

prompt &s1.Create package Body PIT_UTIL
@&plsql_dir.pit_util.pkb
show errors

prompt &s1.Create internal messages
@core/create_default_messages.sql

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

prompt &s1.Create global context PIT_CTX
@core/create_global_context.sql

prompt &h2.Create type bodies
prompt &s1.Create type body MESSAGE_TYPE
@&sql_dir.types/message_type.tpb
show errors

prompt &s1.Create type body CALL_STACK_TYPE
@&sql_dir.types/call_stack_type.tpb
show errors

prompt &s1.Create type body DEFAULT_ADAPTER
@&sql_dir.types/default_adapter.tpb
show errors

prompt &s1.Create type body PIT_MODULE
@&sql_dir.types/pit_module.tpb
show errors

prompt &h2.Create package bodies
prompt &s1.Create package body PIT
@&plsql_dir.pit.pkb
show errors

prompt &s1.Create package body PIT_PKG
@&plsql_dir.pit_pkg.pkb
show errors
