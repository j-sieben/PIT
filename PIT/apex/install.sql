define apex_dir=apex/
define apex_version_dir=&apex_dir.apex_&APEX_VERSION.
define view_dir=&apex_dir.views/
define tools=tools/

prompt &h2.Installation in Schema &REMOTE_USER.
prompt &h3.Grant OBJECT privileges and create local synonyms if necessary
@install_scripts/create_apex_synonyms.sql

prompt &h3.Create UI-VIEWS
--@&tools.install_view apex_ui_list_menu -- Part of UTL_APEX, no need to overwrite
@&tools.install_view pit_ui_admin_pms
@&tools.install_view pit_ui_admin_par
@&tools.install_view pit_ui_admin_par_realm
@&tools.install_view pit_ui_edit_pgr
@&tools.install_view pit_ui_admin_pit_active_context
@&tools.install_view pit_ui_admin_pit_context
@&tools.install_view pit_ui_admin_pit_module
@&tools.install_view pit_ui_admin_pit_toggle
@&tools.install_view pit_ui_admin_pit_module
@&tools.install_view pit_ui_edit_context
@&tools.install_view pit_ui_edit_message_trans
@&tools.install_view pit_ui_edit_module
@&tools.install_view pit_ui_edit_par
@&tools.install_view pit_ui_edit_par_realm
@&tools.install_view pit_ui_edit_pgr
@&tools.install_view pit_ui_edit_pmg
@&tools.install_view pit_ui_edit_pms
@&tools.install_view pit_ui_edit_realm
@&tools.install_view pit_ui_set_realm
@&tools.install_view pit_ui_edit_toggle
@&tools.install_view pit_ui_lang_settings_default
@&tools.install_view pit_ui_list_active_for_page
@&tools.install_view pit_ui_lov_available_packages
@&tools.install_view pit_ui_lov_boolean_tri_state
@&tools.install_view pit_ui_lov_context
@&tools.install_view pit_ui_lov_message_group
@&tools.install_view pit_ui_lov_message_language
@&tools.install_view pit_ui_lov_message_severity
@&tools.install_view pit_ui_lov_output_modules
@&tools.install_view pit_ui_lov_parameter_group
@&tools.install_view pit_ui_lov_parameter_realm
@&tools.install_view pit_ui_lov_parameter_type
@&tools.install_view pit_ui_lov_trace_level

prompt &h3.Create UI-MESSAGES
@@&apex_dir.messages/&DEFAULT_LANGUAGE./MessageGroup_PIT_UI.sql


prompt &h3.Create UI-PACKAGES
prompt &s1.Package PIT_UI
@&apex_dir.packages/pit_ui.pks
show errors

prompt &s1.Package body PIT_UI
@&apex_dir.packages/pit_ui.pkb
show errors


prompt &h3.Install APEX-application from folder apex_&APEX_VERSION.
prompt &s1.Prepare installation
@&apex_version_dir./prepare_apex_import.sql


prompt &s1.Install application
@&apex_version_dir/application.sql

