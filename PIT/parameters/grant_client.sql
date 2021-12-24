define param_dir=parameters/
define tools=tools/

prompt
prompt &h2.Granting access to parameter package to &REMOTE_USER.

prompt &h3.Grant access rights to &REMOTE_USER.
@&tools.grant_access.sql execute param
@&tools.grant_access.sql execute param_admin

@&tools.grant_access.sql "select, references" parameter_group
@&tools.grant_access.sql "select, references" parameter_realm
@&tools.grant_access.sql "select, references" parameter_tab
@&tools.grant_access.sql "select, references" parameter_type

@&tools.grant_access.sql read parameter_core_vw
@&tools.grant_access.sql read parameter_realm_vw