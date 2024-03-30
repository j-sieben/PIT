
@init/set_folders.sql core

prompt &h2.Create sequences
@&tools.check_has_sequence pit_log_seq
@&tools.check_has_sequence pit_translatable_item_seq

prompt &h2.Create tables
@&tools.check_has_table pit_message_language
@&tools.check_has_table pit_message_group
@&tools.check_has_table pit_translatable_item
@&tools.check_has_table pit_message_severity
@&tools.check_has_table pit_trace_level
@&tools.check_has_table pit_message

prompt &h2.Merge initial data
@&tools.run_script merge_languages

prompt &h2.Create views
@&tools.install_view pit_message_group_v
@&tools.install_view pit_message_language_v
@&tools.install_view pit_message_v
@&tools.install_view pit_translatable_item_v
@&tools.install_view pit_message_severity_v
@&tools.install_view pit_trace_level_v

prompt &h2.Create type declarations
@&tools.install_type_spec char_table
@&tools.install_type_spec msg_args
@&tools.install_type_spec msg_args_char
@&tools.check_has_sql_boolean &type_dir.msg_param_23.tps &type_dir.msg_param.tps
@&tools.install_type_spec msg_params
@&tools.install_type_spec message_type
@&tools.install_type_spec pit_args
@&tools.install_type_spec pit_context_type
@&tools.install_type_spec pit_call_stack_type
@&tools.install_type_spec pit_default_adapter
@&tools.install_type_spec pit_log_state_type
@&tools.install_type_spec pit_message_table
@&tools.install_type_spec pit_module
@&tools.install_type_spec pit_module_meta
@&tools.install_type_spec pit_module_list

prompt &h2.Create ADMIN package declarations
@&tools.install_package_spec pit_util
@&tools.install_package_spec pit_admin

@&tools.install_package_body pit_util
@&tools.install_package_body pit_admin

prompt &s1.Create default parameters
@&tools.run_script ParameterGroup_PIT
@&tools.run_script ParameterGroup_CONTEXT

prompt &s1.Create translatable items
@&tools.run_language_script TranslatableItemGroup_PIT

prompt &s1.Merge trace levels and message severities
@&tools.run_script merge_levels_and_severities

prompt &s1.Create internal messages
@&tools.run_language_script MessageGroup_PIT
@&tools.run_language_script MessageGroup_PARAM
@&tools.run_language_script MessageGroup_ORA

prompt &h2.Create CORE package declarations
@&tools.install_package_spec msg
@&tools.install_package_spec pit
@&tools.install_package_spec pit_context
@&tools.install_package_spec pit_call_stack
@&tools.install_package_spec pit_internal

prompt &s1.Create global context
@&tools.run_script create_global_context

prompt &h2.Create type bodies
@&tools.install_type_body message_type
@&tools.check_has_sql_boolean &type_dir.msg_param_23.tpb &type_dir.msg_param.tpb
@&tools.install_type_body pit_call_stack_type
@&tools.install_type_body pit_context_type
@&tools.install_type_body pit_default_adapter
@&tools.install_type_body pit_log_state_type
@&tools.install_type_body pit_module

prompt &h2.Create CORE package implementations
@&tools.install_package_body pit
@&tools.install_package_body pit_call_stack
@&tools.install_package_body pit_context
@&tools.install_package_body pit_internal