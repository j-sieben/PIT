prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.4.00.08'
,p_default_workspace_id=>2990503753058468
,p_default_application_id=>110
,p_default_owner=>'APEX_BUCH'
);
end;
/
 
prompt APPLICATION 110 - PIT-Administration
--
-- Application Export:
--   Application:     110
--   Name:            PIT-Administration
--   Date and Time:   18:23 Friday June 5, 2020
--   Exported By:     BUCH_ADMIN
--   Flashback:       0
--   Export Type:     Application Export
--   Version:         5.1.4.00.08
--   Instance ID:     220158092942401
--

-- Application Statistics:
--   Pages:                     13
--     Items:                   54
--     Validations:             15
--     Processes:               26
--     Regions:                 36
--     Buttons:                 37
--     Dynamic Actions:         24
--   Shared Components:
--     Logic:
--     Navigation:
--       Lists:                  3
--       Breadcrumbs:            1
--         Entries:              5
--     Security:
--       Authentication:         1
--     User Interface:
--       Themes:                 1
--       Templates:
--         Page:                 9
--         Region:              13
--         Label:                5
--         List:                11
--         Popup LOV:            1
--         Calendar:             1
--         Breadcrumb:           1
--         Button:               3
--         Report:               9
--       LOVs:                  14
--       Shortcuts:              1
--       Plug-ins:               2
--     Globalization:
--       Messages:               1
--     Reports:
--   Supporting Objects:  Included

prompt --application/delete_application
begin
wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/create_application
begin
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_display_id=>nvl(wwv_flow_application_install.get_application_id,110)
,p_owner=>nvl(wwv_flow_application_install.get_schema,'APEX_BUCH')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'PIT-Administration')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'PIT')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'1B01909BF2F79725B04F511808F58A7A4D635D5483B1EF191A92C34EF2D1E267'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'5.0'
,p_flow_language=>'de'
,p_flow_language_derived_from=>'0'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(14740333816194098)
,p_application_tab_set=>0
,p_logo_image=>'TEXT:PIT-Administration'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=> nvl(wwv_flow_application_install.get_proxy,'')
,p_flow_version=>'release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200605175412'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>6
,p_ui_type_name => null
);
end;
/
prompt --application/shared_components/navigation/lists
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(7166933591486551)
,p_name=>'MainPageList'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null, label_value, target_value, is_current, image_value, image_attr_value, image_alt_value, attribute_01, attribute_02',
'  from apex_ui_list_menu',
' where list_name = ''Desktop Navigation Menu''',
'   and level_value = 2',
' order by display_sequence'))
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(14697746357194054)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(14741535318194109)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Startseite'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:MAIN:&SESSION.'
,p_list_item_icon=>'fa-dot-circle-o'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''MAIN'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16493900080751348)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'PIT administrieren'
,p_list_item_link_target=>'F?p=&APP_ALIAS.:ADMIN_PIT:&SESSION.'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_api.id(14741535318194109)
,p_list_text_01=>'Einsatzeinstellungen'
,p_list_text_02=>'Kontrolliert Kontexte, Toggles und zeigt die aktuelle Parametrierung'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''PIT'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(14758313152407172)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Meldungen administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_list_item_icon=>'fa-comment-o'
,p_parent_list_item_id=>wwv_flow_api.id(14741535318194109)
,p_list_text_01=>'Meldungen erzeugen und editieren'
,p_list_text_02=>'Verwaltung neuer Meldungen und Änderung bestehender'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''MESSAGE'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(15541215658299656)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Parameter administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PARAM:&SESSION.'
,p_list_item_icon=>'fa-cog'
,p_parent_list_item_id=>wwv_flow_api.id(14741535318194109)
,p_list_text_01=>'Parameter erstellen und editieren'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''PARAMETER'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16648530913023261)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Stammdaten'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:EXPORT:&SESSION.'
,p_list_item_icon=>'fa-exchange'
,p_parent_list_item_id=>wwv_flow_api.id(14741535318194109)
,p_list_text_01=>'Übersetzung und Export'
,p_list_text_02=>'Erlaubt die Erstellung von Skriptdateien zum Export oder zum Übersetzen'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''EXPORT'''))
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(14740117447194095)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(14740322403194097)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Log Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_current_for_pages=>'&LOGOUT_URL.'
);
end;
/
prompt --application/shared_components/files
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '76617220636F6E646573203D20636F6E646573207C7C207B7D3B0A636F6E6465732E706974203D20636F6E6465732E706974C2A07C7CC2A07B7D3B0A0A636F6E6465732E7069742E7574696C73203D207B0A2020636F6E74726F6C4578706F7274497465';
wwv_flow_api.g_varchar2_table(2) := '6D73203A2066756E6374696F6E28297B0A20200A20202020617065782E6974656D28274558504F52545F504D5327292E64697361626C6528293B0A20202020617065782E6974656D28275452414E534C4154455F504D5327292E64697361626C6528293B';
wwv_flow_api.g_varchar2_table(3) := '0A20202020617065782E6974656D28274558504F52545F50415227292E64697361626C6528293B0A20202020617065782E6974656D28275452414E534C4154455F50544927292E64697361626C6528293B0A20202020617065782E6974656D2827455850';
wwv_flow_api.g_varchar2_table(4) := '4F52545F50544927292E64697361626C6528293B0A202020200A2020202069662028617065782E6974656D28275031365F504D535F504D475F4C49535427292E67657456616C7565282920213D202222297B0A202020202020617065782E6974656D2827';
wwv_flow_api.g_varchar2_table(5) := '4558504F52545F504D5327292E656E61626C6528293B0A20202020202069662028617065782E6974656D28275031365F504D535F504D4C5F4E414D4527292E67657456616C7565282920213D202222297B0A2020202020202020617065782E6974656D28';
wwv_flow_api.g_varchar2_table(6) := '275452414E534C4154455F504D5327292E656E61626C6528293B0A2020202020207D0A202020207D3B0A202020200A2020202069662028617065782E6974656D28275031365F5054495F504D475F4C49535427292E67657456616C7565282920213D2022';
wwv_flow_api.g_varchar2_table(7) := '22297B0A202020202020617065782E6974656D28274558504F52545F50544927292E656E61626C6528293B0A20202020202069662028617065782E6974656D28275031365F5054495F504D4C5F4E414D4527292E67657456616C7565282920213D202222';
wwv_flow_api.g_varchar2_table(8) := '297B0A2020202020202020617065782E6974656D28275452414E534C4154455F50544927292E656E61626C6528293B0A2020202020207D0A202020207D3B0A202020200A2020202069662028617065782E6974656D28275031365F5041525F5047525F4C';
wwv_flow_api.g_varchar2_table(9) := '49535427292E67657456616C7565282920213D202222297B0A202020202020617065782E6974656D28274558504F52545F50415227292E656E61626C6528293B0A202020207D0A20207D0A7D3B';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(4680568065959831)
,p_file_name=>'condes.pit.utils.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(7161196976469171)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'LEGACY'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(7161239955469171)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'classic'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(7161591893469171)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IG'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(14697477679194054)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(14697623843194054)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'Ja'
,p_attribute_03=>'N'
,p_attribute_04=>'Nein'
,p_attribute_05=>'SELECT_LIST'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(14697660797194054)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(15572421716454137)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'PLUGIN_DE.CONDES.PLUGIN.SCT'
,p_attribute_01=>'de.condes.plugin.sct.apex_42_5_0'
);
end;
/
prompt --application/shared_components/security/authorizations
begin
null;
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_processes
begin
null;
end;
/
prompt --application/shared_components/logic/application_items
begin
null;
end;
/
prompt --application/shared_components/logic/application_computations
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(16640624451854825)
,p_lov_name=>'LOV_AVAILABLE_PACKAGES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_available_packages',
' order by d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(4360234584505429)
,p_lov_name=>'LOV_BOOLEAN_TRI_STATE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_boolean_tri_state'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(16641563226887637)
,p_lov_name=>'LOV_CONTEXT'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_context',
' order by d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(16615759936421551)
,p_lov_name=>'LOV_OUTPUT_MODULES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_output_modules',
' order by d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(15566601804385920)
,p_lov_name=>'LOV_PARAMETER_GROUP'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_parameter_group',
' order by d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(15566763295388506)
,p_lov_name=>'LOV_PARAMETER_TYPE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_parameter_type',
' order by d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(7202985735672469)
,p_lov_name=>'LOV_PIT_MESSAGE_GROUP'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_group',
' order by d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(14797368866154042)
,p_lov_name=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_language',
' order by pml_default_order nulls last, d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(14791062366926531)
,p_lov_name=>'LOV_PIT_MESSAGE_SEVERITY'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_severity',
' order by r desc'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(14791321473929664)
,p_lov_name=>'LOV_PIT_TRACE_LEVEL'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_trace_level',
' order by r desc'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(14798745919192011)
,p_lov_name=>'LOV_PML_DISPLAY_NAME'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, d as r',
'  from pit_ui_lov_message_language',
' where pml_in_use = ''Y'''))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(7204899142708215)
,p_lov_name=>'LOV_PML_NAME_IN_USE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_language',
' where pml_in_use = ''Y''',
' order by pml_default_order'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(4697683429869068)
,p_lov_name=>'LOV_PMS_PMG_IN_USE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_group',
' where has_message = 1',
' order by d'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(4697395185855318)
,p_lov_name=>'LOV_PTI_PMG_IN_USE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_group',
' where has_translatable_item = 1',
' order by d'))
);
end;
/
prompt --application/shared_components/navigation/trees
begin
null;
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(16650837890041154)
,p_group_name=>'EXPORT'
,p_group_desc=>'Export von Stammdaten'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(15536022370910683)
,p_group_name=>'MAIN'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(15536061605911403)
,p_group_name=>'MESSAGE'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(15536150023912708)
,p_group_name=>'PARAMETER'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(16496474367775761)
,p_group_name=>'PIT'
,p_group_desc=>'PIT-Administrationsseiten'
);
end;
/
prompt --application/comments
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(14741501339194109)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(14741858527194111)
,p_parent_id=>0
,p_short_name=>'Startseite'
,p_link=>'f?p=&APP_ALIAS.:MAIN:&SESSION.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(14765161411407201)
,p_parent_id=>wwv_flow_api.id(14741858527194111)
,p_short_name=>'Meldungen administrieren'
,p_link=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(16325130936045573)
,p_parent_id=>wwv_flow_api.id(14741858527194111)
,p_short_name=>'Parameter verwalten'
,p_link=>'f?p=&APP_ID.:6:&SESSION.'
,p_page_id=>6
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(16494731721751353)
,p_parent_id=>wwv_flow_api.id(14741858527194111)
,p_short_name=>'PIT administrieren'
,p_link=>'f?p=&APP_ID.:9:&SESSION.'
,p_page_id=>9
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(16656590293103829)
,p_parent_id=>wwv_flow_api.id(14741858527194111)
,p_short_name=>'Stammdaten exportieren und übersetzen'
,p_link=>'f?p=&APP_ALIAS.:EXPORT:&SESSION.'
,p_page_id=>16
);
end;
/
prompt --application/shared_components/user_interface/templates/page
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14697835859194059)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_internal_name=>'LEFT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'        <footer class="t-Footer">',
'          #APP_VERSION#',
'          #CUSTOMIZE#',
'          #SCREEN_READER_TOGGLE#',
'          #REGION_POSITION_05#',
'        </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14697936331194061)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698035718194061)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698171203194062)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698235372194062)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698394727194062)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698464442194062)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698574127194062)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698719111194062)
,p_page_template_id=>wwv_flow_api.id(14697835859194059)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14698734876194062)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_internal_name=>'LEFT_AND_RIGHT_SIDE_COLUMNS'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        #APP_VERSION#',
'        #CUSTOMIZE#',
'        #SCREEN_READER_TOGGLE#',
'        #REGION_POSITION_05#',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>false
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14698912091194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699011342194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699086426194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699133553194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699301058194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699392349194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699513085194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699556873194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699674607194062)
,p_page_template_id=>wwv_flow_api.id(14698734876194062)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14699778038194062)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_internal_name=>'MINIMAL_NO_NAVIGATION'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer">',
'          #APP_VERSION#',
'          #CUSTOMIZE#',
'          #SCREEN_READER_TOGGLE#',
'          #REGION_POSITION_05#',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>4
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699860286194062)
,p_page_template_id=>wwv_flow_api.id(14699778038194062)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14699948359194062)
,p_page_template_id=>wwv_flow_api.id(14699778038194062)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700058656194062)
,p_page_template_id=>wwv_flow_api.id(14699778038194062)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700222128194062)
,p_page_template_id=>wwv_flow_api.id(14699778038194062)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700234961194062)
,p_page_template_id=>wwv_flow_api.id(14699778038194062)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700390307194062)
,p_page_template_id=>wwv_flow_api.id(14699778038194062)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700500767194062)
,p_page_template_id=>wwv_flow_api.id(14699778038194062)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14700535711194062)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_internal_name=>'RIGHT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        #APP_VERSION#',
'        #CUSTOMIZE#',
'        #SCREEN_READER_TOGGLE#',
'        #REGION_POSITION_05#',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>false
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
,p_translate_this_template=>'N'
);
end;
/
begin
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700679264194062)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700735994194062)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700833163194062)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14700978972194064)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701119825194064)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701191083194064)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701246900194064)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701413913194064)
,p_page_template_id=>wwv_flow_api.id(14700535711194062)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14701513967194064)
,p_theme_id=>42
,p_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer">',
'          #APP_VERSION#',
'          #CUSTOMIZE#',
'          #SCREEN_READER_TOGGLE#',
'          #REGION_POSITION_05#',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>1
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701622847194064)
,p_page_template_id=>wwv_flow_api.id(14701513967194064)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701630121194064)
,p_page_template_id=>wwv_flow_api.id(14701513967194064)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701788074194064)
,p_page_template_id=>wwv_flow_api.id(14701513967194064)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14701878617194064)
,p_page_template_id=>wwv_flow_api.id(14701513967194064)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702023679194064)
,p_page_template_id=>wwv_flow_api.id(14701513967194064)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702083384194064)
,p_page_template_id=>wwv_flow_api.id(14701513967194064)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702148841194064)
,p_page_template_id=>wwv_flow_api.id(14701513967194064)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>false
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14702263222194064)
,p_theme_id=>42
,p_name=>'Login'
,p_internal_name=>'LOGIN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!doctype html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="html-login no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="html-login no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="html-login no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="html-login no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="html-login no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody--login no-anim #PAGE_CSS_CLASSES#" #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #REGION_POSITION_01#',
'  #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'  <div class="t-Body-wrap">',
'    <div class="t-Body-col t-Body-col--main">',
'      <div class="t-Login-container">',
'      #BODY#',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>6
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702345574194064)
,p_page_template_id=>wwv_flow_api.id(14702263222194064)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702427327194064)
,p_page_template_id=>wwv_flow_api.id(14702263222194064)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14702565779194064)
,p_theme_id=>42
,p_name=>'Master Detail'
,p_internal_name=>'MASTER_DETAIL'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-info" id="t_Body_info">',
'        #REGION_POSITION_02#',
'      </div>',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        #APP_VERSION#',
'        #CUSTOMIZE#',
'        #SCREEN_READER_TOGGLE#',
'        #REGION_POSITION_05#',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702632128194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702813966194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702859043194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14702925654194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703054002194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703202529194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703316064194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703397680194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703462200194064)
,p_page_template_id=>wwv_flow_api.id(14702565779194064)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14703622267194064)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_internal_name=>'MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-Dialog-page #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-wrapper">',
'    <div class="t-Dialog-header">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Dialog-body">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'    </div>',
'    <div class="t-Dialog-footer">',
'      #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'500'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_css_classes=>'t-Dialog--standard'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
,p_translate_this_template=>'N'
);
end;
/
begin
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703714323194064)
,p_page_template_id=>wwv_flow_api.id(14703622267194064)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703791788194064)
,p_page_template_id=>wwv_flow_api.id(14703622267194064)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14703886084194064)
,p_page_template_id=>wwv_flow_api.id(14703622267194064)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(14703955185194064)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_internal_name=>'WIZARD_MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-Dialog-page #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Wizard t-Wizard--modal">',
'    <div class=" t-Wizard-steps">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Wizard-body">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'    </div>',
'    <div class="t-Wizard-footer">',
'      #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'480'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_css_classes=>'t-Dialog--wizard'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14704097181194064)
,p_page_template_id=>wwv_flow_api.id(14703955185194064)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14704210069194064)
,p_page_template_id=>wwv_flow_api.id(14703955185194064)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(14704236371194064)
,p_page_template_id=>wwv_flow_api.id(14703955185194064)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/button
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(14734834221194084)
,p_template_name=>'Icon'
,p_internal_name=>'ICON'
,p_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"><'
||'/span></button>'
,p_hot_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-h'
||'idden="true"></span></button>'
,p_reference_id=>2347660919680321258
,p_translate_this_template=>'N'
,p_theme_class_id=>5
,p_theme_id=>42
);
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(14734925509194086)
,p_template_name=>'Text'
,p_internal_name=>'TEXT'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(14735052365194086)
,p_template_name=>'Text with Icon'
,p_internal_name=>'TEXT_WITH_ICON'
,p_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-label">#LABEL#'
||'</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-'
||'label">#LABEL#</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_reference_id=>2081382742158699622
,p_translate_this_template=>'N'
,p_theme_class_id=>4
,p_preset_template_options=>'t-Button--iconRight'
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/region
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14704374780194065)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #BODY#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">#PREVIOUS##CLOSE##CREATE##NEXT#</div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Alert'
,p_internal_name=>'ALERT'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2039236646100190748
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14704430297194065)
,p_plug_template_id=>wwv_flow_api.id(14704374780194065)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14705880823194067)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> ',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Blank with Attributes'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14705966597194067)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'   <div class="t-Region-carouselRegions">',
'     #SUB_REGIONS#',
'   </div>',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Carousel Container'
,p_internal_name=>'CAROUSEL_CONTAINER'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-Region--showCarouselControls'
,p_preset_template_options=>'t-Region--hiddenOverflow'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2865840475322558786
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14706095113194069)
,p_plug_template_id=>wwv_flow_api.id(14705966597194067)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14706143460194069)
,p_plug_template_id=>wwv_flow_api.id(14705966597194067)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14709504451194070)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-body js-regionDialog-body">',
'#BODY#',
'  </div>',
'  <div class="t-DialogRegion-buttons js-regionDialog-buttons">',
'     <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'       <div class="t-ButtonRegion-wrap">',
'         <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'         <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'       </div>',
'     </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Dialog'
,p_internal_name=>'INLINE_DIALOG'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal:js-draggable:js-resizable'
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2671226943886536762
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14709556193194070)
,p_plug_template_id=>wwv_flow_api.id(14709504451194070)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14710401710194070)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--content">',
'      <h2 class="t-ButtonRegion-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      #BODY#',
'      <div class="t-ButtonRegion-buttons">#CHANGE#</div>',
'    </div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Buttons Container'
,p_internal_name=>'BUTTONS_CONTAINER'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>17
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2124982336649579661
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14710470022194070)
,p_plug_template_id=>wwv_flow_api.id(14710401710194070)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14710528707194070)
,p_plug_template_id=>wwv_flow_api.id(14710401710194070)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14711184259194070)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls">',
'    <button class="t-Button t-Button--icon t-Button--hideShow" type="button"></button>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#EDIT#</div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#CLOSE#</div>',
'    <div class="t-Region-buttons-right">#CREATE#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #COPY#',
'     #BODY#',
'     #SUB_REGIONS#',
'     #CHANGE#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
' </div>',
'</div>'))
,p_page_plug_template_name=>'Collapsible'
,p_internal_name=>'COLLAPSIBLE'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>1
,p_preset_template_options=>'is-expanded:t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2662888092628347716
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14711306988194070)
,p_plug_template_id=>wwv_flow_api.id(14711184259194070)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14711390629194070)
,p_plug_template_id=>wwv_flow_api.id(14711184259194070)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14713304281194072)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-wrap">',
'    <div class="t-HeroRegion-col t-HeroRegion-col--left"><span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'      <h2 class="t-HeroRegion-title">#TITLE#</h2>',
'      #BODY#',
'    </div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--right"><div class="t-HeroRegion-form">#SUB_REGIONS#</div><div class="t-HeroRegion-buttons">#NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Hero'
,p_internal_name=>'HERO'
,p_theme_id=>42
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672571031438297268
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14713422350194072)
,p_plug_template_id=>wwv_flow_api.id(14713304281194072)
,p_name=>'Region Body'
,p_placeholder=>'#BODY#'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14713504681194072)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#" role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Interactive Report'
,p_internal_name=>'INTERACTIVE_REPORT'
,p_theme_id=>42
,p_theme_class_id=>9
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2099079838218790610
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14713805556194072)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <div class="t-Login-header">',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#"></span>',
'    <h1 class="t-Login-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'  </div>',
'  <div class="t-Login-body">',
'    #BODY#',
'  </div>',
'  <div class="t-Login-buttons">',
'    #NEXT#',
'  </div>',
'  <div class="t-Login-links">',
'    #EDIT##CREATE#',
'  </div>',
'  #SUB_REGIONS#',
'</div>'))
,p_page_plug_template_name=>'Login'
,p_internal_name=>'LOGIN'
,p_theme_id=>42
,p_theme_class_id=>23
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672711194551076376
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14713837298194072)
,p_plug_template_id=>wwv_flow_api.id(14713805556194072)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14714008353194072)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4070912133526059312
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14714096459194072)
,p_plug_template_id=>wwv_flow_api.id(14714008353194072)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14714193810194072)
,p_plug_template_id=>wwv_flow_api.id(14714008353194072)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14716082618194072)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES#" #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
'  #BODY#',
'  <div class="t-TabsRegion-items">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Tabs Container'
,p_internal_name=>'TABS_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14716160267194073)
,p_plug_template_id=>wwv_flow_api.id(14716082618194072)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14716279236194073)
,p_plug_template_id=>wwv_flow_api.id(14716082618194072)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14717261385194073)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-BreadcrumbRegion #REGION_CSS_CLASSES#"> ',
'  <div class="t-BreadcrumbRegion-body">',
'    <div class="t-BreadcrumbRegion-breadcrumb">',
'      #BODY#',
'    </div>',
'    <div class="t-BreadcrumbRegion-title">',
'      <h1 class="t-BreadcrumbRegion-titleText">#TITLE#</h1>',
'    </div>',
'  </div>',
'  <div class="t-BreadcrumbRegion-buttons">#PREVIOUS##CLOSE##DELETE##HELP##CHANGE##EDIT##COPY##CREATE##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Title Bar'
,p_internal_name=>'TITLE_BAR'
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BreadcrumbRegion--showBreadcrumb'
,p_preset_template_options=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2530016523834132090
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(14717733562194073)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Wizard #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Wizard-header">',
'    <h1 class="t-Wizard-title">#TITLE#</h1>',
'    <div class="u-Table t-Wizard-controls">',
'      <div class="u-Table-fit t-Wizard-buttons">#PREVIOUS##CLOSE#</div>',
'      <div class="u-Table-fill t-Wizard-steps">',
'        #BODY#',
'      </div>',
'      <div class="u-Table-fit t-Wizard-buttons">#NEXT#</div>',
'    </div>',
'  </div>',
'  <div class="t-Wizard-body">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Wizard Container'
,p_internal_name=>'WIZARD_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Wizard--hideStepsXSmall'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2117602213152591491
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(14717903569194073)
,p_plug_template_id=>wwv_flow_api.id(14717733562194073)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14726168879194078)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value"><a href="#LINK#" #A03#>#A01#</a></span>',
'</li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value"><a href="#LINK#" #A03#>#A01#</a></span>',
'</li>',
''))
,p_list_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_theme_id=>42
,p_theme_class_id=>3
,p_default_template_options=>'t-BadgeList--responsive'
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed'
,p_list_template_before_rows=>'<ul class="t-BadgeList t-BadgeList--circular #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14727877888194079)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--3cols:t-Cards--featured'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_reference_id=>2885322685880632508
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14729949315194081)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_internal_name=>'MENU_BAR'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_reference_id=>2008709236185638887
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14730501664194081)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" role="button">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" role="button">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Navigation Bar'
,p_internal_name=>'NAVIGATION_BAR'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<ul class="t-NavigationBar #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<div class="t-NavigationBar-menu" style="display: none" id="menu_#PARENT_LIST_ITEM_ID#"><ul>'
,p_after_sub_list=>'</ul></div></li>'
,p_sub_list_item_current=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_templ_noncurr_w_child=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_reference_id=>2846096252961119197
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14730539150194081)
,p_list_template_current=>'<li class="t-Tabs-item is-active"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-Tabs-item"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_name=>'Tabs'
,p_internal_name=>'TABS'
,p_theme_id=>42
,p_theme_class_id=>7
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>3288206686691809997
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14731482580194083)
,p_list_template_current=>'<li class="t-WizardSteps-step is-active" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></div></li>'
,p_list_template_noncurrent=>'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"><span class="t-Icon a-Icon icon-check"></span></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"'
||'></span></span></div></li>'
,p_list_template_name=>'Wizard Progress'
,p_internal_name=>'WIZARD_PROGRESS'
,p_javascript_code_onload=>'apex.theme.initWizardProgressBar();'
,p_theme_id=>42
,p_theme_class_id=>17
,p_preset_template_options=>'t-WizardSteps--displayLabels'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2 class="u-VisuallyHidden">#CURRENT_PROGRESS#</h2>',
'<ul class="t-WizardSteps #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'))
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>2008702338707394488
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14732019561194083)
,p_list_template_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_list_template_name=>'Links List'
,p_internal_name=>'LINKS_LIST'
,p_theme_id=>42
,p_theme_class_id=>18
,p_list_template_before_rows=>'<ul class="t-LinksList #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<ul class="t-LinksList-list">'
,p_after_sub_list=>'</ul>'
,p_sub_list_item_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_sub_list_item_noncurrent=>'<li class="t-LinksList-item#A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#<'
||'/span></a></li>'
,p_item_templ_curr_w_child=>'<li class="t-LinksList-item is-current is-expanded #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t'
||'-LinksList-badge">#A01#</span></a>#SUB_LISTS#</li>'
,p_item_templ_noncurr_w_child=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14732737779194083)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_internal_name=>'MENU_POPUP'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({ slide: e.hasClass("js-slide")});',
''))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Data ID'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut'
,p_reference_id=>3492264004432431646
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14732830743194083)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item  #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-MediaList--showDesc:t-MediaList--showIcons'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_reference_id=>2066548068783481421
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14733799587194083)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Side Navigation Menu'
,p_internal_name=>'SIDE_NAVIGATION_MENU'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''body'').addClass(''t-PageBody--leftNav'');',
''))
,p_theme_id=>42
,p_theme_class_id=>19
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav" id="t_Body_nav" role="navigation" aria-label="&APP_TITLE!ATTR.">',
'<div class="t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&APP_TITLE!ATTR."><ul style="display:none">'))
,p_list_template_after_rows=>'</ul></div></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True/False'
,p_a04_label=>'Title'
,p_reference_id=>2466292414354694776
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14733862962194083)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_internal_name=>'TOP_NAVIGATION_MENU'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True / False'
,p_a03_label=>'Hide'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut Key'
,p_reference_id=>2525307901300239072
);
end;
/
prompt --application/shared_components/user_interface/templates/report
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14718347501194073)
,p_row_template_name=>'Alerts'
,p_internal_name=>'ALERTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title">#ALERT_TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #ALERT_DESC#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      #ALERT_ACTION#',
'    </div>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="t-Alerts">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>14
,p_reference_id=>2881456138952347027
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14718503979194075)
,p_row_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
'  <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'  <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList t-BadgeList--circular #COMPONENT_CSS_CLASSES#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BadgeList--responsive'
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14720165765194075)
,p_row_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon"><span class="t-Icon #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Cards--3cols:t-Cards--featured'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14722308594194076)
,p_row_template_name=>'Comments'
,p_internal_name=>'COMMENTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'    <div class="t-Comments-icon a-MediaBlock-graphic">',
'        <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'    </div>',
'    <div class="t-Comments-body a-MediaBlock-content">',
'        <div class="t-Comments-info">',
'            #USER_NAME# &middot; <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'        </div>',
'        <div class="t-Comments-comment">',
'            #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>',
''))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Comments--chat'
,p_reference_id=>2611722012730764232
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14722722733194076)
,p_row_template_name=>'Search Results'
,p_internal_name=>'SEARCH_RESULTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition1=>':LABEL_02 is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition2=>':LABEL_03 is null'
,p_row_template3=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition3=>':LABEL_04 is null'
,p_row_template4=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'      <span class="t-SearchResults-misc">#LABEL_04#: #VALUE_04#</span>',
'    </div>',
'  </li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#">',
'<ul class="t-SearchResults-list">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070913431524059316
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14722782695194076)
,p_row_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES#>',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" summary="#REGION_TITLE#">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'      </tbody>',
'    </table>',
'    </div>',
'    <div class="t-Report-links">#EXTERNAL_LINK##CSV_LINK#</div>',
'    <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation">#PAGINATION#</table>',
'  </div>',
'</div>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_before_column_heading=>'<thead>'
,p_column_heading_template=>'<th class="t-Report-colHead" #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>'
,p_after_column_heading=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</thead>',
'<tbody>'))
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Report--altRowsDefault:t-Report--rowHighlight'
,p_reference_id=>2537207537838287671
,p_translate_this_template=>'N'
);
begin
wwv_flow_api.create_row_template_patch(
 p_id=>wwv_flow_api.id(14722782695194076)
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
);
exception when others then null;
end;
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14724053459194076)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_COLUMN'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES#>'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068636272681754
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14725044652194078)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068321678681753
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14726001171194078)
,p_row_template_name=>'Timeline'
,p_internal_name=>'TIMELINE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <div class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':EVENT_LINK is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <a href="#EVENT_LINK#" class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </a>',
'</li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Timeline #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_timeline">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_reference_id=>1513373588340069864
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(14734328599194084)
,p_template_name=>'Hidden'
,p_internal_name=>'HIDDEN'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer t-Form-labelContainer--hiddenLabel col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label u-VisuallyHidden">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--hiddenLabel rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#">'
,p_after_element=>'#HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(14734456304194084)
,p_template_name=>'Optional'
,p_internal_name=>'OPTIONAL'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>',
''))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#">'
,p_after_element=>'#HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(14734600634194084)
,p_template_name=>'Optional - Above'
,p_internal_name=>'OPTIONAL_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>#HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer">'
,p_after_element=>'#ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(14734643971194084)
,p_template_name=>'Required'
,p_internal_name=>'REQUIRED'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label><span class="t-Form-required"><span class="a-Icon icon-asterisk"></span></span>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#">'
,p_after_element=>'#HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(14734819134194084)
,p_template_name=>'Required - Above'
,p_internal_name=>'REQUIRED_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label><span class="t-Form-required"><span class="a-Icon icon-asterisk"></span></span> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer">'
,p_after_element=>'#ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb
begin
wwv_flow_api.create_menu_template(
 p_id=>wwv_flow_api.id(14735520260194086)
,p_name=>'Breadcrumb'
,p_internal_name=>'BREADCRUMB'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active"><span class="t-Breadcrumb-label">#NAME#</span></li>'
,p_non_current_page_option=>'<li class="t-Breadcrumb-item"><a href="#LINK#" class="t-Breadcrumb-label">#NAME#</a></li>'
,p_after_last=>'</ul>'
,p_max_levels=>6
,p_start_with_node=>'PARENT_TO_LEAF'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916542570059325
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/popuplov
begin
wwv_flow_api.create_popup_lov_template(
 p_id=>wwv_flow_api.id(14735686202194087)
,p_page_name=>'winlov'
,p_page_title=>'Search Dialog'
,p_page_html_head=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html lang="&BROWSER_LANGUAGE.">',
'<head>',
'<title>#TITLE#</title>',
'#APEX_CSS#',
'#THEME_CSS#',
'#THEME_STYLE_CSS#',
'#FAVICONS#',
'#APEX_JAVASCRIPT#',
'#THEME_JAVASCRIPT#',
'<meta name="viewport" content="width=device-width,initial-scale=1.0" />',
'</head>'))
,p_page_body_attr=>'onload="first_field()" class="t-Page t-Page--popupLOV"'
,p_before_field_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_filter_width=>'20'
,p_filter_max_width=>'100'
,p_filter_text_attr=>'class="t-Form-field t-Form-searchField"'
,p_find_button_text=>'Search'
,p_find_button_attr=>'class="t-Button t-Button--hot t-Button--padLeft"'
,p_close_button_text=>'Close'
,p_close_button_attr=>'class="t-Button u-pullRight"'
,p_next_button_text=>'Next &gt;'
,p_next_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_prev_button_text=>'&lt; Previous'
,p_prev_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_after_field_text=>'</div>'
,p_scrollbars=>'1'
,p_resizable=>'1'
,p_width=>'380'
,p_height=>'380'
,p_result_row_x_of_y=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_result_rows_per_pg=>100
,p_before_result_set=>'<div class="t-PopupLOV-links">'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>2885398517835871876
,p_translate_this_template=>'N'
,p_after_result_set=>'</div>'
);
end;
/
prompt --application/shared_components/user_interface/templates/calendar
begin
wwv_flow_api.create_calendar_template(
 p_id=>wwv_flow_api.id(14735592699194086)
,p_cal_template_name=>'Calendar'
,p_internal_name=>'CALENDAR'
,p_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>',
''))
,p_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_day_close_format=>'</td>'
,p_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_close_format=>'</td>'
,p_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_nonday_close_format=>'</td>'
,p_week_open_format=>'<tr>'
,p_week_close_format=>'</tr> '
,p_daily_title_format=>'<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'
,p_daily_open_format=>'<tr>'
,p_daily_close_format=>'</tr>'
,p_weekly_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--weekly">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_weekly_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_weekly_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_weekly_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_day_close_format=>'</div></td>'
,p_weekly_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_close_format=>'</div></td>'
,p_weekly_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_weekly_time_close_format=>'</th>'
,p_weekly_time_title_format=>'#TIME#'
,p_weekly_hour_open_format=>'<tr>'
,p_weekly_hour_close_format=>'</tr>'
,p_daily_day_of_week_format=>'<th scope="col" id="#DY#" class="t-ClassicCalendar-dayColumn">#IDAY#</th>'
,p_daily_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--daily">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #DD#, #YYYY#</h1>'))
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
,p_daily_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_daily_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_day_close_format=>'</div></td>'
,p_daily_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol" id="#TIME#">'
,p_daily_time_close_format=>'</th>'
,p_daily_time_title_format=>'#TIME#'
,p_daily_hour_open_format=>'<tr>'
,p_daily_hour_close_format=>'</tr>'
,p_cust_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="uCal">',
'<h1 class="uMonth">#IMONTH# <span>#YYYY#</span></h1>'))
,p_cust_day_of_week_format=>'<th scope="col" class="uCalDayCol" id="#DY#">#IDAY#</th>'
,p_cust_month_open_format=>'<table class="uCal" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'<div class="uCalFooter"></div>',
'</div>',
''))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="uDayTitle">#DD#</span>'
,p_cust_day_open_format=>'<td class="uDay" headers="#DY#"><div class="uDayData">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="uDay today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="uDayTitle">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="uDay nonday" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="uDayTitle weekendday">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="uDay" headers="#DY#">'
,p_cust_weekend_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="uDayData">#DATA#</span>',
'</td>'))
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="uCalHour" id="#TIME#">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="uCal uCalWeekly">',
'<h1 class="uMonth">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="uCalDayCol" id="#DY#">',
'  <span class="visible-desktop">#DD# #IDAY#</span>',
'  <span class="hidden-desktop">#DD# <em>#IDY#</em></span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="uCal">'
,p_cust_wk_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'<div class="uCalFooter"></div>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_title_format=>'<span class="uDayTitle">#DD#</span>'
,p_cust_wk_day_open_format=>'<td class="uDay" headers="#DY#"><div class="uDayData">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="uDay today" headers="#DY#"><div class="uDayData">'
,p_cust_wk_weekend_open_format=>'<td class="uDay weekend" headers="#DY#"><div class="uDayData">'
,p_cust_wk_weekend_close_format=>'</div></td>'
,p_agenda_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--list">',
'  <div class="t-ClassicCalendar-title">#IMONTH# #YYYY#</div>',
'  <ul class="t-ClassicCalendar-list">',
'    #DAYS#',
'  </ul>',
'</div>'))
,p_agenda_past_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-past">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_today_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-today">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_future_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-future">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_past_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-past">#DATA#</li>'
,p_agenda_today_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-today">#DATA#</li>'
,p_agenda_future_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-future">#DATA#</li>'
,p_month_data_format=>'#DAYS#'
,p_month_data_entry_format=>'<span class="t-ClassicCalendar-event">#DATA#</span>'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916747979059326
);
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(14736090817194090)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(14701513967194064)
,p_default_dialog_template=>wwv_flow_api.id(14703622267194064)
,p_error_template=>wwv_flow_api.id(14702263222194064)
,p_printer_friendly_template=>wwv_flow_api.id(14701513967194064)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(14702263222194064)
,p_default_button_template=>wwv_flow_api.id(14734925509194086)
,p_default_region_template=>wwv_flow_api.id(14714008353194072)
,p_default_chart_template=>wwv_flow_api.id(14714008353194072)
,p_default_form_template=>wwv_flow_api.id(14714008353194072)
,p_default_reportr_template=>wwv_flow_api.id(14714008353194072)
,p_default_tabform_template=>wwv_flow_api.id(14714008353194072)
,p_default_wizard_template=>wwv_flow_api.id(14714008353194072)
,p_default_menur_template=>wwv_flow_api.id(14717261385194073)
,p_default_listr_template=>wwv_flow_api.id(14714008353194072)
,p_default_irr_template=>wwv_flow_api.id(14713504681194072)
,p_default_report_template=>wwv_flow_api.id(14722782695194076)
,p_default_label_template=>wwv_flow_api.id(14734456304194084)
,p_default_menu_template=>wwv_flow_api.id(14735520260194086)
,p_default_calendar_template=>wwv_flow_api.id(14735592699194086)
,p_default_list_template=>wwv_flow_api.id(14732019561194083)
,p_default_nav_list_template=>wwv_flow_api.id(14733862962194083)
,p_default_top_nav_list_temp=>wwv_flow_api.id(14733862962194083)
,p_default_side_nav_list_temp=>wwv_flow_api.id(14733799587194083)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(14710401710194070)
,p_default_dialogr_template=>wwv_flow_api.id(14705880823194067)
,p_default_option_label=>wwv_flow_api.id(14734456304194084)
,p_default_required_label=>wwv_flow_api.id(14734643971194084)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(14730501664194081)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.0/')
,p_files_version=>62
,p_icon_library=>'FONTAWESOME'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#tooltipManager#MIN#.js?v=#APEX_VERSION#',
'#HAMMERJS_URL#',
'#THEME_IMAGES#js/modernizr-custom#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#plugins/com.oracle.apex.carousel/1.0/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(14735792850194089)
,p_theme_id=>42
,p_name=>'Vista'
,p_css_file_urls=>'#THEME_IMAGES#css/Vista#MIN#.css?v=#APEX_VERSION#'
,p_is_current=>false
,p_is_public=>false
,p_is_accessible=>false
,p_theme_roller_read_only=>true
,p_reference_id=>4007676303523989775
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(14735896893194089)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>true
,p_is_public=>false
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(14735943209194089)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_is_public=>false
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
,p_theme_roller_config=>'{"customCSS":"","vars":{"@g_Accent-BG":"#505f6d","@g_Accent-OG":"#ececec","@g_Body-Title-BG":"#dee1e4","@l_Link-Base":"#337ac0","@g_Body-BG":"#f5f5f5"}}'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_display_points
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14704629128194067)
,p_theme_id=>42
,p_name=>'ALERT_ICONS'
,p_display_name=>'Alert Icons'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets how icons are handled for the Alert Region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14704906212194067)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14705208640194067)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14706232138194069)
,p_theme_id=>42
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body height. You can also specify a custom height by modifying the Region''s CSS Classes and using the height helper classes "i-hXXX" where XXX is any increment of 10 from 100 to 800.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14706765713194069)
,p_theme_id=>42
,p_name=>'TIMER'
,p_display_name=>'Timer'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets the timer for when to automatically navigate to the next region within the Carousel Region.'
,p_null_text=>'No Timer'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14707493697194069)
,p_theme_id=>42
,p_name=>'ACCENT'
,p_display_name=>'Accent'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_help_text=>'Set the Region''s accent. This accent corresponds to a Theme-Rollable color and sets the background of the Region''s Header.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14708026744194069)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14708409320194069)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14708536034194069)
,p_theme_id=>42
,p_name=>'HEADER'
,p_display_name=>'Header'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Determines the display of the Region Header which also contains the Region Title.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14708783216194069)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the region is styled. Use the "Remove Borders" template option to remove the region''s borders and shadows.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14709708995194070)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14710778863194070)
,p_theme_id=>42
,p_name=>'BODY_PADDING'
,p_display_name=>'Body Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body padding for the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14711911019194072)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14716492673194073)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14716713110194073)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14716885957194073)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14717506257194073)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14718011033194073)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14718596360194075)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14719405773194075)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14720546273194075)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Controls the style and design of the cards in the report.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14720820885194075)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14721133522194075)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the amount of text to display for the Card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14721548449194076)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Controls how to handle icons in the report.'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14722398530194076)
,p_theme_id=>42
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the style in which comments are displayed.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14722875484194076)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14723059335194076)
,p_theme_id=>42
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of the Report''s borders.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14723460767194076)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14724165891194076)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14726276713194079)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14726513195194079)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14728292476194079)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14728436694194079)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14728849035194079)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14729308752194079)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14730946701194083)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14731588672194083)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14732491464194083)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14735206449194086)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14736144835194094)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14736401301194094)
,p_theme_id=>42
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>70
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the left of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14736592988194094)
,p_theme_id=>42
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>80
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the right of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14736757053194094)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the size of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14736975370194094)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>30
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the style of the button. Use the "Simple" option for secondary actions or sets of buttons. Use the "Remove UI Decoration" option to make the button appear as text.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14737379897194094)
,p_theme_id=>42
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>40
,p_template_types=>'BUTTON'
,p_help_text=>'Enables you to group many buttons together into a pill. You can use this option to specify where the button is within this set. Set the option to Default if this button is not part of a button set.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14738087275194094)
,p_theme_id=>42
,p_name=>'WIDTH'
,p_display_name=>'Width'
,p_display_sequence=>60
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the width of the button.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14738501579194094)
,p_theme_id=>42
,p_name=>'LABEL_POSITION'
,p_display_name=>'Label Position'
,p_display_sequence=>140
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the label relative to the form item.'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14738661927194094)
,p_theme_id=>42
,p_name=>'ITEM_SIZE'
,p_display_name=>'Item Size'
,p_display_sequence=>110
,p_template_types=>'REGION'
,p_help_text=>'Sets the size of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14738840453194094)
,p_theme_id=>42
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>130
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14739061367194094)
,p_theme_id=>42
,p_name=>'ITEM_PADDING'
,p_display_name=>'Item Padding'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the padding around items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14739374419194094)
,p_theme_id=>42
,p_name=>'ITEM_WIDTH'
,p_display_name=>'Item Width'
,p_display_sequence=>120
,p_template_types=>'REGION'
,p_help_text=>'Sets the width of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(14739683988194094)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14704526042194065)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14704791747194067)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(14704629128194067)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14704955000194067)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(14704906212194067)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14705077795194067)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(14704629128194067)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14705291982194067)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(14705208640194067)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14705390197194067)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(14704906212194067)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14705519816194067)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(14704629128194067)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14705607454194067)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(14704906212194067)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14705679245194067)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(14704906212194067)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14705756153194067)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14704374780194065)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(14705208640194067)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14706329264194069)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14706428242194069)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14706562245194069)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14706637822194069)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14706897580194069)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(14706765713194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707001084194069)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(14706765713194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707106144194069)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(14706765713194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707127730194069)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(14706765713194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707277763194069)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707363632194069)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707540953194069)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707683354194069)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707729144194069)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14707877779194069)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14708008970194069)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14708169444194069)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(14708026744194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14708303431194069)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(14708026744194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14708478222194069)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(14708409320194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14708636769194069)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(14708536034194069)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14708879066194069)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14708974925194069)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14709030164194069)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(14708536034194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14709147651194070)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(14708409320194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14709292009194070)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14709363199194070)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14705966597194067)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14709791464194070)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14709504451194070)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(14709708995194070)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14709869935194070)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14709504451194070)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(14709708995194070)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14709966422194070)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14709504451194070)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(14709708995194070)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14710065974194070)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14709504451194070)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14710165899194070)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14709504451194070)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14710319823194070)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14709504451194070)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14710683851194070)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(14710401710194070)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14710824972194070)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(14710401710194070)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(14710778863194070)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14711015829194070)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(14710401710194070)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14711092925194070)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(14710401710194070)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(14710778863194070)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14711490487194070)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14711575447194070)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14711668379194072)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14711769113194072)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712001342194072)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(14711911019194072)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712089180194072)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(14711911019194072)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712132824194072)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712310799194072)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712420487194072)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712475681194072)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712561978194072)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712720539194072)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(14708409320194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712789365194072)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712861102194072)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14712972199194072)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14713087588194072)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(14708409320194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14713180494194072)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14711184259194070)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14713550169194072)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14713504681194072)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14713714795194072)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14713504681194072)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714253860194072)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714413921194072)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714425575194072)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714592948194072)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(14706232138194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714711983194072)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714761467194072)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714864513194072)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14714941390194072)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715064703194072)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715180700194072)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(14707493697194069)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715234077194072)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(14708409320194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715414210194072)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(14708536034194069)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715465742194072)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715552453194072)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715689291194072)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715757733194072)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(14708536034194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715884077194072)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(14708409320194069)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14715967771194072)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14714008353194072)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(14708783216194069)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14716376386194073)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14716082618194072)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14716610081194073)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14716082618194072)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(14716492673194073)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14716760165194073)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14716082618194072)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(14716713110194073)
,p_template_types=>'REGION'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14716944443194073)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14716082618194072)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(14716885957194073)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14717096865194073)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14716082618194072)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(14716885957194073)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14717214457194073)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14716082618194072)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(14716713110194073)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14717394670194073)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(14717261385194073)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14717580429194073)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(14717261385194073)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(14717506257194073)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14717723355194073)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(14717261385194073)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(14717506257194073)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14718115733194073)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(14717733562194073)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(14718011033194073)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14718179497194073)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14717733562194073)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(14718011033194073)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14718261947194073)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(14717733562194073)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14718630817194075)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14718815693194075)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14718835692194075)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14718982676194075)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719047389194075)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719202212194075)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719256099194075)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719470164194075)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(14719405773194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719542444194075)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(14719405773194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719716158194075)
,p_theme_id=>42
,p_name=>'RESPONSIVE'
,p_display_name=>'Responsive'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--responsive'
,p_template_types=>'REPORT'
,p_help_text=>'Automatically resize badges to smaller sizes as screen becomes smaller.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719733847194075)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(14719405773194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14719891388194075)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14720015510194075)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(14719405773194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14720106315194075)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(14718503979194075)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(14719405773194075)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14720266574194075)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14720379763194075)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14720512508194075)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14720680609194075)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(14720546273194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14720837632194075)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Use Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--colorize'
,p_group_id=>wwv_flow_api.id(14720820885194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721007555194075)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721039925194075)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(14720546273194075)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721300042194075)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(14721133522194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721360890194075)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(14721133522194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721475359194076)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(14721133522194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721662693194076)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(14721548449194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721729730194076)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(14721548449194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721886452194076)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--featured'
,p_group_id=>wwv_flow_api.id(14720546273194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14721926314194076)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14722063363194076)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(14721133522194075)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14722131157194076)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(14720165765194075)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14722511387194076)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14722308594194076)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(14722398530194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14722590709194076)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14722308594194076)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(14722398530194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14722985524194076)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(14722875484194076)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723173620194076)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(14723059335194076)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723289817194076)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(14723059335194076)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723346015194076)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(14723059335194076)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723566406194076)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(14723460767194076)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723723888194076)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(14723460767194076)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723763559194076)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(14722875484194076)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723918465194076)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14723994233194076)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14722782695194076)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(14723059335194076)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724319253194076)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724420626194076)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724508904194078)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724595492194078)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724697004194078)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724765447194078)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724907476194078)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14724928113194078)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(14724053459194076)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725180304194078)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725321290194078)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725335737194078)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725448430194078)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725584652194078)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(14718596360194075)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725639232194078)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725725615194078)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14725895564194078)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(14725044652194078)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(14724165891194076)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14726122715194078)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(14726001171194078)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(14720546273194075)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact video of timeline with smaller font-sizes and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14726356282194079)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'.t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(14726276713194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14726596288194079)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14726684145194079)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14726734951194079)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14726873514194079)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14726988019194079)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727071414194079)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727190391194079)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727252960194079)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(14726276713194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727414375194079)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(14726276713194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727497402194079)
,p_theme_id=>42
,p_name=>'RESPONSIVE'
,p_display_name=>'Responsive'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--responsive'
,p_template_types=>'LIST'
,p_help_text=>'Automatically resize badges to smaller sizes as screen becomes smaller.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727616195194079)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(14726276713194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727638623194079)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727741748194079)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(14726168879194078)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(14726276713194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14727970413194079)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14728055649194079)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14728144009194079)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14728375054194079)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(14728292476194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14728529144194079)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Use Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--colorize'
,p_group_id=>wwv_flow_api.id(14728436694194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14728678051194079)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14728784302194079)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(14728292476194079)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14728942685194079)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(14728849035194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729087562194079)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(14728849035194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729133220194079)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(14728849035194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729376112194079)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(14729308752194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729486350194081)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(14729308752194079)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729573217194081)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--featured'
,p_group_id=>wwv_flow_api.id(14728292476194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729639538194081)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729779770194081)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(14728849035194079)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14729852639194081)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14730060753194081)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(14729949315194081)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14730148177194081)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14729949315194081)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14730319143194081)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14729949315194081)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14730394153194081)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14729949315194081)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14730697939194083)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(14730539150194081)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14730778886194083)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14730539150194081)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(14729308752194079)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14730842737194083)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14730539150194081)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(14729308752194079)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14731119795194083)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14730539150194081)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(14730946701194083)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14731197428194083)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14730539150194081)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(14728292476194079)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14731265883194083)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14730539150194081)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(14728292476194079)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14731414884194083)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(14730539150194081)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(14730946701194083)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14731632531194083)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14731482580194083)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(14731588672194083)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14731815212194083)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14731482580194083)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(14731588672194083)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14731892238194083)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14731482580194083)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(14731588672194083)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14732024974194083)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14732019561194083)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(14728292476194079)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14732197917194083)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14732019561194083)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14732283874194083)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14732019561194083)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14732363442194083)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14732019561194083)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14732580409194083)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14732019561194083)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(14732491464194083)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14732635811194083)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14732019561194083)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(14732491464194083)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14732982590194083)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733084390194083)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733165421194083)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733322610194083)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733379602194083)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(14726513195194079)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733515657194083)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733586216194083)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733709994194083)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14732830743194083)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Shows an icon for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14733935396194084)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(14733862962194083)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14734037368194084)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(14733862962194083)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14734196763194084)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(14733862962194083)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14734318400194084)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(14733862962194083)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14735312935194086)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(14735052365194086)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(14735206449194086)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14735359156194086)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(14735052365194086)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(14735206449194086)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14736308111194094)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(14736144835194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14736442895194094)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large Left Margin'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(14736401301194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14736662339194094)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large Right Margin'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(14736592988194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14736916696194094)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(14736757053194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737117197194094)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(14736975370194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737134414194094)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small Left Margin'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(14736401301194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737320416194094)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small Right Margin'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(14736592988194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737452297194094)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(14737379897194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737544017194094)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(14737379897194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737689847194094)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(14737379897194094)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737767235194094)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(14736144835194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737870354194094)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(14736975370194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14737963880194094)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(14736757053194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14738208528194094)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(14738087275194094)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14738229024194094)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(14736144835194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14738421118194094)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(14736144835194094)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14738552373194094)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(14738501579194094)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14738726601194094)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(14738661927194094)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14739020192194094)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(14738840453194094)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14739222626194094)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(14739061367194094)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14739239109194094)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(14739061367194094)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14739474619194094)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(14739374419194094)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14739596011194094)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(14738661927194094)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14739743182194095)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(14739683988194094)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14739875319194095)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14740012647194095)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(14739683988194094)
,p_template_types=>'FIELD'
);
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/globalization/translations
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(16660105354344486)
,p_name=>'ORACLE_ERROR_HINT'
,p_message_language=>'de'
,p_message_text=>'<h2>Oracle-Fehlermapping</h2><p>Wenn Sie einen Oracle-Fehler auf eine PIT-Meldung abbilden möchten, beachten Sie:</p><ul><li>Bereits vordefinierte Fehler können nicht überschrieben werden (z.B. NO_DATA_FOUND)</li><li>Oracle-Fehlernummern können nur e'
||'inmal von PIT überschrieben werden</li></ul><p>Da Oracle-Fehler nur einmal gemappt werden können, sollte der Bezeichner möglichst generisch gewählt werden.<br>Verwenden Sie eine Namenskonvention mit Schema- oder Bereichspräfixen, beachten Sie, dass d'
||'iese Fehlermappings übergreifend verwendet werden müssen und daher eine entsprechende Namenskonvention benötigen.</p><p>Um einen Oracle-Fehler mit mehreren Meldungen zu verbinden, definieren Sie eine Oracle-Fehlernachricht und separate Meldungen. Im '
||'Exception-Block des Codes fangen Sie dann den benannten Oracle-Fehler und geben die spezifische Nachricht aus.</p>'
);
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts
begin
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(14750900737407054)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>'Bitte bestätigen Sie, dass die Daten gelöscht werden sollen.'
);
end;
/
prompt --application/shared_components/security/authentications
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(14740333816194098)
,p_name=>'APEX'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/shared_components/plugins/item_type/de_condes_apex_plugin_codemirror
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(51464337394665259)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'DE.CONDES.APEX.PLUGIN.CODEMIRROR'
,p_display_name=>'CodeMirror'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('ITEM TYPE','DE.CONDES.APEX.PLUGIN.CODEMIRROR'),'../i/libraries/codemirror/4.4/')
,p_css_file_urls=>'#PLUGIN_PREFIX#plsql.js'
,p_api_version=>1
,p_render_function=>'plugin_code_mirror.render_code_mirror'
,p_ajax_function=>'plugin_code_mirror.refresh_code_mirror'
,p_validation_function=>'plugin_code_mirror.validate_code_mirror'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:SOURCE:ELEMENT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h1>',
'	Code-Mirror-Plugin</h1>',
'<p>',
'	CodeMirror is a free code editor coded in JavaScript. For further information see the About URL.</p>',
'<h2>',
'	Usage</h2>',
'<p>',
'	You use this plug-in as any normal item plug-in by installing it and then referencing it on the page.</p>',
'<p>',
'	There are three mandatory and one optional parameter to define:</p>',
'<ol>',
'	<li>',
'		EditorId<br />',
'		This is a unique ID for the given Page (as a convention, use &quot;P&lt;page_number&gt;_&lt;Your_Name&gt;&quot;) which will be used internally to allow for multiple usages of the plug-in on one page</li>',
'	<li>',
'		Method<br />',
'		Define the language you&#39;d like to support. The selection of method is according to the method name attribut of codemirror</li>',
'	<li>',
'		Theme<br />',
'		Choose an appearance style. As with method, any provided theme of codemirror is allowed. If you don&#39;t want to bother with this, simply select the default theme.</li>',
'	<li>',
'		Options<br />',
'		This parameter expects an optional Options object as defined within codemirror. You may set any option codemirror offers, but I&#39;d like to repeat the warning that no checks are being performed, so choosing any options is at your own risk.</li>',
'	<li>',
'		ItemValue<br />',
'		Enter a SQL query that reads the content of the element from the database. You may reference any page or application item using the v(&#39;&lt;Name of the item&gt;&#39;) function.</li>',
'	<li>',
'		Label<br />',
'		Enter a label for the element. It will be displayed above the item.</li>',
'</ol>'))
,p_version_identifier=>'1.0.0'
,p_about_url=>'http://codemirror.net'
,p_files_version=>3
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(51465040080684909)
,p_plugin_id=>wwv_flow_api.id(51464337394665259)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Method'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'text/x-plsql'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51465627398690772)
,p_plugin_attribute_id=>wwv_flow_api.id(51465040080684909)
,p_display_sequence=>10
,p_display_value=>'SQL bzw. PL/SQL'
,p_return_value=>'text/x-plsql'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51466440904694653)
,p_plugin_attribute_id=>wwv_flow_api.id(51465040080684909)
,p_display_sequence=>20
,p_display_value=>'JavaScript'
,p_return_value=>'text/javascript'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51466812638695899)
,p_plugin_attribute_id=>wwv_flow_api.id(51465040080684909)
,p_display_sequence=>30
,p_display_value=>'JavaScript JSON'
,p_return_value=>'application/json'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51467326836700007)
,p_plugin_attribute_id=>wwv_flow_api.id(51465040080684909)
,p_display_sequence=>40
,p_display_value=>'XML'
,p_return_value=>'application/xml'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51467730992701247)
,p_plugin_attribute_id=>wwv_flow_api.id(51465040080684909)
,p_display_sequence=>50
,p_display_value=>'HTML'
,p_return_value=>'text/html'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51475736317112722)
,p_plugin_attribute_id=>wwv_flow_api.id(51465040080684909)
,p_display_sequence=>60
,p_display_value=>'CSS'
,p_return_value=>'text/css'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(51470923184985936)
,p_plugin_id=>wwv_flow_api.id(51464337394665259)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Theme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'default'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51471525262986485)
,p_plugin_attribute_id=>wwv_flow_api.id(51470923184985936)
,p_display_sequence=>10
,p_display_value=>'Night'
,p_return_value=>'night'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51471926647986954)
,p_plugin_attribute_id=>wwv_flow_api.id(51470923184985936)
,p_display_sequence=>20
,p_display_value=>'Neat'
,p_return_value=>'neat'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51472329764987805)
,p_plugin_attribute_id=>wwv_flow_api.id(51470923184985936)
,p_display_sequence=>30
,p_display_value=>'Elegant'
,p_return_value=>'elegant'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(51472731842988424)
,p_plugin_attribute_id=>wwv_flow_api.id(51470923184985936)
,p_display_sequence=>40
,p_display_value=>'Default'
,p_return_value=>'default'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(51468712422705340)
,p_plugin_id=>wwv_flow_api.id(51464337394665259)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Options'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'lineNumbers: true,',
'matchBrackets: true,',
'indentUnit: 2'))
,p_is_translatable=>false
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '436F64654D6972726F722E646566696E654D6F64652822706C73716C222C2066756E6374696F6E28636F6E6669672C20706172736572436F6E66696729207B0D0A202076617220696E64656E74556E6974202020202020203D20636F6E6669672E696E64';
wwv_flow_api.g_varchar2_table(2) := '656E74556E69742C0D0A2020202020206B6579776F7264732020202020202020203D20706172736572436F6E6669672E6B6579776F7264732C0D0A20202020202066756E6374696F6E7320202020202020203D20706172736572436F6E6669672E66756E';
wwv_flow_api.g_varchar2_table(3) := '6374696F6E732C0D0A20202020202074797065732020202020202020202020203D20706172736572436F6E6669672E74797065732C0D0A20202020202073716C706C7573202020202020202020203D20706172736572436F6E6669672E73716C706C7573';
wwv_flow_api.g_varchar2_table(4) := '2C0D0A2020202020206D756C74694C696E65537472696E6773203D20706172736572436F6E6669672E6D756C74694C696E65537472696E67733B0D0A20207661722069734F70657261746F72436861722020203D202F5B2B5C2D2A26253D3C3E213F3A5C';
wwv_flow_api.g_varchar2_table(5) := '2F7C5D2F3B0D0A202066756E6374696F6E20636861696E2873747265616D2C2073746174652C206629207B0D0A2020202073746174652E746F6B656E697A65203D20663B0D0A2020202072657475726E20662873747265616D2C207374617465293B0D0A';
wwv_flow_api.g_varchar2_table(6) := '20207D0D0A0D0A202076617220747970653B0D0A202066756E6374696F6E207265742874702C207374796C6529207B0D0A2020202074797065203D2074703B0D0A2020202072657475726E207374796C653B0D0A20207D0D0A0D0A202066756E6374696F';
wwv_flow_api.g_varchar2_table(7) := '6E20746F6B656E426173652873747265616D2C20737461746529207B0D0A20202020766172206368203D2073747265616D2E6E65787428293B0D0A202020202F2F207374617274206F6620737472696E673F0D0A20202020696620286368203D3D202722';
wwv_flow_api.g_varchar2_table(8) := '27207C7C206368203D3D20222722290D0A20202020202072657475726E20636861696E2873747265616D2C2073746174652C20746F6B656E537472696E6728636829293B0D0A202020202F2F206973206974206F6E65206F662074686520737065636961';
wwv_flow_api.g_varchar2_table(9) := '6C207369676E73205B5D7B7D28292E2C3B3F20536570657261746F723F0D0A20202020656C736520696620282F5B5C5B5C5D7B7D5C285C292C3B5C2E5D2F2E7465737428636829290D0A20202020202072657475726E20726574286368293B0D0A202020';
wwv_flow_api.g_varchar2_table(10) := '202F2F207374617274206F662061206E756D6265722076616C75653F0D0A20202020656C736520696620282F5C642F2E746573742863682929207B0D0A20202020202073747265616D2E6561745768696C65282F5B5C775C2E5D2F293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(11) := '2072657475726E2072657428226E756D626572222C20226E756D62657222293B0D0A202020207D0D0A202020202F2F206D756C7469206C696E6520636F6D6D656E74206F722073696D706C65206F70657261746F723F0D0A20202020656C736520696620';
wwv_flow_api.g_varchar2_table(12) := '286368203D3D20222F2229207B0D0A2020202020206966202873747265616D2E65617428222A222929207B0D0A202020202020202072657475726E20636861696E2873747265616D2C2073746174652C20746F6B656E436F6D6D656E74293B0D0A202020';
wwv_flow_api.g_varchar2_table(13) := '2020207D0D0A202020202020656C7365207B0D0A202020202020202073747265616D2E6561745768696C652869734F70657261746F7243686172293B0D0A202020202020202072657475726E2072657428226F70657261746F72222C20226F7065726174';
wwv_flow_api.g_varchar2_table(14) := '6F7222293B0D0A2020202020207D0D0A202020207D0D0A202020202F2F2073696E676C65206C696E6520636F6D6D656E74206F722073696D706C65206F70657261746F723F0D0A20202020656C736520696620286368203D3D20222D2229207B0D0A2020';
wwv_flow_api.g_varchar2_table(15) := '202020206966202873747265616D2E65617428222D222929207B0D0A202020202020202073747265616D2E736B6970546F456E6428293B0D0A202020202020202072657475726E207265742822636F6D6D656E74222C2022636F6D6D656E7422293B0D0A';
wwv_flow_api.g_varchar2_table(16) := '2020202020207D0D0A202020202020656C7365207B0D0A202020202020202073747265616D2E6561745768696C652869734F70657261746F7243686172293B0D0A202020202020202072657475726E2072657428226F70657261746F72222C20226F7065';
wwv_flow_api.g_varchar2_table(17) := '7261746F7222293B0D0A2020202020207D0D0A202020207D0D0A202020202F2F20706C2F73716C207661726961626C653F0D0A20202020656C736520696620286368203D3D20224022207C7C206368203D3D2022242229207B0D0A202020202020737472';
wwv_flow_api.g_varchar2_table(18) := '65616D2E6561745768696C65282F5B5C775C645C245F5D2F293B0D0A20202020202072657475726E207265742822776F7264222C20227661726961626C6522293B0D0A202020207D0D0A202020202F2F2069732069742061206F70657261746F723F0D0A';
wwv_flow_api.g_varchar2_table(19) := '20202020656C7365206966202869734F70657261746F72436861722E746573742863682929207B0D0A20202020202073747265616D2E6561745768696C652869734F70657261746F7243686172293B0D0A20202020202072657475726E2072657428226F';
wwv_flow_api.g_varchar2_table(20) := '70657261746F72222C20226F70657261746F7222293B0D0A202020207D0D0A20202020656C7365207B0D0A2020202020202F2F20676574207468652077686F6C6520776F72640D0A20202020202073747265616D2E6561745768696C65282F5B5C775C24';
wwv_flow_api.g_varchar2_table(21) := '5F5D2F293B0D0A2020202020202F2F206973206974206F6E65206F6620746865206C6973746564206B6579776F7264733F0D0A202020202020696620286B6579776F726473202626206B6579776F7264732E70726F70657274794973456E756D65726162';
wwv_flow_api.g_varchar2_table(22) := '6C652873747265616D2E63757272656E7428292E746F4C6F77657243617365282929292072657475726E2072657428226B6579776F7264222C20226B6579776F726422293B0D0A2020202020202F2F206973206974206F6E65206F6620746865206C6973';
wwv_flow_api.g_varchar2_table(23) := '7465642066756E6374696F6E733F0D0A2020202020206966202866756E6374696F6E732026262066756E6374696F6E732E70726F70657274794973456E756D657261626C652873747265616D2E63757272656E7428292E746F4C6F776572436173652829';
wwv_flow_api.g_varchar2_table(24) := '29292072657475726E2072657428226B6579776F7264222C20226275696C74696E22293B0D0A2020202020202F2F206973206974206F6E65206F6620746865206C69737465642074797065733F0D0A202020202020696620287479706573202626207479';
wwv_flow_api.g_varchar2_table(25) := '7065732E70726F70657274794973456E756D657261626C652873747265616D2E63757272656E7428292E746F4C6F77657243617365282929292072657475726E2072657428226B6579776F7264222C20227661726961626C652D3222293B0D0A20202020';
wwv_flow_api.g_varchar2_table(26) := '20202F2F206973206974206F6E65206F6620746865206C69737465642073716C706C7573206B6579776F7264733F0D0A2020202020206966202873716C706C75732026262073716C706C75732E70726F70657274794973456E756D657261626C65287374';
wwv_flow_api.g_varchar2_table(27) := '7265616D2E63757272656E7428292E746F4C6F77657243617365282929292072657475726E2072657428226B6579776F7264222C20227661726961626C652D3322293B0D0A2020202020202F2F2064656661756C743A206A75737420612022776F726422';
wwv_flow_api.g_varchar2_table(28) := '0D0A20202020202072657475726E207265742822776F7264222C2022706C73716C2D776F726422293B0D0A202020207D0D0A20207D0D0A0D0A202066756E6374696F6E20746F6B656E537472696E672871756F746529207B0D0A2020202072657475726E';
wwv_flow_api.g_varchar2_table(29) := '2066756E6374696F6E2873747265616D2C20737461746529207B0D0A2020202020207661722065736361706564203D2066616C73652C206E6578742C20656E64203D2066616C73653B0D0A2020202020207768696C652028286E657874203D2073747265';
wwv_flow_api.g_varchar2_table(30) := '616D2E6E65787428292920213D206E756C6C29207B0D0A2020202020202020696620286E657874203D3D2071756F746520262620216573636170656429207B656E64203D20747275653B20627265616B3B7D0D0A20202020202020206573636170656420';
wwv_flow_api.g_varchar2_table(31) := '3D202165736361706564202626206E657874203D3D20225C5C223B0D0A2020202020207D0D0A20202020202069662028656E64207C7C20212865736361706564207C7C206D756C74694C696E65537472696E677329290D0A202020202020202073746174';
wwv_flow_api.g_varchar2_table(32) := '652E746F6B656E697A65203D20746F6B656E426173653B0D0A20202020202072657475726E207265742822737472696E67222C2022706C73716C2D737472696E6722293B0D0A202020207D3B0D0A20207D0D0A0D0A202066756E6374696F6E20746F6B65';
wwv_flow_api.g_varchar2_table(33) := '6E436F6D6D656E742873747265616D2C20737461746529207B0D0A20202020766172206D61796265456E64203D2066616C73652C2063683B0D0A202020207768696C6520286368203D2073747265616D2E6E657874282929207B0D0A2020202020206966';
wwv_flow_api.g_varchar2_table(34) := '20286368203D3D20222F22202626206D61796265456E6429207B0D0A202020202020202073746174652E746F6B656E697A65203D20746F6B656E426173653B0D0A2020202020202020627265616B3B0D0A2020202020207D0D0A2020202020206D617962';
wwv_flow_api.g_varchar2_table(35) := '65456E64203D20286368203D3D20222A22293B0D0A202020207D0D0A2020202072657475726E207265742822636F6D6D656E74222C2022706C73716C2D636F6D6D656E7422293B0D0A20207D0D0A0D0A20202F2F20496E746572666163650D0A0D0A2020';
wwv_flow_api.g_varchar2_table(36) := '72657475726E207B0D0A20202020737461727453746174653A2066756E6374696F6E2862617365636F6C756D6E29207B0D0A20202020202072657475726E207B0D0A2020202020202020746F6B656E697A653A20746F6B656E426173652C0D0A20202020';
wwv_flow_api.g_varchar2_table(37) := '2020202073746172744F664C696E653A20747275650D0A2020202020207D3B0D0A202020207D2C0D0A0D0A20202020746F6B656E3A2066756E6374696F6E2873747265616D2C20737461746529207B0D0A2020202020206966202873747265616D2E6561';
wwv_flow_api.g_varchar2_table(38) := '7453706163652829292072657475726E206E756C6C3B0D0A202020202020766172207374796C65203D2073746174652E746F6B656E697A652873747265616D2C207374617465293B0D0A20202020202072657475726E207374796C653B0D0A202020207D';
wwv_flow_api.g_varchar2_table(39) := '0D0A20207D3B0D0A7D293B0D0A0D0A2866756E6374696F6E2829207B0D0A202066756E6374696F6E206B6579776F7264732873747229207B0D0A20202020766172206F626A203D207B7D2C20776F726473203D207374722E73706C697428222022293B0D';
wwv_flow_api.g_varchar2_table(40) := '0A20202020666F7220287661722069203D20303B2069203C20776F7264732E6C656E6774683B202B2B6929206F626A5B776F7264735B695D5D203D20747275653B0D0A2020202072657475726E206F626A3B0D0A20207D0D0A202076617220634B657977';
wwv_flow_api.g_varchar2_table(41) := '6F726473203D202261626F727420616363657074206163636573732061646420616C6C20616C74657220616E6420616E792061727261792061727261796C656E20617320617363206173736572742061737369676E206174206174747269627574657320';
wwv_flow_api.g_varchar2_table(42) := '61756469742022202B0D0A202020202020202022617574686F72697A6174696F6E206176672022202B0D0A202020202020202022626173655F7461626C6520626567696E206265747765656E2062696E6172795F696E746567657220626F647920626F6F';
wwv_flow_api.g_varchar2_table(43) := '6C65616E2062792022202B0D0A202020202020202022636173652063617374206368617220636861725F6261736520636865636B20636C6F736520636C757374657220636C75737465727320636F6C6175746820636F6C756D6E20636F6D6D656E742063';
wwv_flow_api.g_varchar2_table(44) := '6F6D6D697420636F6D707265737320636F6E6E6563742022202B0D0A202020202020202022636F6E6E656374656420636F6E7374616E7420636F6E73747261696E74206372617368206372656174652063726F73732063757272656E7420637572727661';
wwv_flow_api.g_varchar2_table(45) := '6C20637572736F722022202B0D0A202020202020202022646174615F62617365206461746162617365206461746520646261206465616C6C6F636174652064656275676F66662064656275676F6E20646563696D616C206465636C617265206465666175';
wwv_flow_api.g_varchar2_table(46) := '6C7420646566696E6974696F6E2064656C61792064656C6574652022202B0D0A202020202020202022646573632064696769747320646973706F73652064697374696E637420646F2064726F702022202B0D0A202020202020202022656C736520656C73';
wwv_flow_api.g_varchar2_table(47) := '696620656E61626C6520656E6420656E7472792065736361706520657863657074696F6E20657863657074696F6E5F696E69742065786368616E6765206578636C75736976652065786973747320657869742065787465726E616C2022202B0D0A202020';
wwv_flow_api.g_varchar2_table(48) := '202020202022666173742066657463682066696C6520666F7220666F72636520666F726D2066726F6D2066756C6C2066756E6374696F6E2022202B0D0A20202020202020202267656E6572696320676F746F206772616E742067726F75702022202B0D0A';
wwv_flow_api.g_varchar2_table(49) := '202020202020202022686176696E672022202B0D0A2020202020202020226964656E74696669656420696620696D6D65646961746520696E20696E6372656D656E7420696E64657820696E646578657320696E64696361746F7220696E697469616C2069';
wwv_flow_api.g_varchar2_table(50) := '6E697472616E7320696E6E657220696E7365727420696E7465726661636520696E7465727365637420696E746F2069732022202B0D0A2020202020202020226A6F696E2022202B0D0A2020202020202020226B65792022202B0D0A202020202020202022';
wwv_flow_api.g_varchar2_table(51) := '6C656674206C6576656C206C696272617279206C696B65206C696D69746564206C6F63616C206C6F636B206C6F67206C6F6767696E67206C6F6E67206C6F6F702022202B0D0A2020202020202020226D6173746572206D6178657874656E7473206D6178';
wwv_flow_api.g_varchar2_table(52) := '7472616E73206D656D626572206D696E657874656E7473206D696E7573206D69736C6162656C206D6F6465206D6F64696679206D756C74697365742022202B0D0A2020202020202020226E6577206E657874206E6F206E6F6175646974206E6F636F6D70';
wwv_flow_api.g_varchar2_table(53) := '72657373206E6F6C6F6767696E67206E6F706172616C6C656C206E6F74206E6F77616974206E756D6265725F626173652022202B0D0A2020202020202020226F626A656374206F66206F6666206F66666C696E65206F6E206F6E6C696E65206F6E6C7920';
wwv_flow_api.g_varchar2_table(54) := '6F70656E206F7074696F6E206F72206F72646572206F7574206F757465722022202B0D0A2020202020202020227061636B61676520706172616C6C656C20706172746974696F6E207063746672656520706374696E637265617365207063747573656420';
wwv_flow_api.g_varchar2_table(55) := '706C735F696E746567657220706F73697469766520706F7369746976656E20707261676D61207072696D617279207072696F7220707269766174652070726976696C656765732070726F636564757265207075626C69632022202B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(56) := '202272616973652072616E67652072617720726561642072656275696C64207265636F726420726566207265666572656E63657320726566726573682072656C656173652072656E616D65207265706C616365207265736F757263652072657374726963';
wwv_flow_api.g_varchar2_table(57) := '742072657475726E2022202B0D0A20202020202020202272657475726E696E672072657665727365207265766F6B6520726967687420726F6C6C6261636B20726F7720726F77696420726F776C6162656C20726F776E756D20726F77732072756E202220';
wwv_flow_api.g_varchar2_table(58) := '2B0D0A20202020202020202273617665706F696E7420736368656D61207365676D656E742073656C6563742073657061726174652073657373696F6E20736574207368617265207369626C696E677320736E617073686F7420736F6D6520737061636520';
wwv_flow_api.g_varchar2_table(59) := '73706C69742073716C2073746172742073746174656D656E742022202B0D0A20202020202020202273746F726167652073756274797065207375636365737366756C2073796E6F6E796D2022202B0D0A2020202020202020227461626175746820746162';
wwv_flow_api.g_varchar2_table(60) := '6C65207461626C6573207461626C657370616365207461736B207465726D696E617465207468656E20746F2074726967676572207472756E6361746520747970652022202B0D0A202020202020202022756E696F6E20756E6971756520756E6C696D6974';
wwv_flow_api.g_varchar2_table(61) := '656420756E7265636F76657261626C6520756E757361626C652075706461746520757365207573696E672022202B0D0A20202020202020202276616C69646174652076616C75652076616C756573207661726961626C6520766965772076696577732022';
wwv_flow_api.g_varchar2_table(62) := '202B0D0A2020202020202020227768656E207768656E65766572207768657265207768696C65207769746820776F726B223B0D0A0D0A2020766172206346756E6374696F6E73203D20226162732061636F73206164645F6D6F6E74687320617070656E64';
wwv_flow_api.g_varchar2_table(63) := '6368696C64786D6C206173636969206173636969737472206173696E206174616E206174616E32206176672022202B0D0A2020202020202020226266696C656E616D652062696E5F746F5F6E756D20626974616E642022202B0D0A202020202020202022';
wwv_flow_api.g_varchar2_table(64) := '63617264696E616C6974792063617374206365696C2063686172746F726F7769642063687220636C75737465725F696420636C75737465725F70726F626162696C69747920636C75737465725F73657420636F616C6573636520636F6C6C65637420636F';
wwv_flow_api.g_varchar2_table(65) := '6D706F736520636F6E63617420636F6E766572742022202B0D0A202020202020202022636F727220636F72725F7320636F72725F6B20636F7320636F736820636F756E7420636F7661725F706F7020636F7661725F73616D7020637562652063756D655F';
wwv_flow_api.g_varchar2_table(66) := '646973742063757272656E745F646174652063757272656E745F74696D657374616D702063762022202B0D0A202020202020202022646274696D657A6F6E65206465636F6465206465636F6D706F73652064656C657465786D6C2064656E73655F72616E';
wwv_flow_api.g_varchar2_table(67) := '6B206465707468206465726566206475616C2064756D70206475705F76616C5F6F6E5F696E6465782022202B0D0A202020202020202022656D70747920656D7074795F626C6F6220656D7074795F636C6F62206572726F72206578697374735F6E6F6465';
wwv_flow_api.g_varchar2_table(68) := '20657870206578747261637420657874726163745F76616C75652022202B0D0A20202020202020202266616C736520666561747572655F696420666561747572655F73657420666561747572655F76616C75652066697273742066697273745F76616C75';
wwv_flow_api.g_varchar2_table(69) := '6520666C6F6F722066726F6D5F747A20666F756E642022202B0D0A202020202020202022676C622067726561746573742067726F75705F69642067726F7570696E672067726F7570696E675F69642022202B0D0A202020202020202022686578746F7261';
wwv_flow_api.g_varchar2_table(70) := '772022202B0D0A202020202020202022696E697463617020696E736572746368696C64786D6C20696E73657274786D6C6265666F726520696E73747220696E7374726220697465726174696F6E5F6E756D6265722069736F70656E2022202B0D0A202020';
wwv_flow_api.g_varchar2_table(71) := '2020202020226C6167206C617374206C6173745F646179206C6173745F76616C7565206C656164206C65617374206C656E677468206C656E67746862206C6E206C6E6E766C206C6F63616C74696D657374616D70206C6F67206C6F776572206C70616420';
wwv_flow_api.g_varchar2_table(72) := '6C7472696D206C75622022202B0D0A2020202020202020226D616B655F726566206D6178206D656469616E206D696E206D6F64206D6F6E7468735F6265747765656E2022202B0D0A2020202020202020226E616E766C206E636872206E65775F74696D65';
wwv_flow_api.g_varchar2_table(73) := '206E6578745F646179206E65787476616C206E6C735F636861727365745F6465636C5F6C656E206E6C735F636861727365745F6964206E6C735F636861727365745F6E616D65206E6C735F696E69746361702022202B0D0A2020202020202020226E6C73';
wwv_flow_api.g_varchar2_table(74) := '5F736F7274206E6C73736F7274206E6C735F7570706572206E6F5F646174615F666F756E64206E6F74666F756E64206E74696C65206E756C6C206E756C6C6966206E756D746F6473696E74657276616C206E756D746F796D696E74657276616C206E766C';
wwv_flow_api.g_varchar2_table(75) := '206E766C322022202B0D0A2020202020202020226F72615F68617368206F74686572732022202B0D0A202020202020202022706174682070657263656E745F72616E6B2070657263656E74696C655F636F6E742070657263656E74696C655F6469736320';
wwv_flow_api.g_varchar2_table(76) := '706F77657220706F7765726D756C746973657420707765726D756C74697365745F62795F63617264696E616C6974792022202B0D0A20202020202020202270726564696374696F6E2070726564696374696F6E5F636F73742070726564696374696F6E5F';
wwv_flow_api.g_varchar2_table(77) := '64657461696C732070726564696374696F6E5F70726F626162696C6974792070726564696374696F6E5F7365742070726573656E746E6E762070726573656E74762070726576696F75732022202B0D0A20202020202020202272616E6B20726174696F5F';
wwv_flow_api.g_varchar2_table(78) := '746F5F7265706F727420726177746F68657820726177746F6E6865782072656620726566746F686578207265676578705F696E737472207265676578705F7265706C616365207265676578705F7375627374722022202B0D0A2020202020202020227265';
wwv_flow_api.g_varchar2_table(79) := '67722072656D61696E646572207265706C61636520726F756E6420726F77636F756E7420726F775F6E756D62657220726F776964746F6368617220726F776964746F6E63686172207270616420727472696D2022202B0D0A20202020202020202273636E';
wwv_flow_api.g_varchar2_table(80) := '5F746F5F74696D657374616D702073657373696F6E74696D657A6F6E6520736574207369676E2073696E2073696E6820736F756E64657820737172742073716C636F64652073716C6572726D2022202B0D0A20202020202020202273746174735F62696E';
wwv_flow_api.g_varchar2_table(81) := '6F6D696E616C5F746573742073746174735F63726F73737461622073746174735F665F746573742073746174735F6B735F746573742073746174735F6D6F64652073746174735F6D775F746573742073746174735F6F6E655F7761795F616E6F76612022';
wwv_flow_api.g_varchar2_table(82) := '202B0D0A202020202020202022737461747320745F746573745F6F6E652073746174735F745F746573745F7061697265642073746174735F745F746573745F696E6465702073746174735F745F746573745F696E646570752073746174735F7773725F74';
wwv_flow_api.g_varchar2_table(83) := '6573742022202B0D0A202020202020202022737464646576207374646465765F706F70207374646465765F73616D702073756273747220737562737472622073756D2022202B0D0A2020202020202020227379735F636F6E6E6563745F62795F70617468';
wwv_flow_api.g_varchar2_table(84) := '207379735F636F6E74657874207379735F646275726967656E207379735F657874726163745F757463207379735F67756964207379735F747970656964207379735F786D6C616767207379735F786D6C67656E20737973646174652073797374696D6573';
wwv_flow_api.g_varchar2_table(85) := '74616D702022202B0D0A20202020202020202274616E2074616E682074696D657374616D705F746F5F73636E20746F5F62696E6172795F646F75626C6520746F5F62696E6172795F666C6F617420746F5F6368617220746F5F636C6F6220746F5F646174';
wwv_flow_api.g_varchar2_table(86) := '6520746F5F6473696E74657276616C202022202B0D0A202020202020202022746F5F6C6162656C20746F206C6F6220746F5F6D756C74695F6279746520746F5F6E6368617220746F5F6E636C6F6220746F5F6E756D62657220746F5F73696E676C655F62';
wwv_flow_api.g_varchar2_table(87) := '79746520746F5F74696D657374616D7020746F5F74696D657374616D705F747A20746F5F796D696E74657276616C202022202B0D0A2020202020202020227472616E736C617465207472656174207472696D2074727565207472756E6320747A5F6F6666';
wwv_flow_api.g_varchar2_table(88) := '7365742022202B0D0A20202020202020202275696420756E6973747220757064617465786D6C20757070657220757365722075736572656E76207573696E672022202B0D0A20202020202020202276616C7565207661725F706F70207661725F73616D70';
wwv_flow_api.g_varchar2_table(89) := '2076617269616E6365207673697A652022202B0D0A20202020202020202277696474685F6275636B65742022202B0D0A202020202020202022786D6C61676720786D6C636461746120786D6C636F6C61747476616C20786D6C636F6D6D656E7420786D6C';
wwv_flow_api.g_varchar2_table(90) := '636F6E63617420786D6C656C656D656E7420786D6C666F7265737420786D6C706172736520786D6C706920786D6C717565727920786D6C726F6F7420786D6C73657175656E636520786D6C73657269616C697A6520786D6C7461626C6520786D6C747261';
wwv_flow_api.g_varchar2_table(91) := '6E73666F726D20223B0D0A0D0A202076617220635479706573203D20226266696C6520626C6F622022202B0D0A20202020202020202263686172616374657220636C6F622022202B0D0A2020202020202020226465632022202B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(92) := '22666C6F61742022202B0D0A202020202020202022696E7420696E74656765722022202B0D0A2020202020202020226D6C736C6162656C2022202B0D0A2020202020202020226E61747572616C206E61747572616C6E206E63686172206E636C6F62206E';
wwv_flow_api.g_varchar2_table(93) := '756D626572206E756D65726963206E76617263686172322022202B0D0A2020202020202020227265616C20726F77747970652022202B0D0A2020202020202020227369676E7479706520736D616C6C696E7420737472696E672022202B0D0A2020202020';
wwv_flow_api.g_varchar2_table(94) := '2020202276617263686172207661726368617232223B0D0A0D0A2020766172206353716C706C7573203D2022617070696E666F20617272617973697A65206175746F636F6D6D6974206175746F7072696E74206175746F7265636F76657279206175746F';
wwv_flow_api.g_varchar2_table(95) := '74726163652022202B0D0A202020202020202022626C6F636B7465726D696E61746F7220627265616B20627469746C652022202B0D0A202020202020202022636D6473657020636F6C73657020636F6D7061746962696C69747920636F6D707574652063';
wwv_flow_api.g_varchar2_table(96) := '6F6E63617420636F7079636F6D6D697420636F707974797065636865636B2022202B0D0A202020202020202022646566696E652064657363726962652022202B0D0A2020202020202020226563686F206564697466696C6520656D626564646564206573';
wwv_flow_api.g_varchar2_table(97) := '63617065206578656320657865637574652022202B0D0A202020202020202022666565646261636B20666C616767657220666C7573682022202B0D0A20202020202020202268656164696E6720686561647365702022202B0D0A20202020202020202269';
wwv_flow_api.g_varchar2_table(98) := '6E7374616E63652022202B0D0A2020202020202020226C696E6573697A65206C6E6F206C6F626F6666736574206C6F67736F75726365206C6F6E67206C6F6E676368756E6B73697A652022202B0D0A2020202020202020226D61726B75702022202B0D0A';
wwv_flow_api.g_varchar2_table(99) := '2020202020202020226E6174697665206E657770616765206E756D666F726D6174206E756D77696474682022202B0D0A2020202020202020227061676573697A6520706175736520706E6F2022202B0D0A20202020202020202272656373657020726563';
wwv_flow_api.g_varchar2_table(100) := '736570636861722072656C6561736520726570666F6F746572207265706865616465722022202B0D0A2020202020202020227365727665726F7574707574207368696674696E6F75742073686F772073686F776D6F64652073697A652073706F6F6C2073';
wwv_flow_api.g_varchar2_table(101) := '716C626C616E6B6C696E65732073716C636173652073716C636F64652073716C636F6E74696E75652073716C6E756D6265722022202B0D0A20202020202020202273716C706C7573636F6D7061746962696C6974792073716C7072656669782073716C70';
wwv_flow_api.g_varchar2_table(102) := '726F6D70742073716C7465726D696E61746F72207375666669782022202B0D0A202020202020202022746162207465726D207465726D6F75742074696D652074696D696E67207472696D6F7574207472696D73706F6F6C20747469746C652022202B0D0A';
wwv_flow_api.g_varchar2_table(103) := '202020202020202022756E6465726C696E652022202B0D0A2020202020202020227665726966792076657273696F6E2022202B0D0A20202020202020202277726170223B0D0A0D0A2020436F64654D6972726F722E646566696E654D494D452822746578';
wwv_flow_api.g_varchar2_table(104) := '742F782D706C73716C222C207B0D0A202020206E616D653A2022706C73716C222C0D0A202020206B6579776F7264733A206B6579776F72647328634B6579776F726473292C0D0A2020202066756E6374696F6E733A206B6579776F726473286346756E63';
wwv_flow_api.g_varchar2_table(105) := '74696F6E73292C0D0A2020202074797065733A206B6579776F72647328635479706573292C0D0A2020202073716C706C75733A206B6579776F726473286353716C706C7573290D0A20207D293B0D0A7D2829293B0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(16293118528871409)
,p_plugin_id=>wwv_flow_api.id(51464337394665259)
,p_file_name=>'plsql.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/shared_components/plugins/dynamic_action/de_condes_plugin_sct
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(153276322008343886)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'DE.CONDES.PLUGIN.SCT'
,p_display_name=>'StatusChartToolkit'
,p_category=>'NAVIGATION'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','DE.CONDES.PLUGIN.SCT'),'')
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'../condes/kismonitor/plugins/sct/js/sct.js',
'../condes/kismonitor/plugins/sct/js/sctApex.js'))
,p_css_file_urls=>'../condes/kismonitor/plugins/sct/js/sct.css'
,p_api_version=>1
,p_render_function=>'plugin_sct.render'
,p_ajax_function=>'plugin_sct.ajax'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Plugin StatusChartToolkit</h2>',
'<p>Das Plugin vereinfacht die Verwaltung von Formularen auf einer Seite.<br/>Folgende Funktionen sind implementiert:</p>',
'<ul><li>Es können Regeln definiert werden, die steuern, ob Elemente auf der Seite angezeigt werden oder nicht</li>',
'  <li>Elemente können regelbasiert zu Pflichtfeldern erklärt und geprüft werden</li>',
'  <li>Regeln können Validierungs- oder Initialisierungscode auf der Datenbank aufrufen</li>',
'  <li>Regeln werden automatisch rekursiv aufgelöst und rduzieren so die Anzahl der benötigten Regeln</li>',
'  <li>Treten Fehler bei der Initialisierung, Berechnung oder Validierung von Werten auf, werden diese dynamisch auf die Seite integriert</li>',
'</ul>',
'<p>Regeln werden innerhalb von Tabellen in der Datenbank abgelegt. Diese Regeln können durch eine eigene APEX-Anwendung verwaltet werden und anwendungsübergreifend eingesetzt werden.</p>'))
,p_version_identifier=>'1.0'
,p_files_version=>21
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(22992635678667628)
,p_plugin_id=>wwv_flow_api.id(153276322008343886)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'SCT-Apexfunktionen'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'de.condes.plugin.sct.apex_42_5_0'
,p_display_length=>40
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>SCT-APEX-Funktionen</h2>',
'<p>Dieser Parameter definiert den Namensraum der JavaScript-Funktionalität, die für das SCT benötigt wird.</p>',
'<p>Standardmäßig wird de.condes.plugin.sct.apex verwendet und mitgeliefert. Wenn diese Funktionen zum eingesetzten Theme nicht passen, können Sie eine eigene Kopie dieser Datei erstellen und anpassen.<br/>Stellen Sie sicher, dass die in der mitgelief'
||'erten Datei SCTApex.js implementierten, öffentlichen Funktionen auch in Ihrer Implementierung vorhanden sind.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(153276975742683304)
,p_plugin_id=>wwv_flow_api.id(153276322008343886)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Name der Regelgruppe'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_display_length=>30
,p_max_length=>50
,p_is_translatable=>false
,p_help_text=>'Geben Sie hier den Namen der Regelgruppe ein, die für dieses Plugin genutzt werden soll.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(84514655996653844)
,p_plugin_id=>wwv_flow_api.id(153276322008343886)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Fehlerabhängige Elemente'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_max_length=>200
,p_is_translatable=>false
,p_text_case=>'UPPER'
,p_help_text=>'<p>Liste von Elementnamen, die deaktiviert werden, wenn auf der Seite Fehler auftreten</p>'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := 'EFBBBF2F2F204E616D6573706163650D0A766172206465203D206465207C7C207B7D3B0D0A64652E636F6E646573203D2064652E636F6E646573207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E203D2064652E636F6E6465732E706C7567';
wwv_flow_api.g_varchar2_table(2) := '696E207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E736374203D207B7D3B0D0A0D0A0D0A2F2A210D0A2020506C7567696E207A757220537465756572756E67206B6F6D706C6578657220415045582D466F726D756C6172650D0A202A2F';
wwv_flow_api.g_varchar2_table(3) := '0D0A2F2A2A0D0A202A204066696C654F766572766965770D0A202A2044617320506C7567696E2064656C65676965727420646965204265726563686E756E67206465732053746174757320766F6E20466F726D756C6172656C656D656E74656E2065696E';
wwv_flow_api.g_varchar2_table(4) := '657220415045582D536569746520616E2064696520446174656E62616E6B2E0D0A202A20486965727A75207370726963687420657320696E2064657220446174656E62616E6B2065696E6520526567656C67727570706520616E2C206469652052656765';
wwv_flow_api.g_varchar2_table(5) := '6C6E20656E7468C3A46C742E20446965736520526567656C6E206265726563686E656E0D0A202A2064656E205374617475732064657220416E77656E64756E6773656C656D656E74652064657220616B7475656C6C656E2053656974652C206261736965';
wwv_flow_api.g_varchar2_table(6) := '72656E64206175662064656D206D6F6D656E74616E656E2053657373696F6E7374617475732E0D0A202A0D0A202A2044617320506C7567696E2062656EC3B674696774206E75722077656E69676520506172616D657465723A0D0A202A20616A61784964';
wwv_flow_api.g_varchar2_table(7) := '656E7469666965723A20415045582D67656E6572696572746572204964656E7469666965720D0A202A2062696E644974656D733A204C6973746520766F6E2053656974656E656C656D656E74656E2C20616E2064696520616E204576656E747320676562';
wwv_flow_api.g_varchar2_table(8) := '756E64656E20776972642E20446965204C6973746520776972642064757263682064696520446174656E62616E6B0D0A202A2020202020202020202020206265726563686E65742028626173696572656E64206175662064656E2045696E7A656C726567';
wwv_flow_api.g_varchar2_table(9) := '656C6E2920756E6420616C73204A534F4E2D4F626A656B742067656C6965666572742E205A75206A6564656D2053656974656E656C656D656E740D0A202A202020202020202020202020776972642064696520494420756E6420646572204576656E7420';
wwv_flow_api.g_varchar2_table(10) := '616E6765676562656E2C2064657220676562756E64656E2077657264656E20736F6C6C2E0D0A202A20706167654974656D733A204C6973746520766F6E2053656974656E656C656D656E74656E2C20646572656E20616B7475656C6C657220456C656D65';
wwv_flow_api.g_varchar2_table(11) := '6E7477657274206265696D204175736CC3B673656E2065696E6573204576656E7473206175662065696E656D200D0A202A202020202020202020202020676562756E64656E656E20456C656D656E742061757367656C6573656E20756E6420616E206469';
wwv_flow_api.g_varchar2_table(12) := '6520446174656E62616E6B20676573636869636B742077657264656E20736F6C6C2E0D0A202A202020202020202020202020446965204C69737465207769726420766F6E2064657220446174656E62616E6B206265726563686E657420756E6420626569';
wwv_flow_api.g_varchar2_table(13) := '2064657220496E697469616C6973696572756E67207665726D65726B740D0A202A20417065784A533A202020204F626A656B742C20646173206469652056697375616C6973696572756E6720766F6E20506C7567696E66756E6B74696F6E656E20617566';
wwv_flow_api.g_varchar2_table(14) := '20646572204F626572666CC3A4636865206B617073656C742E0D0A202A20202020202020202020202044696573657220506172616D65746572207769726420616C73204170706C69636174696F6E2D506172616D657465722064657320506C7567696E73';
wwv_flow_api.g_varchar2_table(15) := '2076657277616C74657420756E64206765737461747465742065732C20646965204A6176615363726970742D0D0A202A2020202020202020202020204C6962726172792C206469652066C3BC7220646965204461727374656C6C756E672076657277656E';
wwv_flow_api.g_varchar2_table(16) := '64657420776972642C2065696E7A757374656C6C656E2E0D0A202A202020202020202020202020446965206B6F6E6B7265746520496D706C656D656E74696572756E67206B616E6E20647572636820646966666572696572656E646520416E666F726465';
wwv_flow_api.g_varchar2_table(17) := '72756E67656E2C206765C3A46E64657274652054656D706C61746573206F64657220736F6E73746967650D0A202A2020202020202020202020204772C3BC6E6465206E696368742067656E65726973636820646566696E696572742077657264656E2E20';
wwv_flow_api.g_varchar2_table(18) := '5374616E646172646DC3A4C39F696720776972642064652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F302076657277656E6465742E0D0A202A20202020202020202020202044657461696C73207A752065696E657220C39C62';
wwv_flow_api.g_varchar2_table(19) := '657273636872656962756E67206469657365722044617465692066696E646574207369636820696E2064657220446F6B756D656E746174696F6E2064657220446174656920736374417065782E6A730D0A202A2020202020202020202020202D20736574';
wwv_flow_api.g_varchar2_table(20) := '4E6F66696369746174696F6E0D0A202A20202020202020202020202020202020446965204D6574686F6465207365747A742065696E65204E61636872696368742061756620646572204F626572666CC3A46368652E0D0A202A2020202020202020202020';
wwv_flow_api.g_varchar2_table(21) := '20576972642065696E6520656967656E6520496D706C656D656E74696572756E6720766F7267656E6F6D6D656E2C20656D70666965686C7420657320736963682C20766F6E20646572206578697374696572656E64656E20736374417065782E6A732061';
wwv_flow_api.g_varchar2_table(22) := '627A756C656974656E2E0D0A202A0D0A202A2044617320506C7567696E2077697264206175662064657220536569746520616C732044796E616D696320416374696F6E207A756D205A65697470756E6B7420504147455F4C4F41442065696E676562756E';
wwv_flow_api.g_varchar2_table(23) := '64656E2E200D0A202A204265696D2045696E66C3BC67656E207769726420646572204E616D6520646572207265666572656E7A69657274656E20526567656C67727570706520616E6765676562656E20736F776965206F7074696F6E616C2065696E6520';
wwv_flow_api.g_varchar2_table(24) := '4C6973746520766F6E2053656974656E656C656D656E74656E2C0D0A202A20646965206465616B746976696572742077657264656E20736F6C6C656E2C2077656E6E2065696E204665686C6572206175662064657220536569746520616E67657A656967';
wwv_flow_api.g_varchar2_table(25) := '7420776972642E0D0A202A20576569746572652061646D696E6973747261746976652041726265697420697374206E69636874206572666F726465726C6963680D0A202A2F0D0A2866756E6374696F6E287363742C20242C20736572766572297B0D0A20';
wwv_flow_api.g_varchar2_table(26) := '20200D0A2020435F42494E445F4556454E54203D20276368616E6765273B0D0A2020435F434C49434B5F4556454E54203D2027636C69636B273B0D0A2020435F415045585F4245464F52455F52454652455348203D2027617065786265666F7265726566';
wwv_flow_api.g_varchar2_table(27) := '72657368273B0D0A2020435F415045585F41465445525F52454652455348203D202761706578616674657272656672657368273B0D0A2020435F4E4F5F54524947474552494E475F4954454D203D2027444F43554D454E54273B0D0A20200D0A20207363';
wwv_flow_api.g_varchar2_table(28) := '742E616A61784964656E746966696572203D207B7D3B0D0A20200D0A20202F2A0D0A2020202046756E6B74696F6E656E2C20646965206475726368205363726970742061757320526573706F6E7365206175666765727566656E2077657264656E2E0D0A';
wwv_flow_api.g_varchar2_table(29) := '2020202A2F20200D0A20202F2F20446965204D6574686F6465207365744974656D56616C756573207769726420766F6E20526573706F6E7365206175666765727566656E20756E642064617266206461686572206E6963687420756D62656E616E6E7420';
wwv_flow_api.g_varchar2_table(30) := '6F64657220656E746665726E742077657264656E0D0A20207363742E73657452756C654E616D65203D2066756E6374696F6E2872756C654E616D65297B0D0A20202020617065782E64656275672E6C6F67286052756C6520757365643A20247B72756C65';
wwv_flow_api.g_varchar2_table(31) := '4E616D657D60293B0D0A202020202F2F20544F444F3A2056657277656E6465746520526567656C206175662053656974656E656C656D656E74206B6F70696572656E3F204576656E7475656C6C207A7573C3A4747A6C696368657220506172616D657465';
wwv_flow_api.g_varchar2_table(32) := '722066C3BC722064696573656E205A7765636B0D0A20207D3B0D0A20200D0A20200D0A20202F2F207365744974656D56616C7565732073796E6368726F6E697369657274206765C3A46E646572746520456C656D656E747765727465206175732064656D';
wwv_flow_api.g_varchar2_table(33) := '2053657373696F6E20537461746520617566206465722053656974652E0D0A20202F2F20446965204D6574686F6465207365744974656D56616C756573207769726420766F6E20526573706F6E7365206175666765727566656E20756E64206461726620';
wwv_flow_api.g_varchar2_table(34) := '6461686572206E6963687420756D62656E616E6E74206F64657220656E746665726E742077657264656E0D0A20207363742E7365744974656D56616C756573203D2066756E6374696F6E28706167654974656D73297B0D0A202020202F2F20456E746E65';
wwv_flow_api.g_varchar2_table(35) := '686D6520646965206E6575656E20456C656D656E74776572746520756E64207365747A652073696520617566206465722053656974650D0A20202020242E6561636828706167654974656D732C2066756E6374696F6E28297B0D0A202020202020696620';
wwv_flow_api.g_varchar2_table(36) := '2828746869732E76616C7565207C7C2027464F4F272920213D2028247628746869732E696429207C7C2027464F4F2729297B0D0A2020202020202020617065782E6974656D28746869732E6964292E73657456616C756528746869732E76616C75652C20';
wwv_flow_api.g_varchar2_table(37) := '746869732E76616C75652C2074727565293B0D0A2020202020202020617065782E64656275672E6C6F6728604974656D2022247B746869732E69647D222073657420746F2022247B746869732E76616C75657D2260293B0D0A2020202020207D3B0D0A20';
wwv_flow_api.g_varchar2_table(38) := '2020207D293B0D0A20207D3B0D0A200D0A0D0A20202F2F20446965204D6574686F6465207365744572726F7273207769726420766F6E20526573706F6E7365206175666765727566656E20756E642064617266206461686572206E6963687420756D6265';
wwv_flow_api.g_varchar2_table(39) := '6E616E6E74206F64657220656E746665726E742077657264656E0D0A20202F2F205370657A6966697363682066C3BC722064696520616B7475656C6C652056657273696F6E2064657220416E77656E64756E672E204D757373207761687273636865696E';
wwv_flow_api.g_varchar2_table(40) := '6C69636820C3BC62657261726265697465742077657264656E2C0D0A20202F2F2077656E6E20646572206E657565205374796C6547756964652065696E67657365747A7420776972640D0A20207363742E7365744572726F7273203D2066756E6374696F';
wwv_flow_api.g_varchar2_table(41) := '6E286572726F724C69737429207B0D0A202020207363742E417065784A532E6D61696E7461696E4572726F7273286572726F724C697374293B0D0A20207D3B0D0A2020200D0A20202F2A200D0A20202020507269766174652048696C66736D6574686F64';
wwv_flow_api.g_varchar2_table(42) := '656E200D0A2020202A2F0D0A20202F2F2042696E64657420616E20616C6C652053656974656E656C656D656E746520617573205343542E42494E445F4954454D5320616E2064656E204348414E47452D4576656E742C0D0A20202F2F20756D2064696520';
wwv_flow_api.g_varchar2_table(43) := '566572617262656974756E672064657320506C7567696E73206175737A756CC3B673656E0D0A20202F2F20416C6C652072656C6576616E74656E20456C656D656E74652077657264656E20696E20706167654974656D732068696E7465726C6567742C20';
wwv_flow_api.g_varchar2_table(44) := '756D206265696D204175736CC3B673656E20456C656D656E7477657274650D0A20202F2F20616E2064696520446174656E62616E6B207A752073656E64656E2E0D0A202066756E6374696F6E2062696E644576656E74732829207B0D0A20202020242E65';
wwv_flow_api.g_varchar2_table(45) := '616368287363742E62696E644974656D732C2066756E6374696F6E28297B0D0A202020202020766172202474686973203D202428272327202B20746869732E6964293B0D0A202020202020766172206576656E74203D20746869732E6576656E743B0D0A';
wwv_flow_api.g_varchar2_table(46) := '20202020202024746869730D0A2020202020202E6F6E286576656E742C2066756E6374696F6E2865297B0D0A20202020202020207363742E6578656375746528652C207363742E616A61784964656E7469666965722C207363742E706167654974656D73';
wwv_flow_api.g_varchar2_table(47) := '293B0D0A2020202020202020617065782E64656275672E6C6F6728604576656E7420C2BB247B6576656E747DC2AB2072616973656420617420247B746869732E69647D60293B0D0A2020202020207D293B0D0A2020202020206966286576656E74203D3D';
wwv_flow_api.g_varchar2_table(48) := '20435F42494E445F4556454E54297B0D0A202020202020202024746869730D0A20202020202020202E6F6E28435F415045585F4245464F52455F524546524553482C2066756E6374696F6E2865297B0D0A20202020202020202020242874686973292E6F';
wwv_flow_api.g_varchar2_table(49) := '666628435F42494E445F4556454E54293B0D0A20202020202020202020617065782E64656275672E6C6F6728604576656E7420C2BB247B435F42494E445F4556454E547DC2AB2070617573656420617420247B746869732E69647D60293B0D0A20202020';
wwv_flow_api.g_varchar2_table(50) := '202020207D290D0A20202020202020202E6F6E28435F415045585F41465445525F524546524553482C2066756E6374696F6E2865297B0D0A20202020202020202020242874686973292E6F6E28435F42494E445F4556454E542C2066756E6374696F6E28';
wwv_flow_api.g_varchar2_table(51) := '65297B0D0A2020202020202020202020207363742E6578656375746528652C207363742E616A61784964656E7469666965722C207363742E706167654974656D73293B0D0A202020202020202020207D293B0D0A20202020202020202020617065782E64';
wwv_flow_api.g_varchar2_table(52) := '656275672E6C6F6728604576656E7420C2BB247B435F42494E445F4556454E547DC2AB2072652D65737461626C697368656420617420247B746869732E69647D60293B0D0A20202020202020207D293B0D0A2020202020207D3B0D0A202020207D293B0D';
wwv_flow_api.g_varchar2_table(53) := '0A20207D3B0D0A20200D0A20200D0A20202F2A0D0A20202020496D706C656D656E74696572756E672064657220506C7567696E2D46756E6B74696F6E616C6974C3A4740D0A2020202A2F0D0A20207363742E7375626D6974203D2066756E6374696F6E28';
wwv_flow_api.g_varchar2_table(54) := '726571756573742C206D657373616765297B0D0A202020207363742E417065784A532E7375626D69745061676528726571756573742C206D657373616765293B0D0A20207D0D0A20200D0A20200D0A20207363742E7365744D616E6461746F7279203D20';
wwv_flow_api.g_varchar2_table(55) := '66756E6374696F6E286974656D2C206D616E6461746F7279297B0D0A202020207363742E417065784A532E7365744669656C644D616E6461746F7279286974656D2C206D616E6461746F7279293B0D0A20207D0D0A20200D0A20200D0A20207363742E6E';
wwv_flow_api.g_varchar2_table(56) := '6F74696679203D2066756E6374696F6E286D657373616765297B0D0A202020207363742E417065784A532E7365744E6F74696669636174696F6E286D657373616765293B0D0A20207D0D0A2020200D0A2020200D0A20207363742E65786563757465203D';
wwv_flow_api.g_varchar2_table(57) := '2066756E6374696F6E2865297B0D0A202020207661722063616C6C6261636B203D2066756E6374696F6E2864617461297B0D0A2020202020202F2F204E696D6D74206461732045726765626E697320656E74676567656E20756E642066C3BC6774206573';
wwv_flow_api.g_varchar2_table(58) := '20616C7320446F6B756D656E742D467261676D656E742065696E2E0D0A2020202020202F2F20446965732066C3BC6872742064656E20656E7468616C74656E656E204A6176615372636970742D436F646520646972656B74206175732C20736F20646173';
wwv_flow_api.g_varchar2_table(59) := '73206461732065696E676566C3BC677465200D0A2020202020202F2F20456C656D656E7420616E7363686C6965C39F656E6420646972656B74207769656465722067656CC3B6736368742077657264656E206B616E6E0D0A202020202020696620286461';
wwv_flow_api.g_varchar2_table(60) := '746129207B0D0A2020202020202020617065782E64656275672E6C6F672827526573706F6E736520726563656976656427293B0D0A2020202020202020242827626F647927292E617070656E642864617461293B0D0A2020202020202020242827232720';
wwv_flow_api.g_varchar2_table(61) := '2B20242864617461292E61747472282769642729292E72656D6F766528293B0D0A2020202020207D3B0D0A202020207D3B0D0A202020200D0A202020202F2F20494420646573206175736CC3B673656E64656E20456C656D656E74732E2046616C6C7320';
wwv_flow_api.g_varchar2_table(62) := '506167654C6F61642C20776972642022646F63756D656E74222076657277656E6465740D0A202020207661722074726967676572696E67456C656D656E74203D20435F4E4F5F54524947474552494E475F4954454D0D0A2020202069662028747970656F';
wwv_flow_api.g_varchar2_table(63) := '6620652E74617267657420213D2027756E646566696E656427297B0D0A20202020202074726967676572696E67456C656D656E74203D20652E7461726765742E69643B0D0A2020202020202474726967676572696E67456C656D656E74203D2024282723';
wwv_flow_api.g_varchar2_table(64) := '27202B2074726967676572696E67456C656D656E74290D0A2020202020206966282474726967676572696E67456C656D656E742E617474722827747970652729203D3D2027726164696F27297B0D0A202020202020202074726967676572696E67456C65';
wwv_flow_api.g_varchar2_table(65) := '6D656E74203D202474726967676572696E67456C656D656E742E706172656E747328276669656C6473657427292E617474722827696427293B0D0A2020202020207D0D0A202020202020617065782E64656275672E6C6F67286054726967676572696E67';
wwv_flow_api.g_varchar2_table(66) := '20656C656D656E743A20247B74726967676572696E67456C656D656E747D60293B0D0A202020207D0D0A202020200D0A202020207365727665722E706C7567696E280D0A2020202020207363742E616A61784964656E7469666965722C0D0A2020202020';
wwv_flow_api.g_varchar2_table(67) := '207B0D0A202020202020202027783031273A74726967676572696E67456C656D656E742C0D0A20202020202020202F2F204B6F706965726520616C6C652072656C6576616E74656E2053656974656E656C656D656E746520696E2064656E205365737369';
wwv_flow_api.g_varchar2_table(68) := '6F6E53746174650D0A202020202020202027706167654974656D73273A7363742E706167654974656D730D0A2020202020207D2C0D0A2020202020207B0D0A2020202020202020276461746154797065273A2768746D6C272C0D0A202020202020202027';
wwv_flow_api.g_varchar2_table(69) := '73756363657373273A63616C6C6261636B0D0A2020202020207D0D0A20202020293B0D0A20207D3B0D0A20200D0A20200D0A20207363742E696E6974203D2066756E6374696F6E286D65297B0D0A202020202F2F2042696E6465206175736CC3B673656E';
wwv_flow_api.g_varchar2_table(70) := '6465204576656E747320616E20456C656D656E74652C2064696520C3BC62657220417474726962757420303120C3BC626572676562656E2077657264656E0D0A202020207363742E62696E644974656D73203D20242E70617273654A534F4E286D652E61';
wwv_flow_api.g_varchar2_table(71) := '6374696F6E2E61747472696275746530312E7265706C616365282F7E2F672C2027222729293B0D0A20202020696620286D652E616374696F6E2E617474726962757465303229207B0D0A2020202020207363742E706167654974656D73203D206D652E61';
wwv_flow_api.g_varchar2_table(72) := '6374696F6E2E61747472696275746530322E73706C697428272C27293B0D0A202020207D3B0D0A202020207363742E616A61784964656E746966696572203D206D652E616374696F6E2E616A61784964656E7469666965723B0D0A202020200D0A202020';
wwv_flow_api.g_varchar2_table(73) := '202F2F20526567697374726965726520415045582D4A617661536372697074204F626A656B740D0A202020207363742E417065784A53203D206576616C286D652E616374696F6E2E6174747269627574653033293B0D0A202020200D0A202020202F2F20';
wwv_flow_api.g_varchar2_table(74) := '426572656974652045696E7361747A2064657320506C7567696E7320766F720D0A2020202062696E644576656E747328293B0D0A20202020617065782E64656275672E6C6F67282753435420696E697469616C697A656427293B0D0A202020200D0A2020';
wwv_flow_api.g_varchar2_table(75) := '20202F2F204CC3B67365206265696D2053656974656E6C6164656E206578706C697A697420566572617262656974756E672064657320506C7567696E73206175730D0A20202020617065782E64656275672E6C6F67286054726967676572696E6720656C';
wwv_flow_api.g_varchar2_table(76) := '656D656E743A20646F63756D656E7460293B0D0A202020207363742E65786563757465286D65293B0D0A20207D0D0A20200D0A7D292864652E636F6E6465732E706C7567696E2E7363742C20617065782E6A51756572792C20617065782E736572766572';
wwv_flow_api.g_varchar2_table(77) := '293B0D0A0D0A0D0A2F2F205363686E6974747374656C6C65207A756D20415045582D506C7567696E2D4D656368616E69736D75732C20646965206175732065696E656D206D6972206E696368742062656B616E6E74656E204772756E640D0A2F2F205363';
wwv_flow_api.g_varchar2_table(78) := '687769657269676B656974656E206D6974206465722056657277656E64756E672065696E6573204E616D656E737261756D6F626A656B747320686162656E0D0A66756E6374696F6E2064655F636F6E6465735F706C7567696E5F73637428297B0D0A2020';
wwv_flow_api.g_varchar2_table(79) := '64652E636F6E6465732E706C7567696E2E7363742E696E69742874686973293B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(22999296063230650)
,p_plugin_id=>wwv_flow_api.id(153276322008343886)
,p_file_name=>'sct.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E7363742D6572726F72207B0D0A2020636F6C6F723A7265643B0D0A7D0D0A0D0A2E7363742D64697361626C65647B0D0A2020636F6C6F723A677265793B0D0A7D0D0A0D0A2E7363742D64747B0D0A2020626F726465722D746F703A6772657920736F6C';
wwv_flow_api.g_varchar2_table(2) := '6964207468696E3B0D0A2020666F6E742D7765696768743A626F6C643B0D0A2020666F6E742D73697A653A312E32656D3B0D0A202070616464696E672D746F703A203370783B0D0A202070616464696E672D626F74746F6D3A203370783B0D0A20206D61';
wwv_flow_api.g_varchar2_table(3) := '7267696E2D746F703A313870783B0D0A7D0D0A0D0A2E7363742D6361726F7573656C2D6861734572726F727B0D0A20206261636B67726F756E643A72676261283235352C20302C20302C20302E33290D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(22999698770231509)
,p_plugin_id=>wwv_flow_api.id(153276322008343886)
,p_file_name=>'sct.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F204E616D6573706163650D0A766172206465203D206465207C7C207B7D3B0D0A64652E636F6E646573203D2064652E636F6E646573207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E203D2064652E636F6E6465732E706C7567696E20';
wwv_flow_api.g_varchar2_table(2) := '7C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E736374203D2064652E636F6E6465732E706C7567696E2E736374207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F30203D207B7D3B0D0A';
wwv_flow_api.g_varchar2_table(3) := '0D0A2F2A210D0A202A2048696C66736D6574686F64656E207A7572204461727374656C6C756E672064657220506C7567696E2D46756E6B74696F6E616C6974C3A474206175662064657220415045582D4F626572666CC3A46368650D0A202A2F0D0A2F2A';
wwv_flow_api.g_varchar2_table(4) := '2A204066696C654F766572766965770D0A202A204461207369636820696E206469657365722044617465692064657220436F646520626566696E6465742C20646572206D697420646572204F626572666CC3A463686520766F6E204150455820696E7465';
wwv_flow_api.g_varchar2_table(5) := '726167696572742C0D0A202A20626573746568742065696E6520416268C3A46E6769676B65697420766F6E206465722076657277656E646574656E20415045582D56657273696F6E2E0D0A202A2044696573652056657273696F6E206F7269656E746965';
wwv_flow_api.g_varchar2_table(6) := '7274207369636820616D2056657268616C74656E206465722056657273696F6E20352E302C205468656D652034322E20536F6C6C74652065696E65206E65756572652056657273696F6E2076657277656E6465742077657264656E2C0D0A202A206F6465';
wwv_flow_api.g_varchar2_table(7) := '722065696E205374796C6547756964652065696E67657365747A742077657264656E2C206465722065696E206572776569746572746573206F646572206765C3A46E6465727465732056657268616C74656E206572666F72646572742C206B616E6E2064';
wwv_flow_api.g_varchar2_table(8) := '69657320696D706C656D656E74696572740D0A202A2077657264656E2C20696E64656D2065696E6520616E67657061737374652056657273696F6E206469657365722044617465692076657277656E64657420756E6420C3BC6265722065696E656E2065';
wwv_flow_api.g_varchar2_table(9) := '6E74737072656368656E642062656E616E6E74656E204E616D656E737261756D207A7572200D0A202A2056657266C3BC67756E672067657374656C6C7420776972642E20446965736572206B616E6E2064656D20506C7567696E20616C7320436F6D706F';
wwv_flow_api.g_varchar2_table(10) := '6E656E742D506172616D6574657220C3BC626572676562656E2077657264656E2C207374616E646172646DC3A4C39F6967206973742065730D0A202A2064652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F302E0D0A202A0D0A';
wwv_flow_api.g_varchar2_table(11) := '202A20416267656C65697465746520496D706C656D656E74696572756E67656E206DC3BC7373656E20666F6C67656E64652046756E6B74696F6E656E20696D706C656D656E74696572656E3A0D0A202A202D207375626D69745061676528726571756573';
wwv_flow_api.g_varchar2_table(12) := '742C206D657373616765290D0A202A2020204D6574686F6465207072C3BC66742C206F62204665686C65726D656C64756E67656E206175662064657220536569746520616E67657A656967742077657264656E20756E642077697266742065696E652046';
wwv_flow_api.g_varchar2_table(13) := '65686C65726D656C64756E672C20616E736F6E7374656E0D0A202A202020776972642064696520536569746520C3BC62657220617065782E7375626D6974287265717565737429206162676573636869636B740D0A202A202D207365744669656C644D61';
wwv_flow_api.g_varchar2_table(14) := '6E6461746F7279286974656D2C206D616E6461746F7279290D0A202A202020446965204D6574686F64652073746174746574204954454D206D69742064656E204B6C617373656E2065696E65732050666C6963687466656C646573206175732C2066616C';
wwv_flow_api.g_varchar2_table(15) := '6C73204D414E4441544F52592074727565206973742C20616E736F6E7374656E0D0A202A202020656E746665726E7420646965204D6574686F646520646965204B6C617373656E0D0A202A202D206D61696E7461696E4572726F7273286572726F724C69';
wwv_flow_api.g_varchar2_table(16) := '7374290D0A202A202020446965204D6574686F646520696D706C656D656E74696572742064696520416E7A6569676520766F6E204665686C65726D656C64756E67656E2061756620646572204F626572666CC3A46368652E0D0A202A2020204469652046';
wwv_flow_api.g_varchar2_table(17) := '65686C65726461727374656C6C756E6720756E64206469652042656E61636872696368746967756E672073696E6420696E204150455820696E2064656E2052656E6465722D50726F7A6573732064657220536569746520696E74656772696572740D0A20';
wwv_flow_api.g_varchar2_table(18) := '2A202020756E64206DC3BC7373656E2C2077656E6E207369652064757263682064617320506C7567696E2076657277656E6465742077657264656E20736F6C6C656E2C2068696572206E616368676562696C6465742077657264656E2E0D0A202A202020';
wwv_flow_api.g_varchar2_table(19) := '446965204D6574686F646520657268C3A46C742065696E204A534F4E2D4F626A656B74206D6974204665686C65726E2C2064696520617566676574726574656E2073696E6420756E642064617267657374656C6C742077657264656E206DC3BC7373656E';
wwv_flow_api.g_varchar2_table(20) := '2E0D0A202A202020446965736573204A534F4E2D4F626A656B74207769726420696E20666F6C67656E64656D20466F726D617420C3BC626572676562656E3A0D0A202A20202020207B22636F756E74223A302C202F2F20416E7A61686C20646572204665';
wwv_flow_api.g_varchar2_table(21) := '686C65722C2064696520617566676574726574656E2073696E640D0A202A2020202020202020226572726F72446570656E64656E74427574746F6E73223A22222C202F2F204C6973746520766F6E2053656974656E656C656D656E74656E20286E6F726D';
wwv_flow_api.g_varchar2_table(22) := '616C6572776569736520536368616C74666CC3A46368656E292C20646965206465616B746976696572740D0A202A2020202020202020202020202020202020202020202020202020202020202020202020202F2F2077657264656E20736F6C6C656E2C20';
wwv_flow_api.g_varchar2_table(23) := '77656E6E2077656E69677374656E732065696E204665686C6572206175662064657220536569746520616E67657A6569677420776972640D0A202A202020202020202022666972696E674974656D73223A22222C20202020202020202020202F2F204C69';
wwv_flow_api.g_varchar2_table(24) := '73746520766F6E20456C656D656E74656E2C206469652064757263682064696520616B7475656C6C6520526567656C20626574726F6666656E2073696E642E20566F6E2064696573656E20456C656D656E74656E0D0A202A202020202020202020202020';
wwv_flow_api.g_varchar2_table(25) := '2020202020202020202020202020202020202020202020202F2F206DC3BC7373656E206576656E7475656C6C20766F7268616E64656E65204665686C65726D656C64756E67656E20656E746665726E742077657264656E2E0D0A202A2020202020202020';
wwv_flow_api.g_varchar2_table(26) := '226572726F7273223A5B2020202020202020202020202020202020202F2F204C697374652064657220617566676574726574656E656E204665686C65720D0A202A202020202020202020207B226974656D223A22222C2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(27) := '202F2F2049442064657320456C656D656E74732C206461732064656E204665686C657220657268C3A46C742C206F64657220444F43554D454E542C200D0A202A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(28) := '2F2F20756D20616E7A757A656967656E2C20646173732065696E2067656E6572656C6C6572204665686C657220766F726C696567740D0A202A202020202020202020202020226D657373616765223A22222C20202020202020202020202F2F204665686C';
wwv_flow_api.g_varchar2_table(29) := '65726D656C64756E670D0A202A202020202020202020202020226164646974696F6E616C496E666F223A222220202020202F2F206F7074696F6E616C65205A757361747A696E666F726D6174696F6E656E2C207A2E422E2043616C6C537461636B206574';
wwv_flow_api.g_varchar2_table(30) := '632E0D0A202A202020202020202020207D0D0A202A20202020202020205D0D0A202A20202020207D0D0A202A202020446965204D6574686F646520656E746665726E74207A756EC3A46368737420616C6C65204665686C65726D656C64756E67656E2064';
wwv_flow_api.g_varchar2_table(31) := '657220456C656D656E74652061757320464952494E4749544D455320756E642066C3BC677420616E7363686C6965C39F656E642064696520C3BC626572676562656E656E204665686C65722065696E2E0D0A202A202D207365744E6F7469666963617469';
wwv_flow_api.g_varchar2_table(32) := '6F6E286D657373616765290D0A202A202020446965204D6574686F6465207A656967742065696E652042656E61636872696368746967756E672061756620646572204F626572666CC3A46368652E20576972642061756620646572204F626572666CC3A4';
wwv_flow_api.g_varchar2_table(33) := '63686520626572656974732065696E65204E616368726963687420616E67657A656967742C200D0A202A2020207769726420646965736520766F72616220656E746665726E742E2042656E61636872696368746967756E67656E20756E64204665686C65';
wwv_flow_api.g_varchar2_table(34) := '726D656C64756E67656E206DC3BC7373656E2064617261756668696E2067657072C3BC66742077657264656E2C206F6220736965206175636820626569206D6F64616C656E0D0A202A2020204469616C6F67656E206B6F7272656B742066756E6B74696F';
wwv_flow_api.g_varchar2_table(35) := '6E696572656E0D0A202A202D20636C6561724E6F74696669636174696F6E0D0A202A202020446965204D65746F646520656E746665726E742065696E652042656E61636872696368746967756E6720766F6E20646572204F626572666CC3A46368650D0A';
wwv_flow_api.g_varchar2_table(36) := '202A2F0D0A200D0A202F2F2056657273696F6E20352E302C205468656D652034320D0A2866756E6374696F6E28736374297B0D0A2020202F2F20415045582D4665686C6572626568616E646C756E670D0A202076617220435F415045585F4552524F525F';
wwv_flow_api.g_varchar2_table(37) := '434C415353203D2027617065782D706167652D6974656D2D6572726F72273B0D0A202076617220435F415045585F4552524F525F434C4153535F53454C203D20602E247B435F415045585F4552524F525F434C4153537D603B0D0A20200D0A2020766172';
wwv_flow_api.g_varchar2_table(38) := '20435F4D4553534147455F5449544C455F53454C203D20272E742D416C6572742D7469746C65273B202020200D0A202076617220435F4552524F525F434C4153535F53454C203D2020272E742D426F64792D616C657274273B0D0A202076617220435F45';
wwv_flow_api.g_varchar2_table(39) := '52524F525F554C5F53454C203D2060247B435F4552524F525F434C4153535F53454C7D20756C2E68746D6C6462556C457272603B0D0A202076617220435F4552524F525F524547494F4E5F504F534954494F4E5F53454C203D20272E742D426F64792D63';
wwv_flow_api.g_varchar2_table(40) := '6F6E74656E74273B0D0A202076617220435F4552524F525F4449414C4F475F504F534954494F4E5F53454C203D20272E742D4469616C6F672D626F6479273B0D0A20200D0A202076617220435F4341524F5553454C5F53454C203D20272E612D52656769';
wwv_flow_api.g_varchar2_table(41) := '6F6E2D6361726F7573656C4974656D273B0D0A202076617220435F4341524F5553454C5F4552524F525F434C415353203D20277363742D6361726F7573656C2D6861734572726F72273B0D0A20200D0A202076617220435F415045585F4552524F525F49';
wwv_flow_api.g_varchar2_table(42) := '445F53454C203D202723745F416C6572745F4E6F74696669636174696F6E273B0D0A202076617220435F504147455F4552524F525F54454D504C415445203D20603C64697620636C6173733D22742D426F64792D616C657274223E0D0A20203C64697620';
wwv_flow_api.g_varchar2_table(43) := '636C6173733D22742D416C65727420742D416C6572742D2D64656661756C7449636F6E7320742D416C6572742D2D7761726E696E6720742D416C6572742D2D686F72697A6F6E74616C20742D416C6572742D2D7061676520742D416C6572742D2D636F6C';
wwv_flow_api.g_varchar2_table(44) := '6F7242472069732D76697369626C65222069643D22745F416C6572745F4E6F74696669636174696F6E2220726F6C653D22616C657274223E0D0A202020203C64697620636C6173733D22742D416C6572742D77726170223E0D0A2020202020203C646976';
wwv_flow_api.g_varchar2_table(45) := '20636C6173733D22742D416C6572742D69636F6E223E0D0A20202020202020203C7370616E20636C6173733D22742D49636F6E223E3C2F7370616E3E0D0A2020202020203C2F6469763E0D0A2020202020203C64697620636C6173733D22742D416C6572';
wwv_flow_api.g_varchar2_table(46) := '742D636F6E74656E74223E0D0A20202020202020203C64697620636C6173733D22742D416C6572742D686561646572223E0D0A202020202020202020203C683220636C6173733D22742D416C6572742D7469746C65223E3C2F68323E0D0A202020202020';
wwv_flow_api.g_varchar2_table(47) := '20203C2F6469763E0D0A20202020202020203C64697620636C6173733D22742D416C6572742D626F6479223E0D0A202020202020202020203C756C20636C6173733D2268746D6C6462556C457272223E3C2F756C3E0D0A20202020202020203C2F646976';
wwv_flow_api.g_varchar2_table(48) := '3E0D0A2020202020203C2F6469763E0D0A2020202020203C64697620636C6173733D22742D416C6572742D627574746F6E73223E0D0A20202020202020203C627574746F6E20636C6173733D22742D427574746F6E20742D427574746F6E2D2D6E6F5549';
wwv_flow_api.g_varchar2_table(49) := '20742D427574746F6E2D2D69636F6E20742D427574746F6E2D2D636C6F7365416C6572742220747970653D22627574746F6E22207469746C653D225363686C6965C39F656E223E3C7370616E20636C6173733D22742D49636F6E2069636F6E2D636C6F73';
wwv_flow_api.g_varchar2_table(50) := '65223E3C2F7370616E3E3C2F627574746F6E3E0D0A2020202020203C2F6469763E0D0A202020203C2F6469763E0D0A20203C2F6469763E0D0A3C2F6469763E603B0D0A20200D0A20202F2F205374616E646172642041504558204665686C65726D656C64';
wwv_flow_api.g_varchar2_table(51) := '756E67206265696D20456C656D656E740D0A202076617220435F454C454D454E545F4552524F525F54454D504C415445203D20603C7370616E20636C6173733D22742D466F726D2D6572726F72223E247B746869732E6D6573736167657D3C2F7370616E';
wwv_flow_api.g_varchar2_table(52) := '3E603B0D0A202076617220435F454C454D454E545F4552524F525F53454C203D2027202E742D466F726D2D6572726F72273B0D0A0D0A20202F2F2042656E61636872696368746967756E67656E0D0A202076617220435F415045585F4E4F544946494341';
wwv_flow_api.g_varchar2_table(53) := '54494F4E5F49445F53454C203D202723745F416C6572745F53756363657373273B0D0A202076617220435F504147455F4E4F54494649434154494F4E5F54454D504C415445203D20603C64697620636C6173733D22742D426F64792D616C657274223E0D';
wwv_flow_api.g_varchar2_table(54) := '0A20203C6469762069643D22745F416C6572745F537563636573732220636C6173733D22742D416C65727420742D416C6572742D2D64656661756C7449636F6E7320742D416C6572742D2D7375636365737320742D416C6572742D2D686F72697A6F6E74';
wwv_flow_api.g_varchar2_table(55) := '616C20742D416C6572742D2D7061676520742D416C6572742D2D636F6C6F7242472069732D76697369626C652220726F6C653D22616C657274223E0D0A202020203C64697620636C6173733D22742D416C6572742D77726170223E0D0A2020202020203C';
wwv_flow_api.g_varchar2_table(56) := '64697620636C6173733D22742D416C6572742D69636F6E223E0D0A20202020202020203C7370616E20636C6173733D22742D49636F6E223E3C2F7370616E3E0D0A2020202020203C2F6469763E0D0A2020202020203C64697620636C6173733D22742D41';
wwv_flow_api.g_varchar2_table(57) := '6C6572742D636F6E74656E74223E0D0A20202020202020203C64697620636C6173733D22742D416C6572742D686561646572223E0D0A202020202020202020203C683220636C6173733D22742D416C6572742D7469746C65223E3C2F68323E0D0A202020';
wwv_flow_api.g_varchar2_table(58) := '20202020203C2F6469763E0D0A2020202020203C2F6469763E0D0A20202020202020203C64697620636C6173733D22742D416C6572742D626F6479223E3C2F6469763E0D0A2020202020203C64697620636C6173733D22742D416C6572742D627574746F';
wwv_flow_api.g_varchar2_table(59) := '6E73223E0D0A20202020202020203C627574746F6E20636C6173733D22742D427574746F6E20742D427574746F6E2D2D6E6F554920742D427574746F6E2D2D69636F6E20742D427574746F6E2D2D636C6F7365416C6572742220747970653D2262757474';
wwv_flow_api.g_varchar2_table(60) := '6F6E22207469746C653D225363686C6965C39F656E223E3C7370616E20636C6173733D22742D49636F6E2069636F6E2D636C6F7365223E3C2F7370616E3E3C2F627574746F6E3E0D0A2020202020203C2F6469763E0D0A202020203C2F6469763E0D0A20';
wwv_flow_api.g_varchar2_table(61) := '203C2F6469763E0D0A3C2F6469763E603B0D0A20200D0A20202F2F2050666C6963687466656C6465720D0A202076617220435F52455155495245445F5350414E5F53454C203D20277370616E2E742D466F726D2D7265717569726564273B0D0A20207661';
wwv_flow_api.g_varchar2_table(62) := '7220435F4649454C445F52455155495245445F54454D504C415445203D20273C7370616E20636C6173733D22742D466F726D2D7265717569726564223E3C7370616E20636C6173733D22612D49636F6E2069636F6E2D617374657269736B223E3C2F7370';
wwv_flow_api.g_varchar2_table(63) := '616E3E3C2F7370616E3E273B0D0A2020766172206572726F72436F756E743B0D0A0D0A20202F2F2048696C667366756E6B74696F6E656E0D0A202066756E6374696F6E207365744D6573736167652829207B0D0A202020206572726F72436F756E74203D';
wwv_flow_api.g_varchar2_table(64) := '202428435F415045585F4552524F525F434C4153535F53454C292E6C656E6774683B0D0A20202020617065782E64656275672E6C6F672860416E7A61686C204665686C65723A20247B6572726F72436F756E747D60293B0D0A20202020246D6573736167';
wwv_flow_api.g_varchar2_table(65) := '655469746C65203D202428435F4D4553534147455F5449544C455F53454C293B0D0A2020200D0A2020202073776974636820286572726F72436F756E74297B0D0A09202020206361736520303A0D0A2020202020202020246D6573736167655469746C65';
wwv_flow_api.g_varchar2_table(66) := '2E7465787428604B65696E65204665686C657260293B0D0A2020202020202020627265616B3B0D0A092020200D0A09202020206361736520313A0D0A2020202020202020246D6573736167655469746C652E746578742860457320697374203120466568';
wwv_flow_api.g_varchar2_table(67) := '6C657220617566676574726574656E60293B0D0A2020202020202020627265616B3B0D0A092020200D0A092020202064656661756C743A0D0A202020202020246D6573736167655469746C652E74657874286045732073696E6420247B6572726F72436F';
wwv_flow_api.g_varchar2_table(68) := '756E747D204665686C657220617566676574726574656E60293B0D0A202020207D3B0D0A20207D3B0D0A20200D0A20200D0A20202F2F2048696C667366756E6B74696F6E207A756D2042657265696E6967656E2064657220536569746520766F6E204665';
wwv_flow_api.g_varchar2_table(69) := '686C65726D656C64756E67656E0D0A202066756E6374696F6E2072656D6F76654572726F7273286572726F724C69737429207B0D0A2020202076617220666972696E674974656D73203D206572726F724C6973742E666972696E674974656D732E73706C';
wwv_flow_api.g_varchar2_table(70) := '697428272C27293B0D0A202020200D0A20202020242E6561636828666972696E674974656D732C2066756E6374696F6E28297B0D0A20202020202024286023247B746869737D247B435F415045585F4552524F525F434C4153535F53454C7D60290D0A20';
wwv_flow_api.g_varchar2_table(71) := '20202020202E72656D6F7665436C61737328435F415045585F4552524F525F434C415353290D0A2020202020202E7369626C696E677328277370616E27290D0A2020202020202E72656D6F766528293B0D0A0D0A2020202020206572726F72436F756E74';
wwv_flow_api.g_varchar2_table(72) := '203D202428435F415045585F4552524F525F434C4153535F53454C292E6C656E6774683B0D0A202020202020696620286572726F72436F756E74203D3D2030297B0D0A20202020202020202428435F4552524F525F434C4153535F53454C292E72656D6F';
wwv_flow_api.g_varchar2_table(73) := '766528293B0D0A2020202020207D0D0A202020202020656C73657B0D0A2020202020202020242860247B435F4552524F525F434C4153535F53454C7D202E247B746869737D60292E72656D6F766528293B0D0A2020202020207D0D0A2020202020200D0A';
wwv_flow_api.g_varchar2_table(74) := '2020202020202F2F204CC3B673636865204665686C6572206175732052656769737465726B617274656E2D5265697465726E2C2066616C6C73206B65696E65204665686C657220656E7468616C74656E2073696E640D0A20202020202076617220636172';
wwv_flow_api.g_varchar2_table(75) := '6F7573656C4944203D2024286023247B746869737D60292E636C6F7365737428435F4341524F5553454C5F53454C292E617474722827696427293B0D0A20202020202069662028286361726F7573656C494429202626202824286023247B6361726F7573';
wwv_flow_api.g_varchar2_table(76) := '656C49447D20247B435F415045585F4552524F525F434C4153535F53454C7D60292E6C656E677468203D3D20302929207B0D0A2020202020202020242860612E612D526567696F6E2D6361726F7573656C4C696E6B5B687265663D2223247B6361726F75';
wwv_flow_api.g_varchar2_table(77) := '73656C49447D225D60292E72656D6F7665436C61737328435F4341524F5553454C5F4552524F525F434C415353293B0D0A2020202020207D3B0D0A202020207D293B0D0A20207D3B0D0A0D0A20200D0A20202F2F20446965204D6574686F646520736574';
wwv_flow_api.g_varchar2_table(78) := '4572726F7273207769726420766F6E20526573706F6E7365206175666765727566656E20756E642064617266206461686572206E6963687420756D62656E616E6E74206F64657220656E746665726E742077657264656E0D0A20202F2A2A0D0A2020202A';
wwv_flow_api.g_varchar2_table(79) := '20446965204D6574686F646520626568616E64656C7420616C6C652045696E7A656C6665686C657220617573206572726F724C6973742C2062657265696E6967742064696520626573746568656E6465204665686C65726C697374650D0A2020202A2075';
wwv_flow_api.g_varchar2_table(80) := '6E642066C3BC677420646965206E6575656E204665686C65722068696E7A752E205A7573C3A4747A6C696368207A757220415045582D4772756E6466756E6B74696F6E616C6974C3A4742077657264656E204665686C65722061756368200D0A2020202A';
wwv_flow_api.g_varchar2_table(81) := '20696E2052656769737465726B617274656E7265697465726E20616E67657A656967742C2077656E6E20646572204665686C65722073696368206175662064657220656E74737072656368656E64656E2052656769737465726B6172746520626566696E';
wwv_flow_api.g_varchar2_table(82) := '6465742E0D0A2020202A2F0D0A202066756E6374696F6E207365744572726F7273286572726F724C69737429207B0D0A202020200D0A20202020696620286572726F724C6973742E636F756E74203E2030297B0D0A202020202020617065782E64656275';
wwv_flow_api.g_varchar2_table(83) := '672E6C6F672860416E7A61686C204665686C657220506C7567496E3A20247B6572726F724C6973742E636F756E747D60293B0D0A092020200D0A20202020202069662028242860247B435F4552524F525F434C4153535F53454C7D20247B435F41504558';
wwv_flow_api.g_varchar2_table(84) := '5F4552524F525F49445F53454C7D60292E6C656E677468203D3D2030297B0D0A20202020202020202F2F20457320697374206B65696E65204665686C6572726567696F6E206175662064657220536569746520766F7268616E64656E2C20616E7A656967';
wwv_flow_api.g_varchar2_table(85) := '656E0D0A2020202020202020696620282428435F4552524F525F4449414C4F475F504F534954494F4E5F53454C292E6C656E677468297B200D0A202020202020202020202F2F20457320776972642065696E65206D6F64616C6520536569746520616E67';
wwv_flow_api.g_varchar2_table(86) := '657A656967740D0A202020202020202020202428435F4552524F525F4449414C4F475F504F534954494F4E5F53454C292E70726570656E6428435F504147455F4552524F525F54454D504C415445293B0D0A20202020202020207D0D0A20202020202020';
wwv_flow_api.g_varchar2_table(87) := '20656C73657B0D0A202020202020202020202428435F4552524F525F524547494F4E5F504F534954494F4E5F53454C292E70726570656E6428435F504147455F4552524F525F54454D504C415445293B0D0A20202020202020207D0D0A2020202020207D';
wwv_flow_api.g_varchar2_table(88) := '0D0A2020202020200D0A2020202020202F2F20416C6C652045696E7A656C6665686C657220626568616E64656C6E0D0A202020202020242E65616368286572726F724C6973742E6572726F72732C2066756E6374696F6E2829207B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(89) := '20766172206974656D4944203D20746869732E6974656D3B0D0A202020202020202076617220246974656D203D2024286023247B746869732E6974656D7D60293B0D0A2020202020202020766172206974656D4C6162656C203D2024286023247B697465';
wwv_flow_api.g_varchar2_table(90) := '6D49447D5F4C4142454C60292E7465787428293B0D0A2020202020202020766172206C696E6B5461726765743B0D0A2020202020202020766172206C696E6B546578743B0D0A20202020202020200D0A20202020202020202F2F20415045582D4665686C';
wwv_flow_api.g_varchar2_table(91) := '65726B6C6173736520756E64202D6D656C64756E6720616E2064617320456C656D656E742068C3A46E67656E0D0A2020202020202020246974656D0D0A20202020202020202E616464436C61737328435F415045585F4552524F525F434C415353290D0A';
wwv_flow_api.g_varchar2_table(92) := '20202020202020202E7369626C696E677328277370616E27292E72656D6F766528293B0D0A2020202020202020246974656D2E706172656E7428292E617070656E6428603C7370616E20636C6173733D27742D466F726D2D6572726F72273E247B746869';
wwv_flow_api.g_varchar2_table(93) := '732E6D6573736167657D3C2F7370616E3E60293B0D0A20202020202020200D0A20202020202020202F2F204665686C6572726567696F6E20616B7475616C6973696572656E0D0A20202020202020202F2F204665686C65726D656C64756E6720696E2046';
wwv_flow_api.g_varchar2_table(94) := '65686C6572726567696F6E20657268C3A46C74204C696E6B20617566206461732046656C64202847656865207A75204665686C65722920736F776965204944207A756D2073656C656B746976656E204CC3B6736368656E0D0A20202020202020206C696E';
wwv_flow_api.g_varchar2_table(95) := '6B546172676574203D20606A6176617363726970743A20617065782E6974656D2827247B6974656D49447D27292E736574466F63757328293B766F69642830293B603B0D0A20202020202020206C696E6B54657874203D206047656865207A7520466568';
wwv_flow_api.g_varchar2_table(96) := '6C65723A203C7370616E20636C6173733D27656B2D6974656D4C6162656C54657874273E247B6974656D4C6162656C7D3C2F7370616E3E603B0D0A20202020202020200D0A20202020202020202F2F205465696C2065696E6573204361726F757373656C';
wwv_flow_api.g_varchar2_table(97) := '733F2044616E6E204C696E6B20C3BC626572617262656974656E0D0A202020202020202076617220246361726F7573656C203D20246974656D2E636C6F7365737428435F4341524F5553454C5F53454C293B0D0A20202020202020206966202824636172';
wwv_flow_api.g_varchar2_table(98) := '6F7573656C2E6C656E677468297B0D0A20202020202020202020766172206361726F7573656C4964203D20246361726F7573656C2E617474722827696427293B0D0A20202020202020202020766172206361726F7573656C4E616D65203D20246361726F';
wwv_flow_api.g_varchar2_table(99) := '7573656C2E6368696C6472656E28276469765B646174612D6C6162656C5D27292E6461746128276C6162656C27293B0D0A20202020202020202020242860612E612D526567696F6E2D6361726F7573656C4C696E6B5B687265663D2223247B6361726F75';
wwv_flow_api.g_varchar2_table(100) := '73656C49447D225D60292E616464436C61737328435F4341524F5553454C5F4552524F525F434C415353293B0D0A202020202020202020206C696E6B5461726765742E7265706C61636528276A6176617363726970743A20272C20606A61766173637269';
wwv_flow_api.g_varchar2_table(101) := '70743A20242822612E612D526567696F6E2D6361726F7573656C4C696E6B5B687265663D2723247B6361726F7573656C49647D275D22292E636C69636B28293B60293B0D0A202020202020202020206C696E6B54657874202B3D206020696D2052656769';
wwv_flow_api.g_varchar2_table(102) := '737465723A20247B6361726F7573656C4E616D657D603B0D0A20202020202020207D0D0A20202020202020200D0A20202020202020202F2F204665686C657220616C73204C4920696E204665686C6572726567696F6E2065696E66C3BC67656E0D0A2020';
wwv_flow_api.g_varchar2_table(103) := '2020202020202428435F4552524F525F554C5F53454C292E617070656E6428603C6C6920636C6173733D2768746D6C646253746445727220247B6974656D49447D273E247B746869732E6D6573736167657D20283C6120687265663D247B6C696E6B5461';
wwv_flow_api.g_varchar2_table(104) := '726765747D3E247B6C696E6B546578747D3C2F613E293C2F6C693E60293B0D0A09202020207D293B0D0A202020207D3B0D0A20207D3B20200D0A0D0A20202F2A2A0D0A2020202A20446965204D6574686F6465207072C3BC66742C206F62206461732050';
wwv_flow_api.g_varchar2_table(105) := '6C7567696E20616268C3A46E6769676520456C656D656E74652076657277616C74657420756E64207374657565727420646572656E20416B7469766974C3A47420616268C3A46E676967206461766F6E2C0D0A2020202A206F6220617566206465722053';
wwv_flow_api.g_varchar2_table(106) := '65697465204665686C657220616E67657A656967742077657264656E206F646572206E696368742E0D0A2020202A2F0D0A202066756E6374696F6E206D61696E7461696E446570656E64656E74456C656D656E7473286572726F724C697374297B0D0A20';
wwv_flow_api.g_varchar2_table(107) := '202020696620286572726F724C6973742E6572726F72446570656E64656E74427574746F6E7320213D206E756C6C202626206572726F724C6973742E6572726F72446570656E64656E74427574746F6E7320213D202727297B0D0A202020202020766172';
wwv_flow_api.g_varchar2_table(108) := '206572726F72446570656E64656E74427574746F6E73203D206572726F724C6973742E6572726F72446570656E64656E74427574746F6E732E73706C697428272C27293B0D0A202020202020696620282428435F415045585F4552524F525F434C415353';
wwv_flow_api.g_varchar2_table(109) := '5F53454C292E6C656E677468203D3D2030297B0D0A2020202020202020242E65616368286572726F72446570656E64656E74427574746F6E732C2066756E6374696F6E2829207B0D0A20202020202020202020617065782E6974656D2874686973292E65';
wwv_flow_api.g_varchar2_table(110) := '6E61626C6528293B0D0A20202020202020207D293B0D0A2020202020207D0D0A202020202020656C7365207B0D0A2020202020202020242E65616368286572726F72446570656E64656E74427574746F6E732C2066756E6374696F6E2829207B0D0A2020';
wwv_flow_api.g_varchar2_table(111) := '2020202020202020617065782E6974656D2874686973292E64697361626C6528293B0D0A20202020202020207D293B0D0A2020202020207D3B0D0A202020207D3B0D0A20207D3B0D0A0D0A20200D0A20202F2A2A200D0A2020202A204D6574686F646520';
wwv_flow_api.g_varchar2_table(112) := '73656E646574206469652053656974652061622C2066616C6C73206B65696E65204665686C6572206175662064657220536569746520676566756E64656E2077657264656E2E0D0A2020202A2F0D0A20207363742E7375626D697450616765203D206675';
wwv_flow_api.g_varchar2_table(113) := '6E6374696F6E28726571756573742C206D657373616765297B0D0A20202020696620282428435F415045585F4552524F525F434C4153535F53454C292E6C656E677468203D3D203029207B0D0A202020202020617065782E7375626D6974287265717565';
wwv_flow_api.g_varchar2_table(114) := '7374293B0D0A202020207D0D0A20202020656C73657B0D0A202020202020616C657274286D657373616765293B0D0A202020207D0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F6465207A757220537465756572756E';
wwv_flow_api.g_varchar2_table(115) := '6720646572204461727374656C6C756E6720766F6E2050666C69636874656C656D656E74656E0D0A2020202A2F0D0A20207363742E7365744669656C644D616E6461746F7279203D2066756E6374696F6E286974656D2C206D616E6461746F7279297B0D';
wwv_flow_api.g_varchar2_table(116) := '0A2020202076617220246D616E6461746F72794974656D203D2024286023247B6974656D7D5F4C4142454C60293B0D0A202020202F2F206576746C2E20766F7268616E64656E65204D61726B696572756E6720656E746665726E656E0D0A20202020246D';
wwv_flow_api.g_varchar2_table(117) := '616E6461746F72794974656D2E7369626C696E677328435F52455155495245445F5350414E5F53454C292E72656D6F766528293B0D0A202020200D0A202020206966286D616E6461746F7279297B0D0A202020202020246D616E6461746F72794974656D';
wwv_flow_api.g_varchar2_table(118) := '2E706172656E7428292E617070656E6428435F4649454C445F52455155495245445F54454D504C415445293B0D0A202020207D0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F64652C20756D204665686C6572206175';
wwv_flow_api.g_varchar2_table(119) := '6620646572205365697465207A752076657277616C74656E2E0D0A2020202A2F0D0A20207363742E6D61696E7461696E4572726F7273203D2066756E6374696F6E286572726F724C697374297B0D0A20202020696620286572726F724C6973742E666972';
wwv_flow_api.g_varchar2_table(120) := '696E674974656D7320213D202727207C7C206572726F724C6973742E666972696E674974656D7320213D202727297B2020202020200D0A20202020202072656D6F76654572726F7273286572726F724C697374293B0D0A2020202020207365744572726F';
wwv_flow_api.g_varchar2_table(121) := '7273286572726F724C697374293B0D0A2020202020207365744D65737361676528293B0D0A202020207D0D0A20202020656C7365207B0D0A202020202020696620282428435F4552524F525F434C4153535F53454C292E6C656E677468203E2030297B0D';
wwv_flow_api.g_varchar2_table(122) := '0A20202020202020202F2F206265696D2053656974656C6164656E2C206576656E7475656C6C20696E20646572204D656C64756E6773726567696F6E20766F7268616E64656E65204665686C6572206D697420756E736572656E204B6C617373656E2076';
wwv_flow_api.g_varchar2_table(123) := '6572736568656E0D0A20202020202020202F2F206BC3B66E6E656E206E7572204665686C657220656E7468616C74656E207365696E2C20646965206175732064657220415045582D53656974656E766572617262656974756E6720726573756C74696572';
wwv_flow_api.g_varchar2_table(124) := '656E0D0A20202020202020202F2F205665726D65726B6520696E2064696573656E204665686C65726E2064696520494420646573207265666572656E7A69657274656E20456C656D656E747320756D2073656C656B746976656E204CC3B6736368656E20';
wwv_flow_api.g_varchar2_table(125) := 'C3BC626572204A6176615363726970740D0A2020202020202020242860247B435F4552524F525F434C4153535F53454C7D206C692E68746D6C6462537464457272206160292E656163682866756E6374696F6E28297B0D0A202020202020202020207661';
wwv_flow_api.g_varchar2_table(126) := '72206974656D4C696E6B203D20242874686973292E6174747228276872656627293B0D0A20202020202020202020766172206974656D4E616D65203D206974656D4C696E6B2E6D617463682827617065782E6974656D282E2A292E736574466F63757327';
wwv_flow_api.g_varchar2_table(127) := '295B315D2E7265706C616365282F28275C285C29292F672C202727293B0D0A20202020202020202020242874686973292E636C6F7365737428276C6927292E616464436C617373286974656D4E616D65293B0D0A20202020202020207D293B0D0A202020';
wwv_flow_api.g_varchar2_table(128) := '2020207D3B0D0A202020207D3B0D0A202020202F2F20496E206A6564656D2046616C6C206665686C6572616268C3A46E6769676520456C656D656E746520616B7475616C6973696572656E0D0A202020206D61696E7461696E446570656E64656E74456C';
wwv_flow_api.g_varchar2_table(129) := '656D656E7473286572726F724C697374293B0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F6465207A757220416E7A656967652065696E6572204E61636872696368742061756620646572204F626572666CC3A46368';
wwv_flow_api.g_varchar2_table(130) := '650D0A2020202A2F0D0A20207363742E7365744E6F74696669636174696F6E203D2066756E6374696F6E286D657373616765297B0D0A202020207363742E636C6561724E6F74696669636174696F6E3B0D0A202020202428435F4552524F525F4449414C';
wwv_flow_api.g_varchar2_table(131) := '4F475F504F534954494F4E5F53454C292E70726570656E6428435F504147455F4E4F54494649434154494F4E5F54454D504C415445293B0D0A202020202428435F4D4553534147455F5449544C455F53454C292E74657874286D657373616765293B2020';
wwv_flow_api.g_varchar2_table(132) := '202020200D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F6465207A756D20456E746665726E656E2065696E65722042656E61636872696368746967756E672061756620646572204F7074696F6E0D0A2020202A2F0D0A';
wwv_flow_api.g_varchar2_table(133) := '20207363742E636C6561724E6F74696669636174696F6E203D2066756E6374696F6E28297B0D0A20202020242860247B435F4552524F525F434C4153535F53454C7D20247B435F415045585F4E4F54494649434154494F4E5F49445F53454C7D60292E70';
wwv_flow_api.g_varchar2_table(134) := '6172656E7428292E72656D6F766528293B20202020200D0A20207D3B0D0A7D292864652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F30293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(23000059603232125)
,p_plugin_id=>wwv_flow_api.id(153276322008343886)
,p_file_name=>'sctApex.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(14740188155194095)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN_DESKTOP:&SESSION.'
,p_theme_style_by_user_pref=>false
,p_navigation_list_id=>wwv_flow_api.id(14697746357194054)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(14733799587194083)
,p_nav_list_template_options=>'#DEFAULT#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(14740117447194095)
,p_nav_bar_list_template_id=>wwv_flow_api.id(14730501664194081)
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'PIT-Administration'
,p_alias=>'MAIN'
,p_page_mode=>'NORMAL'
,p_step_title=>'PIT-Administration'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'Home'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(15536022370910683)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200516093241'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14742010382194111)
,p_plug_name=>'Breadcrumbs'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14717261385194073)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(14741501339194109)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(14735520260194086)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14744339058318773)
,p_plug_name=>'Anwendungsbereiche'
,p_component_template_options=>'#DEFAULT#:t-Cards--featured:t-Cards--displayIcons:t-Cards--4cols:t-Cards--desc-2ln:t-Cards--colorize'
,p_plug_template=>wwv_flow_api.id(14705880823194067)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(7166933591486551)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(14727877888194079)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Meldungen administrieren'
,p_alias=>'ADMIN_PMS'
,p_page_mode=>'NORMAL'
,p_step_title=>'Meldungen administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(15536061605911403)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200521085109'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14759256365407190)
,p_plug_name=>'Meldungen'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id,',
'       pms_name,',
'       pms_pmg_name,',
'       pms_pml_name,',
'       pml_display_name,',
'       pms_text,',
'       pse_display_name,',
'       pms_custom_error,',
'       pms_active_error,',
'       pms_description',
'  from pit_ui_admin_pms'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P2_PMG_NAME,P2_PML_NAME'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13482924787910300)
,p_name=>'ROW_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROW_ID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:EDIT_PMS:&SESSION.::&DEBUG.:RP:P3_ROWID:&ROW_ID.'
,p_link_text=>'<i class="fa fa-pencil"/>'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483024372910301)
,p_name=>'PMS_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483143298910302)
,p_name=>'PMS_PMG_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_PMG_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Meldungsgruppe'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483286148910303)
,p_name=>'PMS_PML_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_PML_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Sprache-ID'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483409727910304)
,p_name=>'PML_DISPLAY_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PML_DISPLAY_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Sprache'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483446147910305)
,p_name=>'PMS_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_TEXT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Text'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483518625910306)
,p_name=>'PSE_DISPLAY_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PSE_DISPLAY_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Schweregrad'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483691024910307)
,p_name=>'PMS_CUSTOM_ERROR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_CUSTOM_ERROR'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Fehler-ID'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483792095910308)
,p_name=>'PMS_ACTIVE_ERROR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_ACTIVE_ERROR'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Fehlernr'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(13483873173910309)
,p_name=>'PMS_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Beschreibung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(13482897835910299)
,p_internal_uid=>9352784268707840
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_max_row_count=>100000
,p_show_nulls_as=>'-'
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(7189346877631127)
,p_interactive_grid_id=>wwv_flow_api.id(13482897835910299)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(7189479316631127)
,p_report_id=>wwv_flow_api.id(7189346877631127)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7190012602631132)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(13482924787910300)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7190433619631137)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(13483024372910301)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>319
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7190946652631138)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(13483143298910302)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7191445076631140)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(13483286148910303)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7191974382631141)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(13483409727910304)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7192474589631143)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(13483446147910305)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7193001753631144)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(13483518625910306)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>109
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7193502163631146)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(13483691024910307)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7193999125631148)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(13483792095910308)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>68
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(7194495567631149)
,p_view_id=>wwv_flow_api.id(7189479316631127)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(13483873173910309)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14765393818407203)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14717261385194073)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(14741501339194109)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(14735520260194086)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13482743661910298)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(14759256365407190)
,p_button_name=>'EDIT_PMG'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Meldungsgruppe bearbeiten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMG:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14763917332407198)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(14759256365407190)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Meldung erzeugen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMS:&SESSION.::&DEBUG.:RP:P3_ROWID:#ROW_ID#'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10074409574423102)
,p_name=>'P2_PMG_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(14759256365407190)
,p_prompt=>'Gruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_GROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_group',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- optional wählen'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10074475862423103)
,p_name=>'P2_PML_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(14759256365407190)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PML_NAME_IN_USE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_language',
' where pml_in_use = ''Y''',
' order by pml_default_order'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- optional wählen'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14762968323407198)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(14759256365407190)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14763507702407198)
,p_event_id=>wwv_flow_api.id(14762968323407198)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(14759256365407190)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14764315674407200)
,p_name=>'Create Button - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(14763917332407198)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14764769478407200)
,p_event_id=>wwv_flow_api.id(14764315674407200)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(14759256365407190)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(10074550800423104)
,p_name=>'Refresh Report'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_PML_NAME,P2_PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10074685055423105)
,p_event_id=>wwv_flow_api.id(10074550800423104)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(14759256365407190)
,p_stop_execution_on_error=>'Y'
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Meldung editieren'
,p_alias=>'EDIT_PMS'
,p_page_mode=>'MODAL'
,p_step_title=>'Meldung editieren'
,p_reload_on_submit=>'A'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(15536061605911403)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_step_template=>wwv_flow_api.id(14703622267194064)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'800'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_protection_level=>'C'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200605175412'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14748349057407053)
,p_plug_name=>'Meldung editieren'
,p_region_name=>'EDIT_PMS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14705880823194067)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14749037068407053)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14710401710194070)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14749492947407053)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(14749037068407053)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14748937935407053)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(14749037068407053)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Meldung entfernen'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14748900201407053)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(14749037068407053)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14748751408407053)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(14749037068407053)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Meldug erzeugen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_grid=>false
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7206178422736260)
,p_name=>'P3_PMS_PMG_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Meldungsgruppe'
,p_source=>'PMS_PMG_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_GROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_group',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- bitte wählen'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(14734643971194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7206621302736265)
,p_name=>'P3_PMS_DESCRIPTION'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Beschreibung'
,p_source=>'PMS_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_help_text=>'Optionale Beschreibung.<br>Kann verwendet werden, um im Fehlerfall zusätzliche Handlungsanweisungen an den Anwender zu geben.'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14752209790407144)
,p_name=>'P3_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14752607336407161)
,p_name=>'P3_PMS_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'PMS_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>120
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(14734643971194084)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Eindeutiger Name, gemäß Benennungskonventionen:',
'<ul><li>Großbuchstaben</li><li>Nur Unterstrich als Sonderzeichen</li><li>Fehlermeldung maximal 26, andere maximal 30 Zeichen</li></ul>'))
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14752889680407164)
,p_name=>'P3_PMS_PML_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_item_default=>'return pit_ui_pkg.get_default_language;'
,p_item_default_type=>'PLSQL_FUNCTION_BODY'
,p_prompt=>'Sprache'
,p_source=>'PMS_PML_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_language',
' order by pml_default_order nulls last, d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Sprache wählen -'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(14734643971194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Sprache der Meldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14753281931407164)
,p_name=>'P3_PMS_TEXT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Meldung'
,p_source=>'PMS_TEXT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_help_text=>'Meldungstext.<br>Ersetzung der Parameter #1# bis #50# gemäß Zahlwert.<br>Übergebene Parameter werden positional nummeriert und auf die Ersetzungsmarken verteilt.'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14753704226407164)
,p_name=>'P3_PMS_PSE_ID'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_item_default=>'70'
,p_prompt=>'Schweregrad'
,p_source=>'PMS_PSE_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_severity',
' order by r desc'))
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Schweregrad der Fehlermeldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14754076517407165)
,p_name=>'P3_PMS_CUSTOM_ERROR'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fehlernummer'
,p_source=>'PMS_CUSTOM_ERROR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Optionale Fehlernummer.<br>Muss bei eigenen Fehlern nicht angegeben werden, dient dem Mappen Oracle-definierter Fehler auf Fehlermeldungen.<br>Wird eine Fehlernummer doppelt belegt, wird ein Fehler geworfen.<br>Insbesondere darf keine Fehlernummer im'
||' Bereich - 20999 bis -20001 angegben werden, PIT verwaltet diese Fehlernummer automatisch.'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16468216543451670)
,p_name=>'P3_ORACLE_ERROR_HINT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(14748349057407053)
,p_source=>'apex_lang.message(''ORACLE_ERROR_HINT'');'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_protection_level=>'I'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(7206496986736263)
,p_validation_name=>'Validate EDIT_PMS'
,p_validation_sequence=>10
,p_validation=>'return pit_ui_pkg.validate_edit_pms;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_always_execute=>'N'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14749581523407053)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(14749492947407053)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14750334441407054)
,p_event_id=>wwv_flow_api.id(14749581523407053)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(10074775155423106)
,p_name=>'Show Error Item'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_PMS_PSE_ID'
,p_condition_element=>'P3_PMS_PSE_ID'
,p_triggering_condition_type=>'LESS_THAN_OR_EQUAL'
,p_triggering_expression=>'30'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10074876394423107)
,p_event_id=>wwv_flow_api.id(10074775155423106)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR,P3_ORACLE_ERROR_HINT'
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10074990274423108)
,p_event_id=>wwv_flow_api.id(10074775155423106)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR,P3_ORACLE_ERROR_HINT'
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4225610727687338)
,p_event_id=>wwv_flow_api.id(10074775155423106)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'-20000'
,p_attribute_09=>'N'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4225752888687339)
,p_event_id=>wwv_flow_api.id(10074775155423106)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7206301254736261)
,p_name=>'Format PMS_NAME'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_PMS_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7206314911736262)
,p_event_id=>wwv_flow_api.id(7206301254736261)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui_pkg.harmonize_sql_name(''P3_PMS_NAME'');'
,p_attribute_02=>'P3_PMS_NAME'
,p_attribute_03=>'P3_PMS_NAME'
,p_attribute_04=>'Y'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4225420188687336)
,p_name=>'Initialize Page'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4225528474687337)
,p_event_id=>wwv_flow_api.id(4225420188687336)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_PML_NAME'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14756403983407169)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_PMS'
,p_attribute_02=>'PIT_UI_EDIT_PMS'
,p_attribute_03=>'P3_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(10073242163423091)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_PMG'
,p_process_sql_clob=>'pit_ui_pkg.process_edit_pms;'
,p_process_error_message=>'Fehler beim Speichern der Meldung:<br>#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Meldung wurde gespeichert.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14757216927407169)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(14748937935407053)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14757539765407169)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_api.create_page(
 p_id=>4
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Meldungsgruppe bearbeiten'
,p_alias=>'EDIT_PMG'
,p_page_mode=>'MODAL'
,p_step_title=>'Meldungsgruppe bearbeiten'
,p_step_sub_title=>'Meldungsgruppe bearbeiten'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'900'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200524110539'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4554682877823226)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14710401710194070)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4710567423573965)
,p_plug_name=>'Meldungsgruppe bearbeiten'
,p_region_name=>'EDIT_PMG'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14713504681194072)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PMG_NAME,',
'       PMG_DESCRIPTION,',
'       PMG_AMOUNT,',
'       ALLOWED_OPERATIONS',
'  from PIT_UI_EDIT_PMG'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4711773400573970)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4712215467573970)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4712871027573971)
,p_name=>'PMG_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMG_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Meldungsgruppe'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
,p_readonly_condition_type=>'PLSQL_EXPRESSION'
,p_readonly_condition=>':PMG_AMOUNT > 0'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4713487732573973)
,p_name=>'PMG_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMG_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Beschreibung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>800
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4714042984573973)
,p_name=>'PMG_AMOUNT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMG_AMOUNT'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Anzahl Meldungen'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>50
,p_value_alignment=>'RIGHT'
,p_attribute_02=>'VALUE'
,p_format_mask=>'9990'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4714646505573973)
,p_name=>'ALLOWED_OPERATIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ALLOWED_OPERATIONS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(4711045753573967)
,p_internal_uid=>4711045753573967
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_edit_row_operations_column=>'ALLOWED_OPERATIONS'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_add_button_label=>'Meldungsgruppe erstellen'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(4711466308573968)
,p_interactive_grid_id=>wwv_flow_api.id(4711045753573967)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(4711507483573968)
,p_report_id=>wwv_flow_api.id(4711466308573968)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4712639038573971)
,p_view_id=>wwv_flow_api.id(4711507483573968)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(4712215467573970)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4713271913573973)
,p_view_id=>wwv_flow_api.id(4711507483573968)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(4712871027573971)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4713837041573973)
,p_view_id=>wwv_flow_api.id(4711507483573968)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(4713487732573973)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>423
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4714423337573973)
,p_view_id=>wwv_flow_api.id(4711507483573968)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(4714042984573973)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>127
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4715063345573973)
,p_view_id=>wwv_flow_api.id(4711507483573968)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(4714646505573973)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4554730306823227)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4554682877823226)
,p_button_name=>'CANCEL'
,p_button_static_id=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4555050881823230)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4554682877823226)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Schließen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4554521970823225)
,p_tabular_form_region_id=>wwv_flow_api.id(4710567423573965)
,p_validation_name=>'Validate EDIT_PMG'
,p_validation_sequence=>10
,p_validation=>'return pit_ui_pkg.validate_edit_pmg;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_always_execute=>'N'
,p_only_for_changed_rows=>'Y'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4554872055823228)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(4554730306823227)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4554930053823229)
,p_event_id=>wwv_flow_api.id(4554872055823228)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4555631660823236)
,p_name=>'Format PMG_NAME'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(4710567423573965)
,p_triggering_element=>'PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4555757992823237)
,p_event_id=>wwv_flow_api.id(4555631660823236)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui_pkg.harmonize_sql_name(''PMG_NAME'');'
,p_attribute_02=>'PMG_NAME'
,p_attribute_03=>'PMG_NAME'
,p_attribute_04=>'Y'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4715219616573975)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(4710567423573965)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PMG'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui_pkg.process_edit_pmg;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4555280582823232)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_api.create_page(
 p_id=>6
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Parameter administrieren'
,p_alias=>'ADMIN_PARAM'
,p_page_mode=>'NORMAL'
,p_step_title=>'Parameter administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(15536150023912708)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200516120616'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4223454604687316)
,p_plug_name=>'Liste der Parameter'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, ',
'       par_id,',
'       pgr_id,',
'       pgr_description,',
'       par_description,',
'       pat_description,',
'       par_value,',
'       par_is_modifiable',
'  from pit_ui_admin_par '))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P6_PGR_ID'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4223639261687318)
,p_name=>'ROW_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROW_ID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:EDIT_PAR:&SESSION.::&DEBUG.:RP,7:P7_ROWID:&ROW_ID.'
,p_link_text=>'<i class="fa fa-pencil"/>'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4223718365687319)
,p_name=>'PAR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Parameter'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4223882296687320)
,p_name=>'PGR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PGR_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Pgr id'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4223985807687321)
,p_name=>'PGR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PGR_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Parametergruppe'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4224006265687322)
,p_name=>'PAR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Beschreibung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>800
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4224189327687323)
,p_name=>'PAT_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAT_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Texttyp'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4224989565687331)
,p_name=>'PAR_IS_MODIFIABLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_IS_MODIFIABLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'modifizierbar'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_attribute_01=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4225380497687335)
,p_name=>'PAR_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_VALUE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Parameterwert'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>150
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(4223525175687317)
,p_internal_uid=>4223525175687317
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(4281191988139179)
,p_interactive_grid_id=>wwv_flow_api.id(4223525175687317)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(4281256608139179)
,p_report_id=>wwv_flow_api.id(4281191988139179)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4281783150139182)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(4223639261687318)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4282210125139185)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(4223718365687319)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>216
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4282748556139187)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(4223882296687320)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4283110692139187)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(4223985807687321)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4283642516139189)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(4224006265687322)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>502
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4284134560139190)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(4224189327687323)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4288163021139198)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(4224989565687331)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>119
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4331139313386659)
,p_view_id=>wwv_flow_api.id(4281256608139179)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(4225380497687335)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>427
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16325344660045576)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14717261385194073)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(14741501339194109)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(14735520260194086)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16468618033451674)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4223454604687316)
,p_button_name=>'EDIT_PGR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Parametergruppen verwalten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PGR:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16323909418045573)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4223454604687316)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Parameter erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PAR:&SESSION.::&DEBUG.:RP:P7_ROWID:'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16468282939451671)
,p_name=>'P6_PGR_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(4223454604687316)
,p_prompt=>'Parmetergruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_parameter_group',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Alle'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16324237674045573)
,p_name=>'Schaltfläche erstellen - Dialog geschlossen'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(4223454604687316)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16324725268045573)
,p_event_id=>wwv_flow_api.id(16324237674045573)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(4223454604687316)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16468416896451672)
,p_name=>'Refresh Parameter verwalten'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P6_PGR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16468515606451673)
,p_event_id=>wwv_flow_api.id(16468416896451672)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(4223454604687316)
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Parameter bearbeiten'
,p_alias=>'EDIT_PAR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parameter bearbeiten'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(15536150023912708)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_height=>'1000'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_protection_level=>'C'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_read_only_when=>':P7_PAR_IS_MODIFIABLE = utl_apex.C_FALSE'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200516115635'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16303681075045426)
,p_plug_name=>'Parameter bearbeiten'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14705880823194067)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16304381224045429)
,p_plug_name=>'Schaltflächen'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14710401710194070)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16325958271045576)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14717261385194073)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(14741501339194109)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(14735520260194086)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16304820823045429)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16304381224045429)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16304231011045429)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(16304381224045429)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Löschen'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P7_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16304193226045429)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(16304381224045429)
,p_button_name=>'SAVE'
,p_button_static_id=>'B7_SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Änderungen anwenden'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16304105548045429)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(16304381224045429)
,p_button_name=>'CREATE'
,p_button_static_id=>'P7_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4225236325687334)
,p_name=>'P7_PAR_XML_VALUE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'XML-Wert'
,p_source=>'PAR_XML_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16307172676045520)
,p_name=>'P7_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_source=>'ROW_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16307513696045534)
,p_name=>'P7_PAR_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Parameter'
,p_source=>'PAR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>120
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16307783341045536)
,p_name=>'P7_PAR_PGR_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Parametergruppe'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_parameter_group',
' order by d'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16308147068045536)
,p_name=>'P7_PAR_DESCRIPTION'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Besschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>800
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16308527945045539)
,p_name=>'P7_PAR_STRING_VALUE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Zeichenkettenwert'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16309003113045539)
,p_name=>'P7_PAR_INTEGER_VALUE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Ganzzahlwert'
,p_source=>'PAR_INTEGER_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16309325973045539)
,p_name=>'P7_PAR_FLOAT_VALUE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fließkommazahlwert'
,p_source=>'PAR_FLOAT_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16309769325045539)
,p_name=>'P7_PAR_DATE_VALUE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Datumswert'
,p_source=>'PAR_DATE_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16310175734045540)
,p_name=>'P7_PAR_TIMESTAMP_VALUE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Zeitstempelwert'
,p_source=>'PAR_TIMESTAMP_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16310954858045540)
,p_name=>'P7_PAR_BOOLEAN_VALUE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Wahrheitswert'
,p_source=>'PAR_BOOLEAN_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_BOOLEAN_TRI_STATE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_boolean_tri_state'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16311396968045542)
,p_name=>'P7_PAR_IS_MODIFIABLE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Ist modifizierbar'
,p_source=>'PAR_IS_MODIFIABLE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Nein;N'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- wie Parametergruppe'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16311823717045542)
,p_name=>'P7_PAR_PAT_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Parametertyp'
,p_source=>'PAR_PAT_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_TYPE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_parameter_type',
' order by d'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16312163666045542)
,p_name=>'P7_PAR_VALIDATION_STRING'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Validierungsausdruck'
,p_source=>'PAR_VALIDATION_STRING'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16312544722045542)
,p_name=>'P7_PAR_VALIDATION_MESSAGE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(16303681075045426)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fehlermeldung'
,p_source=>'PAR_VALIDATION_MESSAGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16310675733045540)
,p_validation_name=>'P7_PAR_TIMESTAMP_VALUE must be timestamp'
,p_validation_sequence=>90
,p_validation=>'P7_PAR_TIMESTAMP_VALUE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# muss ein gültiger Zeitstempel sein.'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(16310175734045540)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16326725545170772)
,p_validation_name=>'P7_PAR_FLOAT_VALUE must be numeric'
,p_validation_sequence=>100
,p_validation=>'P7_PAR_FLOAT_VALUE'
,p_validation_type=>'ITEM_IS_NUMERIC'
,p_error_message=>'Geben Sie bitte eine gültige Zahl an. Dezimaltrenner: .'
,p_always_execute=>'N'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16326842881170773)
,p_validation_name=>'P7_INTEGER_VALUE must be an integer'
,p_validation_sequence=>110
,p_validation=>'return pit_ui_pkg.validate_is_integer(:P7_PAR_INTEGER_VALUE);'
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(16309003113045539)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4225131503687333)
,p_validation_name=>'Validate EDIT_PAR'
,p_validation_sequence=>120
,p_validation=>'return pit_ui_pkg.validate_edit_par;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_always_execute=>'N'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16304867458045429)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(16304820823045429)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16305639857045433)
,p_event_id=>wwv_flow_api.id(16304867458045429)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16314581216045545)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_PAR'
,p_attribute_02=>'PIT_UI_EDIT_PAR'
,p_attribute_03=>'P7_ROWID'
,p_attribute_04=>'ROW_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16314999560045545)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_PAR'
,p_process_sql_clob=>'pit_ui_pkg.process_edit_par;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16315357927045545)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(16304231011045429)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16315727851045547)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
end;
/
prompt --application/pages/page_00008
begin
wwv_flow_api.create_page(
 p_id=>8
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Parametergruppe bearbeiten'
,p_alias=>'EDIT_PGR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parametergruppe bearbeiten'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(15536150023912708)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1000'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200524130240'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4223251164687314)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14710401710194070)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16479054237677942)
,p_plug_name=>'Parametergruppe bearbeiten'
,p_region_name=>'EDIT_PGR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14713504681194072)
,p_plug_display_sequence=>15
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select pgr_id,',
'       pgr_description,',
'       pgr_is_modifiable,',
'       allowed_operations,',
'       par_amount',
'  from pit_ui_edit_pgr',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4222103725687303)
,p_name=>'PGR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PGR_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Parametergruppe'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4222299374687304)
,p_name=>'PGR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PGR_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Beschreibung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4222358546687305)
,p_name=>'PGR_IS_MODIFIABLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PGR_IS_MODIFIABLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'modifizierbar'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'APPLICATION'
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'Y'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4222551847687307)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>40
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4222627630687308)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4222970670687311)
,p_name=>'ALLOWED_OPERATIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ALLOWED_OPERATIONS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4556202176823242)
,p_name=>'PAR_AMOUNT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_AMOUNT'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Anz. Parameter'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(4221981779687301)
,p_internal_uid=>4221981779687301
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_edit_row_operations_column=>'ALLOWED_OPERATIONS'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>false
,p_show_toolbar=>true
,p_toolbar_buttons=>'SAVE'
,p_add_button_label=>'Parametergruppe erstellen'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>false
,p_download_formats=>null
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(4230426645699204)
,p_interactive_grid_id=>wwv_flow_api.id(4221981779687301)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(4230583680699204)
,p_report_id=>wwv_flow_api.id(4230426645699204)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4231587737699212)
,p_view_id=>wwv_flow_api.id(4230583680699204)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(4222103725687303)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4232092617699214)
,p_view_id=>wwv_flow_api.id(4230583680699204)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(4222299374687304)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>437
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4232579868699215)
,p_view_id=>wwv_flow_api.id(4230583680699204)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(4222358546687305)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>99
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4236418436723925)
,p_view_id=>wwv_flow_api.id(4230583680699204)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(4222551847687307)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4237395934723928)
,p_view_id=>wwv_flow_api.id(4230583680699204)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(4222970670687311)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4829909587026798)
,p_view_id=>wwv_flow_api.id(4230583680699204)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(4556202176823242)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>107
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16482843269677951)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4223251164687314)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Schließen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16482628360677951)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4223251164687314)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4223321230687315)
,p_tabular_form_region_id=>wwv_flow_api.id(16479054237677942)
,p_validation_name=>'Validate EDIT_PGR'
,p_validation_sequence=>10
,p_validation=>'return pit_ui_pkg.validate_edit_pgr;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_always_execute=>'N'
,p_only_for_changed_rows=>'Y'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4223057798687312)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(16482628360677951)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4223165948687313)
,p_event_id=>wwv_flow_api.id(4223057798687312)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4555924344823239)
,p_name=>'Format PGR'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(16479054237677942)
,p_triggering_element=>'PGR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4556001814823240)
,p_event_id=>wwv_flow_api.id(4555924344823239)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui_pkg.harmonize_sql_name(''PGR_ID'');'
,p_attribute_02=>'PGR_ID'
,p_attribute_03=>'PGR_ID'
,p_attribute_04=>'Y'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4222715180687309)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(16479054237677942)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PGR'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui_pkg.process_edit_pgr;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16486949934677959)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00009
begin
wwv_flow_api.create_page(
 p_id=>9
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'PIT administrieren'
,p_alias=>'ADMIN_PIT'
,p_page_mode=>'NORMAL'
,p_step_title=>'PIT administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(16496474367775761)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200519155253'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16469228828451681)
,p_plug_name=>'Hinweise zu Ausgabemodulen'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Ausgabemodule werden verwendet, um Nachrichten von PIT an Tabellen, Dateien, APEX oder beliebige weitere Ziele zu senden.<br>',
'Angezeigt werden alle Module, die derzeit in der Datenbank installiert sind. Sie können an der Spalte »verfügbar« sehen, ob es bei der Installation des Ausgabemoduls Probleme gab oder ob das Modul einsatzbereit ist.<br>',
'Spalte »aktiv« zeigt an, ob das Modul aktuell zur Ausgabe von Meldungen verwendet wird.',
''))
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16469354091451682)
,p_plug_name=>'Hinweise zu Kontexten'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Ein Kontext fasst das Debug- und Traceverhalten von PIT unter einem Namen zusammen.<br>',
'Während der Anwendung kann der Kontext global oder nur für einen Benutzer geändert werden. Dadurch wird feingranular gesteuert, welche Einstellungen aktuell gelten sollen.<br>',
'Der Standard-Kontext »DEFAULT« wird gewählt, wenn kein anderer Kontext ausgewählt wurde. Daher kann dieser Kontext nicht gelöscht werden.<br>Sie können beliebig viele Kontexte anlegen.'))
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16470289582451691)
,p_plug_name=>'Debugging nach Package filtern (Toggles)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(16470516546451693)
,p_name=>'Verfügbare Toggles'
,p_parent_plug_id=>wwv_flow_api.id(16470289582451691)
,p_template=>wwv_flow_api.id(14714008353194072)
,p_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, par_id, par_pgr_id, toggle_module_list, toggle_context_name',
'  from pit_ui_admin_pit_toggle'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(14722782695194076)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16470622774451694)
,p_query_column_id=>1
,p_column_alias=>'ROW_ID'
,p_column_display_sequence=>1
,p_column_link=>'f?p=&APP_ID.:EDIT_TOGGLE:&SESSION.::&DEBUG.:RP:P12_ROWID:#ROW_ID#'
,p_column_linktext=>'<i class="fa fa-pencil"/>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16470656738451695)
,p_query_column_id=>2
,p_column_alias=>'PAR_ID'
,p_column_display_sequence=>2
,p_column_heading=>'Toggle-Name'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16470785927451696)
,p_query_column_id=>3
,p_column_alias=>'PAR_PGR_ID'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16470896401451697)
,p_query_column_id=>4
,p_column_alias=>'TOGGLE_MODULE_LIST'
,p_column_display_sequence=>4
,p_column_heading=>'Liste der Packages'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16470996829451698)
,p_query_column_id=>5
,p_column_alias=>'TOGGLE_CONTEXT_NAME'
,p_column_display_sequence=>5
,p_column_heading=>'Kontext'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16470330924451692)
,p_plug_name=>'Informationen zum Filter des Debuggings'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source=>'Das Debugging kann global für alle Anwendungspackages eingestellt werden, indem Kontexte verwendet werden.<br>Zusätzlich ist es möglich, Das Logging für einzelne Packages ein- oder auszuschalten. Hierfür wird eine Liste von Packages verwaltet, denen '
||'jeweils ein benannter Kontext zugeordnet wird.<br>Wird eines dieser Packages ausgeführt, schaltet PIT den zugeordneten Kontext aktiv. Wird das Package verlassen, wird wieder der vorherige Kontext aktiv.'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16494354990751351)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14717261385194073)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(14741501339194109)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(14735520260194086)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(16505348445755417)
,p_name=>'Installierte Ausgabemodule'
,p_template=>wwv_flow_api.id(14714008353194072)
,p_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select module_name module_id,',
'       module_name,',
'       module_stack,',
'       module_available,',
'       module_active',
'  from pit_ui_admin_pit_module',
'  ',
''))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(14722782695194076)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'Keine Daten gefunden'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16468977883451678)
,p_query_column_id=>1
,p_column_alias=>'MODULE_ID'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_column_link=>'f?p=&APP_ID.:EDIT_MODULE:&SESSION.::&DEBUG.:RP:P11_PIT_MODULE:#MODULE_ID#'
,p_column_linktext=>'<i class="fa fa-pencil"/>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16468650134451675)
,p_query_column_id=>2
,p_column_alias=>'MODULE_NAME'
,p_column_display_sequence=>2
,p_column_heading=>'Ausgabemodul'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(13482214175910293)
,p_query_column_id=>3
,p_column_alias=>'MODULE_STACK'
,p_column_display_sequence=>3
,p_column_heading=>'Meldung'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16468815612451676)
,p_query_column_id=>4
,p_column_alias=>'MODULE_AVAILABLE'
,p_column_display_sequence=>4
,p_column_heading=>'verfügbar'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<i class="fa #MODULE_AVAILABLE#"/>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16468889693451677)
,p_query_column_id=>5
,p_column_alias=>'MODULE_ACTIVE'
,p_column_display_sequence=>5
,p_column_heading=>'aktiv'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<i class="fa #MODULE_ACTIVE#"/>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(16596593131109653)
,p_name=>'Verfügbare Kontexte'
,p_template=>wwv_flow_api.id(14714008353194072)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'N'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ROW_ID,',
'       CONTEXT_NAME,',
'       CONTEXT_DESCRIPTION,',
'       CONTEXT_SETTING',
'  from PIT_UI_ADMIN_PIT_CONTEXT'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(14722782695194076)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'Keine Daten gefunden'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16469839754451687)
,p_query_column_id=>1
,p_column_alias=>'ROW_ID'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_column_link=>'f?p=&APP_ID.:EDIT_CONTEXT:&SESSION.::&DEBUG.:RP:P10_ROWID:#ROW_ID#'
,p_column_linktext=>'<i class="fa fa-pencil"/>'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16597572754109658)
,p_query_column_id=>2
,p_column_alias=>'CONTEXT_NAME'
,p_column_display_sequence=>2
,p_column_heading=>'Kontext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16597936377109658)
,p_query_column_id=>3
,p_column_alias=>'CONTEXT_DESCRIPTION'
,p_column_display_sequence=>3
,p_column_heading=>'Beschreibung'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(16598363850109658)
,p_query_column_id=>4
,p_column_alias=>'CONTEXT_SETTING'
,p_column_display_sequence=>4
,p_column_heading=>'Einstellungen'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16471478140451703)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16596593131109653)
,p_button_name=>'CREATE_CONTEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_CONTEXT:&SESSION.::&DEBUG.:RP,10:P10_ROWID:'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16471556616451704)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16470289582451691)
,p_button_name=>'CREATE_TOGGLE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_TOGGLE:&SESSION.::&DEBUG.:RP,12:P12_ROWID:'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16471116719451699)
,p_name=>'P9_ALLOW_TOGGLE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16470289582451691)
,p_use_cache_before_default=>'NO'
,p_item_default=>'pit_ui_pkg.allows_toggles'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Toggles verwenden'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16530044691755434)
,p_name=>'Bericht bearbeiten - Dialog geschlossen'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(16505348445755417)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16530617953755436)
,p_event_id=>wwv_flow_api.id(16530044691755434)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16505348445755417)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16470111684451689)
,p_name=>'Kontext bearbeiten - Dialog geschlossen'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(16596593131109653)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16470172096451690)
,p_event_id=>wwv_flow_api.id(16470111684451689)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16596593131109653)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16471150068451700)
,p_name=>'Toggle Report Verfügbare Toggles'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P9_ALLOW_TOGGLE'
,p_condition_element=>'P9_ALLOW_TOGGLE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'Y'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16471226035451701)
,p_event_id=>wwv_flow_api.id(16471150068451700)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16470516546451693)
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16471364299451702)
,p_event_id=>wwv_flow_api.id(16471150068451700)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16470516546451693)
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16472344458451712)
,p_event_id=>wwv_flow_api.id(16471150068451700)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(16471556616451704)
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16472453740451713)
,p_event_id=>wwv_flow_api.id(16471150068451700)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(16471556616451704)
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16471768200451706)
,p_event_id=>wwv_flow_api.id(16471150068451700)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui_pkg.set_allow_toggles;'
,p_attribute_02=>'P9_ALLOW_TOGGLE'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16471832104451707)
,p_event_id=>wwv_flow_api.id(16471150068451700)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui_pkg.set_allow_toggles;'
,p_attribute_02=>'P9_ALLOW_TOGGLE'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16472182144451710)
,p_name=>'Toggle bearbeiten - Dialog geschlossen'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(16470289582451691)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16472284649451711)
,p_event_id=>wwv_flow_api.id(16472182144451710)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16470516546451693)
,p_stop_execution_on_error=>'Y'
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Kontext administrieren'
,p_alias=>'EDIT_CONTEXT'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(16496474367775761)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_protection_level=>'C'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200519160107'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16603205533289094)
,p_plug_name=>'Kontext administrieren'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14705880823194067)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16603875166289094)
,p_plug_name=>'Schaltflächen'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14710401710194070)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16603790896289094)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(16603875166289094)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Löschen'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'not pit_ui_pkg.is_default_context'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16603706039289094)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(16603875166289094)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16603614825289094)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(16603875166289094)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_grid=>false
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16604254081289095)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16603875166289094)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16469453336451683)
,p_name=>'P10_PSE_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_item_default=>'10'
,p_prompt=>'Debug-Level'
,p_source=>'PSE_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_severity',
' order by r desc'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16469539256451684)
,p_name=>'P10_PTL_ID'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Trace-Level'
,p_source=>'PTL_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_TRACE_LEVEL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_trace_level',
' order by r desc'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16469695849451685)
,p_name=>'P10_CTX_TIMING'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Zeitinformation erfassen'
,p_source=>'CTX_TIMING'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16469783032451686)
,p_name=>'P10_CTX_OUTPUT_MODULES'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Ausgabemodule'
,p_source=>'CTX_OUTPUT_MODULES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_OUTPUT_MODULES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_output_modules',
' order by d'))
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16606714049289098)
,p_name=>'P10_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Rowid'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16607119961289115)
,p_name=>'P10_PAR_ID'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Kontext'
,p_source=>'PAR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>120
,p_read_only_when=>'pit_ui_pkg.is_default_context'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(14734643971194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16607497962289117)
,p_name=>'P10_PAR_PGR_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16607923762289117)
,p_name=>'P10_PAR_DESCRIPTION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>800
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16608283384289117)
,p_name=>'P10_PAR_STRING_VALUE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(16603205533289094)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4553027645823210)
,p_validation_name=>'Validate EDIT_CONTEXT'
,p_validation_sequence=>10
,p_validation=>'return pit_ui_pkg.validate_edit_context;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_always_execute=>'N'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16604413360289095)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(16604254081289095)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16605180110289095)
,p_event_id=>wwv_flow_api.id(16604413360289095)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16610238182289122)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_CONTEXT'
,p_attribute_02=>'PIT_UI_EDIT_CONTEXT'
,p_attribute_03=>'P10_ROWID'
,p_attribute_04=>'ROW_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16469965658451688)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_CONTEXT'
,p_process_sql_clob=>'pit_ui_pkg.process_edit_context;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16611085737289122)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(16603790896289094)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16611465778289122)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_api.create_page(
 p_id=>11
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Ausgabemodul administrieren'
,p_alias=>'EDIT_MODULE'
,p_page_mode=>'MODAL'
,p_step_title=>'Ausgabemodul administrieren'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(16496474367775761)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1200'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200524130542'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4226071780687342)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14710401710194070)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4470785146382368)
,p_plug_name=>'Ausgabemodul administrieren'
,p_region_name=>'EDIT_MODULE'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14713504681194072)
,p_plug_display_sequence=>15
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_id,',
'       par_pgr_id,',
'       par_description,',
'       par_string_value,',
'       par_integer_value,',
'       par_float_value,',
'       par_date_value,',
'       par_timestamp_value,',
'       par_boolean_value,',
'       par_is_local,',
'       allowed_actions',
'  from pit_ui_edit_module'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4471737787382390)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4472281169382392)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4472830080382393)
,p_name=>'PAR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Par Id'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_item_width=>16
,p_enable_filter=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4473474096382395)
,p_name=>'PAR_PGR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_PGR_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Par Pgr Id'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_item_width=>16
,p_is_required=>true
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4474001088382395)
,p_name=>'PAR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Parameter'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4474640955382395)
,p_name=>'PAR_STRING_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_STRING_VALUE'
,p_data_type=>'CLOB'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Zeichenkette'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_width=>40
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4475228003382395)
,p_name=>'PAR_INTEGER_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_INTEGER_VALUE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Ganzzahl'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_05=>'BOTH'
,p_format_mask=>'fm9G999G999G999G990'
,p_item_width=>13
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4475820242382396)
,p_name=>'PAR_FLOAT_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_FLOAT_VALUE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Zahl'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
,p_attribute_05=>'BOTH'
,p_item_width=>4
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4476447473382396)
,p_name=>'PAR_DATE_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_DATE_VALUE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Datum'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_width=>12
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4477048433382396)
,p_name=>'PAR_TIMESTAMP_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_TIMESTAMP_VALUE'
,p_data_type=>'TIMESTAMP_TZ'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Zeitstempel'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_width=>12
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4477635253382396)
,p_name=>'PAR_BOOLEAN_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_BOOLEAN_VALUE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_CHECKBOX'
,p_heading=>'Flag'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_01=>'1'
,p_is_required=>false
,p_lov_type=>'STATIC'
,p_lov_source=>'STATIC:Ja;Y,Nein;N'
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>'-'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4552447559823204)
,p_name=>'ALLOWED_ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ALLOWED_ACTIONS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>130
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4552585053823205)
,p_name=>'PAR_IS_LOCAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_IS_LOCAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'überschrieben'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_attribute_01=>'<i class="fa &PAR_IS_LOCAL."/>'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(4471125896382387)
,p_internal_uid=>4471125896382387
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_edit_row_operations_column=>'ALLOWED_ACTIONS'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>300
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(4471428248382389)
,p_interactive_grid_id=>wwv_flow_api.id(4471125896382387)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(4471561822382389)
,p_report_id=>wwv_flow_api.id(4471428248382389)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4472604060382392)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(4472281169382392)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4473219924382395)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(4472830080382393)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4473824036382395)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(4473474096382395)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4474471366382395)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(4474001088382395)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>347
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4475024983382395)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(4474640955382395)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>273
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4475662822382395)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(4475228003382395)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4476213898382396)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(4475820242382396)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>53
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4476829122382396)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(4476447473382396)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4477423423382396)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(4477048433382396)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4478007865382396)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(4477635253382396)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>54
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4568183390042659)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(4552447559823204)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4571243985183854)
,p_view_id=>wwv_flow_api.id(4471561822382389)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(4552585053823205)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>115
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4226400359687346)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4226071780687342)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Schließen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4226187142687343)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4226071780687342)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16469103667451679)
,p_name=>'P11_PIT_MODULE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(4470785146382368)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16565357818823434)
,p_tabular_form_region_id=>wwv_flow_api.id(4470785146382368)
,p_validation_name=>'PAR_INTEGER_VALUE must be numeric'
,p_validation_sequence=>70
,p_validation=>'PAR_INTEGER_VALUE'
,p_validation_type=>'ITEM_IS_NUMERIC'
,p_error_message=>'#COLUMN_HEADER# muss numerisch sein.'
,p_always_execute=>'N'
,p_exec_cond_for_each_row=>'N'
,p_only_for_changed_rows=>'Y'
,p_associated_column=>'PAR_INTEGER_VALUE'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16565731417823434)
,p_tabular_form_region_id=>wwv_flow_api.id(4470785146382368)
,p_validation_name=>'PAR_FLOAT_VALUE must be numeric'
,p_validation_sequence=>80
,p_validation=>'PAR_FLOAT_VALUE'
,p_validation_type=>'ITEM_IS_NUMERIC'
,p_error_message=>'#COLUMN_HEADER# muss numerisch sein.'
,p_always_execute=>'N'
,p_exec_cond_for_each_row=>'N'
,p_only_for_changed_rows=>'Y'
,p_associated_column=>'PAR_FLOAT_VALUE'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16566167799823434)
,p_tabular_form_region_id=>wwv_flow_api.id(4470785146382368)
,p_validation_name=>'PAR_DATE_VALUE must be a valid date'
,p_validation_sequence=>90
,p_validation=>'PAR_DATE_VALUE'
,p_validation_type=>'ITEM_IS_DATE'
,p_error_message=>'#COLUMN_HEADER# muss ein gültiges Datum sein.'
,p_always_execute=>'N'
,p_exec_cond_for_each_row=>'N'
,p_only_for_changed_rows=>'Y'
,p_associated_column=>'PAR_DATE_VALUE'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16566612306823434)
,p_tabular_form_region_id=>wwv_flow_api.id(4470785146382368)
,p_validation_name=>'PAR_TIMESTAMP_VALUE must be a valid timestamp'
,p_validation_sequence=>100
,p_validation=>'PAR_TIMESTAMP_VALUE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#COLUMN_HEADER# muss ein gültiger Zeitstempelwert sein.'
,p_always_execute=>'N'
,p_exec_cond_for_each_row=>'N'
,p_only_for_changed_rows=>'Y'
,p_associated_column=>'PAR_TIMESTAMP_VALUE'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4225940835687341)
,p_tabular_form_region_id=>wwv_flow_api.id(4470785146382368)
,p_validation_name=>'Validate EDIT_MODULE'
,p_validation_sequence=>110
,p_validation=>'return pit_ui_pkg.validate_edit_module;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_always_execute=>'N'
,p_only_for_changed_rows=>'Y'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4226272274687344)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(4226187142687343)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4226344682687345)
,p_event_id=>wwv_flow_api.id(4226272274687344)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4478244932382398)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(4470785146382368)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_MODULE'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui_pkg.process_edit_module;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16567336631823436)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_api.create_page(
 p_id=>12
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Kontext-Toggle administrieren'
,p_alias=>'EDIT_TOGGLE'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext-Toggle administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(16496474367775761)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200518164055'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16629770645729629)
,p_plug_name=>'Kontext-Toggle administrieren'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14705880823194067)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16630523265729629)
,p_plug_name=>'Schaltflächen'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14710401710194070)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16472551203451714)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(16630523265729629)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Löschen'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4552794636823207)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(16630523265729629)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16630252021729629)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(16630523265729629)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16630223948729629)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16630523265729629)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16472037205451709)
,p_name=>'P12_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16629770645729629)
,p_use_cache_before_default=>'NO'
,p_source=>'ROW_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16632396334729631)
,p_name=>'P12_PAR_ID'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16629770645729629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'PAR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>120
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16632814618729633)
,p_name=>'P12_TOGGLE_MODULE_LIST'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(16629770645729629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Liste der Packages'
,p_source=>'TOGGLE_MODULE_LIST'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_AVAILABLE_PACKAGES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_available_packages',
' order by d'))
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16633141075729633)
,p_name=>'P12_TOGGLE_CONTEXT_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(16629770645729629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'zugeordneter Kontext'
,p_source=>'TOGGLE_CONTEXT_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CONTEXT'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_context',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Kontext wählen'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16633593778729633)
,p_name=>'P12_PAR_DESCRIPTION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(16629770645729629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4552632809823206)
,p_validation_name=>'Validate EDIT_TOGGLE'
,p_validation_sequence=>10
,p_validation=>'return pit_ui_pkg.validate_edit_toggle;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_always_execute=>'N'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16631207615729629)
,p_name=>'Dialog abbrechen'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(16630223948729629)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16631700010729629)
,p_event_id=>wwv_flow_api.id(16631207615729629)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16633942280729633)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_TOGGLE'
,p_process_sql_clob=>'pit_ui_pkg.process_edit_toggle;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16634520780729633)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16471955143451708)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_TOGGLE'
,p_attribute_02=>'PIT_UI_EDIT_TOGGLE'
,p_attribute_03=>'P12_ROWID'
,p_attribute_04=>'ROW_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P12_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
end;
/
prompt --application/pages/page_00016
begin
wwv_flow_api.create_page(
 p_id=>16
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Stammdaten exportieren und übersetzen'
,p_alias=>'EXPORT'
,p_page_mode=>'NORMAL'
,p_step_title=>'Stammdaten exportieren und übersetzen'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(16650837890041154)
,p_javascript_file_urls=>'#APP_IMAGES#condes.pit.utils.js'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'Für diese Seite ist keine Hilfe verfügbar.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200605175412'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4553703122823217)
,p_plug_name=>'linke Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14705880823194067)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4553976245823219)
,p_plug_name=>'Begriffe exportieren und übersetzen'
,p_parent_plug_id=>wwv_flow_api.id(4553703122823217)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pit_ui_pkg.has_translatable_items'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16677697311594876)
,p_plug_name=>'Meldungen exportieren und übersetzen'
,p_parent_plug_id=>wwv_flow_api.id(4553703122823217)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4553801552823218)
,p_plug_name=>'rechte Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14705880823194067)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16677758532594877)
,p_plug_name=>'Parameter exportieren'
,p_parent_plug_id=>wwv_flow_api.id(4553801552823218)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16656131009103829)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(14717261385194073)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(14741501339194109)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(14735520260194086)
,p_plug_query_row_template=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4556464430823244)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4553976245823219)
,p_button_name=>'IMPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Übersetzung laden'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4556565401823245)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16677697311594876)
,p_button_name=>'IMPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Übersetzung laden'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4553416931823214)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(16677697311594876)
,p_button_name=>'TRANSLATE_PMS'
,p_button_static_id=>'TRANSLATE_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Meldung übersetzen'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4554414668823224)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4553976245823219)
,p_button_name=>'TRANSLATE_PTI'
,p_button_static_id=>'TRANSLATE_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Begriffe übersetzen'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4554362724823223)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(4553976245823219)
,p_button_name=>'EXPORT_PTI'
,p_button_static_id=>'EXPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Begriffe exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16677380975594873)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(16677697311594876)
,p_button_name=>'EXPORT_PMS'
,p_button_static_id=>'EXPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Meldungen exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4553132765823211)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16677758532594877)
,p_button_name=>'EXPORT_LOCAL_PAR'
,p_button_static_id=>'EXPORT_LOCAL_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Lokale Parameter exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'pit_ui_pkg.has_local_parameters'
,p_button_condition_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16678403118594883)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(16677758532594877)
,p_button_name=>'EXPORT_PAR'
,p_button_static_id=>'EXPORT_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_image_alt=>'Parametergruppen exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4553356003823213)
,p_name=>'P16_PMS_PML_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(16677697311594876)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_language',
' order by pml_default_order nulls last, d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Zielsprache wählen'
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Wählen Sie die Zielsprache, in die Sie die Meldungen übersetzen möchten.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4553545442823215)
,p_name=>'P16_HINT_PMS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(16677697311594876)
,p_prompt=>'Hint pms'
,p_source=>'Falls Sie die Meldungen übersetzen möchten, wählen Sie eine Zielsprache.'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(14734328599194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4554068327823220)
,p_name=>'P16_PTI_PMG_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(4553976245823219)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PTI_PMG_IN_USE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_group',
' where has_translatable_item = 1',
' order by d'))
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4554155582823221)
,p_name=>'P16_HINT_PTI'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(4553976245823219)
,p_prompt=>'Hint pti'
,p_source=>'Falls Sie die Meldungen übersetzen möchten, wählen Sie eine Zielsprache.'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(14734328599194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4554279973823222)
,p_name=>'P16_PTI_PML_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(4553976245823219)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_language',
' order by pml_default_order nulls last, d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Zielsprache wählen'
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Wählen Sie die Zielsprache, in die Sie die Meldungen übersetzen möchten.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4556346520823243)
,p_name=>'P16_PTI_XLIFF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(4553976245823219)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4556617720823246)
,p_name=>'P16_PMS_XLIFF'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(16677697311594876)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16677248840594872)
,p_name=>'P16_PMS_PMG_LIST'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16677697311594876)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PMS_PMG_IN_USE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_message_group',
' where has_message = 1',
' order by d'))
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16678294057594882)
,p_name=>'P16_PAR_PGR_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16677758532594877)
,p_prompt=>'Parametergruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from pit_ui_lov_parameter_group',
' order by d'))
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>'Bewegen Sie alle Parametergruppen, die Sie exportieren möchten, in die rechte Spalte.'
,p_attribute_01=>'MOVE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4225840770687340)
,p_validation_name=>'Validate EXPORT'
,p_validation_sequence=>10
,p_validation=>'return pit_ui_pkg.validate_export;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_always_execute=>'N'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16678619538594885)
,p_name=>'ControlExportItems'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.control-export'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4553663364823216)
,p_event_id=>wwv_flow_api.id(16678619538594885)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'condes.pit.utils.controlExportItems();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4556712163823247)
,p_name=>'Toggle IMPORT_PMS'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P16_PMS_XLIFF'
,p_condition_element=>'P16_PMS_XLIFF'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4556839479823248)
,p_event_id=>wwv_flow_api.id(4556712163823247)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(4556565401823245)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4556908271823249)
,p_event_id=>wwv_flow_api.id(4556712163823247)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(4556565401823245)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4863021431815501)
,p_name=>'Toggle IMPORT_PTI'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P16_PTI_XLIFF'
,p_condition_element=>'P16_PTI_XLIFF'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4863171727815502)
,p_event_id=>wwv_flow_api.id(4863021431815501)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(4556464430823244)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4863295281815503)
,p_event_id=>wwv_flow_api.id(4863021431815501)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(4556464430823244)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16677504481594874)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EXPORT'
,p_process_sql_clob=>'pit_ui_pkg.process_export;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(14740188155194095)
,p_name=>'Login Page'
,p_alias=>'LOGIN_DESKTOP'
,p_page_mode=>'NORMAL'
,p_step_title=>'PIT-Administration - Log In'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(14702263222194064)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'Y'
,p_cache_mode=>'NOCACHE'
,p_last_upd_yyyymmddhh24miss=>'20161016091029'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14740631964194104)
,p_plug_name=>'Log In'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(14714008353194072)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14740997238194108)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(14740631964194104)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(14734925509194086)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Log In'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_alignment=>'LEFT'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14740776113194108)
,p_name=>'P101_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(14740631964194104)
,p_prompt=>'Username'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14740914410194108)
,p_name=>'P101_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(14740631964194104)
,p_prompt=>'Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(14734456304194084)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14741152460194109)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P101_USERNAME) );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14741036350194108)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P101_USERNAME,',
'    p_password => :P101_PASSWORD );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14741369474194109)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14741291976194109)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>':P101_USERNAME := apex_authentication.get_login_username_cookie;'
);
end;
/
prompt --application/deployment/definition
begin
wwv_flow_api.create_install(
 p_id=>wwv_flow_api.id(16496180025765639)
);
end;
/
prompt --application/deployment/install
begin
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
