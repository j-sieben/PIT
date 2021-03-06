define core_dir=core/

prompt
prompt &h2.Granting access to PIT to &REMOTE_USER.

--prompt &h3.Clean up schema &REMOTE_USER.
--@&core_dir.clean_up_client.sql

prompt &h3.Grant rights and create synonyms
-- Types
@tools/grant_access.sql execute char_table
@tools/grant_access.sql execute clob_table
@tools/grant_access.sql execute message_type
@tools/grant_access.sql execute pit_message_table
@tools/grant_access.sql execute msg
@tools/grant_access.sql execute msg_args
@tools/grant_access.sql execute msg_args_char
@tools/grant_access.sql execute msg_param
@tools/grant_access.sql execute msg_params
@tools/grant_access.sql execute pit
@tools/grant_access.sql execute pit_pkg
@tools/grant_access.sql execute pit_admin
@tools/grant_access.sql execute pit_util
@tools/grant_access.sql execute utl_context

-- Tables and Views
@tools/grant_access.sql "select, references" pit_message
@tools/grant_access.sql read pit_message_language
@tools/grant_access.sql read pit_message_language_v
@tools/grant_access.sql "select, references" pit_translatable_item
@tools/grant_access.sql read pit_translatable_item_v


@modules/pit_apex/install_client.sql
@modules/pit_console/install_client.sql
@modules/pit_file/install_client.sql
@modules/pit_mail/install_client.sql
@modules/pit_table/install_client.sql