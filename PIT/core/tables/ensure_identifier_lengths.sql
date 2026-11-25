-- Widen stored identifiers before recreating dependent program units.
@&tools.ensure_identifier_length.sql pit_internal_log pil_affected_id
@&tools.ensure_identifier_length.sql pit_message pms_name
@&tools.ensure_identifier_length.sql pit_message pms_pmg_name
@&tools.ensure_identifier_length.sql pit_message_group pmg_name
@&tools.ensure_identifier_length.sql pit_message_language pml_name
@&tools.ensure_identifier_length.sql pit_message_language pml_effective_name
@&tools.ensure_identifier_length.sql pit_message_severity pse_name
@&tools.ensure_identifier_length.sql pit_message_severity pse_pti_id
@&tools.ensure_identifier_length.sql pit_message_severity pse_pti_pmg_id
@&tools.ensure_identifier_length.sql pit_message_text pmt_pms_name
@&tools.ensure_identifier_length.sql pit_message_text pmt_pml_name
@&tools.ensure_identifier_length.sql pit_trace_level ptl_name
@&tools.ensure_identifier_length.sql pit_trace_level ptl_pti_id
@&tools.ensure_identifier_length.sql pit_trace_level ptl_pti_pmg_id
@&tools.ensure_identifier_length.sql pit_translatable_item pti_id
@&tools.ensure_identifier_length.sql pit_translatable_item pti_pml_name
@&tools.ensure_identifier_length.sql pit_translatable_item pti_pmg_name
