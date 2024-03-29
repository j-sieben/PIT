@init/set_folders parameters


prompt &h2.Create parameter tables
@&tools.check_has_table parameter_group
@&tools.check_has_table parameter_realm
@&tools.check_has_table parameter_type
@&tools.check_has_table parameter_tab
@&tools.check_has_table parameter_local

prompt &h2.Create parameter view
@&tools.install_view parameter_core_v
@&tools.install_view parameter_v.owner
@&tools.install_view parameter_realm_v

prompt &h2.Create parameter packages
@&tools.install_package_spec param
@&tools.install_package_spec param_admin

@&tools.install_package_body param
@&tools.install_package_body param_admin

prompt &h2.Load data
@&tools.run_script merge_parameter_realm
@&tools.run_script merge_parameter_type
