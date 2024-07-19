define tool_dir=tools/

prompt
prompt &h2.Removing registration of PIT objects at &REMOTE_USER.

prompt &h3.Drop synonyms
@&tool_dir.drop_object.sql char_table
@&tool_dir.drop_object.sql clob_table
@&tool_dir.drop_object.sql message_type
@&tool_dir.drop_object.sql pit_message_table
@&tool_dir.drop_object.sql msg
@&tool_dir.drop_object.sql msg_args
@&tool_dir.drop_object.sql msg_args_char
@&tool_dir.drop_object.sql msg_param
@&tool_dir.drop_object.sql msg_params
@&tool_dir.drop_object.sql pit
@&tool_dir.drop_object.sql pit_util

prompt &h3.Drop Tables and Views
@&tool_dir.drop_object.sql pit_message_language
@&tool_dir.drop_object.sql pit_message_language_v
@&tool_dir.drop_object.sql pit_translatable_item_v
