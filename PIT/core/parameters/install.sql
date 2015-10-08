define param_dir=core/parameters/

prompt &h2.Clean up existing installations
@&param_dir.clean_up_install.sql

prompt &h2.Create parameter tables
prompt &s1.Create table PARAMETER_GROUP
@core/sql/parameter_group.tbl

prompt &s1.Create table PARAMETER_TYPE
@core/sql/parameter_type.tbl

prompt &s1.Create table PARAMETER_TAB
@core/sql/parameter_tab.tbl

prompt &h2.Grant PIT user rights
@&param_dir.grant_install_rights.sql

prompt &s1.Creating local synonym PARAMETER for PARAMETER_TAB
@&sql_dir.parameter_install.syn

prompt &h1.Change current schema to &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;

prompt &h2.Clean up schema &REMOTE_USER.
@&param_dir.clean_up_remote.sql

prompt &h2.Create PIT user tables and views
prompt &s1.Create table PARAMETER_LOCAL
@&sql_dir.parameter_local.tbl

prompt &s1.Create view PARAMETER_VW
@&sql_dir.parameter_vw.vw

prompt &s1.Create synonym PARAMETER for PARAMETER_VW
@&sql_dir.parameter_remote.syn

prompt &s1.Pre-create synonyms for PARAM and PARAM_ADMIN_package
@&param_dir.create_remote_synonyms.sql

prompt &h2.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;

prompt &h2.Create parameter packages
prompt &s1.Create package PARAM
@&plsql_dir.param.pks
show errors

prompt &s1.Create package PARAM_ADMIN
@&plsql_dir.param_admin.pks
show errors

prompt &s1.Create package body PARAM
@&plsql_dir.param.pkb
show errors

prompt &s1.Create package PARAM
@&plsql_dir.param_admin.pkb
show errors

prompt &h2.Grant execute on param packages to PIT user
@&param_dir.grant_execute_rights.sql

prompt &h2.Create default parameters
@&param_dir.create_parameters.sql
