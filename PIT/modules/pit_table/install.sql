@init/set_folders modules/pit_table

prompt
prompt &h3.Install module PIT_TABLE
prompt &s1.Create tables
@&tools.check_has_table pit_table_log
@&tools.check_has_table pit_table_call_stack
@&tools.check_has_table pit_table_params

prompt &s1.Create types and packages
@&tools.install_type_spec pit_table
@&tools.install_package_spec pit_table_pkg

@&tools.install_type_body pit_table
@&tools.install_package_body pit_table_pkg

prompt &s1.Create PIT_TABLE parameters
@&tools.run_script ParameterGroup_PIT
