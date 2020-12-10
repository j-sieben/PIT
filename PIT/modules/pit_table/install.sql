@init/set_folders modules/pit_table

prompt
prompt &section.
prompt &h1.Module PIT_TABLE
prompt &h2.Clean up existing installation
@&install_dir.clean_up_install.sql

prompt &h2.Install module PIT_TABLE
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
@&tools.run_script create_parameters
