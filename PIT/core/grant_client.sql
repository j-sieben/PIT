define core_dir=core/

prompt
prompt &h2.Granting access to PIT to &REMOTE_USER.

prompt &h3.Types
@tools/grant_access.sql execute char_table
@tools/grant_access.sql execute clob_table
@tools/grant_access.sql execute message_type
@tools/grant_access.sql execute pit_message_table
@tools/grant_access.sql execute msg
@tools/grant_access.sql execute msg_args
@tools/grant_access.sql execute msg_args_char
@tools/grant_access.sql execute msg_param
@tools/grant_access.sql execute msg_params

prompt &h3.Packages
@tools/grant_access.sql execute pit
@tools/grant_access.sql execute pit_admin
@tools/grant_access.sql execute pit_util
@tools/grant_access.sql execute pit_app_api

prompt &h3.Tables
@tools/grant_access.sql "select, references" pit_message
@tools/grant_access.sql "select, references" pit_translatable_item

prompt &h3.Views
@tools/grant_access_with_grant.sql read pit_message_language_v
@tools/grant_access_with_grant.sql read pit_translatable_item_v
