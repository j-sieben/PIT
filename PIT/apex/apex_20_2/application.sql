prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>14500363782405926
,p_default_application_id=>110
,p_default_id_offset=>33807904481411172
,p_default_owner=>'APEX_APP'
);
end;
/
 
prompt APPLICATION 110 - PIT-Administration
--
-- Application Export:
--   Application:     110
--   Name:            PIT-Administration
--   Date and Time:   14:24 Monday January 4, 2021
--   Exported By:     APP_ADMIN
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     15
--       Items:                   57
--       Validations:             11
--       Processes:               32
--       Regions:                 43
--       Buttons:                 47
--       Dynamic Actions:         32
--     Shared Components:
--       Logic:
--       Navigation:
--         Lists:                  3
--         Breadcrumbs:            1
--           Entries:              5
--       Security:
--         Authentication:         1
--       User Interface:
--         Themes:                 1
--         Templates:
--           Page:                 9
--           Region:              17
--           Label:                7
--           List:                13
--           Popup LOV:            1
--           Calendar:             1
--           Breadcrumb:           1
--           Button:               3
--           Report:              11
--         LOVs:                  14
--         Shortcuts:              1
--         Plug-ins:               1
--       Globalization:
--         Messages:              16
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         20.2.0.00.20
--   Instance ID:     300130950197729
--

prompt --application/delete_application
begin
wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'APEX_APP')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'PIT-Administration')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'PIT')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'1B01909BF2F79725B04F511808F58A7A4D635D5483B1EF191A92C34EF2D1E267'
,p_bookmark_checksum_function=>'SH512'
,p_accept_old_checksums=>false
,p_compatibility_mode=>'19.2'
,p_flow_language=>'de'
,p_flow_language_derived_from=>'BROWSER'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(65112859203242476)
,p_populate_roles=>'A'
,p_application_tab_set=>0
,p_logo_type=>'T'
,p_logo_text=>'PIT-Administration'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_friendly_url=>'N'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142332'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>6
,p_ui_type_name => null
,p_print_server_type=>'INSTANCE'
);
end;
/
prompt --application/shared_components/navigation/lists/mainpagelist
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(57539458978534929)
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
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_menu
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(65070271744242432)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(65114060705242487)
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
 p_id=>wwv_flow_api.id(66866425467799726)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'PIT administrieren'
,p_list_item_link_target=>'F?p=&APP_ALIAS.:ADMIN_PIT:&SESSION.'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_api.id(65114060705242487)
,p_list_text_01=>'Einsatzeinstellungen'
,p_list_text_02=>'Kontrolliert Kontexte, Toggles und zeigt die aktuelle Parametrierung'
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''PIT'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(65130838539455550)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Meldungen administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_list_item_icon=>'fa-comment-o'
,p_parent_list_item_id=>wwv_flow_api.id(65114060705242487)
,p_list_text_01=>'Meldungen erzeugen und editieren'
,p_list_text_02=>unistr('Verwaltung neuer Meldungen und \00C4nderung bestehender')
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''MESSAGE'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(65913741045348034)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Parameter administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PARAM:&SESSION.'
,p_list_item_icon=>'fa-cog'
,p_parent_list_item_id=>wwv_flow_api.id(65114060705242487)
,p_list_text_01=>'Parameter erstellen und editieren'
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''PARAMETER'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(67021056300071639)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Stammdaten'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:EXPORT:&SESSION.'
,p_list_item_icon=>'fa-exchange'
,p_parent_list_item_id=>wwv_flow_api.id(65114060705242487)
,p_list_text_01=>unistr('\00DCbersetzung und Export')
,p_list_text_02=>unistr('Erlaubt die Erstellung von Skriptdateien zum Export oder zum \00DCbersetzen')
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''EXPORT'''))
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_bar
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(65112642834242473)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(65112847790242475)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Log Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_current_for_pages=>'&LOGOUT_URL.'
);
end;
/
prompt --application/shared_components/files/condes_pit_utils_js
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
 p_id=>wwv_flow_api.id(55053093453008209)
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
 p_id=>wwv_flow_api.id(33808036990411249)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(33808566228411250)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attribute_01=>'fa-star'
,p_attribute_04=>'#VALUE#'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(50372885796048450)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_RICH_TEXT_EDITOR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(57533722363517549)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'LEGACY'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(57533765342517549)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'classic'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(65070003066242432)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(65070149230242432)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH_CB'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(65070186184242432)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_settings
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
prompt --application/shared_components/user_interface/lovs/lov_available_packages
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(67013149838903203)
,p_lov_name=>'LOV_AVAILABLE_PACKAGES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_AVAILABLE_PACKAGES'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_available_translations
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(34863035271895072)
,p_lov_name=>'LOV_AVAILABLE_TRANSLATIONS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'PIT_UI_LOV_AVAILABLE_LANGUAGES'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_context
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(67014088613936015)
,p_lov_name=>'LOV_CONTEXT'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_CONTEXT'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_output_modules
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(66988285323469929)
,p_lov_name=>'LOV_OUTPUT_MODULES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_OUTPUT_MODULES'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_parameter_group
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(65939127191434298)
,p_lov_name=>'LOV_PARAMETER_GROUP'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_PARAMETER_GROUP'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_parameter_realm
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(42662492276639237)
,p_lov_name=>'LOV_PARAMETER_REALM'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_PARAMETER_REALM'
,p_query_where=>'pre_is_active = (select utl_apex.get_true from dual)'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_parameter_type
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(65939288682436884)
,p_lov_name=>'LOV_PARAMETER_TYPE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_PARAMETER_TYPE'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_par_is_modifiable
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(45470512488547693)
,p_lov_name=>'LOV_PAR_IS_MODIFIABLE'
,p_lov_query=>'.'||wwv_flow_api.id(45470512488547693)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(45470785286547696)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Editieren sperren'
,p_lov_return_value=>'Nein'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pit_message_group
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(57575511122720847)
,p_lov_name=>'LOV_PIT_MESSAGE_GROUP'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_MESSAGE_GROUP'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pit_message_language
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(65169894253202420)
,p_lov_name=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_MESSAGE_LANGUAGE'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pit_message_severity
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(65163587753974909)
,p_lov_name=>'LOV_PIT_MESSAGE_SEVERITY'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_MESSAGE_SEVERITY'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'R'
,p_default_sort_direction=>'DESC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pit_trace_level
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(65163846860978042)
,p_lov_name=>'LOV_PIT_TRACE_LEVEL'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_TRACE_LEVEL'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'R'
,p_default_sort_direction=>'DESC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pml_name_in_use
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(57577424529756593)
,p_lov_name=>'LOV_PML_NAME_IN_USE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_MESSAGE_LANGUAGE'
,p_query_where=>'pml_in_use = (select utl_apex.get_true from dual)'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'PML_DEFAULT_ORDER'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pms_pmg_in_use
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(55070208816917446)
,p_lov_name=>'LOV_PMS_PMG_IN_USE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_MESSAGE_GROUP'
,p_query_where=>'has_message = 1'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(67023363277089532)
,p_group_name=>'EXPORT'
,p_group_desc=>'Export von Stammdaten'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(65908547757959061)
,p_group_name=>'MAIN'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(65908586992959781)
,p_group_name=>'MESSAGE'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(65908675410961086)
,p_group_name=>'PARAMETER'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(66868999754824139)
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
 p_id=>wwv_flow_api.id(65114026726242487)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(65114383914242489)
,p_parent_id=>0
,p_short_name=>'Startseite'
,p_link=>'f?p=&APP_ALIAS.:MAIN:&SESSION.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(65137686798455579)
,p_parent_id=>wwv_flow_api.id(65114383914242489)
,p_short_name=>'Meldungen administrieren'
,p_link=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(66697656323093951)
,p_parent_id=>wwv_flow_api.id(65114383914242489)
,p_short_name=>'Parameter verwalten'
,p_link=>'f?p=&APP_ID.:6:&SESSION.'
,p_page_id=>6
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(66867257108799731)
,p_parent_id=>wwv_flow_api.id(65114383914242489)
,p_short_name=>'PIT administrieren'
,p_link=>'f?p=&APP_ID.:9:&SESSION.'
,p_page_id=>9
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(67029115680152207)
,p_parent_id=>wwv_flow_api.id(65114383914242489)
,p_short_name=>unistr('Stammdaten exportieren und \00FCbersetzen')
,p_link=>'f?p=&APP_ALIAS.:EXPORT:&SESSION.'
,p_page_id=>16
);
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
null;
end;
/
prompt --application/shared_components/user_interface/templates/page/left_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65070361246242437)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_internal_name=>'LEFT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34047381584427444)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34047879447427444)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34048358750427444)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34048881049427445)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34049412617427445)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34049842038427445)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34050427798427445)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34050870653427445)
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_and_right_side_columns
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65071260263242440)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_internal_name=>'LEFT_AND_RIGHT_SIDE_COLUMNS'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
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
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34055542784427450)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34056033083427450)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34056576324427450)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34057060473427450)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34057591514427450)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34058093801427450)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34058541101427452)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34059087906427452)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34059551846427452)
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
end;
/
prompt --application/shared_components/user_interface/templates/page/minimal_no_navigation
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65072303425242440)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_internal_name=>'MINIMAL_NO_NAVIGATION'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34079957525427460)
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34080437154427460)
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34080999762427460)
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34081445326427460)
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34082005570427460)
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34082460229427460)
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34082948200427460)
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/page/right_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65073061098242440)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_internal_name=>'RIGHT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8"> ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" aria-label="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button'
||'>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34090896561427463)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34091357425427463)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34091846840427463)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34092378113427464)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34092868368427464)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34093409758427464)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34093833237427464)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34094409874427464)
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/standard
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65074039354242442)
,p_theme_id=>42
,p_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34098268863427466)
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34098742312427466)
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34099239434427466)
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34099822391427466)
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34100309282427466)
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34100757403427466)
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34101288262427466)
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/page/login
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65074788609242442)
,p_theme_id=>42
,p_name=>'Login'
,p_internal_name=>'LOGIN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody--login no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-container">',
'  <header class="t-Login-containerHeader">#REGION_POSITION_01#</header>',
'  <main class="t-Login-containerBody" id="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</main>',
'  <footer class="t-Login-containerFooter">#REGION_POSITION_02#</footer>',
'</div>',
''))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#',
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34061433814427452)
,p_page_template_id=>wwv_flow_api.id(65074788609242442)
,p_name=>'Body Footer'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34062007357427452)
,p_page_template_id=>wwv_flow_api.id(65074788609242442)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34062514839427452)
,p_page_template_id=>wwv_flow_api.id(65074788609242442)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/master_detail
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65075091166242442)
,p_theme_id=>42
,p_name=>'Marquee'
,p_internal_name=>'MASTER_DETAIL'
,p_is_popup=>false
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'))
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-info" id="t_Body_info">#REGION_POSITION_02#</div>',
'        <div class="t-Body-contentInner" role="main">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34072053714427456)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34072558269427456)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34073082559427456)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34073619461427456)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34074122317427458)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34074567279427458)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34075046183427458)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34075567948427458)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34076044934427458)
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65076147654242442)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_internal_name=>'MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--standard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--standard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34085306287427461)
,p_page_template_id=>wwv_flow_api.id(65076147654242442)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34085752841427461)
,p_page_template_id=>wwv_flow_api.id(65076147654242442)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34086276897427461)
,p_page_template_id=>wwv_flow_api.id(65076147654242442)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/wizard_modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(65076480572242442)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_internal_name=>'WIZARD_MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--wizard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
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
'        <div class="t-Alert-body">#MESSAGE#</div>',
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
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--wizard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34103585032427467)
,p_page_template_id=>wwv_flow_api.id(65076480572242442)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34104100077427467)
,p_page_template_id=>wwv_flow_api.id(65076480572242442)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(34104534050427467)
,p_page_template_id=>wwv_flow_api.id(65076480572242442)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/button/icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(65107359608242462)
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
end;
/
prompt --application/shared_components/user_interface/templates/button/text
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(65107450896242464)
,p_template_name=>'Text'
,p_internal_name=>'TEXT'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text_with_icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(65107577752242464)
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
prompt --application/shared_components/user_interface/templates/region/cards_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(34210513879427517)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-CardsRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  #BODY##SUB_REGIONS#',
'</div>'))
,p_page_plug_template_name=>'Cards Container'
,p_internal_name=>'CARDS_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>21
,p_default_template_options=>'u-colors'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2071277712695139743
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/content_block
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(50725566224084872)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ContentBlock #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ContentBlock-header">',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--title">',
'      <span class="t-ContentBlock-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'      <h1 class="t-ContentBlock-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'      #EDIT#',
'    </div>',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--buttons">#CHANGE#</div>',
'  </div>',
'  <div class="t-ContentBlock-body">#BODY#</div>',
'  <div class="t-ContentBlock-buttons">#PREVIOUS##NEXT#</div>',
'</div>',
''))
,p_page_plug_template_name=>'Content Block'
,p_internal_name=>'CONTENT_BLOCK'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-ContentBlock--h1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2320668864738842174
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes_no_grid
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(50728732591084878)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes (No Grid)'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES_NO_GRID'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3369790999010910123
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34115227695427475)
,p_plug_template_id=>wwv_flow_api.id(50728732591084878)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34115670748427475)
,p_plug_template_id=>wwv_flow_api.id(50728732591084878)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_popup
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(50730194765084878)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionPopup" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Popup'
,p_internal_name=>'INLINE_POPUP'
,p_theme_id=>42
,p_theme_class_id=>24
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>1483922538999385230
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34164194376427497)
,p_plug_template_id=>wwv_flow_api.id(50730194765084878)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/alert
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65076900167242443)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">#BODY#</div>',
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
 p_id=>wwv_flow_api.id(34106425582427472)
,p_plug_template_id=>wwv_flow_api.id(65076900167242443)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65078406210242445)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/carousel_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65078491984242445)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
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
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#plugins/com.oracle.apex.carousel/1.1/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#'))
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
 p_id=>wwv_flow_api.id(34122128831427478)
,p_plug_template_id=>wwv_flow_api.id(65078491984242445)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34122568317427478)
,p_plug_template_id=>wwv_flow_api.id(65078491984242445)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_dialog
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65082029838242448)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
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
 p_id=>wwv_flow_api.id(34159708066427494)
,p_plug_template_id=>wwv_flow_api.id(65082029838242448)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/buttons_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65082927097242448)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##CLOSE##DELETE#</div></div>',
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
 p_id=>wwv_flow_api.id(34117299399427475)
,p_plug_template_id=>wwv_flow_api.id(65082927097242448)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34117788331427477)
,p_plug_template_id=>wwv_flow_api.id(65082927097242448)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/collapsible
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65083709646242448)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls"><button class="t-Button t-Button--icon t-Button--hideShow" type="button"></button></div>',
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
 p_id=>wwv_flow_api.id(34138267189427485)
,p_plug_template_id=>wwv_flow_api.id(65083709646242448)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34138735898427485)
,p_plug_template_id=>wwv_flow_api.id(65083709646242448)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/hero
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65085829668242450)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-wrap">',
'    <div class="t-HeroRegion-col t-HeroRegion-col--left"><span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'      <h1 class="t-HeroRegion-title">#TITLE#</h1>',
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
 p_id=>wwv_flow_api.id(34155158568427492)
,p_plug_template_id=>wwv_flow_api.id(65085829668242450)
,p_name=>'Region Body'
,p_placeholder=>'#BODY#'
,p_has_grid_support=>false
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/region/interactive_report
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65086030068242450)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#">',
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
end;
/
prompt --application/shared_components/user_interface/templates/region/login
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65086330943242450)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Login-header">',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#"></span>',
'    <h1 class="t-Login-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'  </div>',
'  <div class="t-Login-body">#BODY#</div>',
'  <div class="t-Login-buttons">#NEXT#</div>',
'  <div class="t-Login-links">#EDIT##CREATE#</div>',
'  <div class="t-Login-subRegions">#SUB_REGIONS#</div>',
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
 p_id=>wwv_flow_api.id(34176802997427502)
,p_plug_template_id=>wwv_flow_api.id(65086330943242450)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/standard
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65086533740242450)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
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
 p_id=>wwv_flow_api.id(34182290458427503)
,p_plug_template_id=>wwv_flow_api.id(65086533740242450)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34182814168427503)
,p_plug_template_id=>wwv_flow_api.id(65086533740242450)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/tabs_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65088608005242450)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES# apex-tabs-region" #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
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
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34201446744427513)
,p_plug_template_id=>wwv_flow_api.id(65088608005242450)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(34202015077427513)
,p_plug_template_id=>wwv_flow_api.id(65088608005242450)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/title_bar
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65089786772242451)
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
end;
/
prompt --application/shared_components/user_interface/templates/region/wizard_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(65090258949242451)
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
 p_id=>wwv_flow_api.id(34208565658427516)
,p_plug_template_id=>wwv_flow_api.id(65090258949242451)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_mega_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(34267780320427549)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_name=>'Top Navigation Mega Menu'
,p_internal_name=>'TOP_NAVIGATION_MEGA_MENU'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-MegaMenu #COMPONENT_CSS_CLASSES#" id="t_MenuNav" style="display:none;">',
'  <div class="a-Menu-content t-MegaMenu-container">',
'    <div class="t-MegaMenu-body">',
'    <ul class="t-MegaMenu-list t-MegaMenu-list--top">'))
,p_list_template_after_rows=>' </ul></div></div></div>'
,p_before_sub_list=>'<ul class="t-MegaMenu-list t-MegaMenu-list--sub">'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_list_item_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_sub_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Description'
,p_a04_label=>'List Item Class'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_a07_label=>'Badge Class'
,p_a08_label=>'Menu Item Class'
,p_reference_id=>1665447133514362075
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(50793225742084911)
,p_list_template_current=>'<li class="t-NavTabs-item #A03# is-active" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class'
||'="t-NavTabs-badge #A05#">#A02#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-NavTabs-item #A03#" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class="t-NavTab'
||'s-badge #A05#">#A02#</span></a></li>'
,p_list_template_name=>'Top Navigation Tabs'
,p_internal_name=>'TOP_NAVIGATION_TABS'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-NavTabs--inlineLabels-lg:t-NavTabs--displayLabels-sm'
,p_list_template_before_rows=>'<ul class="t-NavTabs #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_navtabs">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a02_label=>'Badge Value'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_a05_label=>'Badge Class'
,p_reference_id=>1453011561172885578
);
end;
/
prompt --application/shared_components/user_interface/templates/list/badge_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65098694266242456)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_theme_id=>42
,p_theme_class_id=>3
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--cols t-BadgeList--3cols:t-BadgeList--circular'
,p_list_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'Link Classes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
end;
/
prompt --application/shared_components/user_interface/templates/list/cards
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65100403275242457)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item is-active #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Attributes'
,p_a06_label=>'Card Color Class'
,p_a07_label=>'Subtitle'
,p_reference_id=>2885322685880632508
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65102474702242459)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_internal_name=>'MENU_BAR'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>2008709236185638887
);
end;
/
prompt --application/shared_components/user_interface/templates/list/navigation_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65103027051242459)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" title="#A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" title="#A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
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
,p_sub_list_item_current=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#" title="#A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#" title="#A04#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_templ_noncurr_w_child=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_a04_label=>'Title Attribute'
,p_reference_id=>2846096252961119197
);
end;
/
prompt --application/shared_components/user_interface/templates/list/tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65103064537242459)
,p_list_template_current=>'<li class="t-Tabs-item is-active #A03#" id="#A01#"><a href="#LINK#" class="t-Tabs-link #A04#"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-Tabs-item #A03#" id="#A01#"><a href="#LINK#" class="t-Tabs-link #A04#"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_name=>'Tabs'
,p_internal_name=>'TABS'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Tabs--simple'
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_reference_id=>3288206686691809997
);
end;
/
prompt --application/shared_components/user_interface/templates/list/wizard_progress
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65104007967242461)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step is-active" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap" data-link="#LINK#"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></'
||'div></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap" data-link="#LINK#"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></div></li>',
''))
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
end;
/
prompt --application/shared_components/user_interface/templates/list/links_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65104544948242461)
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
,p_sub_list_item_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_item_templ_curr_w_child=>'<li class="t-LinksList-item is-current is-expanded #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t'
||'-LinksList-badge">#A01#</span></a>#SUB_LISTS#</li>'
,p_item_templ_noncurr_w_child=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_popup
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65105263166242461)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_internal_name=>'MENU_POPUP'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({ iconType: ''fa'', callout: e.hasClass("js-menu-callout")});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>3492264004432431646
);
end;
/
prompt --application/shared_components/user_interface/templates/list/media_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65105356130242461)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
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
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
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
,p_default_template_options=>'t-MediaList--showIcons:t-MediaList--showDesc'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Class'
,p_a06_label=>'Icon Color Class'
,p_reference_id=>2066548068783481421
);
end;
/
prompt --application/shared_components/user_interface/templates/list/side_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65106324974242461)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Side Navigation Menu'
,p_internal_name=>'SIDE_NAVIGATION_MENU'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>'apex.jQuery(''body'').addClass(''t-PageBody--leftNav'');'
,p_theme_id=>42
,p_theme_class_id=>19
,p_default_template_options=>'js-defaultCollapsed'
,p_preset_template_options=>'js-navCollapsed--hidden:t-TreeNav--styleA'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav" id="t_Body_nav" role="navigation" aria-label="&APP_TITLE!ATTR.">',
'<div class="t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&APP_TITLE!ATTR."><ul style="display:none">'))
,p_list_template_after_rows=>'</ul></div></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_reference_id=>2466292414354694776
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(65106388349242461)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_internal_name=>'TOP_NAVIGATION_MENU'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("#t_MenuNav", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});',
''))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="t_MenuNav"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_reference_id=>2525307901300239072
);
end;
/
prompt --application/shared_components/user_interface/templates/report/content_row
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(34320952159427575)
,p_row_template_name=>'Content Row'
,p_internal_name=>'CONTENT_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-ContentRow-item #ITEM_CLASSES#">',
'  <div class="t-ContentRow-wrap">',
'    <div class="t-ContentRow-selection">#SELECTION#</div>',
'    <div class="t-ContentRow-iconWrap">',
'      <span class="t-ContentRow-icon #ICON_CLASS#">#ICON_HTML#</span>',
'    </div>',
'    <div class="t-ContentRow-body">',
'      <div class="t-ContentRow-content">',
'        <h3 class="t-ContentRow-title">#TITLE#</h3>',
'        <div class="t-ContentRow-description">#DESCRIPTION#</div>',
'      </div>',
'      <div class="t-ContentRow-misc">#MISC#</div>',
'      <div class="t-ContentRow-actions">#ACTIONS#</div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-ContentRow #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
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
,p_theme_class_id=>4
,p_reference_id=>1797843454948280151
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/media_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(50845329833084935)
,p_row_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'            <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_row_template_condition1=>':LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'    <div class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'            <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
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
,p_theme_class_id=>1
,p_default_template_options=>'t-MediaList--showDesc:t-MediaList--showIcons'
,p_preset_template_options=>'t-MediaList--stack'
,p_reference_id=>2092157460408299055
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/alerts
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65090872888242451)
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
,p_row_template_before_rows=>'<div class="t-Alerts #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_alerts" data-region-id="#REGION_STATIC_ID#">'
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
end;
/
prompt --application/shared_components/user_interface/templates/report/badge_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65091029366242453)
,p_row_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
' <span class="t-BadgeList-wrap u-color">',
'  <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'  <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
' </span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#" data-region-id="#REGION_STATIC_ID#">'
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
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed:t-BadgeList--circular'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/cards
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65092691152242453)
,p_row_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':CARD_LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <div class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards" data-region-id="#REGION_STATIC_ID#">'
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
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/comments
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65094833981242454)
,p_row_template_name=>'Comments'
,p_internal_name=>'COMMENTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'    <div class="t-Comments-icon">',
'        <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'    </div>',
'    <div class="t-Comments-body">',
'        <div class="t-Comments-info">',
'            #USER_NAME# <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'        </div>',
'        <div class="t-Comments-comment">',
'            #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
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
end;
/
prompt --application/shared_components/user_interface/templates/report/search_results
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65095248120242454)
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
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">',
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
end;
/
prompt --application/shared_components/user_interface/templates/report/standard
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65095308082242454)
,p_row_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" id="report_table_#REGION_STATIC_ID#" aria-label="#REGION_TITLE#">'))
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
 p_id=>wwv_flow_api.id(65095308082242454)
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
);
exception when others then null;
end;
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_column
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65096578846242454)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_COLUMN'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">'
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
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_row
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65097570039242456)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" data-region-id="#REGION_STATIC_ID#">'
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
end;
/
prompt --application/shared_components/user_interface/templates/report/timeline
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(65098526558242456)
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
'<ul class="t-Timeline #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_timeline" data-region-id="#REGION_STATIC_ID#">',
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
prompt --application/shared_components/user_interface/templates/label/optional_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(50851842736084941)
,p_template_name=>'Optional - Floating'
,p_internal_name=>'OPTIONAL_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>1607675164727151865
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(50852159565084941)
,p_template_name=>'Required - Floating'
,p_internal_name=>'REQUIRED_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1607675344320152883
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/hidden
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(65106853986242462)
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
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(65106981691242462)
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
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(65107126021242462)
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
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(65107169358242462)
,p_template_name=>'Required'
,p_internal_name=>'REQUIRED'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer is-required rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(65107344521242462)
,p_template_name=>'Required - Above'
,p_internal_name=>'REQUIRED_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb/breadcrumb
begin
wwv_flow_api.create_menu_template(
 p_id=>wwv_flow_api.id(65108045647242464)
,p_name=>'Breadcrumb'
,p_internal_name=>'BREADCRUMB'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active"><h1 class="t-Breadcrumb-label">#NAME#</h1></li>'
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
 p_id=>wwv_flow_api.id(65108211589242465)
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
,p_filter_text_attr=>'class="apex-item-text"'
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
prompt --application/shared_components/user_interface/templates/calendar/calendar
begin
wwv_flow_api.create_calendar_template(
 p_id=>wwv_flow_api.id(65108118086242464)
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
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
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
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
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
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
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
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_cust_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_cust_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">'
,p_cust_weekend_close_format=>'</td>'
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_cust_wk_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_weekend_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_wk_weekend_close_format=>'</td>'
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
 p_id=>wwv_flow_api.id(65108616204242468)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(65074039354242442)
,p_default_dialog_template=>wwv_flow_api.id(65076147654242442)
,p_error_template=>wwv_flow_api.id(65074788609242442)
,p_printer_friendly_template=>wwv_flow_api.id(65074039354242442)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(65074788609242442)
,p_default_button_template=>wwv_flow_api.id(65107450896242464)
,p_default_region_template=>wwv_flow_api.id(65086533740242450)
,p_default_chart_template=>wwv_flow_api.id(65086533740242450)
,p_default_form_template=>wwv_flow_api.id(65086533740242450)
,p_default_reportr_template=>wwv_flow_api.id(65086533740242450)
,p_default_tabform_template=>wwv_flow_api.id(65086533740242450)
,p_default_wizard_template=>wwv_flow_api.id(65086533740242450)
,p_default_menur_template=>wwv_flow_api.id(65089786772242451)
,p_default_listr_template=>wwv_flow_api.id(65086533740242450)
,p_default_irr_template=>wwv_flow_api.id(65086030068242450)
,p_default_report_template=>wwv_flow_api.id(65095308082242454)
,p_default_label_template=>wwv_flow_api.id(65106981691242462)
,p_default_menu_template=>wwv_flow_api.id(65108045647242464)
,p_default_calendar_template=>wwv_flow_api.id(65108118086242464)
,p_default_list_template=>wwv_flow_api.id(65104544948242461)
,p_default_nav_list_template=>wwv_flow_api.id(65106388349242461)
,p_default_top_nav_list_temp=>wwv_flow_api.id(65106388349242461)
,p_default_side_nav_list_temp=>wwv_flow_api.id(65106324974242461)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(65082927097242448)
,p_default_dialogr_template=>wwv_flow_api.id(65078406210242445)
,p_default_option_label=>wwv_flow_api.id(65106981691242462)
,p_default_required_label=>wwv_flow_api.id(65107169358242462)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(65103027051242459)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.6/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(33816312236427355)
,p_theme_id=>42
,p_name=>'Redwood Light'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/oracle-fonts/oraclesans-apex#MIN#.css?v=#APEX_VERSION#',
'#THEME_IMAGES#css/Redwood-Light#MIN#.css?v=#APEX_VERSION#'))
,p_is_current=>true
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_read_only=>true
,p_reference_id=>2596426436825065489
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(33816687470427356)
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
 p_id=>wwv_flow_api.id(33817126612427356)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(33817528431427356)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(33817834287427356)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(33818315727427356)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
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
 p_id=>wwv_flow_api.id(33938568101427402)
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
 p_id=>wwv_flow_api.id(33938932879427403)
,p_theme_id=>42
,p_name=>'ICON_HOVER_ANIMATION'
,p_display_name=>'Icon Hover Animation'
,p_display_sequence=>55
,p_template_types=>'BUTTON'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33939422461427403)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33939807160427403)
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
 p_id=>wwv_flow_api.id(33940188264427403)
,p_theme_id=>42
,p_name=>'SPACING_BOTTOM'
,p_display_name=>'Spacing Bottom'
,p_display_sequence=>100
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the bottom of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33940567544427403)
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
 p_id=>wwv_flow_api.id(33940967602427403)
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
 p_id=>wwv_flow_api.id(33941388512427403)
,p_theme_id=>42
,p_name=>'SPACING_TOP'
,p_display_name=>'Spacing Top'
,p_display_sequence=>90
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the top of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33941734697427403)
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
 p_id=>wwv_flow_api.id(33942163525427403)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33942581055427403)
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
 p_id=>wwv_flow_api.id(33942942727427403)
,p_theme_id=>42
,p_name=>'BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the bottom margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33943389445427403)
,p_theme_id=>42
,p_name=>'ITEM_POST_TEXT'
,p_display_name=>'Item Post Text'
,p_display_sequence=>30
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Post Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33943814110427403)
,p_theme_id=>42
,p_name=>'ITEM_PRE_TEXT'
,p_display_name=>'Item Pre Text'
,p_display_sequence=>20
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Pre Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33944172043427403)
,p_theme_id=>42
,p_name=>'LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the left margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33944531096427405)
,p_theme_id=>42
,p_name=>'PRESERVE_LABEL_SPACING'
,p_display_name=>'Preserve Label Spacing'
,p_display_sequence=>1
,p_template_types=>'FIELD'
,p_help_text=>'Preserves the label space and enables use of the Label Column Span property.'
,p_null_text=>'Yes'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33944944922427405)
,p_theme_id=>42
,p_name=>'RADIO_GROUP_DISPLAY'
,p_display_name=>'Item Group Display'
,p_display_sequence=>300
,p_template_types=>'FIELD'
,p_help_text=>'Determines the display style for radio and check box items.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33945395417427405)
,p_theme_id=>42
,p_name=>'RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'FIELD'
,p_help_text=>'Set the right margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33945798830427405)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33946142331427405)
,p_theme_id=>42
,p_name=>'TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'FIELD'
,p_help_text=>'Set the top margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33946534995427405)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>80
,p_template_types=>'LIST'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33947004243427405)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33947420007427405)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33947784082427405)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE'
,p_display_name=>'Collapse Mode'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33948154651427405)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33948571076427405)
,p_theme_id=>42
,p_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_sequence=>90
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a desktop-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33949003408427405)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33949338770427405)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33949792335427406)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'LIST'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33950188904427406)
,p_theme_id=>42
,p_name=>'ICON_STYLE'
,p_display_name=>'Icon Style'
,p_display_sequence=>35
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33950547947427406)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33951029475427406)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33951383835427406)
,p_theme_id=>42
,p_name=>'MOBILE'
,p_display_name=>'Mobile'
,p_display_sequence=>100
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a mobile-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33951741710427406)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33952218309427406)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33952623463427406)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND'
,p_display_name=>'Page Background'
,p_display_sequence=>20
,p_template_types=>'PAGE'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33952965086427406)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT'
,p_display_name=>'Page Layout'
,p_display_sequence=>10
,p_template_types=>'PAGE'
,p_null_text=>'Floating (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33953343624427406)
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
 p_id=>wwv_flow_api.id(33953813371427406)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33954183278427406)
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
 p_id=>wwv_flow_api.id(33954546984427406)
,p_theme_id=>42
,p_name=>'ALERT_TITLE'
,p_display_name=>'Alert Title'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the title of the alert is displayed.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33954943092427406)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33955396469427408)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33955796526427408)
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
 p_id=>wwv_flow_api.id(33956148693427408)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33956586330427408)
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
 p_id=>wwv_flow_api.id(33956991575427408)
,p_theme_id=>42
,p_name=>'BODY_STYLE'
,p_display_name=>'Body Style'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the region''s body container.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33957414809427408)
,p_theme_id=>42
,p_name=>'CALLOUT_POSITION'
,p_display_name=>'Callout Position'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Determines where the callout for the popup will be positioned relative to its parent.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33957778328427408)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_BUTTON_ICONS'
,p_display_name=>'Collapsible Button Icons'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines which arrows to use to represent the icons for the collapse and expand button.'
,p_null_text=>'Arrows'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33958214263427408)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_ICON_POSITION'
,p_display_name=>'Collapsible Icon Position'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the position of the expand and collapse toggle for the region.'
,p_null_text=>'Start'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33958576521427408)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33958967948427408)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33959349136427408)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON'
,p_display_name=>'Display Icon'
,p_display_sequence=>50
,p_template_types=>'REGION'
,p_help_text=>'Display the Hero Region icon.'
,p_null_text=>'Yes (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33959812216427408)
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
 p_id=>wwv_flow_api.id(33960144296427408)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33960590139427408)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REGION'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Rounded Corners'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33960980858427410)
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
 p_id=>wwv_flow_api.id(33961400027427410)
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
 p_id=>wwv_flow_api.id(33961814118427410)
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
 p_id=>wwv_flow_api.id(33962218203427410)
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
 p_id=>wwv_flow_api.id(33962592921427410)
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
 p_id=>wwv_flow_api.id(33962972524427410)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33963365537427410)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER'
,p_display_name=>'Login Header'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the Login region header.'
,p_null_text=>'Icon and Title (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33963777649427410)
,p_theme_id=>42
,p_name=>'REGION_BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>210
,p_template_types=>'REGION'
,p_help_text=>'Set the bottom margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33964171001427410)
,p_theme_id=>42
,p_name=>'REGION_LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'REGION'
,p_help_text=>'Set the left margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33964627732427410)
,p_theme_id=>42
,p_name=>'REGION_RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'REGION'
,p_help_text=>'Set the right margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33965005303427410)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33965339771427410)
,p_theme_id=>42
,p_name=>'REGION_TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'REGION'
,p_help_text=>'Set the top margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33965737761427410)
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
 p_id=>wwv_flow_api.id(33966151571427411)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33966545045427411)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33966962558427411)
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
 p_id=>wwv_flow_api.id(33967407471427411)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33967742422427411)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>70
,p_template_types=>'REPORT'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33968166661427411)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33968537294427411)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33968952395427411)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33969355693427411)
,p_theme_id=>42
,p_name=>'COL_ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>150
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33969753154427411)
,p_theme_id=>42
,p_name=>'COL_CONTENT_DESCRIPTION'
,p_display_name=>'Description'
,p_display_sequence=>130
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33970199980427411)
,p_theme_id=>42
,p_name=>'COL_CONTENT_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>120
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33970533067427411)
,p_theme_id=>42
,p_name=>'COL_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>110
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33970958725427411)
,p_theme_id=>42
,p_name=>'COL_MISC'
,p_display_name=>'Misc'
,p_display_sequence=>140
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33971349605427411)
,p_theme_id=>42
,p_name=>'COL_SELECTION'
,p_display_name=>'Selection'
,p_display_sequence=>100
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33971805545427413)
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
 p_id=>wwv_flow_api.id(33972193895427413)
,p_theme_id=>42
,p_name=>'CONTENT_ALIGNMENT'
,p_display_name=>'Content Alignment'
,p_display_sequence=>90
,p_template_types=>'REPORT'
,p_null_text=>'Center (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33972562667427413)
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
 p_id=>wwv_flow_api.id(33973007698427413)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REPORT'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33973372811427413)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33973818613427413)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33974195885427413)
,p_theme_id=>42
,p_name=>'PAGINATION_DISPLAY'
,p_display_name=>'Pagination Display'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of pagination for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33974610056427413)
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
 p_id=>wwv_flow_api.id(33974955000427413)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33975341066427413)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(33975776820427413)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the overall style for the component.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(33996920427427424)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(33942942727427403)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(33997568694427424)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(33963777649427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(33998315609427424)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(33942942727427403)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(33999019413427424)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(33963777649427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(33999643918427424)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(33942942727427403)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34000415952427424)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(33963777649427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34001081877427425)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(33942942727427403)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34001819512427425)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(33963777649427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34002495318427425)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(33944172043427403)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34003173927427425)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(33964171001427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34003864177427425)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(33944172043427403)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34004611634427425)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(33964171001427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34005327920427427)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(33944172043427403)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34005982186427427)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(33964171001427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34006632704427427)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(33944172043427403)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34007365680427427)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(33964171001427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34008045567427427)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(33945395417427405)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34008811221427427)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(33964627732427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34009445293427427)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(33945395417427405)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34010155655427428)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(33964627732427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34010834290427428)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(33945395417427405)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34011611857427428)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(33964627732427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34012237360427428)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(33945395417427405)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34013008164427428)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(33964627732427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34013682991427428)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(33946142331427405)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34014409570427430)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(33965339771427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34015096497427430)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(33946142331427405)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34015787371427430)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(33965339771427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34016527191427430)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(33946142331427405)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34017151658427430)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(33965339771427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34017903531427430)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(33946142331427405)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34018620065427431)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(33965339771427410)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34019242801427431)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(33939807160427403)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34020012429427431)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(33942163525427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34020656869427431)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(33940567544427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34021420546427431)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(33940967602427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34022083384427431)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(33940188264427403)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34022811140427431)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(33941388512427403)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34023434512427433)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(33941734697427403)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34024153556427433)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(33941734697427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34024863583427433)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(33940188264427403)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34025600379427433)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(33940567544427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34026241195427433)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(33940967602427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34026982756427435)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(33941388512427403)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34027647234427435)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(33938568101427402)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34028338149427435)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(33938568101427402)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34029125091427435)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(33938568101427402)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34029745108427435)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(33942163525427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34030503868427435)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(33941734697427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34031220837427436)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(33939807160427403)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34031847337427436)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(33942581055427403)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34032540741427436)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(33942163525427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34033230706427436)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(33939807160427403)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34033973142427436)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(33942163525427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34034676705427436)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(33962592921427410)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34035376571427436)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(33961400027427410)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34036115712427438)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(33962218203427410)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34036805018427438)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(33960980858427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34037451196427438)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(33960980858427410)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34038154821427438)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(33961814118427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34038830539427438)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(33961400027427410)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34039590209427438)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(33943389445427403)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34040282795427438)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(33943814110427403)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34041013463427439)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(33945798830427405)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34041706436427439)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(33945798830427405)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34042384316427439)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(33944944922427405)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34042804099427439)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34043483388427439)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_api.id(33974195885427413)
,p_template_types=>'REPORT'
,p_help_text=>'This option will hide the pagination when all rows are displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34063323173427453)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT_SPLIT'
,p_display_name=>'Split'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(65074788609242442)
,p_css_classes=>'t-LoginPage--split'
,p_group_id=>wwv_flow_api.id(33952965086427406)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34064019862427453)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_1'
,p_display_name=>'Background 1'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(65074788609242442)
,p_css_classes=>'t-LoginPage--bg1'
,p_group_id=>wwv_flow_api.id(33952623463427406)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34064700676427453)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_2'
,p_display_name=>'Background 2'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(65074788609242442)
,p_css_classes=>'t-LoginPage--bg2'
,p_group_id=>wwv_flow_api.id(33952623463427406)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34065382549427453)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_3'
,p_display_name=>'Background 3'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_api.id(65074788609242442)
,p_css_classes=>'t-LoginPage--bg3'
,p_group_id=>wwv_flow_api.id(33952623463427406)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34164671051427497)
,p_theme_id=>42
,p_name=>'DISPLAY_POPUP_CALLOUT'
,p_display_name=>'Display Popup Callout'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-popup-callout'
,p_template_types=>'REGION'
,p_help_text=>'Use this option to add display a callout for the popup. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34165428134427497)
,p_theme_id=>42
,p_name=>'BEFORE'
,p_display_name=>'Before'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-popup-pos-before'
,p_group_id=>wwv_flow_api.id(33957414809427408)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout before or typically to the left of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34166086522427497)
,p_theme_id=>42
,p_name=>'AFTER'
,p_display_name=>'After'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-popup-pos-after'
,p_group_id=>wwv_flow_api.id(33957414809427408)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout after or typically to the right of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34166789011427497)
,p_theme_id=>42
,p_name=>'ABOVE'
,p_display_name=>'Above'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-popup-pos-above'
,p_group_id=>wwv_flow_api.id(33957414809427408)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout above or typically on top of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34167506062427499)
,p_theme_id=>42
,p_name=>'BELOW'
,p_display_name=>'Below'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-popup-pos-below'
,p_group_id=>wwv_flow_api.id(33957414809427408)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout below or typically to the bottom of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34168185746427499)
,p_theme_id=>42
,p_name=>'INSIDE'
,p_display_name=>'Inside'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-popup-pos-inside'
,p_group_id=>wwv_flow_api.id(33957414809427408)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout inside of the parent. This is useful when the parent is sufficiently large, such as a report or large region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34177583856427502)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086330943242450)
,p_css_classes=>'t-Login-region--headerIcon'
,p_group_id=>wwv_flow_api.id(33963365537427410)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Icon in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34178316263427502)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086330943242450)
,p_css_classes=>'t-Login-region--headerTitle'
,p_group_id=>wwv_flow_api.id(33963365537427410)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Title in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34179007657427502)
,p_theme_id=>42
,p_name=>'LOGO_HEADER_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65086330943242450)
,p_css_classes=>'t-Login-region--headerHidden'
,p_group_id=>wwv_flow_api.id(33963365537427410)
,p_template_types=>'REGION'
,p_help_text=>'Hides both the Region Icon and Title from the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34211011310427519)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(34210513879427517)
,p_css_classes=>'t-CardsRegion--styleA'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34211360082427519)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(34210513879427517)
,p_css_classes=>'t-CardsRegion--styleB'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34211787056427520)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Style C'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(34210513879427517)
,p_css_classes=>'t-CardsRegion--styleC'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34212132291427520)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(34210513879427517)
,p_css_classes=>'u-colors'
,p_template_types=>'REGION'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34245614782427538)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(65102474702242459)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34247503104427538)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65105263166242461)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34248817701427539)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65103027051242459)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34250073328427539)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_css_classes=>'js-navCollapsed--hidden'
,p_group_id=>wwv_flow_api.id(33947784082427405)
,p_template_types=>'LIST'
,p_help_text=>'Completely hide the navigation menu when it is collapsed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34250465376427541)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34251146795427541)
,p_theme_id=>42
,p_name=>'ICON_DEFAULT'
,p_display_name=>'Icon (Default)'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_css_classes=>'js-navCollapsed--default'
,p_group_id=>wwv_flow_api.id(33947784082427405)
,p_template_types=>'LIST'
,p_help_text=>'Display icons when the navigation menu is collapsed for large screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34260246780427544)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(65106388349242461)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34268283290427549)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34268654118427550)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Displays a callout arrow that points to where the menu was activated from.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34269122874427550)
,p_theme_id=>42
,p_name=>'FULL_WIDTH'
,p_display_name=>'Full Width'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'t-MegaMenu--fullWidth'
,p_template_types=>'LIST'
,p_help_text=>'Stretches the menu to fill the width of the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34269526428427550)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'t-MegaMenu--layout2Cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34269894825427550)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'t-MegaMenu--layout3Cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34270320532427550)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'t-MegaMenu--layout4Cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34270680564427550)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'t-MegaMenu--layout5Cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34271110618427550)
,p_theme_id=>42
,p_name=>'CUSTOM'
,p_display_name=>'Custom'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'t-MegaMenu--layoutCustom'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34271484230427550)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(34267780320427549)
,p_css_classes=>'t-MegaMenu--layoutStacked'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34321441631427575)
,p_theme_id=>42
,p_name=>'ALIGNMENT_TOP'
,p_display_name=>'Top'
,p_display_sequence=>100
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--alignTop'
,p_group_id=>wwv_flow_api.id(33972193895427413)
,p_template_types=>'REPORT'
,p_help_text=>'Aligns the content to the top of the row. This is useful when you expect that yours rows will vary in height (e.g. some rows will have longer descriptions than others).'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34321904810427575)
,p_theme_id=>42
,p_name=>'ACTIONS_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--hideActions'
,p_group_id=>wwv_flow_api.id(33969355693427411)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Actions column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34322300107427575)
,p_theme_id=>42
,p_name=>'DESCRIPTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--hideDescription'
,p_group_id=>wwv_flow_api.id(33969753154427411)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Description from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34322712223427575)
,p_theme_id=>42
,p_name=>'ICON_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--hideIcon'
,p_group_id=>wwv_flow_api.id(33970533067427411)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Icon from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34323070714427577)
,p_theme_id=>42
,p_name=>'MISC_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--hideMisc'
,p_group_id=>wwv_flow_api.id(33970958725427411)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Misc column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34323429966427577)
,p_theme_id=>42
,p_name=>'SELECTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--hideSelection'
,p_group_id=>wwv_flow_api.id(33971349605427411)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Selection column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34323865983427577)
,p_theme_id=>42
,p_name=>'TITLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--hideTitle'
,p_group_id=>wwv_flow_api.id(33970199980427411)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Title from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(34324264121427577)
,p_theme_id=>42
,p_name=>'STYLE_COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(34320952159427575)
,p_css_classes=>'t-ContentRow--styleCompact'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
,p_help_text=>'This option reduces the padding and font sizes to present a compact display of the same information.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50572511290084808)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(65070361246242437)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50581601244084816)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(65071260263242440)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50592865044084819)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(65075091166242442)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50600173878084822)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(65072303425242440)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50603820360084822)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(65076147654242442)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50604245828084822)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(65076147654242442)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50612766395084825)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(65073061098242440)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50620067564084827)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(65074039354242442)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50623717379084828)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(65076480572242442)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50624189380084828)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(65076480572242442)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50626605187084833)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(33954546984427406)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50627395697084835)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(33954546984427406)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50637054961084838)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65082927097242448)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50642250301084839)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50659076644084846)
,p_theme_id=>42
,p_name=>'ICONS_PLUS_OR_MINUS'
,p_display_name=>'Plus or Minus'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--hideShowIconsMath'
,p_group_id=>wwv_flow_api.id(33957778328427408)
,p_template_types=>'REGION'
,p_help_text=>'Use the plus and minus icons for the expand and collapse button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50659721906084847)
,p_theme_id=>42
,p_name=>'CONRTOLS_POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--controlsPosEnd'
,p_group_id=>wwv_flow_api.id(33958214263427408)
,p_template_types=>'REGION'
,p_help_text=>'Position the expand / collapse button to the end of the region header.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50660182691084847)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50673490261084852)
,p_theme_id=>42
,p_name=>'ICONS_CIRCULAR'
,p_display_name=>'Circle'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65085829668242450)
,p_css_classes=>'t-HeroRegion--iconsCircle'
,p_group_id=>wwv_flow_api.id(33960590139427408)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a circle.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50674160542084852)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65085829668242450)
,p_css_classes=>'t-HeroRegion--iconsSquare'
,p_group_id=>wwv_flow_api.id(33960590139427408)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a square.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50674556733084852)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65085829668242450)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50675280266084852)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65085829668242450)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50675944143084852)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65085829668242450)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50676612112084852)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65085829668242450)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(33959349136427408)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50681510824084853)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50681927076084855)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50689850194084857)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50690536592084857)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50691228673084858)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50691911671084858)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50692621848084858)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50693324075084858)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50694030088084858)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50694761339084858)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50695466136084860)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50696169958084860)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50696800037084860)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50697517492084860)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50720740233084869)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65089786772242451)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50726074057084878)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(50725566224084872)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50726493191084878)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(50725566224084872)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(33965005303427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50726877952084878)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(50725566224084872)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(33965005303427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50727214220084878)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(50725566224084872)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(33965005303427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50727648415084878)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(50725566224084872)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(33956991575427408)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50728076514084878)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(50725566224084872)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(33956991575427408)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50728398199084878)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(50725566224084872)
,p_css_classes=>'t-ContentBlock--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50731179813084880)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50731499294084880)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(33958967948427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50731995718084880)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(33958967948427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50732332809084880)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_api.id(33958967948427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50732748490084880)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50733196601084880)
,p_theme_id=>42
,p_name=>'REMOVE_PAGE_OVERLAY'
,p_display_name=>'Remove Page Overlay'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-popup-noOverlay'
,p_template_types=>'REGION'
,p_help_text=>'This option will display the inline dialog without an overlay on the background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50733530957084880)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(50730194765084878)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(33958967948427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50734564751084883)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50735209969084883)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50735992817084883)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50746296717084888)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(33949792335427406)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50746639411084888)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50747315826084888)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50748081797084888)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50748741470084889)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(33946534995427405)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50749472568084889)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(33946534995427405)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50750186064084889)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(33949792335427406)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50767986576084900)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(33949792335427406)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50768676868084902)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(33949792335427406)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50769067936084902)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50769779721084902)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(33951741710427406)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50777898763084905)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65105263166242461)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50779281228084907)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50779928355084907)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_css_classes=>'t-TreeNav--styleA'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation A'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50780615105084907)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_css_classes=>'t-TreeNav--styleB'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation B'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50781321995084907)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Classic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_css_classes=>'t-TreeNav--classic'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
,p_help_text=>'Classic Style'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50790139899084910)
,p_theme_id=>42
,p_name=>'WIZARD_PROGRESS_LINKS'
,p_display_name=>'Make Wizard Steps Clickable'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(65104007967242461)
,p_css_classes=>'js-wizardProgressLinks'
,p_template_types=>'LIST'
,p_help_text=>'This option will make the wizard steps clickable links.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50790569052084910)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65104007967242461)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50793765552084913)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(50793225742084911)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_api.id(33951383835427406)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50794125735084913)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(50793225742084911)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_api.id(33951383835427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50794596385084913)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(50793225742084911)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_api.id(33948571076427405)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50794909812084913)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(50793225742084911)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_api.id(33948571076427405)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50795328956084913)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(50793225742084911)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_api.id(33948571076427405)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50796676485084916)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50797367829084916)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50798065108084916)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50808329289084921)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(33973007698427413)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50809067939084921)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50809425217084921)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50810099657084921)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(33967742422427411)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50810886593084921)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(33967742422427411)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50811560968084921)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(33973007698427413)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50825182742084927)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65094833981242454)
,p_css_classes=>'t-Comments--iconsRounded'
,p_group_id=>wwv_flow_api.id(33973007698427413)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50825891496084927)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65094833981242454)
,p_css_classes=>'t-Comments--iconsSquare'
,p_group_id=>wwv_flow_api.id(33973007698427413)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50845863848084936)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50846232106084936)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50846656815084936)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50847064425084936)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50847415238084936)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50847818354084936)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(33973007698427413)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50848292758084936)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(33973007698427413)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50848620583084936)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(33975341066427413)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50849041024084936)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50849407768084936)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50849849289084936)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50850207131084936)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50850685657084938)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_api.id(50845329833084935)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50853405643084947)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(65107359608242462)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(33938932879427403)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50854183820084947)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(65107359608242462)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(33938932879427403)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50856136046084949)
,p_theme_id=>42
,p_name=>'HIDE_LABEL_ON_MOBILE'
,p_display_name=>'Hide Label on Mobile'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(65107577752242464)
,p_css_classes=>'t-Button--mobileHideLabel'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button label on small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50856834086084949)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(65107577752242464)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(33938932879427403)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(50857569836084949)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(65107577752242464)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(33938932879427403)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65077051429242443)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65077317134242445)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(33954183278427406)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65077480387242445)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(33954943092427406)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65077603182242445)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(33954183278427406)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65077817369242445)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(33953813371427406)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65077915584242445)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(33954943092427406)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65078045203242445)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(33954183278427406)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65078132841242445)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(33954943092427406)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65078204632242445)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(33954943092427406)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65078281540242445)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65076900167242443)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(33953813371427406)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65078854651242447)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65078953629242447)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079087632242447)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079163209242447)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079422967242447)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(33966962558427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079526471242447)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(33966962558427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079631531242447)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(33966962558427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079653117242447)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(33966962558427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079803150242447)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65079889019242447)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65080066340242447)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65080208741242447)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65080254531242447)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65080403166242447)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65080534357242447)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65080694831242447)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(33955396469427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65080828818242447)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(33955396469427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081003609242447)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(33956148693427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081162156242447)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(33959812216427408)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081404453242447)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081500312242447)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081555551242447)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(33959812216427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081673038242448)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(33956148693427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081817396242448)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65081888586242448)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65078491984242445)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65082316851242448)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(33958967948427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65082395322242448)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(33958967948427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65082491809242448)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(33958967948427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65082591361242448)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65082691286242448)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65082845210242448)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65082029838242448)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65083209238242448)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65082927097242448)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65083350359242448)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(65082927097242448)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(33956586330427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65083541216242448)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(65082927097242448)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65083618312242448)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(65082927097242448)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(33956586330427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084015874242448)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084100834242448)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084193766242450)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084294500242450)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084526729242450)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(33958576521427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084614567242450)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(33958576521427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084658211242450)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084836186242450)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65084945874242450)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085001068242450)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085087365242450)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085245926242450)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(33956148693427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085314752242450)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085386489242450)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085497586242450)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085612975242450)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(33956148693427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65085705881242450)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65083709646242448)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65086075556242450)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086030068242450)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65086240182242450)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086030068242450)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65086779247242450)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65086939308242450)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65086950962242450)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087118335242450)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(33955796526427408)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087237370242450)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087286854242450)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087389900242450)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087466777242450)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087590090242450)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087706087242450)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(33953343624427406)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087759464242450)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(33956148693427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087939597242450)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(33959812216427408)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65087991129242450)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65088077840242450)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65088214678242450)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65088283120242450)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(33959812216427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65088409464242450)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(33956148693427408)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65088493158242450)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65086533740242450)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(33965737761427410)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65088901773242451)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65088608005242450)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65089135468242451)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65088608005242450)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(33962972524427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65089285552242451)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65088608005242450)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(33966151571427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65089469830242451)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65088608005242450)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(33966545045427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65089622252242451)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65088608005242450)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(33966545045427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65089739844242451)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65088608005242450)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(33966151571427411)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65089920057242451)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65089786772242451)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65090105816242451)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65089786772242451)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(33965005303427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65090248742242451)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(65089786772242451)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(33965005303427410)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65090641120242451)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(65090258949242451)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(33960144296427408)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65090704884242451)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65090258949242451)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(33960144296427408)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65090787334242451)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(65090258949242451)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091156204242453)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091341080242453)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091361079242453)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091508063242453)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091572776242453)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091727599242453)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091781486242453)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65091995551242453)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(33968166661427411)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65092067831242453)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(33968166661427411)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65092259234242453)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(33968166661427411)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65092416775242453)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65092540897242453)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(33968166661427411)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65092631702242453)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(65091029366242453)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(33968166661427411)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65092791961242453)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65092905150242453)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65093037895242453)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65093205996242453)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65093363019242453)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65093532942242453)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65093565312242453)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65093825429242453)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(33968537294427411)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65093886277242453)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(33968537294427411)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65094000746242454)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(33968537294427411)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65094188080242454)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(33972562667427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65094255117242454)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(33972562667427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65094411839242454)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65094451701242454)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65094588750242454)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(33968537294427411)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65094656544242454)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(65092691152242453)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65095036774242454)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65094833981242454)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(33971805545427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65095116096242454)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65094833981242454)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(33971805545427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65095510911242454)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(33967407471427411)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65095699007242454)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(33974610056427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65095815204242454)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(33974610056427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65095871402242454)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(33974610056427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65096091793242454)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(33974955000427413)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65096249275242454)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(33974955000427413)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65096288946242454)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(33967407471427411)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65096443852242454)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65096519620242454)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65095308082242454)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(33974610056427413)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65096844640242454)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65096946013242454)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097034291242456)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097120879242456)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097222391242456)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097290834242456)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097432863242456)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097453500242456)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(65096578846242454)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097705691242456)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097846677242456)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097861124242456)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65097973817242456)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65098110039242456)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(33973818613427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65098164619242456)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65098251002242456)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65098420951242456)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(65097570039242456)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(33973372811427413)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65098648102242456)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(65098526558242456)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(33975776820427413)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65098881669242457)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(33947004243427405)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099121675242457)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099209532242457)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099260338242457)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099398901242457)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099513406242457)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099596801242457)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099715778242457)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099778347242457)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(33947004243427405)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65099939762242457)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(33947004243427405)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65100141582242457)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(33947004243427405)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65100164010242457)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65100267135242457)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(65098694266242456)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(33947004243427405)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65100495800242457)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65100581036242457)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65100669396242457)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65100900441242457)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65101054531242457)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65101203438242457)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65101309689242457)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65101468072242457)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(33947420007427405)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65101612949242457)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(33947420007427405)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65101658607242457)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(33947420007427405)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65101901499242457)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(33949338770427405)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102011737242459)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(33949338770427405)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102098604242459)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102164925242459)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102305157242459)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(33947420007427405)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102378026242459)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102586140242459)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(65102474702242459)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102673564242459)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65102474702242459)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65102919540242459)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65102474702242459)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65103223326242461)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(65103064537242459)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65103304273242461)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65103064537242459)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(33949338770427405)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65103368124242461)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65103064537242459)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(33949338770427405)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65103645182242461)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65103064537242459)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(33951741710427406)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65103722815242461)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65103064537242459)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65103791270242461)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65103064537242459)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65103940271242461)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(65103064537242459)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(33951741710427406)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65104157918242461)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65104007967242461)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(33950547947427406)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65104340599242461)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65104007967242461)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(33950547947427406)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65104417625242461)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65104007967242461)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(33950547947427406)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65104550361242461)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65104544948242461)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(33952218309427406)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65104723304242461)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65104544948242461)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65104809261242461)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65104544948242461)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65104888829242461)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65104544948242461)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65105105796242461)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65104544948242461)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(33949003408427405)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65105161198242461)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65104544948242461)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(33949003408427405)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65105507977242461)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65105609777242461)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65105690808242461)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65105847997242461)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65105904989242461)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(33951029475427406)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65106041044242461)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65106111603242461)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65106235381242461)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(65105356130242461)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65106460783242462)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(65106388349242461)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65106562755242462)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(65106388349242461)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65106843787242462)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(65106388349242461)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65107838322242464)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(65107577752242464)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(33939422461427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(65107884543242464)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(65107577752242464)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(33939422461427403)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/globalization/language
begin
wwv_flow_api.create_language_map(
 p_id=>wwv_flow_api.id(35211402731765133)
,p_translation_flow_id=>103
,p_translation_flow_language_cd=>'en'
,p_direction_right_to_left=>'N'
);
end;
/
prompt --application/shared_components/globalization/translations
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18103904151315384)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24707031371449533.103)
,p_translate_from_id=>wwv_flow_api.id(24707031371449533)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18104098627315392)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24706890816449531.103)
,p_translate_from_id=>wwv_flow_api.id(24706890816449531)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''PRE_ID'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''PRE_ID'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18104216684315395)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24707031371449533.103)
,p_translate_from_id=>wwv_flow_api.id(24707031371449533)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P10_PAR_ID'
,p_translate_from_text=>'P10_PAR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18104464638315395)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24706890816449531.103)
,p_translate_from_id=>wwv_flow_api.id(24706890816449531)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PRE_ID'
,p_translate_from_text=>'PRE_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18104684010315396)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24707031371449533.103)
,p_translate_from_id=>wwv_flow_api.id(24707031371449533)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P10_PAR_ID'
,p_translate_from_text=>'P10_PAR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18104801222315396)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24706890816449531.103)
,p_translate_from_id=>wwv_flow_api.id(24706890816449531)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PRE_ID'
,p_translate_from_text=>'PRE_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18105086107315400)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24707031371449533.103)
,p_translate_from_id=>wwv_flow_api.id(24707031371449533)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18105232521315400)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24706890816449531.103)
,p_translate_from_id=>wwv_flow_api.id(24706890816449531)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18105430730315401)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24707031371449533.103)
,p_translate_from_id=>wwv_flow_api.id(24707031371449533)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(18105681780315401)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24706890816449531.103)
,p_translate_from_id=>wwv_flow_api.id(24706890816449531)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35211519591769736)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>6.103
,p_translate_from_id=>6
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameters'
,p_translate_from_text=>'Parameter administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35211593081769736)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>7.103
,p_translate_from_id=>7
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit parameter'
,p_translate_from_text=>'Parameter bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35211812057769738)
,p_page_id=>1
,p_translated_flow_id=>103
,p_translate_to_id=>1.103
,p_translate_from_id=>1
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT Administration'
,p_translate_from_text=>'PIT-Administration'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35211966548769738)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>11.103
,p_translate_from_id=>11
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Output Module'
,p_translate_from_text=>'Ausgabemodul administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35212221840769738)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>2.103
,p_translate_from_id=>2
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35212346673769738)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>8.103
,p_translate_from_id=>8
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit arameter group'
,p_translate_from_text=>'Parametergruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35212580050769738)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>12.103
,p_translate_from_id=>12
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context Toggle'
,p_translate_from_text=>'Kontext-Toggle administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35212737834769738)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>4.103
,p_translate_from_id=>4
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35212981443769738)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>101.103
,p_translate_from_id=>101
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Login Page'
,p_translate_from_text=>'Login Page'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35213166209769738)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>5.103
,p_translate_from_id=>5
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich einstellen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35213339916769738)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>10.103
,p_translate_from_id=>10
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context'
,p_translate_from_text=>'Kontext administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35213610859769738)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>3.103
,p_translate_from_id=>3
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Meldung editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35213748351769738)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>9.103
,p_translate_from_id=>9
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35214022882769738)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>16.103
,p_translate_from_id=>16
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export and translate master data'
,p_translate_from_text=>unistr('Stammdaten exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35214181537769741)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>6.103
,p_translate_from_id=>6
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameters'
,p_translate_from_text=>'Parameter administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35214412250769741)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>7.103
,p_translate_from_id=>7
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit parameter'
,p_translate_from_text=>'Parameter bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35214546569769741)
,p_page_id=>1
,p_translated_flow_id=>103
,p_translate_to_id=>1.103
,p_translate_from_id=>1
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT Administration'
,p_translate_from_text=>'PIT-Administration'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35214825202769741)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>11.103
,p_translate_from_id=>11
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Output Module'
,p_translate_from_text=>'Ausgabemodul administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35215003541769741)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>2.103
,p_translate_from_id=>2
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35215146482769741)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>8.103
,p_translate_from_id=>8
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit parameter group'
,p_translate_from_text=>'Parametergruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35215400001769741)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>12.103
,p_translate_from_id=>12
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context Toggle'
,p_translate_from_text=>'Kontext-Toggle administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35215628168769741)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>4.103
,p_translate_from_id=>4
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35215823303769741)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>101.103
,p_translate_from_id=>101
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT-Administration - Log In'
,p_translate_from_text=>'PIT-Administration - Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35215930712769741)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>5.103
,p_translate_from_id=>5
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich einstellen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35216152425769741)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>10.103
,p_translate_from_id=>10
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context'
,p_translate_from_text=>'Kontext administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35216375963769741)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>3.103
,p_translate_from_id=>3
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Meldung editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35216590326769741)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>9.103
,p_translate_from_id=>9
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35216735787769741)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>16.103
,p_translate_from_id=>16
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export and translate master data'
,p_translate_from_text=>unistr('Stammdaten exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35216980138769750)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>6.103
,p_translate_from_id=>6
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35217154764769750)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>7.103
,p_translate_from_id=>7
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35217354926769750)
,p_page_id=>1
,p_translated_flow_id=>103
,p_translate_to_id=>1.103
,p_translate_from_id=>1
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>'No help is available for this page.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35217559124769750)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>11.103
,p_translate_from_id=>11
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35217781084769750)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>2.103
,p_translate_from_id=>2
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>'No help is available for this page.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35218000812769750)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>8.103
,p_translate_from_id=>8
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35218135063769750)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>12.103
,p_translate_from_id=>12
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35218339633769750)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>10.103
,p_translate_from_id=>10
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35218547200769750)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>3.103
,p_translate_from_id=>3
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>'No help is available for this page.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35218765552769750)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>9.103
,p_translate_from_id=>9
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35218969854769750)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>16.103
,p_translate_from_id=>16
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35219140927769752)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976316283337472.103)
,p_translate_from_id=>wwv_flow_api.id(66976316283337472)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35219341596769752)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844003527500081.103)
,p_translate_from_id=>wwv_flow_api.id(66844003527500081)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Context'
,p_translate_from_text=>'Kontext erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35219554974769753)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54929090788871623.103)
,p_translate_from_id=>wwv_flow_api.id(54929090788871623)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung laden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35219813149769753)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65121425588455431.103)
,p_translate_from_id=>wwv_flow_api.id(65121425588455431)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35219993431769753)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976140212337472.103)
,p_translate_from_id=>wwv_flow_api.id(66976140212337472)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Context'
,p_translate_from_text=>'Kontext erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35220189827769753)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67002777408778007.103)
,p_translate_from_id=>wwv_flow_api.id(67002777408778007)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35220345683769753)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926888111871601.103)
,p_translate_from_id=>wwv_flow_api.id(54926888111871601)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export translatable item'
,p_translate_from_text=>'Begriffe exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35220574305769753)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747080793394477.103)
,p_translate_from_id=>wwv_flow_api.id(36747080793394477)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich setzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35220807985769753)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925320023871585.103)
,p_translate_from_id=>wwv_flow_api.id(54925320023871585)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create toggle'
,p_translate_from_text=>'Toggle erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35220939814769753)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598925746735724.103)
,p_translate_from_id=>wwv_flow_api.id(54598925746735724)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35221223610769753)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67002749335778007.103)
,p_translate_from_id=>wwv_flow_api.id(67002749335778007)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35221413334769753)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36789528904952325.103)
,p_translate_from_id=>wwv_flow_api.id(36789528904952325)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35221535196769753)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66855368656726329.103)
,p_translate_from_id=>wwv_flow_api.id(66855368656726329)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35221787836769753)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65122018334455431.103)
,p_translate_from_id=>wwv_flow_api.id(65122018334455431)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35221952476769753)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050928505643261.103)
,p_translate_from_id=>wwv_flow_api.id(67050928505643261)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export Parameter groups'
,p_translate_from_text=>'Parametergruppen exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35222169310769753)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113522625242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113522625242486)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Log In'
,p_translate_from_text=>'Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35222367547769753)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65136442719455576.103)
,p_translate_from_id=>wwv_flow_api.id(65136442719455576)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create message'
,p_translate_from_text=>'Meldung erzeugen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35222572298769753)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66855153747726329.103)
,p_translate_from_id=>wwv_flow_api.id(66855153747726329)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35222808819769753)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65121276795455431.103)
,p_translate_from_id=>wwv_flow_api.id(65121276795455431)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create message'
,p_translate_from_text=>'Meldug erzeugen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35222977547769753)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67049906362643251.103)
,p_translate_from_id=>wwv_flow_api.id(67049906362643251)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export Messages'
,p_translate_from_text=>'Meldungen exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35223217894769753)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54927576268871608.103)
,p_translate_from_id=>wwv_flow_api.id(54927576268871608)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35223347483769753)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36787522494952320.103)
,p_translate_from_id=>wwv_flow_api.id(36787522494952320)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35223547335769755)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60165208636098240.103)
,p_translate_from_id=>wwv_flow_api.id(60165208636098240)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help with Oracle error mappings'
,p_translate_from_text=>'Hilfe zu Oracle-Fehlermappings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35223769422769755)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676718613093807.103)
,p_translate_from_id=>wwv_flow_api.id(66676718613093807)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>unistr('\00C4nderungen anwenden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35224016529769755)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60163701315098225.103)
,p_translate_from_id=>wwv_flow_api.id(60163701315098225)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'Hilfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35224130607769755)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976231426337472.103)
,p_translate_from_id=>wwv_flow_api.id(66976231426337472)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35224334023769755)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925942318871592.103)
,p_translate_from_id=>wwv_flow_api.id(54925942318871592)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Translate message'
,p_translate_from_text=>unistr('Meldung \00FCbersetzen')
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35224626241769755)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164062008098228.103)
,p_translate_from_id=>wwv_flow_api.id(60164062008098228)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'Hilfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35224802966769755)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598712529735721.103)
,p_translate_from_id=>wwv_flow_api.id(54598712529735721)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35225001127769755)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66845076590500092.103)
,p_translate_from_id=>wwv_flow_api.id(66845076590500092)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35225139358769755)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925658152871589.103)
,p_translate_from_id=>wwv_flow_api.id(54925658152871589)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export local parameters'
,p_translate_from_text=>'Lokale Parameter exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35225419646769755)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841143420500052.103)
,p_translate_from_id=>wwv_flow_api.id(66841143420500052)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameter Group'
,p_translate_from_text=>'Parametergruppen verwalten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35225568700769755)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928989817871622.103)
,p_translate_from_id=>wwv_flow_api.id(54928989817871622)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung laden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35225819062769755)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926940055871602.103)
,p_translate_from_id=>wwv_flow_api.id(54926940055871602)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Translate translatable item'
,p_translate_from_text=>unistr('Begriffe \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35226022642769755)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54927255693871605.103)
,p_translate_from_id=>wwv_flow_api.id(54927255693871605)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35226143722769755)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676756398093807.103)
,p_translate_from_id=>wwv_flow_api.id(66676756398093807)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35226403393769755)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676630935093807.103)
,p_translate_from_id=>wwv_flow_api.id(66676630935093807)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create'
,p_translate_from_text=>'Erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35226590513769755)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844082003500082.103)
,p_translate_from_id=>wwv_flow_api.id(66844082003500082)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create toggle'
,p_translate_from_text=>'Toggle erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35226813692769755)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164367542098231.103)
,p_translate_from_id=>wwv_flow_api.id(60164367542098231)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'HIlfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35227019017769755)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976779468337473.103)
,p_translate_from_id=>wwv_flow_api.id(66976779468337473)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35227166890769755)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855269048958676.103)
,p_translate_from_id=>wwv_flow_api.id(63855269048958676)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35227413211769756)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65121463322455431.103)
,p_translate_from_id=>wwv_flow_api.id(65121463322455431)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete message'
,p_translate_from_text=>'Meldung entfernen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35227598356769756)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66696434805093951.103)
,p_translate_from_id=>wwv_flow_api.id(66696434805093951)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Parameter'
,p_translate_from_text=>'Parameter erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35227799500769756)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66677346210093807.103)
,p_translate_from_id=>wwv_flow_api.id(66677346210093807)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35228019883769758)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680039083093912.103)
,p_translate_from_id=>wwv_flow_api.id(66680039083093912)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35228154555769758)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60162687462098215.103)
,p_translate_from_id=>wwv_flow_api.id(60162687462098215)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'editierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35228391822769758)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67004921721778009.103)
,p_translate_from_id=>wwv_flow_api.id(67004921721778009)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35228544480769758)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926593714871598.103)
,p_translate_from_id=>wwv_flow_api.id(54926593714871598)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35228807220769758)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680308728093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680308728093914)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35228989218769758)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979239436337476.103)
,p_translate_from_id=>wwv_flow_api.id(66979239436337476)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Rowid'
,p_translate_from_text=>'Rowid'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35229224305769758)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842221236500063.103)
,p_translate_from_id=>wwv_flow_api.id(66842221236500063)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Gather timing'
,p_translate_from_text=>'Zeitinformation erfassen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35229387354769760)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843642106500077.103)
,p_translate_from_id=>wwv_flow_api.id(66843642106500077)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Allow Toggles'
,p_translate_from_text=>'Toggles verwenden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35229543871769760)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113439797242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113439797242486)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Password'
,p_translate_from_text=>'Passwort'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35229802560769760)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785049559952311.103)
,p_translate_from_id=>wwv_flow_api.id(36785049559952311)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Id'
,p_translate_from_text=>'Par Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35229966143769760)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747259522394479.103)
,p_translate_from_id=>wwv_flow_api.id(36747259522394479)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actual realm'
,p_translate_from_text=>unistr('aktueller G\00FCltigkeitsbereich')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35230187510769760)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67005666462778011.103)
,p_translate_from_id=>wwv_flow_api.id(67005666462778011)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'assigned context'
,p_translate_from_text=>'zugeordneter Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35230360910769760)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67049774227643250.103)
,p_translate_from_id=>wwv_flow_api.id(67049774227643250)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35230604855769760)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681053332093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681053332093917)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text value'
,p_translate_from_text=>'Textwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35230732199769760)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597761712735712.103)
,p_translate_from_id=>wwv_flow_api.id(54597761712735712)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'XML value'
,p_translate_from_text=>'XML-Wert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35230957213769760)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681528500093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681528500093917)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer value'
,p_translate_from_text=>'Ganzzahlwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35231207536769760)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682701121093918.103)
,p_translate_from_id=>wwv_flow_api.id(66682701121093918)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp value'
,p_translate_from_text=>'Zeitstempelwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35231370256769760)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66683480245093918.103)
,p_translate_from_id=>wwv_flow_api.id(66683480245093918)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Boolean value'
,p_translate_from_text=>'Wahrheitswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35231552369769760)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125807318455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125807318455542)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message'
,p_translate_from_text=>'Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35231817577769760)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842064643500062.103)
,p_translate_from_id=>wwv_flow_api.id(66842064643500062)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Trace-Level'
,p_translate_from_text=>'Trace-Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35232006470769760)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841978723500061.103)
,p_translate_from_id=>wwv_flow_api.id(66841978723500061)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Debug-Level'
,p_translate_from_text=>'Debug-Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35232141338769760)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926680969871599.103)
,p_translate_from_id=>wwv_flow_api.id(54926680969871599)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Hint pti'
,p_translate_from_text=>'Hint pti'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35232335468769760)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684349104093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684349104093920)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text type'
,p_translate_from_text=>'Texttyp'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35232595251769760)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113301500242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113301500242486)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Username'
,p_translate_from_text=>'Benutzer'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35232753033769760)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125415067455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125415067455542)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35232999177769760)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65126229613455542.103)
,p_translate_from_id=>wwv_flow_api.id(65126229613455542)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity'
,p_translate_from_text=>'Schweregrad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35233211572769761)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65126601904455543.103)
,p_translate_from_id=>wwv_flow_api.id(65126601904455543)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error number'
,p_translate_from_text=>'Fehlernummer'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35233339332769761)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684689053093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684689053093920)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Validation expression'
,p_translate_from_text=>'Validierungsausdruck'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35233592153769761)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66685070109093920.103)
,p_translate_from_id=>wwv_flow_api.id(66685070109093920)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error message'
,p_translate_from_text=>'Fehlermeldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35233750570769761)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67005340005778011.103)
,p_translate_from_id=>wwv_flow_api.id(67005340005778011)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Package list'
,p_translate_from_text=>'Liste der Packages'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35233932769769761)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006119165778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006119165778011)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35234182163769761)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578703809784638.103)
,p_translate_from_id=>wwv_flow_api.id(57578703809784638)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35234386945769761)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66840808326500049.103)
,p_translate_from_id=>wwv_flow_api.id(66840808326500049)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parmetergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35234584052769761)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980449149337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980449149337495)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35234729611769761)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785870054952315.103)
,p_translate_from_id=>wwv_flow_api.id(36785870054952315)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35234938885769761)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925881390871591.103)
,p_translate_from_id=>wwv_flow_api.id(54925881390871591)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35235221106769761)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60446934961471480.103)
,p_translate_from_id=>wwv_flow_api.id(60446934961471480)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Group'
,p_translate_from_text=>'Gruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35235428273769763)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66683922355093920.103)
,p_translate_from_id=>wwv_flow_api.id(66683922355093920)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'prohibit editing'
,p_translate_from_text=>'editieren untersagen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35235551855769763)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681851360093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681851360093917)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number value'
,p_translate_from_text=>unistr('Flie\00DFkommazahlwert')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35235822492769763)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682294712093917.103)
,p_translate_from_id=>wwv_flow_api.id(66682294712093917)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date value'
,p_translate_from_text=>'Datumswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35235932734769763)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842308419500064.103)
,p_translate_from_id=>wwv_flow_api.id(66842308419500064)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output modules'
,p_translate_from_text=>'Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35236184313769763)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050819444643260.103)
,p_translate_from_id=>wwv_flow_api.id(67050819444643260)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35236419499769763)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926805360871600.103)
,p_translate_from_id=>wwv_flow_api.id(54926805360871600)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35236621917769763)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60447001249471481.103)
,p_translate_from_id=>wwv_flow_api.id(60447001249471481)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35236790630769763)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125132723455539.103)
,p_translate_from_id=>wwv_flow_api.id(65125132723455539)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35236943949769763)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57579146689784643.103)
,p_translate_from_id=>wwv_flow_api.id(57579146689784643)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35237171897769763)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979645348337493.103)
,p_translate_from_id=>wwv_flow_api.id(66979645348337493)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35237336928769763)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785417774952314.103)
,p_translate_from_id=>wwv_flow_api.id(36785417774952314)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Pgr Id'
,p_translate_from_text=>'Par Pgr Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35237618276769763)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680672455093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680672455093914)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Besschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35237828934769763)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926070829871593.103)
,p_translate_from_id=>wwv_flow_api.id(54926070829871593)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Hint pms'
,p_translate_from_text=>'Hint pms'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35238003523769763)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928871907871621.103)
,p_translate_from_id=>wwv_flow_api.id(54928871907871621)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Import XLIFF file'
,p_translate_from_text=>'XLIFF-Datei importieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35238225239769763)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54929143107871624.103)
,p_translate_from_id=>wwv_flow_api.id(54929143107871624)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Import XLIFF file'
,p_translate_from_text=>'XLIFF-Datei importieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35238412182769766)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598366157735718.103)
,p_translate_from_id=>wwv_flow_api.id(54598366157735718)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35238552630769766)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747106570394478.103)
,p_translate_from_id=>wwv_flow_api.id(36747106570394478)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35238751568769766)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57579022373784641.103)
,p_translate_from_id=>wwv_flow_api.id(57579022373784641)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35238999702769766)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595846617735693.103)
,p_translate_from_id=>wwv_flow_api.id(54595846617735693)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35239168845769766)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925158196871584.103)
,p_translate_from_id=>wwv_flow_api.id(54925158196871584)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35239424266769766)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925553032871588.103)
,p_translate_from_id=>wwv_flow_api.id(54925553032871588)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35239535242769766)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597656890735711.103)
,p_translate_from_id=>wwv_flow_api.id(54597656890735711)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35239767498769766)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54927047357871603.103)
,p_translate_from_id=>wwv_flow_api.id(54927047357871603)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35239942265769766)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42677117119686728.103)
,p_translate_from_id=>wwv_flow_api.id(42677117119686728)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35240196069769766)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598466222735719.103)
,p_translate_from_id=>wwv_flow_api.id(54598466222735719)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35240406399769767)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60445767550471469.103)
,p_translate_from_id=>wwv_flow_api.id(60445767550471469)
,p_translate_column_id=>17
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error while saving the message:<br>#SQLERRM#'
,p_translate_from_text=>'Fehler beim Speichern der Meldung:<br>#SQLERRM#'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35240590628769770)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60445767550471469.103)
,p_translate_from_id=>wwv_flow_api.id(60445767550471469)
,p_translate_column_id=>18
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message was saved.'
,p_translate_from_text=>'Meldung wurde gespeichert.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35240796073769770)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66687524947093923.103)
,p_translate_from_id=>wwv_flow_api.id(66687524947093923)
,p_translate_column_id=>18
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Action processed.'
,p_translate_from_text=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35240941582769774)
,p_page_id=>1
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65114535769242489.103)
,p_translate_from_id=>wwv_flow_api.id(65114535769242489)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumbs'
,p_translate_from_text=>'Breadcrumbs'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35241158201769774)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65137919205455581.103)
,p_translate_from_id=>wwv_flow_api.id(65137919205455581)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Breadcrumb'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35241377953769774)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676206462093804.103)
,p_translate_from_id=>wwv_flow_api.id(66676206462093804)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit parameter'
,p_translate_from_text=>'Parameter bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35241612572769774)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66698483658093954.103)
,p_translate_from_id=>wwv_flow_api.id(66698483658093954)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35241800993769774)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65121562455455431.103)
,p_translate_from_id=>wwv_flow_api.id(65121562455455431)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35241962051769774)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595979991735694.103)
,p_translate_from_id=>wwv_flow_api.id(54595979991735694)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'List of parameters'
,p_translate_from_text=>'Liste der Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35242214712769774)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843041933500071.103)
,p_translate_from_id=>wwv_flow_api.id(66843041933500071)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Available Toggles'
,p_translate_from_text=>unistr('Verf\00FCgbare Toggles')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35242383028769775)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842856311500070.103)
,p_translate_from_id=>wwv_flow_api.id(66842856311500070)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Information about the debugging filter'
,p_translate_from_text=>'Informationen zum Filter des Debuggings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35242628507769775)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976400553337472.103)
,p_translate_from_id=>wwv_flow_api.id(66976400553337472)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35242798224769775)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926326939871596.103)
,p_translate_from_id=>wwv_flow_api.id(54926326939871596)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'right column'
,p_translate_from_text=>'rechte Spalte'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35243004521769775)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841754215500059.103)
,p_translate_from_id=>wwv_flow_api.id(66841754215500059)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Hints for Output Modules'
,p_translate_from_text=>'Hinweise zu Ausgabemodulen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35243186192769775)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66969118518158031.103)
,p_translate_from_id=>wwv_flow_api.id(66969118518158031)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Available Contexts'
,p_translate_from_text=>unistr('Verf\00FCgbare Kontexte')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35243360518769775)
,p_page_id=>1
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65116864445367151.103)
,p_translate_from_id=>wwv_flow_api.id(65116864445367151)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Application areas'
,p_translate_from_text=>'Anwendungsbereiche'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35243560643769775)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36787148153952320.103)
,p_translate_from_id=>wwv_flow_api.id(36787148153952320)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35243805070769775)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60165141755098239.103)
,p_translate_from_id=>wwv_flow_api.id(60165141755098239)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Help with Oracle error mappings'
,p_translate_from_text=>'HIlfe zu Oracle-Fehlermappings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35244002881769775)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54927208264871604.103)
,p_translate_from_id=>wwv_flow_api.id(54927208264871604)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35244175167769775)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66877873832803795.103)
,p_translate_from_id=>wwv_flow_api.id(66877873832803795)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Installed Output modules'
,p_translate_from_text=>'Installierte Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35244342729769775)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676906611093807.103)
,p_translate_from_id=>wwv_flow_api.id(66676906611093807)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35244531548769775)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67003048652778007.103)
,p_translate_from_id=>wwv_flow_api.id(67003048652778007)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35244796829769775)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595776551735692.103)
,p_translate_from_id=>wwv_flow_api.id(54595776551735692)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35244972795769775)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113157351242482.103)
,p_translate_from_id=>wwv_flow_api.id(65113157351242482)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Log In'
,p_translate_from_text=>'Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35245218334769775)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42604431968983553.103)
,p_translate_from_id=>wwv_flow_api.id(42604431968983553)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Deviating parameter values for realms'
,p_translate_from_text=>unistr('Abweichende Parameterwerte f\00FCr G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35245398461769775)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66851579624726320.103)
,p_translate_from_id=>wwv_flow_api.id(66851579624726320)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit parameter group'
,p_translate_from_text=>'Parametergruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35245619678769775)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164653829098234.103)
,p_translate_from_id=>wwv_flow_api.id(60164653829098234)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Current debug settings'
,p_translate_from_text=>'Aktuelle Debugeinstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35245741238769775)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050222698643254.103)
,p_translate_from_id=>wwv_flow_api.id(67050222698643254)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Create, edit and translate messages'
,p_translate_from_text=>unistr('Meldungen exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35246023517769775)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66697870047093954.103)
,p_translate_from_id=>wwv_flow_api.id(66697870047093954)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35246135644769775)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66866880377799729.103)
,p_translate_from_id=>wwv_flow_api.id(66866880377799729)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35246391571769775)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55083092810622343.103)
,p_translate_from_id=>wwv_flow_api.id(55083092810622343)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35246603811769777)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36784749996952307.103)
,p_translate_from_id=>wwv_flow_api.id(36784749996952307)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Create Form'
,p_translate_from_text=>'Create Form'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35246743105769777)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841879478500060.103)
,p_translate_from_id=>wwv_flow_api.id(66841879478500060)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Hints for Contexts'
,p_translate_from_text=>'Hinweise zu Kontexten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35246970420769777)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926228509871595.103)
,p_translate_from_id=>wwv_flow_api.id(54926228509871595)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'left column'
,p_translate_from_text=>'linke Spalte'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35247175185769777)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926501632871597.103)
,p_translate_from_id=>wwv_flow_api.id(54926501632871597)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Export and translate translatable items'
,p_translate_from_text=>unistr('Begriffe exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35247398736769777)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65131781752455568.103)
,p_translate_from_id=>wwv_flow_api.id(65131781752455568)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Messages'
,p_translate_from_text=>'Meldungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35247533188769777)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65120874444455431.103)
,p_translate_from_id=>wwv_flow_api.id(65120874444455431)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Meldung editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35247819664769777)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842814969500069.103)
,p_translate_from_id=>wwv_flow_api.id(66842814969500069)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Filter Debugging by Package (Toggles)'
,p_translate_from_text=>'Debugging nach Package filtern (Toggles)'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35247970533769777)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598597167735720.103)
,p_translate_from_id=>wwv_flow_api.id(54598597167735720)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35248184797769777)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050283919643255.103)
,p_translate_from_id=>wwv_flow_api.id(67050283919643255)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Export Parameters'
,p_translate_from_text=>'Parameter exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35248377250769777)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67028656396152207.103)
,p_translate_from_id=>wwv_flow_api.id(67028656396152207)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35248538326769777)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66975730920337472.103)
,p_translate_from_id=>wwv_flow_api.id(66975730920337472)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Context'
,p_translate_from_text=>'Kontext administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35248763331769777)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54843310533430746.103)
,p_translate_from_id=>wwv_flow_api.id(54843310533430746)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Output Module'
,p_translate_from_text=>'Ausgabemodul administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35249024953769777)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67002296032778007.103)
,p_translate_from_id=>wwv_flow_api.id(67002296032778007)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Context Toggle'
,p_translate_from_text=>'Kontext-Toggle administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35249220014769780)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843041933500071.103)
,p_translate_from_id=>wwv_flow_api.id(66843041933500071)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, par_id, par_pgr_id, toggle_module_list, toggle_context_name',
'  from pit_ui_admin_pit_toggle'))
,p_translate_from_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, par_id, par_pgr_id, toggle_module_list, toggle_context_name',
'  from pit_ui_admin_pit_toggle'))
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35249411480769780)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842856311500070.103)
,p_translate_from_id=>wwv_flow_api.id(66842856311500070)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35249586214769780)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841754215500059.103)
,p_translate_from_id=>wwv_flow_api.id(66841754215500059)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35249790949769780)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60165141755098239.103)
,p_translate_from_id=>wwv_flow_api.id(60165141755098239)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35249988392769780)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164653829098234.103)
,p_translate_from_id=>wwv_flow_api.id(60164653829098234)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'return pit_ui.get_active_context; '
,p_translate_from_text=>'return pit_ui.get_active_context; '
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35250163515769780)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841879478500060.103)
,p_translate_from_id=>wwv_flow_api.id(66841879478500060)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35250412711769791)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65112847790242475.103)
,p_translate_from_id=>wwv_flow_api.id(65112847790242475)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Log Out'
,p_translate_from_text=>'Log Out'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35250551304769791)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67021056300071639.103)
,p_translate_from_id=>wwv_flow_api.id(67021056300071639)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Master Data'
,p_translate_from_text=>'Stammdaten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35250785604769791)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65913741045348034.103)
,p_translate_from_id=>wwv_flow_api.id(65913741045348034)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameters'
,p_translate_from_text=>'Parameter administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35250951182769791)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65114060705242487.103)
,p_translate_from_id=>wwv_flow_api.id(65114060705242487)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Home'
,p_translate_from_text=>'Startseite'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35251222287769791)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66866425467799726.103)
,p_translate_from_id=>wwv_flow_api.id(66866425467799726)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35251383144769791)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65130838539455550.103)
,p_translate_from_id=>wwv_flow_api.id(65130838539455550)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35251565136769805)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66877873832803795.103)
,p_translate_from_id=>wwv_flow_api.id(66877873832803795)
,p_translate_column_id=>36
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No data found'
,p_translate_from_text=>'Keine Daten gefunden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35251811702769805)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66969118518158031.103)
,p_translate_from_id=>wwv_flow_api.id(66969118518158031)
,p_translate_column_id=>36
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No data found'
,p_translate_from_text=>'Keine Daten gefunden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35251975836769853)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>63
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Search Dialog'
,p_translate_from_text=>'Search Dialog'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35252083720769860)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>66
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_translate_from_text=>'<div class="t-PopupLOV-actions t-Form--large">'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35252276351769861)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>67
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'</div>'
,p_translate_from_text=>'</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35252505927769867)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>70
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-links">'
,p_translate_from_text=>'<div class="t-PopupLOV-links">'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35252689676769869)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>71
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'</div>'
,p_translate_from_text=>'</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35252868957769870)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>72
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Search'
,p_translate_from_text=>'Search'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35253060772769872)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>73
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>'Close'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35253255921769874)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>74
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Next &gt;'
,p_translate_from_text=>'Next &gt;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35253514006769877)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>75
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&lt; Previous'
,p_translate_from_text=>'&lt; Previous'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35253642438769883)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65123426124455432.103)
,p_translate_from_id=>wwv_flow_api.id(65123426124455432)
,p_translate_column_id=>79
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Please confirm that the data should be deleted.'
,p_translate_from_text=>unistr('Bitte best\00E4tigen Sie, dass die Daten gel\00F6scht werden sollen.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35253902255769919)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65114383914242489.103)
,p_translate_from_id=>wwv_flow_api.id(65114383914242489)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Home'
,p_translate_from_text=>'Startseite'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35253968463769919)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65137686798455579.103)
,p_translate_from_id=>wwv_flow_api.id(65137686798455579)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35254216173769919)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66867257108799731.103)
,p_translate_from_id=>wwv_flow_api.id(66867257108799731)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35254353701769919)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67029115680152207.103)
,p_translate_from_id=>wwv_flow_api.id(67029115680152207)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export and translate master data'
,p_translate_from_text=>unistr('Stammdaten exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35254577788769919)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66697656323093951.103)
,p_translate_from_id=>wwv_flow_api.id(66697656323093951)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameter Group'
,p_translate_from_text=>'Parameter verwalten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35254790887769925)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(45470785286547696.103)
,p_translate_from_id=>wwv_flow_api.id(45470785286547696)
,p_translate_column_id=>103
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Editieren sperren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35254929683769928)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67005666462778011.103)
,p_translate_from_id=>wwv_flow_api.id(67005666462778011)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select context'
,p_translate_from_text=>unistr('- Kontext w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35255174223769928)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684349104093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684349104093920)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35255374293769928)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125415067455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125415067455542)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select laguage'
,p_translate_from_text=>unistr('- Sprache w\00E4hlen -')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35255576144769928)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578703809784638.103)
,p_translate_from_id=>wwv_flow_api.id(57578703809784638)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35255793509769930)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66840808326500049.103)
,p_translate_from_id=>wwv_flow_api.id(66840808326500049)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>'- Alle'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35256013174769930)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785870054952315.103)
,p_translate_from_id=>wwv_flow_api.id(36785870054952315)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35256151625769930)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925881390871591.103)
,p_translate_from_id=>wwv_flow_api.id(54925881390871591)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select target language'
,p_translate_from_text=>unistr('- Zielsprache w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35256357835769930)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60446934961471480.103)
,p_translate_from_id=>wwv_flow_api.id(60446934961471480)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35256533931769930)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926805360871600.103)
,p_translate_from_id=>wwv_flow_api.id(54926805360871600)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select target language'
,p_translate_from_text=>unistr('- Zielsprache w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35256739285769930)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60447001249471481.103)
,p_translate_from_id=>wwv_flow_api.id(60447001249471481)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35256950271769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843421788500075.103)
,p_translate_from_id=>wwv_flow_api.id(66843421788500075)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Package list'
,p_translate_from_text=>'Liste der Packages'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35257137348769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66970889237158036.103)
,p_translate_from_id=>wwv_flow_api.id(66970889237158036)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Settings'
,p_translate_from_text=>'Einstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35257353700769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841415080500055.103)
,p_translate_from_id=>wwv_flow_api.id(66841415080500055)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'active'
,p_translate_from_text=>'aktiv'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35257612489769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63854739562958671.103)
,p_translate_from_id=>wwv_flow_api.id(63854739562958671)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message'
,p_translate_from_text=>'Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35257741002769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66970461764158036.103)
,p_translate_from_id=>wwv_flow_api.id(66970461764158036)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35257938678769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842365141500065.103)
,p_translate_from_id=>wwv_flow_api.id(66842365141500065)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35258154484769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164901828098237.103)
,p_translate_from_id=>wwv_flow_api.id(60164901828098237)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Gather timing'
,p_translate_from_text=>'Zeitinformationen erfassen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35258366792769931)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164688634098235.103)
,p_translate_from_id=>wwv_flow_api.id(60164688634098235)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Debug Level'
,p_translate_from_text=>'Debug Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35258590485769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164790139098236.103)
,p_translate_from_id=>wwv_flow_api.id(60164790139098236)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Trace Level'
,p_translate_from_text=>'Trace Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35258762176769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841340999500054.103)
,p_translate_from_id=>wwv_flow_api.id(66841340999500054)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'available'
,p_translate_from_text=>unistr('verf\00FCgbar')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35258948878769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841503270500056.103)
,p_translate_from_id=>wwv_flow_api.id(66841503270500056)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35259199567769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841175521500053.103)
,p_translate_from_id=>wwv_flow_api.id(66841175521500053)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output module'
,p_translate_from_text=>'Ausgabemodul'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35259409538769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66970098141158036.103)
,p_translate_from_id=>wwv_flow_api.id(66970098141158036)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35259553784769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843182125500073.103)
,p_translate_from_id=>wwv_flow_api.id(66843182125500073)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Toggle name'
,p_translate_from_text=>'Toggle-Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35259792327769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60164979439098238.103)
,p_translate_from_id=>wwv_flow_api.id(60164979439098238)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output modules'
,p_translate_from_text=>'Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35259992180769933)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843522216500076.103)
,p_translate_from_id=>wwv_flow_api.id(66843522216500076)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35260165807769935)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843148161500072.103)
,p_translate_from_id=>wwv_flow_api.id(66843148161500072)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35260344564769935)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842365141500065.103)
,p_translate_from_id=>wwv_flow_api.id(66842365141500065)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35260546215769935)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841503270500056.103)
,p_translate_from_id=>wwv_flow_api.id(66841503270500056)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35260814884769938)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841340999500054.103)
,p_translate_from_id=>wwv_flow_api.id(66841340999500054)
,p_translate_column_id=>108
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa #MODULE_AVAILABLE#"/>'
,p_translate_from_text=>'<i class="fa #MODULE_AVAILABLE#"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35260956838769938)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841415080500055.103)
,p_translate_from_id=>wwv_flow_api.id(66841415080500055)
,p_translate_column_id=>108
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa #MODULE_ACTIVE#"/>'
,p_translate_from_text=>'<i class="fa #MODULE_ACTIVE#"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35261134127769942)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680039083093912.103)
,p_translate_from_id=>wwv_flow_api.id(66680039083093912)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Enter a unique identifier for this parameter set. The name must conform to Oracle naming conventions and must not contain special characters.'
,p_translate_from_text=>unistr('Geben Sie einen eindeutigen Bezeichner f\00FCr diese Parametergruppe ein. Der Name muss den Oracle-Benennungskonventionen entsprechen und darf keine Sonderzeichen enthalten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35261342383769942)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680308728093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680308728093914)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the parameter group to which this parameter should belong.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Parametergruppe, zu der dieser Parameter geh\00F6ren soll.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35261611609769942)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842221236500063.103)
,p_translate_from_id=>wwv_flow_api.id(66842221236500063)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Should time information be collected?'
,p_translate_from_text=>'Sollen Zeitinformationen gesammelt werden?'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35261753042769942)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125807318455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125807318455542)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message text.<br>Replacement of parameters #1# to #50# according to number value.<br>Passed parameters are numbered positionally and distributed to the replacement marks.'
,p_translate_from_text=>unistr('Meldungstext.<br>Ersetzung der Parameter #1# bis #50# gem\00E4\00DF Zahlwert.<br>\00DCbergebene Parameter werden positional nummeriert und auf die Ersetzungsmarken verteilt.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35261959902769942)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842064643500062.103)
,p_translate_from_id=>wwv_flow_api.id(66842064643500062)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Maximum trace level allowed by this context.'
,p_translate_from_text=>'Maximaler Tracelevel, der durch diesen Kontext erlaubt wird.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35262143068769942)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841978723500061.103)
,p_translate_from_id=>wwv_flow_api.id(66841978723500061)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Maximum severity allowed by this context.<br>If an output module has a lower response threshold, messages may not be output even though the threshold specified here has been undershot.'
,p_translate_from_text=>'Maximaler Schweregrad, der durch diesen Kontext erlaubt wird.<br>Sollte ein Ausgabemodule eine niedrigere Ansprechschwelle haben, kann es sein, dass Meldungen nicht ausgegeben werden, obwohl der hier angegebene Schwellwert unterschritten wurde.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35262363454769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684349104093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684349104093920)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'This attribute allows you to specify what type of text should be saved as a text parameter. This controls which editor is offered to you for editing.'
,p_translate_from_text=>unistr('Mit diesem Attribut k\00F6nnen Sie festlegen, welche Art Text als Textparameter gespeichert werden soll. Dies kontrolliert, welcher Editor Ihnen zur Bearbeitung angeboten wird.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35262573333769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125415067455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125415067455542)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message language'
,p_translate_from_text=>'Sprache der Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35262762632769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65126229613455542.103)
,p_translate_from_id=>wwv_flow_api.id(65126229613455542)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity of the error message'
,p_translate_from_text=>'Schweregrad der Fehlermeldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35262971299769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65126601904455543.103)
,p_translate_from_id=>wwv_flow_api.id(65126601904455543)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Optional error number.<br>If you don''t have to specify it for your own errors, it is used to map Oracle-defined errors to error messages.<br>If an error number is used twice, an error is thrown.<br>In particular, you must not specify an error number '
||'in the range -20999 to -20001, PIT manages this error number automatically.'
,p_translate_from_text=>'Optionale Fehlernummer.<br>Muss bei eigenen Fehlern nicht angegeben werden, dient dem Mappen Oracle-definierter Fehler auf Fehlermeldungen.<br>Wird eine Fehlernummer doppelt belegt, wird ein Fehler geworfen.<br>Insbesondere darf keine Fehlernummer im'
||' Bereich - 20999 bis -20001 angegben werden, PIT verwaltet diese Fehlernummer automatisch.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35263147526769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684689053093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684689053093920)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<p>The validation string is used to check the parameter value.</p><p>The following text anchors are available to reference the parameter value:<ul><li>#STRING#</li><li>#DATE#</li><li>#FLOAT#</li><li>#INTEGER#</li><li>#BOOLEAN#</li></ul></p>'
,p_translate_from_text=>unistr('<p>Der Validierungsstring wird genutzt, um den Parameterwert zu pr\00FCfen.</p><p>Es stehen folgende Textanker zur Verf\00FCgung, um den Parameterwert zu referenzieren:<ul><li>#STRING#</li><li>#DATE#</li><li>#FLOAT#</li><li>#INTEGER#</li><li>#BOOLEAN#</li></')
||'ul></p>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35263366640769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980449149337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980449149337495)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Optional description of the scope of the context'
,p_translate_from_text=>'Optionale Beschreibung des Einsatzbereichs des Kontexts'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35263542339769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785870054952315.103)
,p_translate_from_id=>wwv_flow_api.id(36785870054952315)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set the realm for the current environment. This has a direct effect on the parameter values if deviating parameter values have been agreed for this realm.'
,p_translate_from_text=>unistr('Setzen Sie den G\00FCltigkeitsbereich f\00FCr die aktuelle Umgebung. Dies hat direkte Auswirkungen auf die Parameterwerte, falls f\00FCr diesen G\00FCltigkeitsbereich abweichende Parameterwerte vereinbart wurden.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35263792690769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925881390871591.103)
,p_translate_from_id=>wwv_flow_api.id(54925881390871591)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the target language into which you want to translate the messages.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35264005594769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66683922355093920.103)
,p_translate_from_id=>wwv_flow_api.id(66683922355093920)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'If the group allows editing, this can be suppressed for individual parameters.'
,p_translate_from_text=>unistr('Falls die Gruppe das Editieren erlaubt, kann dies f\00FCr einzelne Parameter unterdr\00FCckt werden.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35264140359769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926805360871600.103)
,p_translate_from_id=>wwv_flow_api.id(54926805360871600)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the target language into which you want to translate the messages.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35264391124769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842308419500064.103)
,p_translate_from_id=>wwv_flow_api.id(66842308419500064)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'List of output modules that should output log information.'
,p_translate_from_text=>'Liste der Ausgabemodule, die Log-Informationen ausgeben sollen.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35264620142769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050819444643260.103)
,p_translate_from_id=>wwv_flow_api.id(67050819444643260)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Move all parameter groups you want to export to the right column.'
,p_translate_from_text=>unistr('Bewegen Sie alle Parametergruppen, die Sie exportieren m\00F6chten, in die rechte Spalte.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35264764352769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57579146689784643.103)
,p_translate_from_id=>wwv_flow_api.id(57579146689784643)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Optional Description.<br>Can be used to give additional instructions to the user in case of an error.'
,p_translate_from_text=>unistr('Optionale Beschreibung.<br>Kann verwendet werden, um im Fehlerfall zus\00E4tzliche Handlungsanweisungen an den Anwender zu geben.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35265006972769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125132723455539.103)
,p_translate_from_id=>wwv_flow_api.id(65125132723455539)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Unique name, according to naming conventions:',
'<ul><li>Capital letters</li><li>Only underscore as special characters</li><li>Error message maximum 26, others maximum 30 characters</li></ul>'))
,p_translate_from_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Eindeutiger Name, gem\00E4\00DF Benennungskonventionen:'),
unistr('<ul><li>Gro\00DFbuchstaben</li><li>Nur Unterstrich als Sonderzeichen</li><li>Fehlermeldung maximal 26, andere maximal 30 Zeichen</li></ul>')))
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35265180784769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979645348337493.103)
,p_translate_from_id=>wwv_flow_api.id(66979645348337493)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Unique identifier of the context. Without special characters and spaces. The name is case-sensitive and must conform to the naming rules of an Oracle identifier.'
,p_translate_from_text=>unistr('Eindeutiger Bezeichner des Kontexts. Ohne Sonderzeichen und Leerzeichen. Der Name wird in Gro\00DFschreibung \00FCberf\00FChrt und muss den Namensregeln eines Oracle-Bezeichners entsprechen.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35265416412769944)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680672455093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680672455093914)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Enter an optional description of the parameter.'
,p_translate_from_text=>'Geben Sie eine optionale Beschreibung des Parameters ein.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35265566952769947)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65108211589242465.103)
,p_translate_from_id=>wwv_flow_api.id(65108211589242465)
,p_translate_column_id=>112
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_translate_from_text=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35265771539770145)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(101836862781713637.103)
,p_translate_from_id=>wwv_flow_api.id(101836862781713637)
,p_translate_column_id=>237
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CodeMirror'
,p_translate_from_text=>'CodeMirror'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35265867045770147)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(101836862781713637.103)
,p_translate_from_id=>wwv_flow_api.id(101836862781713637)
,p_translate_column_id=>238
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
,p_translate_from_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35266086920770192)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680039083093912.103)
,p_translate_from_id=>wwv_flow_api.id(66680039083093912)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35266235795770192)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60162687462098215.103)
,p_translate_from_id=>wwv_flow_api.id(60162687462098215)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35266477523770192)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980023349337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980023349337495)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35266643190770192)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67004921721778009.103)
,p_translate_from_id=>wwv_flow_api.id(67004921721778009)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35266894138770192)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926593714871598.103)
,p_translate_from_id=>wwv_flow_api.id(54926593714871598)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35267038993770192)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680308728093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680308728093914)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35267311389770192)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979239436337476.103)
,p_translate_from_id=>wwv_flow_api.id(66979239436337476)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35267440246770192)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842221236500063.103)
,p_translate_from_id=>wwv_flow_api.id(66842221236500063)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35267717340770192)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843642106500077.103)
,p_translate_from_id=>wwv_flow_api.id(66843642106500077)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35267862229770192)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113439797242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113439797242486)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35268046444770194)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785049559952311.103)
,p_translate_from_id=>wwv_flow_api.id(36785049559952311)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35268289193770194)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747259522394479.103)
,p_translate_from_id=>wwv_flow_api.id(36747259522394479)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35268491959770194)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67005666462778011.103)
,p_translate_from_id=>wwv_flow_api.id(67005666462778011)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35268661858770194)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67049774227643250.103)
,p_translate_from_id=>wwv_flow_api.id(67049774227643250)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35268899985770194)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681053332093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681053332093917)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35269107235770194)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597761712735712.103)
,p_translate_from_id=>wwv_flow_api.id(54597761712735712)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35269233081770194)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66683480245093918.103)
,p_translate_from_id=>wwv_flow_api.id(66683480245093918)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35269517033770194)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125807318455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125807318455542)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35269672701770194)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842064643500062.103)
,p_translate_from_id=>wwv_flow_api.id(66842064643500062)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35269916251770194)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841978723500061.103)
,p_translate_from_id=>wwv_flow_api.id(66841978723500061)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35270116399770194)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926680969871599.103)
,p_translate_from_id=>wwv_flow_api.id(54926680969871599)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35270243629770194)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684349104093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684349104093920)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35270448514770194)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113301500242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113301500242486)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35270655787770194)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125415067455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125415067455542)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35270873125770194)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65126229613455542.103)
,p_translate_from_id=>wwv_flow_api.id(65126229613455542)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35271050359770194)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684689053093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684689053093920)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35271293573770194)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66685070109093920.103)
,p_translate_from_id=>wwv_flow_api.id(66685070109093920)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35271527284770194)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841629054500057.103)
,p_translate_from_id=>wwv_flow_api.id(66841629054500057)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35271639818770194)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67005340005778011.103)
,p_translate_from_id=>wwv_flow_api.id(67005340005778011)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35271836941770194)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006119165778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006119165778011)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35272065005770194)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578703809784638.103)
,p_translate_from_id=>wwv_flow_api.id(57578703809784638)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35272303203770194)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66840808326500049.103)
,p_translate_from_id=>wwv_flow_api.id(66840808326500049)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35272432377770194)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980449149337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980449149337495)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35272670148770195)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980808771337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980808771337495)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35272865764770195)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844562592500087.103)
,p_translate_from_id=>wwv_flow_api.id(66844562592500087)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35273116751770195)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785870054952315.103)
,p_translate_from_id=>wwv_flow_api.id(36785870054952315)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35273313155770195)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925881390871591.103)
,p_translate_from_id=>wwv_flow_api.id(54925881390871591)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35273520259770195)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60446934961471480.103)
,p_translate_from_id=>wwv_flow_api.id(60446934961471480)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35273653898770195)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66683922355093920.103)
,p_translate_from_id=>wwv_flow_api.id(66683922355093920)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'1'
,p_translate_from_text=>'1'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35273861884770195)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65124735177455522.103)
,p_translate_from_id=>wwv_flow_api.id(65124735177455522)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35274101024770195)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842308419500064.103)
,p_translate_from_id=>wwv_flow_api.id(66842308419500064)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35274325258770195)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050819444643260.103)
,p_translate_from_id=>wwv_flow_api.id(67050819444643260)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'MOVE'
,p_translate_from_text=>'MOVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35274509825770195)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926805360871600.103)
,p_translate_from_id=>wwv_flow_api.id(54926805360871600)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35274659411770195)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60447001249471481.103)
,p_translate_from_id=>wwv_flow_api.id(60447001249471481)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35274864239770195)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125132723455539.103)
,p_translate_from_id=>wwv_flow_api.id(65125132723455539)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35275033368770195)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57579146689784643.103)
,p_translate_from_id=>wwv_flow_api.id(57579146689784643)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35275304829770195)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979645348337493.103)
,p_translate_from_id=>wwv_flow_api.id(66979645348337493)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35275477197770195)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785417774952314.103)
,p_translate_from_id=>wwv_flow_api.id(36785417774952314)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35275728311770195)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680672455093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680672455093914)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35275882626770195)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926070829871593.103)
,p_translate_from_id=>wwv_flow_api.id(54926070829871593)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35276066639770195)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928871907871621.103)
,p_translate_from_id=>wwv_flow_api.id(54928871907871621)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APEX_APPLICATION_TEMP_FILES'
,p_translate_from_text=>'APEX_APPLICATION_TEMP_FILES'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35276280568770195)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54929143107871624.103)
,p_translate_from_id=>wwv_flow_api.id(54929143107871624)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APEX_APPLICATION_TEMP_FILES'
,p_translate_from_text=>'APEX_APPLICATION_TEMP_FILES'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35276486094770199)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680039083093912.103)
,p_translate_from_id=>wwv_flow_api.id(66680039083093912)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35276695260770199)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67004921721778009.103)
,p_translate_from_id=>wwv_flow_api.id(67004921721778009)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35276912203770199)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680308728093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680308728093914)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35277062133770199)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747259522394479.103)
,p_translate_from_id=>wwv_flow_api.id(36747259522394479)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35277265326770199)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67005666462778011.103)
,p_translate_from_id=>wwv_flow_api.id(67005666462778011)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35277497888770199)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681053332093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681053332093917)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35277700000770199)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597761712735712.103)
,p_translate_from_id=>wwv_flow_api.id(54597761712735712)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35277903494770199)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125807318455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125807318455542)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35278111005770199)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842064643500062.103)
,p_translate_from_id=>wwv_flow_api.id(66842064643500062)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35278287533770199)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66841978723500061.103)
,p_translate_from_id=>wwv_flow_api.id(66841978723500061)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35278511492770199)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926680969871599.103)
,p_translate_from_id=>wwv_flow_api.id(54926680969871599)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35278659565770200)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684349104093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684349104093920)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35278837511770200)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113301500242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113301500242486)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35279063443770200)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125415067455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125415067455542)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35279239713770200)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65126229613455542.103)
,p_translate_from_id=>wwv_flow_api.id(65126229613455542)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35279474928770200)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684689053093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684689053093920)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35279664627770200)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66685070109093920.103)
,p_translate_from_id=>wwv_flow_api.id(66685070109093920)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35279831283770200)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006119165778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006119165778011)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35280104285770200)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578703809784638.103)
,p_translate_from_id=>wwv_flow_api.id(57578703809784638)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35280248885770200)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66840808326500049.103)
,p_translate_from_id=>wwv_flow_api.id(66840808326500049)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35280485459770200)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980449149337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980449149337495)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35280637569770200)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36785870054952315.103)
,p_translate_from_id=>wwv_flow_api.id(36785870054952315)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35280881772770200)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925881390871591.103)
,p_translate_from_id=>wwv_flow_api.id(54925881390871591)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35281040841770200)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60446934961471480.103)
,p_translate_from_id=>wwv_flow_api.id(60446934961471480)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35281258325770200)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926805360871600.103)
,p_translate_from_id=>wwv_flow_api.id(54926805360871600)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35281460519770200)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60447001249471481.103)
,p_translate_from_id=>wwv_flow_api.id(60447001249471481)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35281707173770200)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125132723455539.103)
,p_translate_from_id=>wwv_flow_api.id(65125132723455539)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35281863492770200)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57579146689784643.103)
,p_translate_from_id=>wwv_flow_api.id(57579146689784643)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35282099547770200)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979645348337493.103)
,p_translate_from_id=>wwv_flow_api.id(66979645348337493)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35282257207770200)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680672455093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680672455093914)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35282479612770200)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926070829871593.103)
,p_translate_from_id=>wwv_flow_api.id(54926070829871593)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35282655550770203)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681053332093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681053332093917)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35282919539770203)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597761712735712.103)
,p_translate_from_id=>wwv_flow_api.id(54597761712735712)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35283110411770203)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681528500093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681528500093917)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35283255231770203)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125807318455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125807318455542)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35283455832770203)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65126601904455543.103)
,p_translate_from_id=>wwv_flow_api.id(65126601904455543)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35283703497770205)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980449149337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980449149337495)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35283893520770205)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681851360093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681851360093917)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35284088846770205)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57579146689784643.103)
,p_translate_from_id=>wwv_flow_api.id(57579146689784643)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35284321901770206)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680039083093912.103)
,p_translate_from_id=>wwv_flow_api.id(66680039083093912)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35284502756770206)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67004921721778009.103)
,p_translate_from_id=>wwv_flow_api.id(67004921721778009)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35284642212770206)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747259522394479.103)
,p_translate_from_id=>wwv_flow_api.id(36747259522394479)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35284862982770206)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66681053332093917.103)
,p_translate_from_id=>wwv_flow_api.id(66681053332093917)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35285031636770206)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597761712735712.103)
,p_translate_from_id=>wwv_flow_api.id(54597761712735712)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35285247680770206)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682701121093918.103)
,p_translate_from_id=>wwv_flow_api.id(66682701121093918)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35285431657770206)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125807318455542.103)
,p_translate_from_id=>wwv_flow_api.id(65125807318455542)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35285726121770206)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926680969871599.103)
,p_translate_from_id=>wwv_flow_api.id(54926680969871599)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35285871466770206)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113301500242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113301500242486)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35286127741770206)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684689053093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684689053093920)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35286289119770206)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66685070109093920.103)
,p_translate_from_id=>wwv_flow_api.id(66685070109093920)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35286483454770206)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006119165778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006119165778011)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35286646631770208)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66980449149337495.103)
,p_translate_from_id=>wwv_flow_api.id(66980449149337495)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35286929212770208)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682294712093917.103)
,p_translate_from_id=>wwv_flow_api.id(66682294712093917)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35287060997770208)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125132723455539.103)
,p_translate_from_id=>wwv_flow_api.id(65125132723455539)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35287241865770208)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57579146689784643.103)
,p_translate_from_id=>wwv_flow_api.id(57579146689784643)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35287452564770208)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979645348337493.103)
,p_translate_from_id=>wwv_flow_api.id(66979645348337493)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35287667116770208)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680672455093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680672455093914)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35287852488770208)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926070829871593.103)
,p_translate_from_id=>wwv_flow_api.id(54926070829871593)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35288111994770210)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680039083093912.103)
,p_translate_from_id=>wwv_flow_api.id(66680039083093912)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35288316753770211)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67004921721778009.103)
,p_translate_from_id=>wwv_flow_api.id(67004921721778009)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35288479282770211)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682701121093918.103)
,p_translate_from_id=>wwv_flow_api.id(66682701121093918)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35288643424770211)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113301500242486.103)
,p_translate_from_id=>wwv_flow_api.id(65113301500242486)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35288882772770211)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66684689053093920.103)
,p_translate_from_id=>wwv_flow_api.id(66684689053093920)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35289083702770211)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66685070109093920.103)
,p_translate_from_id=>wwv_flow_api.id(66685070109093920)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35289243992770211)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006119165778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006119165778011)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35289485071770211)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682294712093917.103)
,p_translate_from_id=>wwv_flow_api.id(66682294712093917)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35289713418770211)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65125132723455539.103)
,p_translate_from_id=>wwv_flow_api.id(65125132723455539)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35289880285770211)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66979645348337493.103)
,p_translate_from_id=>wwv_flow_api.id(66979645348337493)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35290054966770211)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66680672455093914.103)
,p_translate_from_id=>wwv_flow_api.id(66680672455093914)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35290315436770214)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682294712093917.103)
,p_translate_from_id=>wwv_flow_api.id(66682294712093917)
,p_translate_column_id=>274
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35290471338770214)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66682701121093918.103)
,p_translate_from_id=>wwv_flow_api.id(66682701121093918)
,p_translate_column_id=>274
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35290692105770219)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928871907871621.103)
,p_translate_from_id=>wwv_flow_api.id(54928871907871621)
,p_translate_column_id=>276
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'REQUEST'
,p_translate_from_text=>'REQUEST'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35290844185770219)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54929143107871624.103)
,p_translate_from_id=>wwv_flow_api.id(54929143107871624)
,p_translate_column_id=>276
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'REQUEST'
,p_translate_from_text=>'REQUEST'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35291069355770220)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928871907871621.103)
,p_translate_from_id=>wwv_flow_api.id(54928871907871621)
,p_translate_column_id=>277
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35291272731770220)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54929143107871624.103)
,p_translate_from_id=>wwv_flow_api.id(54929143107871624)
,p_translate_column_id=>277
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35291502318770224)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36790746128952326.103)
,p_translate_from_id=>wwv_flow_api.id(36790746128952326)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35291714342770224)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66983611124337500.103)
,p_translate_from_id=>wwv_flow_api.id(66983611124337500)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35291859464770224)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65129742314455547.103)
,p_translate_from_id=>wwv_flow_api.id(65129742314455547)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35292111491770224)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60445767550471469.103)
,p_translate_from_id=>wwv_flow_api.id(60445767550471469)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35292245115770224)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54850770319430776.103)
,p_translate_from_id=>wwv_flow_api.id(54850770319430776)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35292496289770224)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595240567735687.103)
,p_translate_from_id=>wwv_flow_api.id(54595240567735687)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35292662150770224)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842491045500066.103)
,p_translate_from_id=>wwv_flow_api.id(66842491045500066)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35292844384770224)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66687524947093923.103)
,p_translate_from_id=>wwv_flow_api.id(66687524947093923)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35293096032770224)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42605783860983566.103)
,p_translate_from_id=>wwv_flow_api.id(42605783860983566)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35293318932770224)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66687883314093923.103)
,p_translate_from_id=>wwv_flow_api.id(66687883314093923)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35293500283770224)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006467667778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006467667778011)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35293717021770224)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55087745003622353.103)
,p_translate_from_id=>wwv_flow_api.id(55087745003622353)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35293873303770224)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113894861242487.103)
,p_translate_from_id=>wwv_flow_api.id(65113894861242487)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35294067905770230)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36790746128952326.103)
,p_translate_from_id=>wwv_flow_api.id(36790746128952326)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_set_realm;'
,p_translate_from_text=>'pit_ui.process_set_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35294232201770230)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60445767550471469.103)
,p_translate_from_id=>wwv_flow_api.id(60445767550471469)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_pms;'
,p_translate_from_text=>'pit_ui.process_edit_pms;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35294467994770230)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54850770319430776.103)
,p_translate_from_id=>wwv_flow_api.id(54850770319430776)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_module;'
,p_translate_from_text=>'pit_ui.process_edit_module;'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35294683016770230)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595240567735687.103)
,p_translate_from_id=>wwv_flow_api.id(54595240567735687)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_pgr;'
,p_translate_from_text=>'pit_ui.process_edit_pgr;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35294879516770230)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842491045500066.103)
,p_translate_from_id=>wwv_flow_api.id(66842491045500066)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_context;'
,p_translate_from_text=>'pit_ui.process_edit_context;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35295121938770231)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66687524947093923.103)
,p_translate_from_id=>wwv_flow_api.id(66687524947093923)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_par;'
,p_translate_from_text=>'pit_ui.process_edit_par;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35295267668770231)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42605783860983566.103)
,p_translate_from_id=>wwv_flow_api.id(42605783860983566)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_par_realm;'
,p_translate_from_text=>'pit_ui.process_edit_par_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35295508927770231)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006467667778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006467667778011)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_toggle;'
,p_translate_from_text=>'pit_ui.process_edit_toggle;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35295680847770231)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55087745003622353.103)
,p_translate_from_id=>wwv_flow_api.id(55087745003622353)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_pmg;'
,p_translate_from_text=>'pit_ui.process_edit_pmg;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35295927506770233)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36790746128952326.103)
,p_translate_from_id=>wwv_flow_api.id(36790746128952326)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35296123445770233)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60445767550471469.103)
,p_translate_from_id=>wwv_flow_api.id(60445767550471469)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35296272772770233)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54850770319430776.103)
,p_translate_from_id=>wwv_flow_api.id(54850770319430776)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35296462996770233)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595240567735687.103)
,p_translate_from_id=>wwv_flow_api.id(54595240567735687)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35296671888770233)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842491045500066.103)
,p_translate_from_id=>wwv_flow_api.id(66842491045500066)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35296861252770233)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66687524947093923.103)
,p_translate_from_id=>wwv_flow_api.id(66687524947093923)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35297080247770233)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42605783860983566.103)
,p_translate_from_id=>wwv_flow_api.id(42605783860983566)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35297327178770233)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006467667778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006467667778011)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35297434040770233)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55087745003622353.103)
,p_translate_from_id=>wwv_flow_api.id(55087745003622353)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35297656839770236)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36790746128952326.103)
,p_translate_from_id=>wwv_flow_api.id(36790746128952326)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35297896199770236)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60445767550471469.103)
,p_translate_from_id=>wwv_flow_api.id(60445767550471469)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35298112219770236)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54850770319430776.103)
,p_translate_from_id=>wwv_flow_api.id(54850770319430776)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35298286725770236)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595240567735687.103)
,p_translate_from_id=>wwv_flow_api.id(54595240567735687)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35298455354770236)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842491045500066.103)
,p_translate_from_id=>wwv_flow_api.id(66842491045500066)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35298675980770236)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66687524947093923.103)
,p_translate_from_id=>wwv_flow_api.id(66687524947093923)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35298908452770236)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42605783860983566.103)
,p_translate_from_id=>wwv_flow_api.id(42605783860983566)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35299060818770236)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67006467667778011.103)
,p_translate_from_id=>wwv_flow_api.id(67006467667778011)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35299237521770236)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55087745003622353.103)
,p_translate_from_id=>wwv_flow_api.id(55087745003622353)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35299486671770245)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843751422500079.103)
,p_translate_from_id=>wwv_flow_api.id(66843751422500079)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35299645790770245)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66843889686500080.103)
,p_translate_from_id=>wwv_flow_api.id(66843889686500080)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35299882753770245)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598053861735715.103)
,p_translate_from_id=>wwv_flow_api.id(54598053861735715)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35300078203770245)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926188751871594.103)
,p_translate_from_id=>wwv_flow_api.id(54926188751871594)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'condes.pit.utils.controlExportItems();'
,p_translate_from_text=>'condes.pit.utils.controlExportItems();'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35300328117770245)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60447401781471485.103)
,p_translate_from_id=>wwv_flow_api.id(60447401781471485)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35300491712770245)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928283379871615.103)
,p_translate_from_id=>wwv_flow_api.id(54928283379871615)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''PMG_NAME'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''PMG_NAME'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35300700144770245)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60447515661471486.103)
,p_translate_from_id=>wwv_flow_api.id(60447515661471486)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35300886370770245)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598278275735717.103)
,p_translate_from_id=>wwv_flow_api.id(54598278275735717)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'STATIC_ASSIGNMENT'
,p_translate_from_text=>'STATIC_ASSIGNMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35301109954770247)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578840298784640.103)
,p_translate_from_id=>wwv_flow_api.id(57578840298784640)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''P3_PMS_NAME'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''P3_PMS_NAME'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35301317879770247)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928527201871618.103)
,p_translate_from_id=>wwv_flow_api.id(54928527201871618)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''PGR_ID'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''PGR_ID'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35301456868770247)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844869845500090.103)
,p_translate_from_id=>wwv_flow_api.id(66844869845500090)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35301658769770247)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844979127500091.103)
,p_translate_from_id=>wwv_flow_api.id(66844979127500091)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35301903552770247)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747455102394481.103)
,p_translate_from_id=>wwv_flow_api.id(36747455102394481)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'SQL_STATEMENT'
,p_translate_from_text=>'SQL_STATEMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35302108651770247)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598136114735716.103)
,p_translate_from_id=>wwv_flow_api.id(54598136114735716)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'STATIC_ASSIGNMENT'
,p_translate_from_text=>'STATIC_ASSIGNMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35302289856770247)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844293587500084.103)
,p_translate_from_id=>wwv_flow_api.id(66844293587500084)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.set_allow_toggles;'
,p_translate_from_text=>'pit_ui.set_allow_toggles;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35302436694770247)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844357491500085.103)
,p_translate_from_id=>wwv_flow_api.id(66844357491500085)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.set_allow_toggles;'
,p_translate_from_text=>'pit_ui.set_allow_toggles;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35302661976770249)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928283379871615.103)
,p_translate_from_id=>wwv_flow_api.id(54928283379871615)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PMG_NAME'
,p_translate_from_text=>'PMG_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35302896216770249)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578840298784640.103)
,p_translate_from_id=>wwv_flow_api.id(57578840298784640)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P3_PMS_NAME'
,p_translate_from_text=>'P3_PMS_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35303117282770249)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928527201871618.103)
,p_translate_from_id=>wwv_flow_api.id(54928527201871618)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PGR_ID'
,p_translate_from_text=>'PGR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35303272030770249)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598136114735716.103)
,p_translate_from_id=>wwv_flow_api.id(54598136114735716)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'-20000'
,p_translate_from_text=>'-20000'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35303520021770249)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844293587500084.103)
,p_translate_from_id=>wwv_flow_api.id(66844293587500084)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P9_ALLOW_TOGGLE'
,p_translate_from_text=>'P9_ALLOW_TOGGLE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35303652995770249)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844357491500085.103)
,p_translate_from_id=>wwv_flow_api.id(66844357491500085)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P9_ALLOW_TOGGLE'
,p_translate_from_text=>'P9_ALLOW_TOGGLE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35303846994770252)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928283379871615.103)
,p_translate_from_id=>wwv_flow_api.id(54928283379871615)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PMG_NAME'
,p_translate_from_text=>'PMG_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35304090657770252)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578840298784640.103)
,p_translate_from_id=>wwv_flow_api.id(57578840298784640)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P3_PMS_NAME'
,p_translate_from_text=>'P3_PMS_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35304319458770252)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928527201871618.103)
,p_translate_from_id=>wwv_flow_api.id(54928527201871618)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PGR_ID'
,p_translate_from_text=>'PGR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35304459172770252)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747455102394481.103)
,p_translate_from_id=>wwv_flow_api.id(36747455102394481)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from pit_ui_admin_par_realm'))
,p_translate_from_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from pit_ui_admin_par_realm'))
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35304710522770253)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928283379871615.103)
,p_translate_from_id=>wwv_flow_api.id(54928283379871615)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35304915623770253)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578840298784640.103)
,p_translate_from_id=>wwv_flow_api.id(57578840298784640)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35305065927770253)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928527201871618.103)
,p_translate_from_id=>wwv_flow_api.id(54928527201871618)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35305246133770256)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928283379871615.103)
,p_translate_from_id=>wwv_flow_api.id(54928283379871615)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35305436011770256)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57578840298784640.103)
,p_translate_from_id=>wwv_flow_api.id(57578840298784640)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35305682139770256)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928527201871618.103)
,p_translate_from_id=>wwv_flow_api.id(54928527201871618)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35305894718770256)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844293587500084.103)
,p_translate_from_id=>wwv_flow_api.id(66844293587500084)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35306102361770256)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66844357491500085.103)
,p_translate_from_id=>wwv_flow_api.id(66844357491500085)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35306245607770261)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747455102394481.103)
,p_translate_from_id=>wwv_flow_api.id(36747455102394481)
,p_translate_column_id=>295
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35306514022770263)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598136114735716.103)
,p_translate_from_id=>wwv_flow_api.id(54598136114735716)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35306712797770263)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598278275735717.103)
,p_translate_from_id=>wwv_flow_api.id(54598278275735717)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35306851883770264)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36747455102394481.103)
,p_translate_from_id=>wwv_flow_api.id(36747455102394481)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35307089530770267)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(50372885796048450.103)
,p_translate_from_id=>wwv_flow_api.id(50372885796048450)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35307290849770267)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65070003066242432.103)
,p_translate_from_id=>wwv_flow_api.id(65070003066242432)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35307484518770267)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65070149230242432.103)
,p_translate_from_id=>wwv_flow_api.id(65070149230242432)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35307690382770267)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57533765342517549.103)
,p_translate_from_id=>wwv_flow_api.id(57533765342517549)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'classic'
,p_translate_from_text=>'classic'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35307864397770267)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(57533722363517549.103)
,p_translate_from_id=>wwv_flow_api.id(57533722363517549)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'LEGACY'
,p_translate_from_text=>'LEGACY'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35308109340770269)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(33808566228411250.103)
,p_translate_from_id=>wwv_flow_api.id(33808566228411250)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'fa-star'
,p_translate_from_text=>'fa-star'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35308261278770269)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(33808036990411249.103)
,p_translate_from_id=>wwv_flow_api.id(33808036990411249)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35308492053770270)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(33808036990411249.103)
,p_translate_from_id=>wwv_flow_api.id(33808036990411249)
,p_translate_column_id=>299
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35308856846770272)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65070149230242432.103)
,p_translate_from_id=>wwv_flow_api.id(65070149230242432)
,p_translate_column_id=>300
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35309117866770274)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(33808566228411250.103)
,p_translate_from_id=>wwv_flow_api.id(33808566228411250)
,p_translate_column_id=>301
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'#VALUE#'
,p_translate_from_text=>'#VALUE#'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35309482037770277)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65070149230242432.103)
,p_translate_from_id=>wwv_flow_api.id(65070149230242432)
,p_translate_column_id=>302
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'SWITCH_CB'
,p_translate_from_text=>'SWITCH_CB'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35309633720770286)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676206462093804.103)
,p_translate_from_id=>wwv_flow_api.id(66676206462093804)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35309881998770286)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65121562455455431.103)
,p_translate_from_id=>wwv_flow_api.id(65121562455455431)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35310075993770286)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976400553337472.103)
,p_translate_from_id=>wwv_flow_api.id(66976400553337472)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35310269162770288)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926326939871596.103)
,p_translate_from_id=>wwv_flow_api.id(54926326939871596)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35310499033770288)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36787148153952320.103)
,p_translate_from_id=>wwv_flow_api.id(36787148153952320)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35310709928770288)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54927208264871604.103)
,p_translate_from_id=>wwv_flow_api.id(54927208264871604)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35310917887770288)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676906611093807.103)
,p_translate_from_id=>wwv_flow_api.id(66676906611093807)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35311035085770288)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67003048652778007.103)
,p_translate_from_id=>wwv_flow_api.id(67003048652778007)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35311296758770288)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595776551735692.103)
,p_translate_from_id=>wwv_flow_api.id(54595776551735692)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35311487487770288)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113157351242482.103)
,p_translate_from_id=>wwv_flow_api.id(65113157351242482)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35311711945770288)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050222698643254.103)
,p_translate_from_id=>wwv_flow_api.id(67050222698643254)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35311892567770288)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926228509871595.103)
,p_translate_from_id=>wwv_flow_api.id(54926228509871595)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35312058290770288)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926501632871597.103)
,p_translate_from_id=>wwv_flow_api.id(54926501632871597)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35312321580770288)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65120874444455431.103)
,p_translate_from_id=>wwv_flow_api.id(65120874444455431)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35312451960770288)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842814969500069.103)
,p_translate_from_id=>wwv_flow_api.id(66842814969500069)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35312635995770288)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598597167735720.103)
,p_translate_from_id=>wwv_flow_api.id(54598597167735720)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35312926572770288)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050283919643255.103)
,p_translate_from_id=>wwv_flow_api.id(67050283919643255)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35313070934770288)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66975730920337472.103)
,p_translate_from_id=>wwv_flow_api.id(66975730920337472)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35313278174770288)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67002296032778007.103)
,p_translate_from_id=>wwv_flow_api.id(67002296032778007)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35313431977770291)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676206462093804.103)
,p_translate_from_id=>wwv_flow_api.id(66676206462093804)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35313715712770291)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65121562455455431.103)
,p_translate_from_id=>wwv_flow_api.id(65121562455455431)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35313917687770291)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976400553337472.103)
,p_translate_from_id=>wwv_flow_api.id(66976400553337472)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35314112441770291)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926326939871596.103)
,p_translate_from_id=>wwv_flow_api.id(54926326939871596)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35314290991770291)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36787148153952320.103)
,p_translate_from_id=>wwv_flow_api.id(36787148153952320)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35314525032770291)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54927208264871604.103)
,p_translate_from_id=>wwv_flow_api.id(54927208264871604)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35314674832770291)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676906611093807.103)
,p_translate_from_id=>wwv_flow_api.id(66676906611093807)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35314926699770291)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67003048652778007.103)
,p_translate_from_id=>wwv_flow_api.id(67003048652778007)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35315113051770291)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595776551735692.103)
,p_translate_from_id=>wwv_flow_api.id(54595776551735692)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35315266410770291)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113157351242482.103)
,p_translate_from_id=>wwv_flow_api.id(65113157351242482)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35315504603770291)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050222698643254.103)
,p_translate_from_id=>wwv_flow_api.id(67050222698643254)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35315705210770291)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926228509871595.103)
,p_translate_from_id=>wwv_flow_api.id(54926228509871595)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35315848724770291)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54926501632871597.103)
,p_translate_from_id=>wwv_flow_api.id(54926501632871597)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35316122286770291)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65120874444455431.103)
,p_translate_from_id=>wwv_flow_api.id(65120874444455431)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35316291525770291)
,p_page_id=>9
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66842814969500069.103)
,p_translate_from_id=>wwv_flow_api.id(66842814969500069)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35316497375770292)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54598597167735720.103)
,p_translate_from_id=>wwv_flow_api.id(54598597167735720)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35316662808770292)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67050283919643255.103)
,p_translate_from_id=>wwv_flow_api.id(67050283919643255)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35316904264770292)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66975730920337472.103)
,p_translate_from_id=>wwv_flow_api.id(66975730920337472)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35317035583770292)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67002296032778007.103)
,p_translate_from_id=>wwv_flow_api.id(67002296032778007)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35317245853770294)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676206462093804.103)
,p_translate_from_id=>wwv_flow_api.id(66676206462093804)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35317432931770294)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65121562455455431.103)
,p_translate_from_id=>wwv_flow_api.id(65121562455455431)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35317728966770294)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66976400553337472.103)
,p_translate_from_id=>wwv_flow_api.id(66976400553337472)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35317852859770294)
,p_page_id=>5
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(36787148153952320.103)
,p_translate_from_id=>wwv_flow_api.id(36787148153952320)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35318069279770294)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66676906611093807.103)
,p_translate_from_id=>wwv_flow_api.id(66676906611093807)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35318265368770294)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67003048652778007.103)
,p_translate_from_id=>wwv_flow_api.id(67003048652778007)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35318470442770294)
,p_page_id=>101
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65113157351242482.103)
,p_translate_from_id=>wwv_flow_api.id(65113157351242482)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35318688361770294)
,p_page_id=>3
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65120874444455431.103)
,p_translate_from_id=>wwv_flow_api.id(65120874444455431)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35318923854770295)
,p_page_id=>10
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66975730920337472.103)
,p_translate_from_id=>wwv_flow_api.id(66975730920337472)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35319084407770295)
,p_page_id=>12
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67002296032778007.103)
,p_translate_from_id=>wwv_flow_api.id(67002296032778007)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35319233163770310)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928871907871621.103)
,p_translate_from_id=>wwv_flow_api.id(54928871907871621)
,p_translate_column_id=>318
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'application/xliff+xml'
,p_translate_from_text=>'application/xliff+xml'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35319445350770310)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54929143107871624.103)
,p_translate_from_id=>wwv_flow_api.id(54929143107871624)
,p_translate_column_id=>318
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'application/xliff+xml'
,p_translate_from_text=>'application/xliff+xml'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35319672390770311)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928871907871621.103)
,p_translate_from_id=>wwv_flow_api.id(54928871907871621)
,p_translate_column_id=>319
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NATIVE'
,p_translate_from_text=>'NATIVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35319800225770311)
,p_page_id=>16
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54929143107871624.103)
,p_translate_from_id=>wwv_flow_api.id(54929143107871624)
,p_translate_column_id=>319
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NATIVE'
,p_translate_from_text=>'NATIVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35320027720770411)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67021056300071639.103)
,p_translate_from_id=>wwv_flow_api.id(67021056300071639)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung und Export')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35320083953770411)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65913741045348034.103)
,p_translate_from_id=>wwv_flow_api.id(65913741045348034)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create and edit parameter values'
,p_translate_from_text=>'Parameter erstellen und editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35320310886770411)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66866425467799726.103)
,p_translate_from_id=>wwv_flow_api.id(66866425467799726)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer actual PIT settings'
,p_translate_from_text=>'Einsatzeinstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35320477750770411)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65130838539455550.103)
,p_translate_from_id=>wwv_flow_api.id(65130838539455550)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create, edit and translate messages'
,p_translate_from_text=>'Meldungen erzeugen und editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35320665213770414)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(67021056300071639.103)
,p_translate_from_id=>wwv_flow_api.id(67021056300071639)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Allows the creation of script files for export or translation'
,p_translate_from_text=>unistr('Erlaubt die Erstellung von Skriptdateien zum Export oder zum \00DCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35320906008770414)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(66866425467799726.103)
,p_translate_from_id=>wwv_flow_api.id(66866425467799726)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Controls contexts, toggles and shows the current parameterization'
,p_translate_from_text=>'Kontrolliert Kontexte, Toggles und zeigt die aktuelle Parametrierung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35321034061770414)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65130838539455550.103)
,p_translate_from_id=>wwv_flow_api.id(65130838539455550)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Management of new messages and modification of existing ones'
,p_translate_from_text=>unistr('Verwaltung neuer Meldungen und \00C4nderung bestehender')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35321276635770449)
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(65112713542242473.103)
,p_translate_from_id=>wwv_flow_api.id(65112713542242473)
,p_translate_column_id=>397
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Desktop'
,p_translate_from_text=>'Desktop'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35321442081770483)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55086568371622351.103)
,p_translate_from_id=>wwv_flow_api.id(55086568371622351)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message Amt.'
,p_translate_from_text=>'Anzahl Meldungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35321657781770485)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54845355467430771.103)
,p_translate_from_id=>wwv_flow_api.id(54845355467430771)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Id'
,p_translate_from_text=>'Par Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35321831930770485)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(20947274508809095.103)
,p_translate_from_id=>wwv_flow_api.id(20947274508809095)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Pms Pse Id'
,p_translate_from_text=>'Pms Pse Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35322085123770485)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856216411958685.103)
,p_translate_from_id=>wwv_flow_api.id(63856216411958685)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error ID'
,p_translate_from_text=>'Fehler-ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35322264250770485)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606847128983577.103)
,p_translate_from_id=>wwv_flow_api.id(42606847128983577)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Boolean value'
,p_translate_from_text=>'Wahrheitswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35322461196770485)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54850160640430774.103)
,p_translate_from_id=>wwv_flow_api.id(54850160640430774)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Flag'
,p_translate_from_text=>'Flag'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35322638354770485)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54594883933735683.103)
,p_translate_from_id=>wwv_flow_api.id(54594883933735683)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'modifizierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35322848639770485)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855971534958683.103)
,p_translate_from_id=>wwv_flow_api.id(63855971534958683)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text'
,p_translate_from_text=>'Text'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35323121329770485)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60162868494098216.103)
,p_translate_from_id=>wwv_flow_api.id(60162868494098216)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35323265054770485)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606344191983572.103)
,p_translate_from_id=>wwv_flow_api.id(42606344191983572)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text value'
,p_translate_from_text=>'Textwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35323495423770485)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928727563871620.103)
,p_translate_from_id=>wwv_flow_api.id(54928727563871620)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter Amt.'
,p_translate_from_text=>'Anz. Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35323637405770485)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855668685958680.103)
,p_translate_from_id=>wwv_flow_api.id(63855668685958680)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35323911700770485)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856317482958686.103)
,p_translate_from_id=>wwv_flow_api.id(63856317482958686)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error number'
,p_translate_from_text=>'Fehlernr'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35324043349770485)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596714714735701.103)
,p_translate_from_id=>wwv_flow_api.id(54596714714735701)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text type'
,p_translate_from_text=>'Texttyp'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35324273215770485)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55086013119622351.103)
,p_translate_from_id=>wwv_flow_api.id(55086013119622351)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35324503181770485)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606663326983575.103)
,p_translate_from_id=>wwv_flow_api.id(42606663326983575)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date value'
,p_translate_from_text=>'Datumswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35324702762770485)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54846526475430773.103)
,p_translate_from_id=>wwv_flow_api.id(54846526475430773)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35324908371770485)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54847166342430773.103)
,p_translate_from_id=>wwv_flow_api.id(54847166342430773)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'String'
,p_translate_from_text=>'Zeichenkette'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35325059058770485)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925110440871583.103)
,p_translate_from_id=>wwv_flow_api.id(54925110440871583)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'overwritten'
,p_translate_from_text=>unistr('\00FCberschrieben')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35325253012770485)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596243752735697.103)
,p_translate_from_id=>wwv_flow_api.id(54596243752735697)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35325444260770486)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855811535958681.103)
,p_translate_from_id=>wwv_flow_api.id(63855811535958681)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language ID'
,p_translate_from_text=>'Sprache-ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35325717850770486)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(20947353237809096.103)
,p_translate_from_id=>wwv_flow_api.id(20947353237809096)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Validation String'
,p_translate_from_text=>'Par Validation String'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35325912033770486)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597905884735713.103)
,p_translate_from_id=>wwv_flow_api.id(54597905884735713)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter value'
,p_translate_from_text=>'Parameterwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35326112029770486)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606713986983576.103)
,p_translate_from_id=>wwv_flow_api.id(42606713986983576)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp value'
,p_translate_from_text=>'Zeitstempelwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35326312276770486)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54594629112735681.103)
,p_translate_from_id=>wwv_flow_api.id(54594629112735681)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35326443032770486)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54848345629430774.103)
,p_translate_from_id=>wwv_flow_api.id(54848345629430774)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number'
,p_translate_from_text=>'Zahl'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35326658630770486)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606412036983573.103)
,p_translate_from_id=>wwv_flow_api.id(42606412036983573)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer value'
,p_translate_from_text=>'Ganzzahlwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35326863069770486)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54847753390430773.103)
,p_translate_from_id=>wwv_flow_api.id(54847753390430773)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer'
,p_translate_from_text=>'Ganzzahl'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35327062896770486)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55085396414622349.103)
,p_translate_from_id=>wwv_flow_api.id(55085396414622349)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35327249149770486)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42605901615983568.103)
,p_translate_from_id=>wwv_flow_api.id(42605901615983568)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Area'
,p_translate_from_text=>'Bereich'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35327468368770486)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54849573820430774.103)
,p_translate_from_id=>wwv_flow_api.id(54849573820430774)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp'
,p_translate_from_text=>'Zeitstempel'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35327632531770486)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855549759958679.103)
,p_translate_from_id=>wwv_flow_api.id(63855549759958679)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35327924653770486)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856044012958684.103)
,p_translate_from_id=>wwv_flow_api.id(63856044012958684)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity'
,p_translate_from_text=>'Schweregrad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35328083087770486)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856398560958687.103)
,p_translate_from_id=>wwv_flow_api.id(63856398560958687)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35328257373770486)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596407683735698.103)
,p_translate_from_id=>wwv_flow_api.id(54596407683735698)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Pgr id'
,p_translate_from_text=>'Pgr id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35328461139770486)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596531652735700.103)
,p_translate_from_id=>wwv_flow_api.id(54596531652735700)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35328650175770486)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855935114958682.103)
,p_translate_from_id=>wwv_flow_api.id(63855935114958682)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35328907292770486)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597514952735709.103)
,p_translate_from_id=>wwv_flow_api.id(54597514952735709)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'modifizierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35329086782770486)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54594824761735682.103)
,p_translate_from_id=>wwv_flow_api.id(54594824761735682)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35329307886770486)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54845999483430773.103)
,p_translate_from_id=>wwv_flow_api.id(54845999483430773)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Pgr Id'
,p_translate_from_text=>'Par Pgr Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35329512941770488)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54848972860430774.103)
,p_translate_from_id=>wwv_flow_api.id(54848972860430774)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date'
,p_translate_from_text=>'Datum'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35329660881770488)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596511194735699.103)
,p_translate_from_id=>wwv_flow_api.id(54596511194735699)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35329843107770488)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606557968983574.103)
,p_translate_from_id=>wwv_flow_api.id(42606557968983574)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number value'
,p_translate_from_text=>unistr('Flie\00DFkommazahlwert')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35330114053770489)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54845355467430771.103)
,p_translate_from_id=>wwv_flow_api.id(54845355467430771)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35330269425770489)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606847128983577.103)
,p_translate_from_id=>wwv_flow_api.id(42606847128983577)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35330458133770489)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54850160640430774.103)
,p_translate_from_id=>wwv_flow_api.id(54850160640430774)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35330635932770489)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54594883933735683.103)
,p_translate_from_id=>wwv_flow_api.id(54594883933735683)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35330831090770489)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595153017735686.103)
,p_translate_from_id=>wwv_flow_api.id(54595153017735686)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35331126573770489)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855971534958683.103)
,p_translate_from_id=>wwv_flow_api.id(63855971534958683)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35331299066770489)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55087171892622351.103)
,p_translate_from_id=>wwv_flow_api.id(55087171892622351)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35331524612770489)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606344191983572.103)
,p_translate_from_id=>wwv_flow_api.id(42606344191983572)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35331696855770489)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855668685958680.103)
,p_translate_from_id=>wwv_flow_api.id(63855668685958680)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35331840093770491)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55084298787622348.103)
,p_translate_from_id=>wwv_flow_api.id(55084298787622348)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35332083584770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596714714735701.103)
,p_translate_from_id=>wwv_flow_api.id(54596714714735701)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35332240999770491)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42677330299686730.103)
,p_translate_from_id=>wwv_flow_api.id(42677330299686730)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35332524520770491)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54925110440871583.103)
,p_translate_from_id=>wwv_flow_api.id(54925110440871583)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa &PAR_IS_LOCAL."/>'
,p_translate_from_text=>'<i class="fa &PAR_IS_LOCAL."/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35332706846770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596243752735697.103)
,p_translate_from_id=>wwv_flow_api.id(54596243752735697)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35332877701770491)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42605990835983569.103)
,p_translate_from_id=>wwv_flow_api.id(42605990835983569)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35333128202770491)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54924972946871582.103)
,p_translate_from_id=>wwv_flow_api.id(54924972946871582)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35333257694770491)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855811535958681.103)
,p_translate_from_id=>wwv_flow_api.id(63855811535958681)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35333488913770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(20947353237809096.103)
,p_translate_from_id=>wwv_flow_api.id(20947353237809096)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35333693693770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597905884735713.103)
,p_translate_from_id=>wwv_flow_api.id(54597905884735713)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35333864548770491)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595496057735689.103)
,p_translate_from_id=>wwv_flow_api.id(54595496057735689)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35334076758770491)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856044012958684.103)
,p_translate_from_id=>wwv_flow_api.id(63856044012958684)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35334301009770491)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856398560958687.103)
,p_translate_from_id=>wwv_flow_api.id(63856398560958687)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35334503753770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596407683735698.103)
,p_translate_from_id=>wwv_flow_api.id(54596407683735698)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35334679825770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596531652735700.103)
,p_translate_from_id=>wwv_flow_api.id(54596531652735700)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35334843459770491)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855935114958682.103)
,p_translate_from_id=>wwv_flow_api.id(63855935114958682)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35335062935770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597514952735709.103)
,p_translate_from_id=>wwv_flow_api.id(54597514952735709)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
,p_translate_from_text=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35335264620770491)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54845999483430773.103)
,p_translate_from_id=>wwv_flow_api.id(54845999483430773)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35335459910770491)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606181505983570.103)
,p_translate_from_id=>wwv_flow_api.id(42606181505983570)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35335670775770491)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54844263174430768.103)
,p_translate_from_id=>wwv_flow_api.id(54844263174430768)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35335882765770491)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596511194735699.103)
,p_translate_from_id=>wwv_flow_api.id(54596511194735699)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35336102781770494)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55086568371622351.103)
,p_translate_from_id=>wwv_flow_api.id(55086568371622351)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35336239472770494)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595153017735686.103)
,p_translate_from_id=>wwv_flow_api.id(54595153017735686)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35336473339770494)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855971534958683.103)
,p_translate_from_id=>wwv_flow_api.id(63855971534958683)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35336645294770494)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606344191983572.103)
,p_translate_from_id=>wwv_flow_api.id(42606344191983572)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35336837668770494)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54928727563871620.103)
,p_translate_from_id=>wwv_flow_api.id(54928727563871620)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35337090034770494)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855668685958680.103)
,p_translate_from_id=>wwv_flow_api.id(63855668685958680)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35337261270770494)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55084298787622348.103)
,p_translate_from_id=>wwv_flow_api.id(55084298787622348)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35337442347770494)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596714714735701.103)
,p_translate_from_id=>wwv_flow_api.id(54596714714735701)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35337678058770495)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42677330299686730.103)
,p_translate_from_id=>wwv_flow_api.id(42677330299686730)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35337923201770495)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54846526475430773.103)
,p_translate_from_id=>wwv_flow_api.id(54846526475430773)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35338068936770495)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596243752735697.103)
,p_translate_from_id=>wwv_flow_api.id(54596243752735697)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35338245757770495)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855811535958681.103)
,p_translate_from_id=>wwv_flow_api.id(63855811535958681)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35338461532770495)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(20947353237809096.103)
,p_translate_from_id=>wwv_flow_api.id(20947353237809096)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35338668391770495)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597905884735713.103)
,p_translate_from_id=>wwv_flow_api.id(54597905884735713)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35338922399770495)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856044012958684.103)
,p_translate_from_id=>wwv_flow_api.id(63856044012958684)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35339083269770495)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856398560958687.103)
,p_translate_from_id=>wwv_flow_api.id(63856398560958687)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35339295068770495)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596407683735698.103)
,p_translate_from_id=>wwv_flow_api.id(54596407683735698)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35339449530770495)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596531652735700.103)
,p_translate_from_id=>wwv_flow_api.id(54596531652735700)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35339724440770495)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855935114958682.103)
,p_translate_from_id=>wwv_flow_api.id(63855935114958682)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35339885466770495)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54844263174430768.103)
,p_translate_from_id=>wwv_flow_api.id(54844263174430768)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35340128928770495)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596511194735699.103)
,p_translate_from_id=>wwv_flow_api.id(54596511194735699)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35340293241770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(20947274508809095.103)
,p_translate_from_id=>wwv_flow_api.id(20947274508809095)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35340468421770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856216411958685.103)
,p_translate_from_id=>wwv_flow_api.id(63856216411958685)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35340675184770499)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54595153017735686.103)
,p_translate_from_id=>wwv_flow_api.id(54595153017735686)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35340834569770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855971534958683.103)
,p_translate_from_id=>wwv_flow_api.id(63855971534958683)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35341052318770499)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606344191983572.103)
,p_translate_from_id=>wwv_flow_api.id(42606344191983572)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35341237335770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855668685958680.103)
,p_translate_from_id=>wwv_flow_api.id(63855668685958680)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35341527129770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856317482958686.103)
,p_translate_from_id=>wwv_flow_api.id(63856317482958686)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35341678474770499)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55084298787622348.103)
,p_translate_from_id=>wwv_flow_api.id(55084298787622348)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35341925856770499)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596714714735701.103)
,p_translate_from_id=>wwv_flow_api.id(54596714714735701)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35342065168770499)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42677330299686730.103)
,p_translate_from_id=>wwv_flow_api.id(42677330299686730)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35342263787770499)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596243752735697.103)
,p_translate_from_id=>wwv_flow_api.id(54596243752735697)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35342457651770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855811535958681.103)
,p_translate_from_id=>wwv_flow_api.id(63855811535958681)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35342701118770499)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(20947353237809096.103)
,p_translate_from_id=>wwv_flow_api.id(20947353237809096)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35342846977770499)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597905884735713.103)
,p_translate_from_id=>wwv_flow_api.id(54597905884735713)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35343062693770499)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606412036983573.103)
,p_translate_from_id=>wwv_flow_api.id(42606412036983573)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35343265485770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856044012958684.103)
,p_translate_from_id=>wwv_flow_api.id(63856044012958684)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35343443725770499)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856398560958687.103)
,p_translate_from_id=>wwv_flow_api.id(63856398560958687)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35343719928770500)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596407683735698.103)
,p_translate_from_id=>wwv_flow_api.id(54596407683735698)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35343903123770500)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596531652735700.103)
,p_translate_from_id=>wwv_flow_api.id(54596531652735700)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35344086918770500)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855935114958682.103)
,p_translate_from_id=>wwv_flow_api.id(63855935114958682)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35344308880770500)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54844263174430768.103)
,p_translate_from_id=>wwv_flow_api.id(54844263174430768)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35344434253770500)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596511194735699.103)
,p_translate_from_id=>wwv_flow_api.id(54596511194735699)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35344711259770500)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606557968983574.103)
,p_translate_from_id=>wwv_flow_api.id(42606557968983574)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35344921130770502)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855971534958683.103)
,p_translate_from_id=>wwv_flow_api.id(63855971534958683)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35345065725770502)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606344191983572.103)
,p_translate_from_id=>wwv_flow_api.id(42606344191983572)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35345280035770502)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855668685958680.103)
,p_translate_from_id=>wwv_flow_api.id(63855668685958680)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35345467966770502)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596714714735701.103)
,p_translate_from_id=>wwv_flow_api.id(54596714714735701)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35345678688770502)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606663326983575.103)
,p_translate_from_id=>wwv_flow_api.id(42606663326983575)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35345848230770502)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596243752735697.103)
,p_translate_from_id=>wwv_flow_api.id(54596243752735697)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35346064388770502)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855811535958681.103)
,p_translate_from_id=>wwv_flow_api.id(63855811535958681)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35346247666770502)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(20947353237809096.103)
,p_translate_from_id=>wwv_flow_api.id(20947353237809096)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35346522743770503)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54597905884735713.103)
,p_translate_from_id=>wwv_flow_api.id(54597905884735713)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35346672459770503)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54849573820430774.103)
,p_translate_from_id=>wwv_flow_api.id(54849573820430774)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35346912167770503)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856044012958684.103)
,p_translate_from_id=>wwv_flow_api.id(63856044012958684)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35347079954770503)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63856398560958687.103)
,p_translate_from_id=>wwv_flow_api.id(63856398560958687)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35347296326770503)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596407683735698.103)
,p_translate_from_id=>wwv_flow_api.id(54596407683735698)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35347434864770503)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596531652735700.103)
,p_translate_from_id=>wwv_flow_api.id(54596531652735700)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35347658387770503)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855935114958682.103)
,p_translate_from_id=>wwv_flow_api.id(63855935114958682)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35347869554770503)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54848972860430774.103)
,p_translate_from_id=>wwv_flow_api.id(54848972860430774)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35348074349770503)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54596511194735699.103)
,p_translate_from_id=>wwv_flow_api.id(54596511194735699)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35348306687770505)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55086013119622351.103)
,p_translate_from_id=>wwv_flow_api.id(55086013119622351)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35348437775770505)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606663326983575.103)
,p_translate_from_id=>wwv_flow_api.id(42606663326983575)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35348709039770506)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54847166342430773.103)
,p_translate_from_id=>wwv_flow_api.id(54847166342430773)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35348863651770506)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606713986983576.103)
,p_translate_from_id=>wwv_flow_api.id(42606713986983576)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35349063775770506)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54594629112735681.103)
,p_translate_from_id=>wwv_flow_api.id(54594629112735681)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35349326840770506)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54848345629430774.103)
,p_translate_from_id=>wwv_flow_api.id(54848345629430774)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35349511252770506)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54847753390430773.103)
,p_translate_from_id=>wwv_flow_api.id(54847753390430773)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35349716379770506)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55085396414622349.103)
,p_translate_from_id=>wwv_flow_api.id(55085396414622349)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35349836435770506)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54849573820430774.103)
,p_translate_from_id=>wwv_flow_api.id(54849573820430774)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35350068850770506)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855549759958679.103)
,p_translate_from_id=>wwv_flow_api.id(63855549759958679)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35350309827770506)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54594824761735682.103)
,p_translate_from_id=>wwv_flow_api.id(54594824761735682)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35350486531770506)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54848972860430774.103)
,p_translate_from_id=>wwv_flow_api.id(54848972860430774)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35350632729770510)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42606663326983575.103)
,p_translate_from_id=>wwv_flow_api.id(42606663326983575)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35350832278770511)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54849573820430774.103)
,p_translate_from_id=>wwv_flow_api.id(54849573820430774)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35351029887770511)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54848972860430774.103)
,p_translate_from_id=>wwv_flow_api.id(54848972860430774)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35351321375770544)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55084740854622348.103)
,p_translate_from_id=>wwv_flow_api.id(55084740854622348)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35351477808770544)
,p_page_id=>11
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54844806556430770.103)
,p_translate_from_id=>wwv_flow_api.id(54844806556430770)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35351669663770549)
,p_page_id=>7
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(42605901615983568.103)
,p_translate_from_id=>wwv_flow_api.id(42605901615983568)
,p_translate_column_id=>450
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35352102842770550)
,p_page_id=>2
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(63855450174958678.103)
,p_translate_from_id=>wwv_flow_api.id(63855450174958678)
,p_translate_column_id=>451
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35352313393770550)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(60162868494098216.103)
,p_translate_from_id=>wwv_flow_api.id(60162868494098216)
,p_translate_column_id=>451
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35352445198770561)
,p_page_id=>4
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(55083571140622345.103)
,p_translate_from_id=>wwv_flow_api.id(55083571140622345)
,p_translate_column_id=>457
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Message Group'
,p_translate_from_text=>'Meldungsgruppe erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35352641154770561)
,p_page_id=>8
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(54594507166735679.103)
,p_translate_from_id=>wwv_flow_api.id(54594507166735679)
,p_translate_column_id=>457
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Parameter Group'
,p_translate_from_text=>'Parametergruppe erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35352870832770594)
,p_translated_flow_id=>103
,p_translate_to_id=>110.103
,p_translate_from_id=>110
,p_translate_column_id=>476
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT Administration'
,p_translate_from_text=>'PIT-Administration'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35924812359561411)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>13.103
,p_translate_from_id=>13
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich administrieren')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35924851379561420)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>13.103
,p_translate_from_id=>13
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich administrieren')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35925052831561431)
,p_page_id=>6
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24702742517449490.103)
,p_translate_from_id=>wwv_flow_api.id(24702742517449490)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich verwalten')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35925310708561431)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24703011140449492.103)
,p_translate_from_id=>wwv_flow_api.id(24703011140449492)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35925528564561436)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24703284615449495.103)
,p_translate_from_id=>wwv_flow_api.id(24703284615449495)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35925685100561445)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24702912546449491.103)
,p_translate_from_id=>wwv_flow_api.id(24702912546449491)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35925890620561445)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35909583762410314.103)
,p_translate_from_id=>wwv_flow_api.id(35909583762410314)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Realms'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35926113755561661)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35909583762410314.103)
,p_translate_from_id=>wwv_flow_api.id(35909583762410314)
,p_translate_column_id=>143
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realms'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35926167642561927)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35916349057410344.103)
,p_translate_from_id=>wwv_flow_api.id(35916349057410344)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35926246413561933)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35916349057410344.103)
,p_translate_from_id=>wwv_flow_api.id(35916349057410344)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_realm;'
,p_translate_from_text=>'pit_ui.process_edit_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35926589393561936)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35916349057410344.103)
,p_translate_from_id=>wwv_flow_api.id(35916349057410344)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35926751925561938)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35916349057410344.103)
,p_translate_from_id=>wwv_flow_api.id(35916349057410344)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35927002473561989)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24702912546449491.103)
,p_translate_from_id=>wwv_flow_api.id(24702912546449491)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35927180795561992)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(24702912546449491.103)
,p_translate_from_id=>wwv_flow_api.id(24702912546449491)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35927331283562211)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35915405260410342.103)
,p_translate_from_id=>wwv_flow_api.id(35915405260410342)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'active'
,p_translate_from_text=>'aktiv'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35927510014562211)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35914355421410342.103)
,p_translate_from_id=>wwv_flow_api.id(35914355421410342)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35927664469562213)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35913390458410341.103)
,p_translate_from_id=>wwv_flow_api.id(35913390458410341)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realm'
,p_translate_from_text=>'Bezeichner'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35927836045562214)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35915405260410342.103)
,p_translate_from_id=>wwv_flow_api.id(35915405260410342)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35928114921562214)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35910914183410322.103)
,p_translate_from_id=>wwv_flow_api.id(35910914183410322)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35928239052562214)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35914355421410342.103)
,p_translate_from_id=>wwv_flow_api.id(35914355421410342)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35928519281562217)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35910914183410322.103)
,p_translate_from_id=>wwv_flow_api.id(35910914183410322)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35928633302562217)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35914355421410342.103)
,p_translate_from_id=>wwv_flow_api.id(35914355421410342)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35928850657562220)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35910914183410322.103)
,p_translate_from_id=>wwv_flow_api.id(35910914183410322)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35929098632562220)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35914355421410342.103)
,p_translate_from_id=>wwv_flow_api.id(35914355421410342)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35929315697562222)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35914355421410342.103)
,p_translate_from_id=>wwv_flow_api.id(35914355421410342)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35929524110562225)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35913390458410341.103)
,p_translate_from_id=>wwv_flow_api.id(35913390458410341)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35929638601562266)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35911378300410322.103)
,p_translate_from_id=>wwv_flow_api.id(35911378300410322)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(35938747000748870)
,p_page_id=>13
,p_translated_flow_id=>103
,p_translate_to_id=>wwv_flow_api.id(35935728746647880.103)
,p_translate_from_id=>wwv_flow_api.id(35935728746647880)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(35708458012263078)
,p_name=>'BOOLEAN_N'
,p_message_language=>'de'
,p_message_text=>'Nein'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106615642325864)
,p_name=>'BOOLEAN_N'
,p_message_text=>'No'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(35708290547262253)
,p_name=>'BOOLEAN_Y'
,p_message_language=>'de'
,p_message_text=>'Ja'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106548289325864)
,p_name=>'BOOLEAN_Y'
,p_message_text=>'Yes'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(35112134081677267)
,p_name=>'HELP_CONTEXT'
,p_message_language=>'de'
,p_message_text=>unistr('<p>Ein Kontext fasst das Debug- und Traceverhalten von PIT unter einem Namen zusammen.</p><p>W\00E4hrend der Anwendung kann der Kontext global oder nur f\00FCr einen Benutzer ge\00E4ndert werden. Dadurch wird feingranular gesteuert, welche Einstellungen aktuell ')
||unistr('gelten sollen.</p><p>Der Standard-Kontext \00BBDEFAULT\00AB wird gew\00E4hlt, wenn kein anderer Kontext ausgew\00E4hlt wurde. Daher kann dieser Kontext nicht gel\00F6scht werden.<br>Sie k\00F6nnen beliebig viele Kontexte anlegen.</p><p>Die Kontextbezeichner \00BBDEFAULT\00AB und \00BBA')
||unistr('CTIVE\00AB werden intern verwendet und sind daher nicht erlaubt.</p>')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106171286325862)
,p_name=>'HELP_CONTEXT'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>A context summarizes the debug and trace behavior of PIT under one name.</p><p>.',
'During the application, the context can be changed globally or only for a user. This provides fine-grained control over which settings should currently apply.</p><p>.',
'The default context "DEFAULT" is selected if no other context is selected. Therefore, this context cannot be deleted.<br>You can create as many contexts as you like.</p><p>.',
'The context identifiers "DEFAULT" and "ACTIVE" are used internally and are therefore not allowed.</p>'))
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(35111291653633675)
,p_name=>'HELP_OUTPUT_MODULES'
,p_message_language=>'de'
,p_message_text=>unistr('<p>Ausgabemodule werden verwendet, um Nachrichten von PIT an Tabellen, Dateien, APEX oder beliebige weitere Ziele zu senden.<br>Angezeigt werden alle Module, die derzeit in der Datenbank installiert sind. Sie k\00F6nnen an der Spalte \00BBverf\00FCgbar\00AB sehen, o')
||unistr('b es bei der Installation des Ausgabemoduls Probleme gab oder ob das Modul einsatzbereit ist.<br>Spalte \00BBaktiv\00AB zeigt an, ob das Modul aktuell zur Ausgabe von Meldungen verwendet wird.</p>')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106024845325862)
,p_name=>'HELP_OUTPUT_MODULES'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Output modules are used to send messages from PIT to tables, files, APEX or any other destination.',
'All modules that are currently installed in the database are displayed. You can see from the "available" column whether there were problems during the installation of the output module or whether the module is ready for use.<br>',
'Column "active" shows whether the module is currently usead for the output of messages.',
''))
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(35112426669683950)
,p_name=>'HELP_TOGGLE'
,p_message_language=>'de'
,p_message_text=>unistr('Das Debugging kann global f\00FCr alle Anwendungspackages eingestellt werden, indem Kontexte verwendet werden.<br>Zus\00E4tzlich ist es m\00F6glich, Das Logging f\00FCr einzelne Packages ein- oder auszuschalten. Hierf\00FCr wird eine Liste von Packages verwaltet, denen ')
||unistr('jeweils ein benannter Kontext zugeordnet wird.<br>Wird eines dieser Packages ausgef\00FChrt, schaltet PIT den zugeordneten Kontext aktiv. Wird das Package verlassen, wird wieder der vorherige Kontext aktiv.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106211511325862)
,p_name=>'HELP_TOGGLE'
,p_message_text=>'Debugging can be set globally for all application packages by using contexts.<br>In addition, it is possible to enable or disable logging for individual packages. To do this, a list of packages is managed, to each of which a named context is assigned'
||'.<br>If one of these packages is executed, PIT activates the assigned context. If the package is left, the previous context becomes active again.'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(35608590860952405)
,p_name=>'HINT_PMS'
,p_message_language=>'de'
,p_message_text=>unistr('Falls Sie die Meldungen \00FCbersetzen m\00F6chten, w\00E4hlen Sie eine Zielsprache.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106399697325862)
,p_name=>'HINT_PMS'
,p_message_text=>'If you want to translate the messages, select a target language.'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(35609152327959927)
,p_name=>'HINT_PTI'
,p_message_language=>'de'
,p_message_text=>unistr('Falls Sie die Begriffe \00FCbersetzen m\00F6chten, w\00E4hlen Sie eine Zielsprache.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106487123325864)
,p_name=>'HINT_PTI'
,p_message_text=>'If you want to translate the translatable items, select a target language.'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(67032630741392864)
,p_name=>'ORACLE_ERROR_HINT'
,p_message_language=>'de'
,p_message_text=>unistr('<h2>Oracle-Fehlermapping</h2><p>Wenn Sie einen Oracle-Fehler auf eine PIT-Meldung abbilden m\00F6chten, beachten Sie:</p><ul><li>Bereits vordefinierte Fehler k\00F6nnen nicht \00FCberschrieben werden (z.B. NO_DATA_FOUND)</li><li>Oracle-Fehlernummern k\00F6nnen nur e')
||unistr('inmal von PIT \00FCberschrieben werden</li></ul><p>Da Oracle-Fehler nur einmal gemappt werden k\00F6nnen, sollte der Bezeichner m\00F6glichst generisch gew\00E4hlt werden.<br>Verwenden Sie eine Namenskonvention mit Schema- oder Bereichspr\00E4fixen, beachten Sie, dass d')
||unistr('iese Fehlermappings \00FCbergreifend verwendet werden m\00FCssen und daher eine entsprechende Namenskonvention ben\00F6tigen.</p><p>Um einen Oracle-Fehler mit mehreren Meldungen zu verbinden, definieren Sie eine Oracle-Fehlernachricht und separate Meldungen. Im ')
||'Exception-Block des Codes fangen Sie dann den benannten Oracle-Fehler und geben die spezifische Nachricht aus.</p>'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(18106721403325864)
,p_name=>'ORACLE_ERROR_HINT'
,p_message_text=>'<h2>Oracle error mapping</h2><p>If you want to map an Oracle error to a PIT message, please note:</p><ul><li>Apredefined errors cannot be overwritten (e.g. NO_DATA_FOUND)</li><li>Oracle error numbers can only be overwritten once by PIT</li></ul><p>Si'
||'nce Oracle errors can only be mapped once, the identifier should be chosen as generically as possible. <br>Use a naming convention with schema or area prefixes. Note that these error mappings must be used across all errors and therefore require an ap'
||'propriate naming convention.</p><p>To link an Oracle error with several messages, define an Oracle error message and separate messages. In the exception block of the code, you then catch the named Oracle error and output the specific message.</p>'
);
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts/delete_confirm_msg
begin
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(65123426124455432)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>unistr('Bitte best\00E4tigen Sie, dass die Daten gel\00F6scht werden sollen.')
);
end;
/
prompt --application/shared_components/security/authentications/apex
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(65112859203242476)
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
 p_id=>wwv_flow_api.id(101836862781713637)
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
 p_id=>wwv_flow_api.id(101837565467733287)
,p_plugin_id=>wwv_flow_api.id(101836862781713637)
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
 p_id=>wwv_flow_api.id(101838152785739150)
,p_plugin_attribute_id=>wwv_flow_api.id(101837565467733287)
,p_display_sequence=>10
,p_display_value=>'SQL bzw. PL/SQL'
,p_return_value=>'text/x-plsql'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101838966291743031)
,p_plugin_attribute_id=>wwv_flow_api.id(101837565467733287)
,p_display_sequence=>20
,p_display_value=>'JavaScript'
,p_return_value=>'text/javascript'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101839338025744277)
,p_plugin_attribute_id=>wwv_flow_api.id(101837565467733287)
,p_display_sequence=>30
,p_display_value=>'JavaScript JSON'
,p_return_value=>'application/json'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101839852223748385)
,p_plugin_attribute_id=>wwv_flow_api.id(101837565467733287)
,p_display_sequence=>40
,p_display_value=>'XML'
,p_return_value=>'application/xml'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101840256379749625)
,p_plugin_attribute_id=>wwv_flow_api.id(101837565467733287)
,p_display_sequence=>50
,p_display_value=>'HTML'
,p_return_value=>'text/html'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101848261704161100)
,p_plugin_attribute_id=>wwv_flow_api.id(101837565467733287)
,p_display_sequence=>60
,p_display_value=>'CSS'
,p_return_value=>'text/css'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(101843448572034314)
,p_plugin_id=>wwv_flow_api.id(101836862781713637)
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
 p_id=>wwv_flow_api.id(101844050650034863)
,p_plugin_attribute_id=>wwv_flow_api.id(101843448572034314)
,p_display_sequence=>10
,p_display_value=>'Night'
,p_return_value=>'night'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101844452035035332)
,p_plugin_attribute_id=>wwv_flow_api.id(101843448572034314)
,p_display_sequence=>20
,p_display_value=>'Neat'
,p_return_value=>'neat'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101844855152036183)
,p_plugin_attribute_id=>wwv_flow_api.id(101843448572034314)
,p_display_sequence=>30
,p_display_value=>'Elegant'
,p_return_value=>'elegant'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(101845257230036802)
,p_plugin_attribute_id=>wwv_flow_api.id(101843448572034314)
,p_display_sequence=>40
,p_display_value=>'Default'
,p_return_value=>'default'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(101841237809753718)
,p_plugin_id=>wwv_flow_api.id(101836862781713637)
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
 p_id=>wwv_flow_api.id(66665643915919787)
,p_plugin_id=>wwv_flow_api.id(101836862781713637)
,p_file_name=>'plsql.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(65112713542242473)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN_DESKTOP:&SESSION.'
,p_theme_style_by_user_pref=>false
,p_navigation_list_id=>wwv_flow_api.id(65070271744242432)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(65106324974242461)
,p_nav_list_template_options=>'#DEFAULT#'
,p_include_legacy_javascript=>'18'
,p_include_jquery_migrate=>true
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(65112642834242473)
,p_nav_bar_list_template_id=>wwv_flow_api.id(65103027051242459)
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
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'PIT-Administration'
,p_alias=>'MAIN'
,p_step_title=>'PIT-Administration'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(65908547757959061)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142332'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(65114535769242489)
,p_plug_name=>'Breadcrumbs'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65089786772242451)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(65114026726242487)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(65108045647242464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(65116864445367151)
,p_plug_name=>'Anwendungsbereiche'
,p_component_template_options=>'#DEFAULT#:t-Cards--featured force-fa-lg:t-Cards--displayIcons:t-Cards--4cols:t-Cards--desc-2ln:u-colors:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(57539458978534929)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(65100403275242457)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Meldungen administrieren'
,p_alias=>'ADMIN_PMS'
,p_step_title=>'Meldungen administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(65908586992959781)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201221135422'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(65131781752455568)
,p_plug_name=>'Meldungen'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_ADMIN_PMS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P2_PMG_NAME,P2_PML_NAME'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(20947274508809095)
,p_name=>'PMS_PSE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_PSE_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Pms Pse Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63855450174958678)
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
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63855549759958679)
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
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63855668685958680)
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
,p_max_length=>931
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63855811535958681)
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
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63855935114958682)
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
,p_max_length=>50
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63855971534958683)
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
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63856044012958684)
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
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63856216411958685)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63856317482958686)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(63856398560958687)
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
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(63855423222958677)
,p_internal_uid=>9352784268707840
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(57561872264679505)
,p_interactive_grid_id=>wwv_flow_api.id(63855423222958677)
,p_static_id=>'158019'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(57562004703679505)
,p_report_id=>wwv_flow_api.id(57561872264679505)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(34332528535434239)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(20947274508809095)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57562537989679510)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(63855450174958678)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57562959006679515)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(63855549759958679)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>319
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57563472039679516)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(63855668685958680)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57563970463679518)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(63855811535958681)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57564499769679519)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(63855935114958682)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57564999976679521)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(63855971534958683)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57565527140679522)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(63856044012958684)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>109
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57566027550679524)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(63856216411958685)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57566524512679526)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(63856317482958686)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>68
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(57567020954679527)
,p_view_id=>wwv_flow_api.id(57562004703679505)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(63856398560958687)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(65137919205455581)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65089786772242451)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(65114026726242487)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(65108045647242464)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63855269048958676)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(65131781752455568)
,p_button_name=>'EDIT_PMG'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Meldungsgruppe bearbeiten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMG:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(65136442719455576)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(65131781752455568)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Meldung erzeugen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMS:&SESSION.::&DEBUG.:RP,3::'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60446934961471480)
,p_name=>'P2_PMG_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(65131781752455568)
,p_prompt=>'Gruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_GROUP'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60447001249471481)
,p_name=>'P2_PML_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(65131781752455568)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PML_NAME_IN_USE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(65135493710455576)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(65131781752455568)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(65136033089455576)
,p_event_id=>wwv_flow_api.id(65135493710455576)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(65131781752455568)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(65136841061455578)
,p_name=>'Create Button - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(65136442719455576)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(65137294865455578)
,p_event_id=>wwv_flow_api.id(65136841061455578)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(65131781752455568)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60447076187471482)
,p_name=>'Refresh Report'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_PML_NAME,P2_PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60447210442471483)
,p_event_id=>wwv_flow_api.id(60447076187471482)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(65131781752455568)
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Meldung editieren'
,p_alias=>'EDIT_PMS'
,p_page_mode=>'MODAL'
,p_step_title=>'Meldung editieren'
,p_reload_on_submit=>'A'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(65908586992959781)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_step_template=>wwv_flow_api.id(65076147654242442)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'800'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142116'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(60165141755098239)
,p_plug_name=>'HIlfe zu Oracle-Fehlermappings'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082029838242448)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(65120874444455431)
,p_plug_name=>'Meldung editieren'
,p_region_name=>'EDIT_PMS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_PMS'
,p_include_rowid_column=>true
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(65121562455455431)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(65122018334455431)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(65121562455455431)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(65121463322455431)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(65121562455455431)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Meldung entfernen'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(65121425588455431)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(65121562455455431)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(65121276795455431)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(65121562455455431)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Meldug erzeugen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60165208636098240)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(65120874444455431)
,p_button_name=>'SHOW_HELP'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107359608242462)
,p_button_image_alt=>'Hilfe zu Oracle-Fehlermappings'
,p_button_position=>'TOP'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(57578703809784638)
,p_name=>'P3_PMS_PMG_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_prompt=>'Meldungsgruppe'
,p_source=>'PMS_PMG_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_GROUP'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_read_only_when=>'P3_PMS_PMG_NAME'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(65107169358242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(57579146689784643)
,p_name=>'P3_PMS_DESCRIPTION'
,p_source_data_type=>'CLOB'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_prompt=>'Beschreibung'
,p_source=>'PMS_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_help_text=>unistr('Optionale Beschreibung.<br>Kann verwendet werden, um im Fehlerfall zus\00E4tzliche Handlungsanweisungen an den Anwender zu geben.')
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65124735177455522)
,p_name=>'P3_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65125132723455539)
,p_name=>'P3_PMS_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_prompt=>'Name'
,p_source=>'PMS_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>120
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>'P3_PMS_NAME'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(65107169358242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Eindeutiger Name, gem\00E4\00DF Benennungskonventionen:'),
unistr('<ul><li>Gro\00DFbuchstaben</li><li>Nur Unterstrich als Sonderzeichen</li><li>Fehlermeldung maximal 26, andere maximal 30 Zeichen</li></ul>')))
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
,p_attribute_06=>'UPPER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65125415067455542)
,p_name=>'P3_PMS_PML_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_default=>'return pit_ui.get_default_language;'
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Sprache'
,p_source=>'PMS_PML_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Sprache w\00E4hlen -')
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(65107169358242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Sprache der Meldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65125807318455542)
,p_name=>'P3_PMS_TEXT'
,p_source_data_type=>'CLOB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_prompt=>'Meldung'
,p_source=>'PMS_TEXT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_help_text=>unistr('Meldungstext.<br>Ersetzung der Parameter #1# bis #50# gem\00E4\00DF Zahlwert.<br>\00DCbergebene Parameter werden positional nummeriert und auf die Ersetzungsmarken verteilt.')
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65126229613455542)
,p_name=>'P3_PMS_PSE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_default=>'70'
,p_prompt=>'Schweregrad'
,p_source=>'PMS_PSE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Schweregrad der Fehlermeldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65126601904455543)
,p_name=>'P3_PMS_CUSTOM_ERROR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(65120874444455431)
,p_item_source_plug_id=>wwv_flow_api.id(65120874444455431)
,p_prompt=>'Fehlernummer'
,p_source=>'PMS_CUSTOM_ERROR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Optionale Fehlernummer.<br>Muss bei eigenen Fehlern nicht angegeben werden, dient dem Mappen Oracle-definierter Fehler auf Fehlermeldungen.<br>Wird eine Fehlernummer doppelt belegt, wird ein Fehler geworfen.<br>Insbesondere darf keine Fehlernummer im'
||' Bereich - 20999 bis -20001 angegben werden, PIT verwaltet diese Fehlernummer automatisch.'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(57579022373784641)
,p_validation_name=>'Validate EDIT_PMS'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_edit_pms;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(65122106910455431)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(65122018334455431)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(65122859828455432)
,p_event_id=>wwv_flow_api.id(65122106910455431)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60447300542471484)
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
 p_id=>wwv_flow_api.id(60447401781471485)
,p_event_id=>wwv_flow_api.id(60447300542471484)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60447515661471486)
,p_event_id=>wwv_flow_api.id(60447300542471484)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54598136114735716)
,p_event_id=>wwv_flow_api.id(60447300542471484)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'-20000'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54598278275735717)
,p_event_id=>wwv_flow_api.id(60447300542471484)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(57578826641784639)
,p_name=>'Format PMS_NAME'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_PMS_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(57578840298784640)
,p_event_id=>wwv_flow_api.id(57578826641784639)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui.harmonize_sql_name(''P3_PMS_NAME'');'
,p_attribute_02=>'P3_PMS_NAME'
,p_attribute_03=>'P3_PMS_NAME'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54597945575735714)
,p_name=>'Initialize Page'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54598053861735715)
,p_event_id=>wwv_flow_api.id(54597945575735714)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_PML_NAME'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60165368129098241)
,p_name=>'Show help region'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(60165208636098240)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60165377732098242)
,p_event_id=>wwv_flow_api.id(60165368129098241)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(60165141755098239)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(65128929370455547)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(65120874444455431)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_PMS'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(60445767550471469)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(65120874444455431)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_PMS'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_pms;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_process_error_message=>'Fehler beim Speichern der Meldung:<br>#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Meldung wurde gespeichert.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(65129742314455547)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(65121463322455431)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(65130065152455547)
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
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Meldungsgruppe bearbeiten'
,p_alias=>'EDIT_PMG'
,p_page_mode=>'MODAL'
,p_step_title=>'Meldungsgruppe bearbeiten'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'900'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142218'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54927208264871604)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(55083092810622343)
,p_plug_name=>'Meldungsgruppe bearbeiten'
,p_region_name=>'EDIT_PMG'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65086030068242450)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_PMG'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(55084298787622348)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(55084740854622348)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(55085396414622349)
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
,p_attribute_06=>'UPPER'
,p_is_required=>true
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
,p_readonly_condition_type=>'EXPRESSION'
,p_readonly_condition=>':PMG_AMOUNT > 0'
,p_readonly_condition2=>'PLSQL'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(55086013119622351)
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
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(55086568371622351)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(55087171892622351)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(55083571140622345)
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
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_add_button_label=>'Meldungsgruppe erstellen'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(55083991695622346)
,p_interactive_grid_id=>wwv_flow_api.id(55083571140622345)
,p_static_id=>'158028'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(55084032870622346)
,p_report_id=>wwv_flow_api.id(55083991695622346)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(55085164425622349)
,p_view_id=>wwv_flow_api.id(55084032870622346)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(55084740854622348)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(55085797300622351)
,p_view_id=>wwv_flow_api.id(55084032870622346)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(55085396414622349)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(55086362428622351)
,p_view_id=>wwv_flow_api.id(55084032870622346)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(55086013119622351)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>423
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(55086948724622351)
,p_view_id=>wwv_flow_api.id(55084032870622346)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(55086568371622351)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>127
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(55087588732622351)
,p_view_id=>wwv_flow_api.id(55084032870622346)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(55087171892622351)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54927255693871605)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(54927208264871604)
,p_button_name=>'CANCEL'
,p_button_static_id=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54927576268871608)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(54927208264871604)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54927047357871603)
,p_tabular_form_region_id=>wwv_flow_api.id(55083092810622343)
,p_validation_name=>'Validate EDIT_PMG'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_edit_pmg;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54927397442871606)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(54927255693871605)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54927455440871607)
,p_event_id=>wwv_flow_api.id(54927397442871606)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54928157047871614)
,p_name=>'Format PMG_NAME'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(55083092810622343)
,p_triggering_element=>'PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54928283379871615)
,p_event_id=>wwv_flow_api.id(54928157047871614)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui.harmonize_sql_name(''PMG_NAME'');'
,p_attribute_02=>'PMG_NAME'
,p_attribute_03=>'PMG_NAME'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(55087745003622353)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(55083092810622343)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PMG'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_pmg;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(54927805969871610)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_api.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>unistr('G\00FCltigkeitsbereich einstellen')
,p_alias=>'SET_REALM'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('G\00FCltigkeitsbereich einstellen')
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(65908675410961086)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201222100933'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(36784749996952307)
,p_plug_name=>'Create Form'
,p_region_name=>'SET_REALM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_REALM'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(36787148153952320)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36787522494952320)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(36787148153952320)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36789528904952325)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(36787148153952320)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36785049559952311)
,p_name=>'P5_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(36784749996952307)
,p_item_source_plug_id=>wwv_flow_api.id(36784749996952307)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Par Id'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36785417774952314)
,p_name=>'P5_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(36784749996952307)
,p_item_source_plug_id=>wwv_flow_api.id(36784749996952307)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Par Pgr Id'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36785870054952315)
,p_name=>'P5_PAR_STRING_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(36784749996952307)
,p_item_source_plug_id=>wwv_flow_api.id(36784749996952307)
,p_prompt=>unistr('G\00FCltigkeitsbereich')
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_REALM'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Setzen Sie den G\00FCltigkeitsbereich f\00FCr die aktuelle Umgebung. Dies hat direkte Auswirkungen auf die Parameterwerte, falls f\00FCr diesen G\00FCltigkeitsbereich abweichende Parameterwerte vereinbart wurden.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(36747106570394478)
,p_validation_name=>'Validate SET_REALM'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_set_realm;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(36787694430952320)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(36787522494952320)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(36788482917952322)
,p_event_id=>wwv_flow_api.id(36787694430952320)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(36790746128952326)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(36784749996952307)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process SET_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_set_realm;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(36791179226952326)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(36790341430952325)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(36784749996952307)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Create Form'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_api.create_page(
 p_id=>6
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Parameter administrieren'
,p_alias=>'ADMIN_PARAM'
,p_step_title=>'Parameter administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(65908675410961086)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201222110704'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54595979991735694)
,p_plug_name=>'Liste der Parameter'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_ADMIN_PAR'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P6_PGR_ID'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(20947353237809096)
,p_name=>'PAR_VALIDATION_STRING'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_VALIDATION_STRING'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Par Validation String'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54596243752735697)
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54596407683735698)
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54596511194735699)
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
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54596531652735700)
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
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54596714714735701)
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
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54597514952735709)
,p_name=>'PAR_IS_MODIFIABLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_IS_MODIFIABLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'modifizierbar'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54597905884735713)
,p_name=>'PAR_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_VALUE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Parameterwert'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(60162868494098216)
,p_name=>'Link'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_LINK'
,p_heading=>'&nbsp;'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:EDIT_PAR:&SESSION.::&DEBUG.:RP,7:P7_PAR_ID,P7_PAR_PGR_ID:&PAR_ID.,&PGR_ID.'
,p_link_text=>'<i class="fa fa-pencil"/>'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(54596050562735695)
,p_internal_uid=>4223525175687317
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(54653717375187557)
,p_interactive_grid_id=>wwv_flow_api.id(54596050562735695)
,p_static_id=>'158032'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(54653781995187557)
,p_report_id=>wwv_flow_api.id(54653717375187557)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(34338048657443261)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(20947353237809096)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(48194952268508435)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(60162868494098216)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>42
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54654735512187563)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(54596243752735697)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>216
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54655273943187565)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(54596407683735698)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54655636079187565)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(54596511194735699)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54656167903187567)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(54596531652735700)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>502
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54656659947187568)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(54596714714735701)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54660688408187576)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(54597514952735709)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>119
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54703664700435037)
,p_view_id=>wwv_flow_api.id(54653781995187557)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(54597905884735713)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>373
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66697870047093954)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65089786772242451)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(65114026726242487)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(65108045647242464)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36747080793394477)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(54595979991735694)
,p_button_name=>'SET_REALM'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('G\00FCltigkeitsbereich setzen')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:SET_REALM:&SESSION.::&DEBUG.:RP,:P5_PAR_ID,P5_PAR_PGR_ID:REALM,PIT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(24702742517449490)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(54595979991735694)
,p_button_name=>'EDIT_REALM'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('G\00FCltigkeitsbereich verwalten')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_REALM:&SESSION.::&DEBUG.:RP,::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66841143420500052)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(54595979991735694)
,p_button_name=>'EDIT_PGR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Parametergruppen verwalten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PGR:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66696434805093951)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(54595979991735694)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Parameter erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PAR:&SESSION.::&DEBUG.:RP,:P7_PAR_ID,P7_PAR_PGR_ID:,&P6_PGR_ID.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36747259522394479)
,p_name=>'P6_REALM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(54595979991735694)
,p_prompt=>unistr('aktueller G\00FCltigkeitsbereich')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from pit_ui_admin_par_realm'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_PARAMETER_REALM'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66840808326500049)
,p_name=>'P6_PGR_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(54595979991735694)
,p_prompt=>'Parmetergruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Alle'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66696763061093951)
,p_name=>unistr('Schaltfl\00E4che erstellen - Dialog geschlossen')
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(54595979991735694)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66697250655093951)
,p_event_id=>wwv_flow_api.id(66696763061093951)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(54595979991735694)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(36747455102394481)
,p_event_id=>wwv_flow_api.id(66696763061093951)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P6_REALM'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from pit_ui_admin_par_realm'))
,p_attribute_08=>'Y'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66840942283500050)
,p_name=>'Refresh Parameter verwalten'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P6_PGR_ID'
,p_condition_element=>'P6_PGR_ID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24703549816449498)
,p_event_id=>wwv_flow_api.id(66840942283500050)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(66696434805093951)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66841040993500051)
,p_event_id=>wwv_flow_api.id(66840942283500050)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(54595979991735694)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24703469420449497)
,p_event_id=>wwv_flow_api.id(66840942283500050)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(66696434805093951)
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Parameter bearbeiten'
,p_alias=>'EDIT_PAR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parameter bearbeiten'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(65908675410961086)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_height=>'1000'
,p_dialog_width=>'1200'
,p_protection_level=>'C'
,p_read_only_when_type=>'EXPRESSION'
,p_read_only_when=>':P7_PAR_IS_MODIFIABLE = utl_apex.C_FALSE'
,p_read_only_when2=>'PLSQL'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142138'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(42604431968983553)
,p_plug_name=>unistr('Abweichende Parameterwerte f\00FCr G\00FCltigkeitsbereiche')
,p_region_name=>'EDIT_PAR_REALM'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_PAR_REALM'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42605901615983568)
,p_name=>'PRE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Bereich'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(42662492276639237)
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ITEM_IS_NOT_NULL'
,p_readonly_condition=>'PRE_ID'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42605990835983569)
,p_name=>'PRE_PAR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_PAR_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42606181505983570)
,p_name=>'PRE_PGR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_PGR_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42606344191983572)
,p_name=>'PRE_STRING_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_STRING_VALUE'
,p_data_type=>'CLOB'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Textwert'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>32767
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42606412036983573)
,p_name=>'PRE_INTEGER_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_INTEGER_VALUE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Ganzzahlwert'
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42606557968983574)
,p_name=>'PRE_FLOAT_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_FLOAT_VALUE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>unistr('Flie\00DFkommazahlwert')
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42606663326983575)
,p_name=>'PRE_DATE_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_DATE_VALUE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Datumswert'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42606713986983576)
,p_name=>'PRE_TIMESTAMP_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_TIMESTAMP_VALUE'
,p_data_type=>'TIMESTAMP_TZ'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Zeitstempelwert'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42606847128983577)
,p_name=>'PRE_BOOLEAN_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_BOOLEAN_VALUE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'Wahrheitswert'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attribute_01=>'APPLICATION'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42677260836686729)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42677330299686730)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(42605850729983567)
,p_internal_uid=>2867465827280140
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(42668493779686078)
,p_interactive_grid_id=>wwv_flow_api.id(42605850729983567)
,p_static_id=>'158034'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(42668612876686078)
,p_report_id=>wwv_flow_api.id(42668493779686078)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42669182909686081)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(42605901615983568)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42669643030686084)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(42605990835983569)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42670125235686087)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(42606181505983570)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42671102001686089)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(42606344191983572)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42671601789686091)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(42606412036983573)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42672169342686092)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(42606557968983574)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42672663630686094)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(42606663326983575)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42673111587686094)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(42606713986983576)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42673602283686095)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(42606847128983577)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42683715113697272)
,p_view_id=>wwv_flow_api.id(42668612876686078)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(42677260836686729)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66676206462093804)
,p_plug_name=>'Parameter bearbeiten'
,p_region_name=>'EDIT_PAR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_PAR'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66676906611093807)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66698483658093954)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65089786772242451)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(65114026726242487)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(65108045647242464)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66677346210093807)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(66676906611093807)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66676756398093807)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(66676906611093807)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66676718613093807)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(66676906611093807)
,p_button_name=>'SAVE'
,p_button_static_id=>'B7_SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\00C4nderungen anwenden')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66676630935093807)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(66676906611093807)
,p_button_name=>'CREATE'
,p_button_static_id=>'P7_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54597761712735712)
,p_name=>'P7_PAR_XML_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'XML-Wert'
,p_source=>'PAR_XML_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60162687462098215)
,p_name=>'P7_PGR_IS_MODIFIABLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select pgr_is_modifiable',
'  from parameter_group',
' where pgr_id = :P6_PGR_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'editierbar'
,p_source=>'PGR_IS_MODIFIABLE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66680039083093912)
,p_name=>'P7_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Parameter'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>128
,p_read_only_when=>'P7_PAR_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(65107169358242462)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Geben Sie einen eindeutigen Bezeichner f\00FCr diese Parametergruppe ein. Der Name muss den Oracle-Benennungskonventionen entsprechen und darf keine Sonderzeichen enthalten.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
,p_attribute_06=>'UPPER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66680308728093914)
,p_name=>'P7_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_default=>'P6_PGR_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Parametergruppe'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P7_PAR_PGR_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(65107169358242462)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('W\00E4hlen Sie die Parametergruppe, zu der dieser Parameter geh\00F6ren soll.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66680672455093914)
,p_name=>'P7_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Besschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Geben Sie eine optionale Beschreibung des Parameters ein.'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66681053332093917)
,p_name=>'P7_PAR_STRING_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Textwert'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66681528500093917)
,p_name=>'P7_PAR_INTEGER_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Ganzzahlwert'
,p_source=>'PAR_INTEGER_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66681851360093917)
,p_name=>'P7_PAR_FLOAT_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>unistr('Flie\00DFkommazahlwert')
,p_source=>'PAR_FLOAT_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66682294712093917)
,p_name=>'P7_PAR_DATE_VALUE'
,p_source_data_type=>'DATE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Datumswert'
,p_source=>'PAR_DATE_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66682701121093918)
,p_name=>'P7_PAR_TIMESTAMP_VALUE'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Zeitstempelwert'
,p_source=>'PAR_TIMESTAMP_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66683480245093918)
,p_name=>'P7_PAR_BOOLEAN_VALUE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Wahrheitswert'
,p_source=>'PAR_BOOLEAN_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66683922355093920)
,p_name=>'P7_PAR_IS_MODIFIABLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'editieren untersagen'
,p_source=>'PAR_IS_MODIFIABLE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_PAR_IS_MODIFIABLE'
,p_lov=>'.'||wwv_flow_api.id(45470512488547693)||'.'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>0
,p_display_when=>':P7_PGR_IS_MODIFIABLE = pit_util.C_TRUE'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(65106853986242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Falls die Gruppe das Editieren erlaubt, kann dies f\00FCr einzelne Parameter unterdr\00FCckt werden.')
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66684349104093920)
,p_name=>'P7_PAR_PAT_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Texttyp'
,p_source=>'PAR_PAT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_TYPE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Mit diesem Attribut k\00F6nnen Sie festlegen, welche Art Text als Textparameter gespeichert werden soll. Dies kontrolliert, welcher Editor Ihnen zur Bearbeitung angeboten wird.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66684689053093920)
,p_name=>'P7_PAR_VALIDATION_STRING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Validierungsausdruck'
,p_source=>'PAR_VALIDATION_STRING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('<p>Der Validierungsstring wird genutzt, um den Parameterwert zu pr\00FCfen.</p><p>Es stehen folgende Textanker zur Verf\00FCgung, um den Parameterwert zu referenzieren:<ul><li>#STRING#</li><li>#DATE#</li><li>#FLOAT#</li><li>#INTEGER#</li><li>#BOOLEAN#</li></')
||'ul></p>'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66685070109093920)
,p_name=>'P7_PAR_VALIDATION_MESSAGE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(66676206462093804)
,p_item_source_plug_id=>wwv_flow_api.id(66676206462093804)
,p_prompt=>'Fehlermeldung'
,p_source=>'PAR_VALIDATION_MESSAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54597656890735711)
,p_validation_name=>'Validate EDIT_PAR'
,p_validation_sequence=>120
,p_validation=>'return pit_ui.validate_edit_par;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(42677117119686728)
,p_tabular_form_region_id=>wwv_flow_api.id(42604431968983553)
,p_validation_name=>'Validate EDIT_PAR_REALM'
,p_validation_sequence=>130
,p_validation=>'return pit_ui.validate_edit_par_realm;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66677392845093807)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(66677346210093807)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66678165244093811)
,p_event_id=>wwv_flow_api.id(66677392845093807)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66687106603093923)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(66676206462093804)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_PAR'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66687524947093923)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(66676206462093804)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_PAR'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_par;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(42605783860983566)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(42604431968983553)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PAR_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_par_realm;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66687883314093923)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(66676756398093807)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66688253238093925)
,p_process_sequence=>60
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
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Parametergruppe bearbeiten'
,p_alias=>'EDIT_PGR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parametergruppe bearbeiten'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(65908675410961086)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1000'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142153'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54595776551735692)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66851579624726320)
,p_plug_name=>'Parametergruppe bearbeiten'
,p_region_name=>'EDIT_PGR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65086030068242450)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_PGR'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54594629112735681)
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
,p_attribute_06=>'UPPER'
,p_is_required=>true
,p_max_length=>128
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ITEM_IS_NOT_NULL'
,p_readonly_condition=>'PGR_ID'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54594824761735682)
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
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54594883933735683)
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
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'Y'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54595077234735685)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>40
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54595153017735686)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54595496057735689)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54928727563871620)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(54594507166735679)
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
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>false
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_add_button_label=>'Parametergruppe erstellen'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>false
,p_download_formats=>null
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(54602952032747582)
,p_interactive_grid_id=>wwv_flow_api.id(54594507166735679)
,p_static_id=>'158041'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(54603109067747582)
,p_report_id=>wwv_flow_api.id(54602952032747582)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54604113124747590)
,p_view_id=>wwv_flow_api.id(54603109067747582)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(54594629112735681)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54604618004747592)
,p_view_id=>wwv_flow_api.id(54603109067747582)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(54594824761735682)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>437
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54605105255747593)
,p_view_id=>wwv_flow_api.id(54603109067747582)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(54594883933735683)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>99
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54608943823772303)
,p_view_id=>wwv_flow_api.id(54603109067747582)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(54595077234735685)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54609921321772306)
,p_view_id=>wwv_flow_api.id(54603109067747582)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(54595496057735689)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(55202434974075176)
,p_view_id=>wwv_flow_api.id(54603109067747582)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(54928727563871620)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>107
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66855368656726329)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(54595776551735692)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66855153747726329)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(54595776551735692)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54595846617735693)
,p_tabular_form_region_id=>wwv_flow_api.id(66851579624726320)
,p_validation_name=>'Validate EDIT_PGR'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_edit_pgr;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54595583185735690)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(66855153747726329)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54595691335735691)
,p_event_id=>wwv_flow_api.id(54595583185735690)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54928449731871617)
,p_name=>'Format PGR'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(66851579624726320)
,p_triggering_element=>'PGR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54928527201871618)
,p_event_id=>wwv_flow_api.id(54928449731871617)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui.harmonize_sql_name(''PGR_ID'');'
,p_attribute_02=>'PGR_ID'
,p_attribute_03=>'PGR_ID'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(54595240567735687)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(66851579624726320)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PGR'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_pgr;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66859475321726337)
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
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'PIT administrieren'
,p_alias=>'ADMIN_PIT'
,p_step_title=>'PIT administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(66868999754824139)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201221100152'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(60164653829098234)
,p_name=>'Aktuelle Debugeinstellungen'
,p_template=>wwv_flow_api.id(65086533740242450)
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_source=>'return pit_ui.get_active_context; '
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(65095308082242454)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(60164688634098235)
,p_query_column_id=>1
,p_column_alias=>'DEBUG_LEVEL'
,p_column_display_sequence=>1
,p_column_heading=>'Debug Level'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(60164790139098236)
,p_query_column_id=>2
,p_column_alias=>'TRACE_LEVEL'
,p_column_display_sequence=>2
,p_column_heading=>'Trace Level'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(60164901828098237)
,p_query_column_id=>3
,p_column_alias=>'TRACE_TIMING'
,p_column_display_sequence=>3
,p_column_heading=>'Zeitinformationen erfassen'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(60164979439098238)
,p_query_column_id=>4
,p_column_alias=>'LOG_MODULES'
,p_column_display_sequence=>4
,p_column_heading=>'Ausgabemodule'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66841754215500059)
,p_plug_name=>'Hinweise zu Ausgabemodulen'
,p_region_name=>'output_modules'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(65082029838242448)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66841879478500060)
,p_plug_name=>'Hinweise zu Kontexten'
,p_region_name=>'contexts'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(65082029838242448)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66842814969500069)
,p_plug_name=>'Debugging nach Package filtern (Toggles)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(66843041933500071)
,p_name=>unistr('Verf\00FCgbare Toggles')
,p_parent_plug_id=>wwv_flow_api.id(66842814969500069)
,p_template=>wwv_flow_api.id(65086533740242450)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, par_id, par_pgr_id, toggle_module_list, toggle_context_name',
'  from pit_ui_admin_pit_toggle'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(65095308082242454)
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
 p_id=>wwv_flow_api.id(66843148161500072)
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
 p_id=>wwv_flow_api.id(66843182125500073)
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
 p_id=>wwv_flow_api.id(66843311314500074)
,p_query_column_id=>3
,p_column_alias=>'PAR_PGR_ID'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(66843421788500075)
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
 p_id=>wwv_flow_api.id(66843522216500076)
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
 p_id=>wwv_flow_api.id(66842856311500070)
,p_plug_name=>'Informationen zum Filter des Debuggings'
,p_region_name=>'toggles'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(65082029838242448)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66866880377799729)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65089786772242451)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(65114026726242487)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(65108045647242464)
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(66877873832803795)
,p_name=>'Installierte Ausgabemodule'
,p_template=>wwv_flow_api.id(65086533740242450)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_ADMIN_PIT_MODULE'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(65095308082242454)
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
 p_id=>wwv_flow_api.id(66841503270500056)
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
 p_id=>wwv_flow_api.id(66841175521500053)
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
 p_id=>wwv_flow_api.id(63854739562958671)
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
 p_id=>wwv_flow_api.id(66841340999500054)
,p_query_column_id=>4
,p_column_alias=>'MODULE_AVAILABLE'
,p_column_display_sequence=>4
,p_column_heading=>unistr('verf\00FCgbar')
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<i class="fa #MODULE_AVAILABLE#"/>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(66841415080500055)
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
 p_id=>wwv_flow_api.id(66969118518158031)
,p_name=>unistr('Verf\00FCgbare Kontexte')
,p_template=>wwv_flow_api.id(65086533740242450)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_ADMIN_PIT_CONTEXT'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(65095308082242454)
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
 p_id=>wwv_flow_api.id(66842365141500065)
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
 p_id=>wwv_flow_api.id(20947443428809097)
,p_query_column_id=>2
,p_column_alias=>'PAR_ID'
,p_column_display_sequence=>14
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(66970098141158036)
,p_query_column_id=>3
,p_column_alias=>'CONTEXT_NAME'
,p_column_display_sequence=>2
,p_column_heading=>'Kontext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(66970461764158036)
,p_query_column_id=>4
,p_column_alias=>'CONTEXT_DESCRIPTION'
,p_column_display_sequence=>3
,p_column_heading=>'Beschreibung'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(66970889237158036)
,p_query_column_id=>5
,p_column_alias=>'CONTEXT_SETTING'
,p_column_display_sequence=>4
,p_column_heading=>'Einstellungen'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60163701315098225)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(66877873832803795)
,p_button_name=>'HELP_OUTPUT_MODULES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107359608242462)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60164062008098228)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(66842814969500069)
,p_button_name=>'HELP_TOGGLES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107359608242462)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66844003527500081)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(66969118518158031)
,p_button_name=>'CREATE_CONTEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_CONTEXT:&SESSION.::&DEBUG.:RP,10:P10_ROWID:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66844082003500082)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(66843041933500071)
,p_button_name=>'CREATE_TOGGLE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_TOGGLE:&SESSION.::&DEBUG.:RP,12:P12_ROWID:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60164367542098231)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(66969118518158031)
,p_button_name=>'HELP_CONTEXTS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107359608242462)
,p_button_image_alt=>'HIlfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66843642106500077)
,p_name=>'P9_ALLOW_TOGGLE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(66842814969500069)
,p_use_cache_before_default=>'NO'
,p_item_default=>'pit_ui.allows_toggles'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Toggles verwenden'
,p_display_as=>'NATIVE_YES_NO'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66902570078803812)
,p_name=>'Bericht bearbeiten - Dialog geschlossen'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(66877873832803795)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66903143340803814)
,p_event_id=>wwv_flow_api.id(66902570078803812)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66877873832803795)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66842637071500067)
,p_name=>'Kontext bearbeiten - Dialog geschlossen'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(66969118518158031)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66842697483500068)
,p_event_id=>wwv_flow_api.id(66842637071500067)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66969118518158031)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66843675455500078)
,p_name=>unistr('Toggle Report Verf\00FCgbare Toggles')
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
 p_id=>wwv_flow_api.id(66843751422500079)
,p_event_id=>wwv_flow_api.id(66843675455500078)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66843041933500071)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66843889686500080)
,p_event_id=>wwv_flow_api.id(66843675455500078)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66843041933500071)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66844869845500090)
,p_event_id=>wwv_flow_api.id(66843675455500078)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(66844082003500082)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66844979127500091)
,p_event_id=>wwv_flow_api.id(66843675455500078)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(66844082003500082)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66844293587500084)
,p_event_id=>wwv_flow_api.id(66843675455500078)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui.set_allow_toggles;'
,p_attribute_02=>'P9_ALLOW_TOGGLE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66844357491500085)
,p_event_id=>wwv_flow_api.id(66843675455500078)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui.set_allow_toggles;'
,p_attribute_02=>'P9_ALLOW_TOGGLE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66844707531500088)
,p_name=>'Toggle bearbeiten - Dialog geschlossen'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(66842814969500069)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66844810036500089)
,p_event_id=>wwv_flow_api.id(66844707531500088)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66843041933500071)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60163810094098226)
,p_name=>'Show output module help'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(60163701315098225)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60163943118098227)
,p_event_id=>wwv_flow_api.id(60163810094098226)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66841754215500059)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60164119855098229)
,p_name=>'Show toggle help'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(60164062008098228)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60164220076098230)
,p_event_id=>wwv_flow_api.id(60164119855098229)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66842856311500070)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60164442516098232)
,p_name=>'Show context help'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(60164367542098231)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60164523579098233)
,p_event_id=>wwv_flow_api.id(60164442516098232)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(66841879478500060)
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Kontext administrieren'
,p_alias=>'EDIT_CONTEXT'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(66868999754824139)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_protection_level=>'C'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201222133648'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66975730920337472)
,p_plug_name=>'Kontext administrieren'
,p_region_name=>'EDIT_CONTEXT'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_CONTEXT'
,p_include_rowid_column=>true
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(66976400553337472)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66976316283337472)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(66976400553337472)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'not pit_ui.is_default_context'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66976231426337472)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(66976400553337472)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66976140212337472)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(66976400553337472)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66976779468337473)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(66976400553337472)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66841978723500061)
,p_name=>'P10_PSE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_default=>'10'
,p_prompt=>'Debug-Level'
,p_source=>'PSE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Maximaler Schweregrad, der durch diesen Kontext erlaubt wird.<br>Sollte ein Ausgabemodule eine niedrigere Ansprechschwelle haben, kann es sein, dass Meldungen nicht ausgegeben werden, obwohl der hier angegebene Schwellwert unterschritten wurde.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66842064643500062)
,p_name=>'P10_PTL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_prompt=>'Trace-Level'
,p_source=>'PTL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_TRACE_LEVEL'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Maximaler Tracelevel, der durch diesen Kontext erlaubt wird.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66842221236500063)
,p_name=>'P10_CTX_TIMING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_prompt=>'Zeitinformation erfassen'
,p_source=>'CTX_TIMING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Sollen Zeitinformationen gesammelt werden?'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66842308419500064)
,p_name=>'P10_CTX_OUTPUT_MODULES'
,p_source_data_type=>'CLOB'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_prompt=>'Ausgabemodule'
,p_source=>'CTX_OUTPUT_MODULES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_OUTPUT_MODULES'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_help_text=>'Liste der Ausgabemodule, die Log-Informationen ausgeben sollen.'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66979239436337476)
,p_name=>'P10_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Rowid'
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66979645348337493)
,p_name=>'P10_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_prompt=>'Kontext'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>120
,p_read_only_when=>'pit_ui.is_default_context'
,p_read_only_when2=>'PLSQL'
,p_read_only_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(65107169358242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Eindeutiger Bezeichner des Kontexts. Ohne Sonderzeichen und Leerzeichen. Der Name wird in Gro\00DFschreibung \00FCberf\00FChrt und muss den Namensregeln eines Oracle-Bezeichners entsprechen.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66980023349337495)
,p_name=>'P10_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66980449149337495)
,p_name=>'P10_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>800
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Optionale Beschreibung des Einsatzbereichs des Kontexts'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66980808771337495)
,p_name=>'P10_PAR_STRING_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(66975730920337472)
,p_item_source_plug_id=>wwv_flow_api.id(66975730920337472)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54925553032871588)
,p_validation_name=>'Validate EDIT_CONTEXT'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_edit_context;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66976938747337473)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(66976779468337473)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66977705497337473)
,p_event_id=>wwv_flow_api.id(66976938747337473)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(24706933703449532)
,p_name=>'Format P10_PAR_ID'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_PAR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24707031371449533)
,p_event_id=>wwv_flow_api.id(24706933703449532)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
,p_attribute_02=>'P10_PAR_ID'
,p_attribute_03=>'P10_PAR_ID'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66982763569337500)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(66975730920337472)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_CONTEXT'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66842491045500066)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(66975730920337472)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_CONTEXT'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_context;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66983611124337500)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(66976316283337472)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66983991165337500)
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
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Ausgabemodul administrieren'
,p_alias=>'EDIT_MODULE'
,p_page_mode=>'MODAL'
,p_step_title=>'Ausgabemodul administrieren'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(66868999754824139)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1200'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201221171303'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54598597167735720)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54843310533430746)
,p_plug_name=>'Ausgabemodul administrieren'
,p_region_name=>'EDIT_MODULE'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65086030068242450)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_MODULE'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54844263174430768)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54844806556430770)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54845355467430771)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54845999483430773)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54846526475430773)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54847166342430773)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54847753390430773)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54848345629430774)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54848972860430774)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54849573820430774)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54850160640430774)
,p_name=>'PAR_BOOLEAN_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_BOOLEAN_VALUE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'Flag'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_01=>'APPLICATION'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54924972946871582)
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
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(54925110440871583)
,p_name=>'PAR_IS_LOCAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAR_IS_LOCAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>unistr('\00FCberschrieben')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_attribute_01=>'<i class="fa &PAR_IS_LOCAL."/>'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(54843651283430765)
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
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>300
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(54843953635430767)
,p_interactive_grid_id=>wwv_flow_api.id(54843651283430765)
,p_static_id=>'158051'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(54844087209430767)
,p_report_id=>wwv_flow_api.id(54843953635430767)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54845129447430770)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(54844806556430770)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54845745311430773)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(54845355467430771)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54846349423430773)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(54845999483430773)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54846996753430773)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(54846526475430773)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>347
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54847550370430773)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(54847166342430773)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>273
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54848188209430773)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(54847753390430773)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54848739285430774)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(54848345629430774)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>53
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54849354509430774)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(54848972860430774)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54849948810430774)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(54849573820430774)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54850533252430774)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(54850160640430774)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>54
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54940708777091037)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(54924972946871582)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(54943769372232232)
,p_view_id=>wwv_flow_api.id(54844087209430767)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(54925110440871583)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>115
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54598925746735724)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(54598597167735720)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54598712529735721)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(54598597167735720)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66841629054500057)
,p_name=>'P11_PIT_MODULE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(54843310533430746)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54598466222735719)
,p_tabular_form_region_id=>wwv_flow_api.id(54843310533430746)
,p_validation_name=>'Validate EDIT_MODULE'
,p_validation_sequence=>110
,p_validation=>'return pit_ui.validate_edit_module;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54598797661735722)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(54598712529735721)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54598870069735723)
,p_event_id=>wwv_flow_api.id(54598797661735722)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(54850770319430776)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(54843310533430746)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_MODULE'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_module;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66939862018871814)
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
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Kontext-Toggle administrieren'
,p_alias=>'EDIT_TOGGLE'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext-Toggle administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(66868999754824139)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201219101529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(67002296032778007)
,p_plug_name=>'Kontext-Toggle administrieren'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_TOGGLE'
,p_include_rowid_column=>true
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(67003048652778007)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(66845076590500092)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(67003048652778007)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54925320023871585)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(67003048652778007)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(67002777408778007)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(67003048652778007)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(67002749335778007)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(67003048652778007)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66844562592500087)
,p_name=>'P12_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(67002296032778007)
,p_item_source_plug_id=>wwv_flow_api.id(67002296032778007)
,p_use_cache_before_default=>'NO'
,p_source=>'ROW_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(67004921721778009)
,p_name=>'P12_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(67002296032778007)
,p_item_source_plug_id=>wwv_flow_api.id(67002296032778007)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>120
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(67005340005778011)
,p_name=>'P12_TOGGLE_MODULE_LIST'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(67002296032778007)
,p_item_source_plug_id=>wwv_flow_api.id(67002296032778007)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Liste der Packages'
,p_source=>'TOGGLE_MODULE_LIST'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_AVAILABLE_PACKAGES'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(67005666462778011)
,p_name=>'P12_TOGGLE_CONTEXT_NAME'
,p_source_data_type=>'CLOB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(67002296032778007)
,p_item_source_plug_id=>wwv_flow_api.id(67002296032778007)
,p_use_cache_before_default=>'NO'
,p_prompt=>'zugeordneter Kontext'
,p_source=>'TOGGLE_CONTEXT_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CONTEXT'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Kontext w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(67006119165778011)
,p_name=>'P12_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(67002296032778007)
,p_item_source_plug_id=>wwv_flow_api.id(67002296032778007)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54925158196871584)
,p_validation_name=>'Validate EDIT_TOGGLE'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_edit_toggle;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(67003733002778007)
,p_name=>'Dialog abbrechen'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(67002749335778007)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67004225397778007)
,p_event_id=>wwv_flow_api.id(67003733002778007)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(67006467667778011)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(67002296032778007)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_TOGGLE'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_toggle;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(67007046167778011)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66844480530500086)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(67002296032778007)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_TOGGLE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P12_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_api.create_page(
 p_id=>13
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>unistr('G\00FCltigkeitsbereich administrieren')
,p_alias=>'EDIT_REALM'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('G\00FCltigkeitsbereich administrieren')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201222133529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(24702912546449491)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65082927097242448)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35909583762410314)
,p_plug_name=>unistr('G\00FCltigkeitsbereiche')
,p_region_name=>'EDIT_REALM'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65086030068242450)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_REALM'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>unistr('G\00FCltigkeitsbereiche')
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(35910914183410322)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(35911378300410322)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(35913390458410341)
,p_name=>'PRE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Bezeichner'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
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
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ITEM_IS_NOT_NULL'
,p_readonly_condition=>'PRE_ID'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(35914355421410342)
,p_name=>'PRE_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_DESCRIPTION'
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
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(35915405260410342)
,p_name=>'PRE_IS_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_IS_ACTIVE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'aktiv'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'APPLICATION'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(35910059391410316)
,p_internal_uid=>17902429915584531
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_download_formats=>null
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(35910460369410317)
,p_interactive_grid_id=>wwv_flow_api.id(35910059391410316)
,p_static_id=>'179029'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(35910634153410317)
,p_report_id=>wwv_flow_api.id(35910460369410317)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35911740664410324)
,p_view_id=>wwv_flow_api.id(35910634153410317)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(35911378300410322)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35913761157410342)
,p_view_id=>wwv_flow_api.id(35910634153410317)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(35913390458410341)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35914783476410342)
,p_view_id=>wwv_flow_api.id(35910634153410317)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(35914355421410342)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35915756360410342)
,p_view_id=>wwv_flow_api.id(35910634153410317)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(35915405260410342)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(35935728746647880)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(24702912546449491)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(24703011140449492)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(24702912546449491)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(24703284615449495)
,p_validation_name=>'Validate EDIT_REALM'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_edit_realm;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(24703044032449493)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(24703011140449492)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24703170919449494)
,p_event_id=>wwv_flow_api.id(24703044032449493)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(24706774366449530)
,p_name=>'Format PRE_ID'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(35909583762410314)
,p_triggering_element=>'PRE_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24706890816449531)
,p_event_id=>wwv_flow_api.id(24706774366449530)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pit_ui.harmonize_sql_name(''PRE_ID'');'
,p_attribute_02=>'PRE_ID'
,p_attribute_03=>'PRE_ID'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(35916349057410344)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(35909583762410314)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>unistr('G\00FCltigkeitsbereich administrieren - Save Interactive Grid Data')
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.process_edit_realm;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(24703403345449496)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00016
begin
wwv_flow_api.create_page(
 p_id=>16
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>unistr('Stammdaten exportieren und \00FCbersetzen')
,p_alias=>'EXPORT'
,p_step_title=>unistr('Stammdaten exportieren und \00FCbersetzen')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(67023363277089532)
,p_javascript_file_urls=>'#APP_IMAGES#condes.pit.utils.js'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201221161704'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54926228509871595)
,p_plug_name=>'linke Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54926501632871597)
,p_plug_name=>unistr('Begriffe exportieren und \00FCbersetzen')
,p_parent_plug_id=>wwv_flow_api.id(54926228509871595)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'pit_ui.has_translatable_items'
,p_plug_display_when_cond2=>'PLSQL'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(67050222698643254)
,p_plug_name=>unistr('Meldungen exportieren und \00FCbersetzen')
,p_parent_plug_id=>wwv_flow_api.id(54926228509871595)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54926326939871596)
,p_plug_name=>'rechte Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65078406210242445)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(67050283919643255)
,p_plug_name=>'Parameter exportieren'
,p_parent_plug_id=>wwv_flow_api.id(54926326939871596)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(67028656396152207)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(65089786772242451)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(65114026726242487)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(65108045647242464)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54928989817871622)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(54926501632871597)
,p_button_name=>'IMPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('\00DCbersetzung laden')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54929090788871623)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(67050222698643254)
,p_button_name=>'IMPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('\00DCbersetzung laden')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54925942318871592)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(67050222698643254)
,p_button_name=>'TRANSLATE_PMS'
,p_button_static_id=>'TRANSLATE_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('Meldung \00FCbersetzen')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54926940055871602)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(54926501632871597)
,p_button_name=>'TRANSLATE_PTI'
,p_button_static_id=>'TRANSLATE_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>unistr('Begriffe \00FCbersetzen')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54926888111871601)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(54926501632871597)
,p_button_name=>'EXPORT_PTI'
,p_button_static_id=>'EXPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Begriffe exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(67049906362643251)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(67050222698643254)
,p_button_name=>'EXPORT_PMS'
,p_button_static_id=>'EXPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Meldungen exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(54925658152871589)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(67050283919643255)
,p_button_name=>'EXPORT_LOCAL_PAR'
,p_button_static_id=>'EXPORT_LOCAL_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Lokale Parameter exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'pit_ui.has_local_parameters'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(67050928505643261)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(67050283919643255)
,p_button_name=>'EXPORT_PAR'
,p_button_static_id=>'EXPORT_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_image_alt=>'Parametergruppen exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54925881390871591)
,p_name=>'P16_PMS_PML_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(67050222698643254)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Zielsprache w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54926070829871593)
,p_name=>'P16_HINT_PMS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(67050222698643254)
,p_prompt=>'Hint pms'
,p_source=>'apex_lang.message(''HINT_PMS'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(65106853986242462)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54926593714871598)
,p_name=>'P16_PTI_PMG_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(54926501632871597)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PMS_PMG_IN_USE'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54926680969871599)
,p_name=>'P16_HINT_PTI'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(54926501632871597)
,p_prompt=>'Hint pti'
,p_source=>'apex_lang.message(''HINT_PTI'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(65106853986242462)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54926805360871600)
,p_name=>'P16_PTI_PML_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(54926501632871597)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Zielsprache w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54928871907871621)
,p_name=>'P16_PTI_XLIFF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(54926501632871597)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
,p_attribute_12=>'NATIVE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54929143107871624)
,p_name=>'P16_PMS_XLIFF'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(67050222698643254)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
,p_attribute_12=>'NATIVE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(67049774227643250)
,p_name=>'P16_PMS_PMG_LIST'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(67050222698643254)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PMS_PMG_IN_USE'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(67050819444643260)
,p_name=>'P16_PAR_PGR_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(67050283919643255)
,p_prompt=>'Parametergruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Bewegen Sie alle Parametergruppen, die Sie exportieren m\00F6chten, in die rechte Spalte.')
,p_attribute_01=>'MOVE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54598366157735718)
,p_validation_name=>'Validate EXPORT'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.validate_export;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(67051144925643263)
,p_name=>'ControlExportItems'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.control-export'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54926188751871594)
,p_event_id=>wwv_flow_api.id(67051144925643263)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'condes.pit.utils.controlExportItems();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54929237550871625)
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
 p_id=>wwv_flow_api.id(54929364866871626)
,p_event_id=>wwv_flow_api.id(54929237550871625)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(54929090788871623)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54929433658871627)
,p_event_id=>wwv_flow_api.id(54929237550871625)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(54929090788871623)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55235546818863879)
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
 p_id=>wwv_flow_api.id(55235697114863880)
,p_event_id=>wwv_flow_api.id(55235546818863879)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(54928989817871622)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55235820668863881)
,p_event_id=>wwv_flow_api.id(55235546818863879)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(54928989817871622)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(67050029868643252)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EXPORT'
,p_process_sql_clob=>'pit_ui.process_export;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(65112713542242473)
,p_name=>'Login Page'
,p_alias=>'LOGIN_DESKTOP'
,p_step_title=>'PIT-Administration - Log In'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(65074788609242442)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201221134959'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(65113157351242482)
,p_plug_name=>'Log In'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(65086533740242450)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(65113522625242486)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(65113157351242482)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(65107450896242464)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Log In'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_alignment=>'LEFT'
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65113301500242486)
,p_name=>'P101_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(65113157351242482)
,p_prompt=>'Benutzer'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(65113439797242486)
,p_name=>'P101_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(65113157351242482)
,p_prompt=>'Passwort'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(65106981691242462)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(65113677847242487)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P101_USERNAME) );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(65113561737242486)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P101_USERNAME,',
'    p_password => :P101_PASSWORD );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(65113894861242487)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(65113817363242487)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>':P101_USERNAME := apex_authentication.get_login_username_cookie;'
,p_process_clob_language=>'PLSQL'
);
end;
/
prompt --application/deployment/definition
begin
wwv_flow_api.create_install(
 p_id=>wwv_flow_api.id(66868705412814017)
);
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
