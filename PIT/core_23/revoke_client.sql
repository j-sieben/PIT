
prompt &h3.Revoke rights and drop synonyms
-- Types
@tools/revoke_access.sql execute CHAR_TABLE
@tools/revoke_access.sql execute CLOB_TABLE
@tools/revoke_access.sql execute MESSAGE_TYPE
@tools/revoke_access.sql execute MSG
@tools/revoke_access.sql execute MSG_ARGS
@tools/revoke_access.sql execute MSG_PARAM
@tools/revoke_access.sql execute MSG_PARAMS
@tools/revoke_access.sql execute PIT
@tools/revoke_access.sql execute PIT_ADMIN
@tools/revoke_access.sql execute PIT_UTIL
@tools/revoke_access.sql execute UTL_CONTEXT

-- Tables and Views
@tools/revoke_access.sql select PIT_CALL_STACK
@tools/revoke_access.sql select PIT_LOG
