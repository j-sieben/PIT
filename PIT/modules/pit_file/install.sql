@init/set_folders modules/pit_file

prompt
prompt &section.
prompt &h1.Module PIT_FILE

prompt
prompt &h2.Checking prerequites
@&install_dir.check_prerequisites

prompt &h2.Create types and packages
@&tools.install_type_spec pit_file
@&tools.install_package_spec pit_file_pkg

@&tools.install_type_body pit_file
@&tools.install_package_body pit_file_pkg

prompt &s1.Create PIT_FILE parameters
@&tools.run_script ParameterGroup_PIT

prompt ### CAVE ###
prompt Please remember to create a directory called PIT_FILE_DIR before use.
prompt This directory is required to enable PIT to store files.
prompt 