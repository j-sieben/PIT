define core_dir=core/

prompt
prompt &h2.Granting access to PIT to &REMOTE_USER.

--prompt &h3.Clean up schema &REMOTE_USER.
--@&core_dir.clean_up_client.sql

prompt &h3.Grant rights and create synonyms
-- Types
@tools/grant_access.sql execute CHAR_TABLE
@tools/grant_access.sql execute CLOB_TABLE
@tools/grant_access.sql execute MESSAGE_TYPE
@tools/grant_access.sql execute MSG
@tools/grant_access.sql execute MSG_ARGS
@tools/grant_access.sql execute MSG_PARAM
@tools/grant_access.sql execute MSG_PARAMS
@tools/grant_access.sql execute PIT
@tools/grant_access.sql execute PIT_ADMIN
@tools/grant_access.sql execute PIT_UTIL
@tools/grant_access.sql execute UTL_CONTEXT

-- Tables and Views
@tools/grant_access.sql select PIT_CALL_STACK
@tools/grant_access.sql select PIT_LOG
@tools/grant_access.sql select PIT_MESSAGE
@tools/grant_access.sql select PIT_MESSAGE_LANGUAGE
@tools/grant_access.sql select PIT_MESSAGE_LANGUAGE_V
@tools/grant_access.sql "select, references" PIT_TRANSLATABLE_ITEM
@tools/grant_access.sql select PIT_TRANSLATABLE_ITEM_V
