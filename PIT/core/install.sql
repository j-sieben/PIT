define core_dir=core/


prompt
prompt &h1.Installing parameter framework
@&core_dir.parameters/install.sql

prompt
prompt &h1.Installing context framework
@&core_dir.context/install.sql

prompt
prompt &h1.Installing PIT core
prompt &h2.Check installation prerequisites
@&core_dir.check_prerequisites.sql

prompt &h2.Remove existing installation
@&core_dir.clean_up_install.sql

prompt &h2.Setting compile flags
@&core_dir.set_compiler_flags.sql

prompt &h2.Create sequences
prompt &s1.Create sequence PIT_LOG_SEQ
@&core_dir.sequences/pit_log_seq.seq

prompt &s1.Create sequence PIT_TRANSLATABLE_ITEM_SEQ
@&core_dir.sequences/pit_translatable_item_seq.seq

prompt &h2.Create tables
prompt &s1.Create table PIT_MESSAGE_SEVERITY
@&core_dir.tables/pit_message_severity.tbl

prompt &s1.Create table PIT_TRACE_LEVEL
@&core_dir.tables/pit_trace_level.tbl

prompt &s1.Create table PIT_MESSAGE_LANGUAGE
@&core_dir.tables/pit_message_language.tbl

prompt &s1.Create table PIT_MESSAGE_GROUP
@&core_dir.tables/pit_message_group.tbl

prompt &s1.Create view PIT_MESSAGE_LANGUAGE_V
@&core_dir.views/pit_message_language_v.vw

prompt &s1.Create table PIT_MESSAGE
@&core_dir.tables/pit_message.tbl

prompt &s1.Create table PIT_TRANSLATABLE_ITEM
@&core_dir.tables/pit_translatable_item.tbl

prompt &h2.Merge initial data
@&core_dir.scripts/merge_initial_data.sql

prompt &h2.Create views
prompt &s1.Create view PIT_MESSAGE_V
@&core_dir.views/pit_message_v.vw

prompt &s1.Create view PIT_TRANSLATABLE_ITEM_V
@&core_dir.views/pit_translatable_item_v.vw

prompt &h2.Create type declarations
prompt &s1.Create type ARGS
@&core_dir.types/args.tps
show errors

prompt &s1.Create type CHAR_TABLE
@&core_dir.types/char_table.tps
show errors

prompt &s1.Create type MSG_ARGS
@&core_dir.types/msg_args.tps
show errors

prompt &s1.Create type MSG_ARGS_CHAR
@&core_dir.types/msg_args_char.tps
show errors

prompt &s1.Create type MSG_PARAM
@&core_dir.types/msg_param.tps
show errors

prompt &s1.Create type MSG_PARAMS
@&core_dir.types/msg_params.tps
show errors

prompt &s1.Create type MESSAGE_TYPE
@&core_dir.types/message_type.tps
show errors

prompt &s1.Create type CALL_STACK_TYPE
@&core_dir.types/call_stack_type.tps
show errors

prompt &s1.Create type DEFAULT_ADAPTER
@&core_dir.types/default_adapter.tps
show errors

prompt &s1.Create type PIT_CONTEXT
@&core_dir.types/pit_context.tps
@&core_dir.types/pit_context.tpb
show errors

prompt &s1.Create type PIT_MODULE
@&core_dir.types/pit_module.tps
show errors

prompt &s1.Create type PIT_MODULE_META
@&core_dir.types/pit_module_meta.tps
show errors

prompt &s1.Create type PIT_MODULE_IIST
@&core_dir.types/pit_module_list.tps
show errors


prompt &h2.Create ADMIN package declarations
prompt &s1.Create package PIT_UTIL
@&core_dir.packages/pit_util.pks
show errors

prompt &s1.Create package PIT_ADMIN
@&core_dir.packages/pit_admin.pks
show errors

prompt &h2.Create ADMIN package implementations
prompt &s1.Create package Body PIT_UTIL
@&core_dir.packages/pit_util.pkb
show errors

prompt &s1.Create package Body PIT_ADMIN
@&core_dir.packages/pit_admin.pkb
show errors

prompt &s1.Create default parameters
@&core_dir.scripts/create_parameters.sql

prompt &s1.Create internal messages
@&core_dir.messages/&DEFAULT_LANGUAGE./create_messages.sql

prompt &h2.Create CORE package declarations
prompt &s1.Create package MSG
@&core_dir.packages/msg.pks
show errors

prompt &s1.Create package PIT
@&core_dir.packages/pit.pks
show errors

prompt &s1.Create package PIT_PKG
@&core_dir.packages/pit_pkg.pks
show errors  

prompt &s1.Create global context PIT_CTX_&INSTALL_USER.
@&core_dir.scripts/create_global_context.sql

prompt &h2.Create type bodies
prompt &s1.Create type body MESSAGE_TYPE
@&core_dir.types/message_type.tpb
show errors

prompt &s1.Create type body CALL_STACK_TYPE
@&core_dir.types/call_stack_type.tpb
show errors

prompt &s1.Create type body DEFAULT_ADAPTER
@&core_dir.types/default_adapter.tpb
show errors

prompt &s1.Create type body PIT_MODULE
@&core_dir.types/pit_module.tpb
show errors

prompt &h2.Create CORE package implementations
prompt &s1.Create package body PIT
@&core_dir.packages/pit.pkb
show errors

prompt &s1.Create package body PIT_PKG
@&core_dir.packages/pit_pkg.pkb
show errors
