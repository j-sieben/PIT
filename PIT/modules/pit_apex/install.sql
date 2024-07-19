@init/set_folders modules/pit_apex

prompt
prompt &h2.Install module PIT_APEX

prompt &s1.Create parameter for PIT_APEX
@&tools.run_script ParameterGroup_PIT

prompt &s1.Merge messages for PIT_APEX
@&tools.run_language_script MessageGroup_PIT

prompt &s1.Create types and packages
@&tools.install_type_spec pit_apex
@&tools.install_type_spec pit_apex_adapter
@&tools.install_package_spec pit_apex_pkg

@&tools.install_type_body pit_apex
@&tools.install_package_body pit_apex_pkg
@&tools.install_type_body pit_apex_adapter