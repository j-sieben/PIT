define param_dir=core/parameters/

prompt &h2.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;

prompt &h2.Clean up existing installations
@&param_dir.clean_up_install.sql

prompt &h2.Create parameter tables
prompt &s1.Create table PARAMETER_GROUP
@&param_dir.tables/parameter_group.tbl

prompt &s1.Create table PARAMETER_TYPE
@&param_dir.tables/parameter_type.tbl

prompt &s1.Create table PARAMETER_TAB
@&param_dir.tables/parameter_tab.tbl

prompt &s1.Create table PARAMETER_LOCAL
@&param_dir.tables/parameter_local.tbl

prompt &h2.Create parameter view
prompt &s1.Create view PARAMETER_VW
@&param_dir.views/parameter_vw.owner.vw

prompt &h2.Create parameter packages
prompt &s1.Create package PARAM
@&param_dir.packages/param.pks
show errors

prompt &s1.Create package PARAM_ADMIN
@&param_dir.packages/param_admin.pks
show errors

prompt &s1.Create package body PARAM
@&param_dir.packages/param.pkb
show errors

prompt &s1.Create package PARAM
@&param_dir.packages/param_admin.pkb
show errors

prompt &h2.Create default parameters
@&param_dir.scripts/create_parameters.sql
