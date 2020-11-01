@init/set_folders modules/pit_file

prompt
prompt &section.
prompt &h1.Module PIT_FILE
prompt &h2.Clean up existing installation
@&install_dir.clean_up_install.sql

prompt
prompt &h2.Grant user rights for PIT_FILE to &INSTALL_USER.
@&tools.run_script user_grants

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