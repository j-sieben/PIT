@init/set_folders context

prompt &h3.Installing context parameters
@&tools.run_script ParameterGroup_CONTEXT

prompt &h3.Installing packages
@&tools.install_package_spec utl_context

@&tools.install_package_body utl_context
