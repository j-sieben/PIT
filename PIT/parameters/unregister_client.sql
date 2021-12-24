define param_dir=parameters/
define tools=tools/

prompt
prompt &h2.Remove registration of parameter package.

prompt &h3.Drop synonyms
@&tools.drop_object.sql param
@&tools.drop_object.sql param_admin

@&tools.drop_object.sql parameter_group
@&tools.drop_object.sql parameter_realm
@&tools.drop_object.sql parameter_tab
@&tools.drop_object.sql parameter_type

@&tools.drop_object.sql parameter_core_vw
@&tools.drop_object.sql parameter_realm_vw

prompt &h3.Drop local objects
prompt &s1.Drop table PARAMETER_LOCAL
@&tools.drop_object.sql parameter_local

prompt &s1.Drop view PARAMETER_VW
@&tools.drop_object.sql parameter_vw