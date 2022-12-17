define param_dir=parameters/
define tools=tools/

prompt
prompt &h2.Registering parameter package.

prompt &h3.Clean up schema &REMOTE_USER.
@&param_dir.unregister_client.sql

prompt &h3.Create synonyms
@&tools.create_synonym.sql param
@&tools.create_synonym.sql param_admin

@&tools.create_synonym.sql parameter_group
@&tools.create_synonym.sql parameter_realm
@&tools.create_synonym.sql parameter_tab
@&tools.create_synonym.sql parameter_type

@&tools.create_synonym.sql parameter_core_v
@&tools.create_synonym.sql parameter_realm_v

prompt &h3.Create PIT user tables and views
prompt &s1.Create table PARAMETER_LOCAL
@&param_dir.tables/parameter_local.tbl

prompt &s1.Create view PARAMETER_V
@&param_dir.views/parameter_v.vw