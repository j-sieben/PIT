define apex_dir=modules/pit_apex/
define msg_dir=&apex_dir.messages/&DEFAULT_LANGUAGE./

prompt
prompt &section.
prompt &h1.Module PIT_APEX
prompt &h2.Clean up existing installation
@&apex_dir.clean_up_install.sql

prompt
prompt &h2.Install module PIT_APEX
prompt &s1.Create type PIT_APEX
@&apex_dir.types/pit_apex.tps
show errors

prompt &s1.Create type apex_adapter
@&apex_dir.types/apex_adapter.tps
show errors

prompt &s1.Merge messages for PIT_APEX
@&msg_dir/create_messages.sql

prompt &s1.Create parameter for PIT_APEX
@&apex_dir.scripts/create_parameters.sql

prompt &s1.Create package PIT_APEX_PKG
@&apex_dir.packages/pit_apex_pkg.pks
show errors

prompt &s1.Create type body PIT_APEX
@&apex_dir.types/pit_apex.tpb
show errors

prompt &s1.Create type body apex_adapter
@&apex_dir.types/apex_adapter.tpb
show errors

prompt &s1.Create package body PIT_APEX_PKG
@&apex_dir.packages/pit_apex_pkg.pkb
show errors