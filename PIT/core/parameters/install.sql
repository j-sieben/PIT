define param_dir=core/parameters/
define sql_dir=&param_dir.sql/
define plsql_dir=&param_dir.plsql/

prompt &h2.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;

prompt &h2.Clean up existing installations
@&param_dir.clean_up_install.sql

prompt &h2.Create parameter tables
prompt &s1.Create table PARAMETER_GROUP
@&sql_dir.tables/parameter_group.tbl

prompt &s1.Create table PARAMETER_TYPE
@&sql_dir.tables/parameter_type.tbl

prompt &s1.Create table PARAMETER_TAB
@&sql_dir.tables/parameter_tab.tbl

prompt &s1.Creating local synonym PARAMETER for PARAMETER_TAB
@&sql_dir.synonyms/parameter_tab.syn

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

prompt &h2.Create default parameters
@&param_dir.create_parameters.sql
