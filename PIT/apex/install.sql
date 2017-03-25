define apex_dir=apex/
define sql_dir=&apex_dir.sql/
define plsql_dir=&apex_dir.plsql/

prompt &h2.Create UI-VIEWS
prompt &s1.View PIT_UI_ADMIN_MESSAGE_MAIN
@&sql_dir.views/pit_ui_admin_message_main.vw

prompt &s1.View PIT_UI_ADMIN_PARAM_MAIN
@&sql_dir.views/pit_ui_admin_param_main.vw

prompt &s1.View PIT_UI_ADMIN_PIT_CONTEXT
@&sql_dir.views/pit_ui_admin_pit_context.vw

prompt &s1.View PIT_UI_ADMIN_PIT_MODULE
@&sql_dir.views/pit_ui_admin_pit_module.vw

prompt &s1.View PIT_UI_ADMIN_PIT_TOGGLE
@&sql_dir.views/pit_ui_admin_pit_toggle.vw

prompt &s1.View PIT_UI_ADMIN_PIT_MODULE
@&sql_dir.views/pit_ui_admin_pit_module.vw

prompt &s1.View PIT_UI_EDIT_CONTEXT
@&sql_dir.views/pit_ui_edit_context.vw

prompt &s1.View PIT_UI_EDIT_MESSAGE_TRANS
@&sql_dir.views/pit_ui_edit_message_trans.vw

prompt &s1.View PIT_UI_EDIT_TOGGLE
@&sql_dir.views/pit_ui_edit_toggle.vw

prompt &s1.View PIT_UI_LANG_SETTINGS_DEFAULT
@&sql_dir.views/pit_ui_lang_settings_default.vw

prompt &s1.View PIT_UI_LIST_ACTIVE_FOR_PAGE
@&sql_dir.views/pit_ui_list_active_for_page.vw

prompt &s1.View PIT_UI_LOV_AVAILABLE_PACKAGES
@&sql_dir.views/pit_ui_lov_available_packages.vw

prompt &s1.View PIT_UI_LOV_CONTEXT
@&sql_dir.views/pit_ui_lov_context.vw

prompt &s1.View PIT_UI_LOV_MESSAGE_LANGUAGE
@&sql_dir.views/pit_ui_lov_message_language.vw

prompt &s1.View PIT_UI_LOV_MESSAGE_SEVERITY
@&sql_dir.views/pit_ui_lov_message_severity.vw

prompt &s1.View PIT_UI_LOV_OUTPUT_MODULES
@&sql_dir.views/pit_ui_lov_output_modules.vw

prompt &s1.View PIT_UI_LOV_PARAMETER_GROUP
@&sql_dir.views/pit_ui_lov_parameter_group.vw

prompt &s1.View PIT_UI_LOV_PARAMETER_TYPE
@&sql_dir.views/pit_ui_lov_parameter_type.vw

prompt &s1.View PIT_UI_LOV_TRACE_LEVEL
@&sql_dir.views/pit_ui_lov_trace_level.vw


prompt &h2.Create UI-MESSAGES
@@&apex_dir.messages/&DEFAULT_LANGUAGE./create_messages.sql


prompt &h2.Create UI-PACKAGES
prompt &s1.Package PIT_UI_PKG
@&plsql_dir.pit_ui_pkg.pks
show errors

prompt &s1.Package body PIT_UI_PKG
@&plsql_dir.pit_ui_pkg.pkb
show errors


prompt &h2.Install APEX-application
prompt &s1.Prepare installation
@&apex_dir.apex/prepare_apex_import.sql


prompt &s1.Install application
@&apex_dir.apex/application.sql

