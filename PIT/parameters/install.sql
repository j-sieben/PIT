@init/set_folders parameters

prompt &h2.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;

prompt &h2.Clean up existing installations
@&install_dir.clean_up_install.sql

prompt &h2.Create parameter tables
@&tools.check_has_table parameter_group
@&tools.check_has_table parameter_type
@&tools.check_has_table parameter_tab
@&tools.check_has_table parameter_local

prompt &h2.Create parameter view
@&tools.install_view parameter_vw.owner

prompt &h2.Create parameter packages
@&tools.install_package_spec param
@&tools.install_package_spec param_admin

@&tools.install_package_body param
@&tools.install_package_body param_admin

prompt &h2.Create default parameters
@&tools.run_script create_parameters
