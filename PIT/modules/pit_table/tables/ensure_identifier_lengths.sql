-- Widen stored identifiers before recreating dependent program units.
@&tools.ensure_identifier_length.sql pit_table_call_stack cls_user_name
@&tools.ensure_identifier_length.sql pit_table_call_stack cls_module_name
@&tools.ensure_identifier_length.sql pit_table_call_stack cls_method_name
@&tools.ensure_identifier_length.sql pit_table_log log_user_name
@&tools.ensure_identifier_length.sql pit_table_log log_message_name
@&tools.ensure_identifier_length.sql pit_table_params ptp_param_name
