@init/set_folders modules/pit_console

prompt
prompt &section.
prompt &h1.Module PIT_CONSOLE

prompt
prompt &h2.Install module PIT_CONSOLE
prompt &s1.Create types and packages
@&tools.install_type_spec pit_console
@&tools.install_package_spec pit_console_pkg

@&tools.install_type_body pit_console
@&tools.install_package_body pit_console_pkg

prompt &s1.Create parameters
@&tools.run_script ParameterGroup_PIT
