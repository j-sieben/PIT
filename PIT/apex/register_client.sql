define tool_dir=tools/

prompt
prompt &h2.Registering PIT objects at &REMOTE_USER.

prompt &h3.Create synonyms
-- Types
@&tool_dir.create_synonym.sql char_table
@&tool_dir.create_synonym.sql clob_table
@&tool_dir.create_synonym.sql message_type
@&tool_dir.create_synonym.sql pit_message_table
@&tool_dir.create_synonym.sql msg
@&tool_dir.create_synonym.sql msg_args
@&tool_dir.create_synonym.sql msg_args_char
@&tool_dir.create_synonym.sql msg_param
@&tool_dir.create_synonym.sql msg_params
@&tool_dir.create_synonym.sql pit
@&tool_dir.create_synonym.sql pit_internal
@&tool_dir.create_synonym.sql pit_admin
@&tool_dir.create_synonym.sql pit_util
@&tool_dir.create_synonym.sql utl_context

-- Tables and Views
@&tool_dir.create_synonym.sql pit_message
@&tool_dir.create_synonym.sql pit_message_group
@&tool_dir.create_synonym.sql pit_message_language
@&tool_dir.create_synonym.sql pit_message_language_v
@&tool_dir.create_synonym.sql pit_message_severity_v
@&tool_dir.create_synonym.sql pit_translatable_item
@&tool_dir.create_synonym.sql pit_translatable_item_v
@&tool_dir.create_synonym.sql pit_trace_level_v
