define param_dir=core/parameters/
define sql_dir=&param_dir.sql/

prompt
prompt &h2.Granting access to parameter package to &REMOTE_USER.
prompt &h3.Change current schema to &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;

prompt &h3.Clean up schema &REMOTE_USER.
@&param_dir.clean_up_client.sql

prompt &h3.Grant access rights to &REMOTE_USER.
@&param_dir.grant_client_rights.sql

prompt &h3.Create PIT user tables and views
prompt &s1.Create table PARAMETER_LOCAL
@&sql_dir.tables/parameter_local.tbl

prompt &s1.Create view PARAMETER_VW
@&sql_dir.views/parameter_vw.vw

prompt &s1.Create synonym PARAMETER for PARAMETER_VW
@&sql_dir.synonyms/parameter_vw.syn

prompt &s1.Create synonym PARAM_ADMIN for PARAM_ADMIN_package
@&sql_dir.synonyms/param_admin.syn

prompt &s1.Pre-create synonyms PARAM for PARAM package 
@&sql_dir.synonyms/param.syn

prompt &h3.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;
