define apex_dir=apex/
define apex_version_dir=&apex_dir.apex_&APEX_VERSION.

prompt &h2.Installation in Schema &REMOTE_USER.
prompt &h3.Grant OBJECT privileges and create local synonyms if necessary

-- Packages
@tools/grant_access.sql execute MAIL
@tools/grant_access.sql execute PIT_APEX_PKG
@tools/grant_access.sql execute PIT_CONSOLE_PKG
@tools/grant_access.sql execute PIT_FILE_PKG
@tools/grant_access.sql execute PIT_MAIL_PKG
@tools/grant_access.sql execute PIT_TABLE_PKG
@tools/grant_access.sql execute PIT_MODULE_META

-- Tables and Views
@tools/grant_access.sql select PIT_MESSAGE
@tools/grant_access.sql select PIT_MESSAGE_GROUP
@tools/grant_access.sql select PIT_MESSAGE_LANGUAGE
@tools/grant_access.sql select PIT_MESSAGE_SEVERITY
@tools/grant_access.sql select PIT_MESSAGE_SEVERITY_V
@tools/grant_access.sql select PIT_TRACE_LEVEL
@tools/grant_access.sql select PIT_TRACE_LEVEL_V
@tools/grant_access.sql select PIT_MESSAGE_LANGUAGE_V
@tools/grant_access.sql select PIT_MESSAGE_V

alter session set current_schema=&REMOTE_USER.;

prompt &h3.Create UI-VIEWS
prompt &s1.View APEX_UI_LIST_MENU
@&apex_dir.views/apex_ui_list_menu.vw

prompt &s1.View PIT_UI_ADMIN_PMS
@&apex_dir.views/pit_ui_admin_pms.vw

prompt &s1.View PIT_UI_ADMIN_PAR
@&apex_dir.views/pit_ui_admin_par.vw

prompt &s1.View PIT_UI_EDIT_PGR
@&apex_dir.views/pit_ui_edit_pgr.vw

prompt &s1.View PIT_UI_ADMIN_PIT_CONTEXT
@&apex_dir.views/pit_ui_admin_pit_context.vw

prompt &s1.View PIT_UI_ADMIN_PIT_MODULE
@&apex_dir.views/pit_ui_admin_pit_module.vw

prompt &s1.View PIT_UI_ADMIN_PIT_TOGGLE
@&apex_dir.views/pit_ui_admin_pit_toggle.vw

prompt &s1.View PIT_UI_ADMIN_PIT_MODULE
@&apex_dir.views/pit_ui_admin_pit_module.vw

prompt &s1.View PIT_UI_EDIT_CONTEXT
@&apex_dir.views/pit_ui_edit_context.vw

prompt &s1.View PIT_UI_EDIT_MESSAGE_TRANS
@&apex_dir.views/pit_ui_edit_message_trans.vw

prompt &s1.View PIT_UI_EDIT_MODULE
@&apex_dir.views/pit_ui_edit_module.vw

prompt &s1.View PIT_UI_EDIT_PAR
@&apex_dir.views/pit_ui_edit_par.vw

prompt &s1.View PIT_UI_EDIT_PGR
@&apex_dir.views/pit_ui_edit_pgr.vw

prompt &s1.View PIT_UI_EDIT_PMG
@&apex_dir.views/pit_ui_edit_pmg.vw

prompt &s1.View PIT_UI_EDIT_PMS
@&apex_dir.views/pit_ui_edit_pms.vw

prompt &s1.View PIT_UI_EDIT_TOGGLE
@&apex_dir.views/pit_ui_edit_toggle.vw

prompt &s1.View PIT_UI_LANG_SETTINGS_DEFAULT
@&apex_dir.views/pit_ui_lang_settings_default.vw

prompt &s1.View PIT_UI_LIST_ACTIVE_FOR_PAGE
@&apex_dir.views/pit_ui_list_active_for_page.vw

prompt &s1.View PIT_UI_LOV_AVAILABLE_PACKAGES
@&apex_dir.views/pit_ui_lov_available_packages.vw

prompt &s1.View PIT_UI_LOV_BOOLEAN_TRI_STATE
@&apex_dir.views/pit_ui_lov_boolean_tri_state.vw

prompt &s1.View PIT_UI_LOV_CONTEXT
@&apex_dir.views/pit_ui_lov_context.vw

prompt &s1.View PIT_UI_LOV_MESSAGE_GROUP
@&apex_dir.views/pit_ui_lov_message_group.vw

prompt &s1.View PIT_UI_LOV_MESSAGE_LANGUAGE
@&apex_dir.views/pit_ui_lov_message_language.vw

prompt &s1.View PIT_UI_LOV_MESSAGE_SEVERITY
@&apex_dir.views/pit_ui_lov_message_severity.vw

prompt &s1.View PIT_UI_LOV_OUTPUT_MODULES
@&apex_dir.views/pit_ui_lov_output_modules.vw

prompt &s1.View PIT_UI_LOV_PARAMETER_GROUP
@&apex_dir.views/pit_ui_lov_parameter_group.vw

prompt &s1.View PIT_UI_LOV_PARAMETER_TYPE
@&apex_dir.views/pit_ui_lov_parameter_type.vw

prompt &s1.View PIT_UI_LOV_TRACE_LEVEL
@&apex_dir.views/pit_ui_lov_trace_level.vw


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

