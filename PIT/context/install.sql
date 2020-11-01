@init/set_folders context

prompt &h3.Checking installation prerequisites
@&install_dir.check_prerequisites.sql

prompt &h3.Remove existing installation
@&install_dir.clean_up.sql

prompt &h3.Installing context parameters
@&tools.run_script ParameterGroup_CONTEXT

prompt &h3.Create type declarations
@&tools.install_type_spec args

prompt &h3.Installing packages
@&tools.install_package_spec utl_context

@&tools.install_package_body utl_context

-- ONLY REQUIRED IF USED STANDALONE
--prompt &h3.Granting object privileges on utl_context
--@&tools.run_script grant_rights