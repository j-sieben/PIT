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
,p_default_workspace_id=>37000359328590246
,p_default_application_id=>300
,p_default_id_offset=>144598841174826025
,p_default_owner=>'ADC_APP'
);
end;
/
 
prompt APPLICATION 300 - PIT-Administration
--
-- Application Export:
--   Application:     300
--   Name:            PIT-Administration
--   Date and Time:   17:58 Thursday February 3, 2022
--   Exported By:     ADC_ADMIN
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
,p_owner=>nvl(wwv_flow_application_install.get_schema,'ADC_APP')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'PIT-Administration')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'PITADC')
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
,p_authentication_id=>wwv_flow_api.id(175903795896657329)
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
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127143829'
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
 p_id=>wwv_flow_api.id(168330395671949782)
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
 p_id=>wwv_flow_api.id(175861208437657285)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(175904997398657340)
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
 p_id=>wwv_flow_api.id(177657362161214579)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'PIT administrieren'
,p_list_item_link_target=>'F?p=&APP_ALIAS.:ADMIN_PIT:&SESSION.'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_api.id(175904997398657340)
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
 p_id=>wwv_flow_api.id(175921775232870403)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Meldungen administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_list_item_icon=>'fa-comment-o'
,p_parent_list_item_id=>wwv_flow_api.id(175904997398657340)
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
 p_id=>wwv_flow_api.id(176704677738762887)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Parameter administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PARAM:&SESSION.'
,p_list_item_icon=>'fa-cog'
,p_parent_list_item_id=>wwv_flow_api.id(175904997398657340)
,p_list_text_01=>'Parameter erstellen und editieren'
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from pit_ui_list_active_for_page',
' where page_group = ''PARAMETER'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(177811992993486492)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Stammdaten'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:EXPORT:&SESSION.'
,p_list_item_icon=>'fa-exchange'
,p_parent_list_item_id=>wwv_flow_api.id(175904997398657340)
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
 p_id=>wwv_flow_api.id(175903579527657326)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(175903784483657328)
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
 p_id=>wwv_flow_api.id(165844030146423062)
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
 p_id=>wwv_flow_api.id(144598973683826102)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(144599502921826103)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attribute_01=>'fa-star'
,p_attribute_04=>'#VALUE#'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(161163822489463303)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_RICH_TEXT_EDITOR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(168324659056932402)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'LEGACY'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(168324702035932402)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'classic'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(175860939759657285)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(175861085923657285)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH_CB'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(175861122877657285)
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
 p_id=>wwv_flow_api.id(177804086532318056)
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
 p_id=>wwv_flow_api.id(145653971965309925)
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
 p_id=>wwv_flow_api.id(177805025307350868)
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
 p_id=>wwv_flow_api.id(177779222016884782)
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
 p_id=>wwv_flow_api.id(176730063884849151)
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
 p_id=>wwv_flow_api.id(153453428970054090)
,p_lov_name=>'LOV_PARAMETER_REALM'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_PARAMETER_REALM'
,p_query_where=>'pre_is_active = (select utl_apex.c_true from dual)'
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
 p_id=>wwv_flow_api.id(176730225375851737)
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
 p_id=>wwv_flow_api.id(156261449181962546)
,p_lov_name=>'LOV_PAR_IS_MODIFIABLE'
,p_lov_query=>'.'||wwv_flow_api.id(156261449181962546)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(156261721979962549)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Editieren sperren'
,p_lov_return_value=>'Nein'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pit_message_group
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(168366447816135700)
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
 p_id=>wwv_flow_api.id(175960830946617273)
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
 p_id=>wwv_flow_api.id(175954524447389762)
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
 p_id=>wwv_flow_api.id(175954783554392895)
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
 p_id=>wwv_flow_api.id(168368361223171446)
,p_lov_name=>'LOV_PML_NAME_IN_USE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PIT_UI_LOV_MESSAGE_LANGUAGE'
,p_query_where=>'pml_in_use = (select utl_apex.c_true from dual)'
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
 p_id=>wwv_flow_api.id(165861145510332299)
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
 p_id=>wwv_flow_api.id(177814299970504385)
,p_group_name=>'EXPORT'
,p_group_desc=>'Export von Stammdaten'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(176699484451373914)
,p_group_name=>'MAIN'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(176699523686374634)
,p_group_name=>'MESSAGE'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(176699612104375939)
,p_group_name=>'PARAMETER'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(177659936448238992)
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
 p_id=>wwv_flow_api.id(175904963419657340)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(175905320607657342)
,p_parent_id=>0
,p_short_name=>'Startseite'
,p_link=>'f?p=&APP_ALIAS.:MAIN:&SESSION.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(175928623491870432)
,p_parent_id=>wwv_flow_api.id(175905320607657342)
,p_short_name=>'Meldungen administrieren'
,p_link=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(177488593016508804)
,p_parent_id=>wwv_flow_api.id(175905320607657342)
,p_short_name=>'Parameter verwalten'
,p_link=>'f?p=&APP_ID.:6:&SESSION.'
,p_page_id=>6
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(177658193802214584)
,p_parent_id=>wwv_flow_api.id(175905320607657342)
,p_short_name=>'PIT administrieren'
,p_link=>'f?p=&APP_ID.:9:&SESSION.'
,p_page_id=>9
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(177820052373567060)
,p_parent_id=>wwv_flow_api.id(175905320607657342)
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
 p_id=>wwv_flow_api.id(175861297939657290)
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
 p_id=>wwv_flow_api.id(144838318277842297)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144838816140842297)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144839295443842297)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144839817742842298)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144840349310842298)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144840778731842298)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144841364491842298)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144841807346842298)
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
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
 p_id=>wwv_flow_api.id(175862196956657293)
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
 p_id=>wwv_flow_api.id(144846479477842303)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144846969776842303)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144847513017842303)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144847997166842303)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144848528207842303)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144849030494842303)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144849477794842305)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144850024599842305)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144850488539842305)
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
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
 p_id=>wwv_flow_api.id(175863240118657293)
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
 p_id=>wwv_flow_api.id(144870894218842313)
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144871373847842313)
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144871936455842313)
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144872382019842313)
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144872942263842313)
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144873396922842313)
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144873884893842313)
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
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
 p_id=>wwv_flow_api.id(175863997791657293)
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
 p_id=>wwv_flow_api.id(144881833254842316)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144882294118842316)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144882783533842316)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144883314806842317)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144883805061842317)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144884346451842317)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144884769930842317)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144885346567842317)
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
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
 p_id=>wwv_flow_api.id(175864976047657295)
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
 p_id=>wwv_flow_api.id(144889205556842319)
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144889679005842319)
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144890176127842319)
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144890759084842319)
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144891245975842319)
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144891694096842319)
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144892224955842319)
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
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
 p_id=>wwv_flow_api.id(175865725302657295)
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
 p_id=>wwv_flow_api.id(144852370507842305)
,p_page_template_id=>wwv_flow_api.id(175865725302657295)
,p_name=>'Body Footer'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144852944050842305)
,p_page_template_id=>wwv_flow_api.id(175865725302657295)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144853451532842305)
,p_page_template_id=>wwv_flow_api.id(175865725302657295)
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
 p_id=>wwv_flow_api.id(175866027859657295)
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
 p_id=>wwv_flow_api.id(144862990407842309)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144863494962842309)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144864019252842309)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144864556154842309)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144865059010842311)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144865503972842311)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144865982876842311)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144866504641842311)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144866981627842311)
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
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
 p_id=>wwv_flow_api.id(175867084347657295)
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
 p_id=>wwv_flow_api.id(144876242980842314)
,p_page_template_id=>wwv_flow_api.id(175867084347657295)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144876689534842314)
,p_page_template_id=>wwv_flow_api.id(175867084347657295)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144877213590842314)
,p_page_template_id=>wwv_flow_api.id(175867084347657295)
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
 p_id=>wwv_flow_api.id(175867417265657295)
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
 p_id=>wwv_flow_api.id(144894521725842320)
,p_page_template_id=>wwv_flow_api.id(175867417265657295)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144895036770842320)
,p_page_template_id=>wwv_flow_api.id(175867417265657295)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(144895470743842320)
,p_page_template_id=>wwv_flow_api.id(175867417265657295)
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
 p_id=>wwv_flow_api.id(175898296301657315)
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
 p_id=>wwv_flow_api.id(175898387589657317)
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
 p_id=>wwv_flow_api.id(175898514445657317)
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
 p_id=>wwv_flow_api.id(145001450572842370)
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
 p_id=>wwv_flow_api.id(161516502917499725)
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
 p_id=>wwv_flow_api.id(161519669284499731)
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
 p_id=>wwv_flow_api.id(144906164388842328)
,p_plug_template_id=>wwv_flow_api.id(161519669284499731)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(144906607441842328)
,p_plug_template_id=>wwv_flow_api.id(161519669284499731)
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
 p_id=>wwv_flow_api.id(161521131458499731)
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
 p_id=>wwv_flow_api.id(144955131069842350)
,p_plug_template_id=>wwv_flow_api.id(161521131458499731)
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
 p_id=>wwv_flow_api.id(175867836860657296)
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
 p_id=>wwv_flow_api.id(144897362275842325)
,p_plug_template_id=>wwv_flow_api.id(175867836860657296)
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
 p_id=>wwv_flow_api.id(175869342903657298)
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
 p_id=>wwv_flow_api.id(175869428677657298)
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
 p_id=>wwv_flow_api.id(144913065524842331)
,p_plug_template_id=>wwv_flow_api.id(175869428677657298)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(144913505010842331)
,p_plug_template_id=>wwv_flow_api.id(175869428677657298)
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
 p_id=>wwv_flow_api.id(175872966531657301)
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
 p_id=>wwv_flow_api.id(144950644759842347)
,p_plug_template_id=>wwv_flow_api.id(175872966531657301)
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
 p_id=>wwv_flow_api.id(175873863790657301)
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
 p_id=>wwv_flow_api.id(144908236092842328)
,p_plug_template_id=>wwv_flow_api.id(175873863790657301)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(144908725024842330)
,p_plug_template_id=>wwv_flow_api.id(175873863790657301)
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
 p_id=>wwv_flow_api.id(175874646339657301)
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
 p_id=>wwv_flow_api.id(144929203882842338)
,p_plug_template_id=>wwv_flow_api.id(175874646339657301)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(144929672591842338)
,p_plug_template_id=>wwv_flow_api.id(175874646339657301)
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
 p_id=>wwv_flow_api.id(175876766361657303)
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
 p_id=>wwv_flow_api.id(144946095261842345)
,p_plug_template_id=>wwv_flow_api.id(175876766361657303)
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
 p_id=>wwv_flow_api.id(175876966761657303)
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
 p_id=>wwv_flow_api.id(175877267636657303)
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
 p_id=>wwv_flow_api.id(144967739690842355)
,p_plug_template_id=>wwv_flow_api.id(175877267636657303)
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
 p_id=>wwv_flow_api.id(175877470433657303)
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
 p_id=>wwv_flow_api.id(144973227151842356)
,p_plug_template_id=>wwv_flow_api.id(175877470433657303)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(144973750861842356)
,p_plug_template_id=>wwv_flow_api.id(175877470433657303)
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
 p_id=>wwv_flow_api.id(175879544698657303)
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
 p_id=>wwv_flow_api.id(144992383437842366)
,p_plug_template_id=>wwv_flow_api.id(175879544698657303)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(144992951770842366)
,p_plug_template_id=>wwv_flow_api.id(175879544698657303)
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
 p_id=>wwv_flow_api.id(175880723465657304)
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
 p_id=>wwv_flow_api.id(175881195642657304)
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
 p_id=>wwv_flow_api.id(144999502351842369)
,p_plug_template_id=>wwv_flow_api.id(175881195642657304)
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
 p_id=>wwv_flow_api.id(145058717013842402)
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
 p_id=>wwv_flow_api.id(161584162435499764)
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
 p_id=>wwv_flow_api.id(175889630959657309)
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
 p_id=>wwv_flow_api.id(175891339968657310)
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
 p_id=>wwv_flow_api.id(175893411395657312)
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
 p_id=>wwv_flow_api.id(175893963744657312)
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
 p_id=>wwv_flow_api.id(175894001230657312)
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
 p_id=>wwv_flow_api.id(175894944660657314)
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
 p_id=>wwv_flow_api.id(175895481641657314)
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
 p_id=>wwv_flow_api.id(175896199859657314)
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
 p_id=>wwv_flow_api.id(175896292823657314)
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
 p_id=>wwv_flow_api.id(175897261667657314)
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
 p_id=>wwv_flow_api.id(175897325042657314)
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
 p_id=>wwv_flow_api.id(145111888852842428)
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
 p_id=>wwv_flow_api.id(161636266526499788)
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
 p_id=>wwv_flow_api.id(175881809581657304)
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
 p_id=>wwv_flow_api.id(175881966059657306)
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
 p_id=>wwv_flow_api.id(175883627845657306)
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
 p_id=>wwv_flow_api.id(175885770674657307)
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
 p_id=>wwv_flow_api.id(175886184813657307)
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
 p_id=>wwv_flow_api.id(175886244775657307)
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
 p_id=>wwv_flow_api.id(175886244775657307)
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
 p_id=>wwv_flow_api.id(175887515539657307)
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
 p_id=>wwv_flow_api.id(175888506732657309)
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
 p_id=>wwv_flow_api.id(175889463251657309)
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
 p_id=>wwv_flow_api.id(161642779429499794)
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
 p_id=>wwv_flow_api.id(161643096258499794)
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
 p_id=>wwv_flow_api.id(175897790679657315)
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
 p_id=>wwv_flow_api.id(175897918384657315)
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
 p_id=>wwv_flow_api.id(175898062714657315)
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
 p_id=>wwv_flow_api.id(175898106051657315)
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
 p_id=>wwv_flow_api.id(175898281214657315)
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
 p_id=>wwv_flow_api.id(175898982340657317)
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
 p_id=>wwv_flow_api.id(175899148282657318)
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
 p_id=>wwv_flow_api.id(175899054779657317)
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
 p_id=>wwv_flow_api.id(175899552897657321)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(175864976047657295)
,p_default_dialog_template=>wwv_flow_api.id(175867084347657295)
,p_error_template=>wwv_flow_api.id(175865725302657295)
,p_printer_friendly_template=>wwv_flow_api.id(175864976047657295)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(175865725302657295)
,p_default_button_template=>wwv_flow_api.id(175898387589657317)
,p_default_region_template=>wwv_flow_api.id(175877470433657303)
,p_default_chart_template=>wwv_flow_api.id(175877470433657303)
,p_default_form_template=>wwv_flow_api.id(175877470433657303)
,p_default_reportr_template=>wwv_flow_api.id(175877470433657303)
,p_default_tabform_template=>wwv_flow_api.id(175877470433657303)
,p_default_wizard_template=>wwv_flow_api.id(175877470433657303)
,p_default_menur_template=>wwv_flow_api.id(175880723465657304)
,p_default_listr_template=>wwv_flow_api.id(175877470433657303)
,p_default_irr_template=>wwv_flow_api.id(175876966761657303)
,p_default_report_template=>wwv_flow_api.id(175886244775657307)
,p_default_label_template=>wwv_flow_api.id(175897918384657315)
,p_default_menu_template=>wwv_flow_api.id(175898982340657317)
,p_default_calendar_template=>wwv_flow_api.id(175899054779657317)
,p_default_list_template=>wwv_flow_api.id(175895481641657314)
,p_default_nav_list_template=>wwv_flow_api.id(175897325042657314)
,p_default_top_nav_list_temp=>wwv_flow_api.id(175897325042657314)
,p_default_side_nav_list_temp=>wwv_flow_api.id(175897261667657314)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(175873863790657301)
,p_default_dialogr_template=>wwv_flow_api.id(175869342903657298)
,p_default_option_label=>wwv_flow_api.id(175897918384657315)
,p_default_required_label=>wwv_flow_api.id(175898106051657315)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(175893963744657312)
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
 p_id=>wwv_flow_api.id(144607248929842208)
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
 p_id=>wwv_flow_api.id(144607624163842209)
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
 p_id=>wwv_flow_api.id(144608063305842209)
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
 p_id=>wwv_flow_api.id(144608465124842209)
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
 p_id=>wwv_flow_api.id(144608770980842209)
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
 p_id=>wwv_flow_api.id(144609252420842209)
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
 p_id=>wwv_flow_api.id(144729504794842255)
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
 p_id=>wwv_flow_api.id(144729869572842256)
,p_theme_id=>42
,p_name=>'ICON_HOVER_ANIMATION'
,p_display_name=>'Icon Hover Animation'
,p_display_sequence=>55
,p_template_types=>'BUTTON'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144730359154842256)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144730743853842256)
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
 p_id=>wwv_flow_api.id(144731124957842256)
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
 p_id=>wwv_flow_api.id(144731504237842256)
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
 p_id=>wwv_flow_api.id(144731904295842256)
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
 p_id=>wwv_flow_api.id(144732325205842256)
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
 p_id=>wwv_flow_api.id(144732671390842256)
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
 p_id=>wwv_flow_api.id(144733100218842256)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144733517748842256)
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
 p_id=>wwv_flow_api.id(144733879420842256)
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
 p_id=>wwv_flow_api.id(144734326138842256)
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
 p_id=>wwv_flow_api.id(144734750803842256)
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
 p_id=>wwv_flow_api.id(144735108736842256)
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
 p_id=>wwv_flow_api.id(144735467789842258)
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
 p_id=>wwv_flow_api.id(144735881615842258)
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
 p_id=>wwv_flow_api.id(144736332110842258)
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
 p_id=>wwv_flow_api.id(144736735523842258)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144737079024842258)
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
 p_id=>wwv_flow_api.id(144737471688842258)
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
 p_id=>wwv_flow_api.id(144737940936842258)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144738356700842258)
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
 p_id=>wwv_flow_api.id(144738720775842258)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE'
,p_display_name=>'Collapse Mode'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144739091344842258)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144739507769842258)
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
 p_id=>wwv_flow_api.id(144739940101842258)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144740275463842258)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144740729028842259)
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
 p_id=>wwv_flow_api.id(144741125597842259)
,p_theme_id=>42
,p_name=>'ICON_STYLE'
,p_display_name=>'Icon Style'
,p_display_sequence=>35
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144741484640842259)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144741966168842259)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144742320528842259)
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
 p_id=>wwv_flow_api.id(144742678403842259)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144743155002842259)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144743560156842259)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND'
,p_display_name=>'Page Background'
,p_display_sequence=>20
,p_template_types=>'PAGE'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144743901779842259)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT'
,p_display_name=>'Page Layout'
,p_display_sequence=>10
,p_template_types=>'PAGE'
,p_null_text=>'Floating (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144744280317842259)
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
 p_id=>wwv_flow_api.id(144744750064842259)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144745119971842259)
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
 p_id=>wwv_flow_api.id(144745483677842259)
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
 p_id=>wwv_flow_api.id(144745879785842259)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144746333162842261)
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
 p_id=>wwv_flow_api.id(144746733219842261)
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
 p_id=>wwv_flow_api.id(144747085386842261)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144747523023842261)
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
 p_id=>wwv_flow_api.id(144747928268842261)
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
 p_id=>wwv_flow_api.id(144748351502842261)
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
 p_id=>wwv_flow_api.id(144748715021842261)
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
 p_id=>wwv_flow_api.id(144749150956842261)
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
 p_id=>wwv_flow_api.id(144749513214842261)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144749904641842261)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144750285829842261)
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
 p_id=>wwv_flow_api.id(144750748909842261)
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
 p_id=>wwv_flow_api.id(144751080989842261)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144751526832842261)
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
 p_id=>wwv_flow_api.id(144751917551842263)
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
 p_id=>wwv_flow_api.id(144752336720842263)
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
 p_id=>wwv_flow_api.id(144752750811842263)
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
 p_id=>wwv_flow_api.id(144753154896842263)
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
 p_id=>wwv_flow_api.id(144753529614842263)
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
 p_id=>wwv_flow_api.id(144753909217842263)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144754302230842263)
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
 p_id=>wwv_flow_api.id(144754714342842263)
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
 p_id=>wwv_flow_api.id(144755107694842263)
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
 p_id=>wwv_flow_api.id(144755564425842263)
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
 p_id=>wwv_flow_api.id(144755941996842263)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144756276464842263)
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
 p_id=>wwv_flow_api.id(144756674454842263)
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
 p_id=>wwv_flow_api.id(144757088264842264)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144757481738842264)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144757899251842264)
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
 p_id=>wwv_flow_api.id(144758344164842264)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144758679115842264)
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
 p_id=>wwv_flow_api.id(144759103354842264)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144759473987842264)
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
 p_id=>wwv_flow_api.id(144759889088842264)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144760292386842264)
,p_theme_id=>42
,p_name=>'COL_ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>150
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144760689847842264)
,p_theme_id=>42
,p_name=>'COL_CONTENT_DESCRIPTION'
,p_display_name=>'Description'
,p_display_sequence=>130
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144761136673842264)
,p_theme_id=>42
,p_name=>'COL_CONTENT_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>120
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144761469760842264)
,p_theme_id=>42
,p_name=>'COL_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>110
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144761895418842264)
,p_theme_id=>42
,p_name=>'COL_MISC'
,p_display_name=>'Misc'
,p_display_sequence=>140
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144762286298842264)
,p_theme_id=>42
,p_name=>'COL_SELECTION'
,p_display_name=>'Selection'
,p_display_sequence=>100
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144762742238842266)
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
 p_id=>wwv_flow_api.id(144763130588842266)
,p_theme_id=>42
,p_name=>'CONTENT_ALIGNMENT'
,p_display_name=>'Content Alignment'
,p_display_sequence=>90
,p_template_types=>'REPORT'
,p_null_text=>'Center (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144763499360842266)
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
 p_id=>wwv_flow_api.id(144763944391842266)
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
 p_id=>wwv_flow_api.id(144764309504842266)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144764755306842266)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144765132578842266)
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
 p_id=>wwv_flow_api.id(144765546749842266)
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
 p_id=>wwv_flow_api.id(144765891693842266)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144766277759842266)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(144766713513842266)
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
 p_id=>wwv_flow_api.id(144787857120842277)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(144733879420842256)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144788505387842277)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(144754714342842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144789252302842277)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(144733879420842256)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144789956106842277)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(144754714342842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144790580611842277)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(144733879420842256)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144791352645842277)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(144754714342842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144792018570842278)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(144733879420842256)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144792756205842278)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(144754714342842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144793432011842278)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(144735108736842256)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144794110620842278)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(144755107694842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144794800870842278)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(144735108736842256)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144795548327842278)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(144755107694842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144796264613842280)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(144735108736842256)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144796918879842280)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(144755107694842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144797569397842280)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(144735108736842256)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144798302373842280)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(144755107694842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144798982260842280)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(144736332110842258)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144799747914842280)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(144755564425842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144800381986842280)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(144736332110842258)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144801092348842281)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(144755564425842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144801770983842281)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(144736332110842258)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144802548550842281)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(144755564425842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144803174053842281)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(144736332110842258)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144803944857842281)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(144755564425842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144804619684842281)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(144737079024842258)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144805346263842283)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(144756276464842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144806033190842283)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(144737079024842258)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144806724064842283)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(144756276464842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144807463884842283)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(144737079024842258)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144808088351842283)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(144756276464842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144808840224842283)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(144737079024842258)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144809556758842284)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(144756276464842263)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144810179494842284)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(144730743853842256)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144810949122842284)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(144733100218842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144811593562842284)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(144731504237842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144812357239842284)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(144731904295842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144813020077842284)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(144731124957842256)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144813747833842284)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(144732325205842256)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144814371205842286)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(144732671390842256)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144815090249842286)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(144732671390842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144815800276842286)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(144731124957842256)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144816537072842286)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(144731504237842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144817177888842286)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(144731904295842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144817919449842288)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(144732325205842256)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144818583927842288)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(144729504794842255)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144819274842842288)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(144729504794842255)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144820061784842288)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(144729504794842255)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144820681801842288)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(144733100218842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144821440561842288)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(144732671390842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144822157530842289)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(144730743853842256)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144822784030842289)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(144733517748842256)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144823477434842289)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(144733100218842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144824167399842289)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(144730743853842256)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144824909835842289)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(144733100218842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144825613398842289)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(144753529614842263)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144826313264842289)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(144752336720842263)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144827052405842291)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(144753154896842263)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144827741711842291)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(144751917551842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144828387889842291)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(144751917551842263)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144829091514842291)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(144752750811842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144829767232842291)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(144752336720842263)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144830526902842291)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(144734326138842256)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144831219488842291)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(144734750803842256)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144831950156842292)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(144736735523842258)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144832643129842292)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(144736735523842258)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144833321009842292)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(144735881615842258)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144833740792842292)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144834420081842292)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_api.id(144765132578842266)
,p_template_types=>'REPORT'
,p_help_text=>'This option will hide the pagination when all rows are displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144854259866842306)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT_SPLIT'
,p_display_name=>'Split'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(175865725302657295)
,p_css_classes=>'t-LoginPage--split'
,p_group_id=>wwv_flow_api.id(144743901779842259)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144854956555842306)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_1'
,p_display_name=>'Background 1'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(175865725302657295)
,p_css_classes=>'t-LoginPage--bg1'
,p_group_id=>wwv_flow_api.id(144743560156842259)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144855637369842306)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_2'
,p_display_name=>'Background 2'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(175865725302657295)
,p_css_classes=>'t-LoginPage--bg2'
,p_group_id=>wwv_flow_api.id(144743560156842259)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144856319242842306)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_3'
,p_display_name=>'Background 3'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_api.id(175865725302657295)
,p_css_classes=>'t-LoginPage--bg3'
,p_group_id=>wwv_flow_api.id(144743560156842259)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144955607744842350)
,p_theme_id=>42
,p_name=>'DISPLAY_POPUP_CALLOUT'
,p_display_name=>'Display Popup Callout'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-popup-callout'
,p_template_types=>'REGION'
,p_help_text=>'Use this option to add display a callout for the popup. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144956364827842350)
,p_theme_id=>42
,p_name=>'BEFORE'
,p_display_name=>'Before'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-popup-pos-before'
,p_group_id=>wwv_flow_api.id(144748351502842261)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout before or typically to the left of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144957023215842350)
,p_theme_id=>42
,p_name=>'AFTER'
,p_display_name=>'After'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-popup-pos-after'
,p_group_id=>wwv_flow_api.id(144748351502842261)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout after or typically to the right of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144957725704842350)
,p_theme_id=>42
,p_name=>'ABOVE'
,p_display_name=>'Above'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-popup-pos-above'
,p_group_id=>wwv_flow_api.id(144748351502842261)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout above or typically on top of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144958442755842352)
,p_theme_id=>42
,p_name=>'BELOW'
,p_display_name=>'Below'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-popup-pos-below'
,p_group_id=>wwv_flow_api.id(144748351502842261)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout below or typically to the bottom of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144959122439842352)
,p_theme_id=>42
,p_name=>'INSIDE'
,p_display_name=>'Inside'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-popup-pos-inside'
,p_group_id=>wwv_flow_api.id(144748351502842261)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout inside of the parent. This is useful when the parent is sufficiently large, such as a report or large region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144968520549842355)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175877267636657303)
,p_css_classes=>'t-Login-region--headerIcon'
,p_group_id=>wwv_flow_api.id(144754302230842263)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Icon in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144969252956842355)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175877267636657303)
,p_css_classes=>'t-Login-region--headerTitle'
,p_group_id=>wwv_flow_api.id(144754302230842263)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Title in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(144969944350842355)
,p_theme_id=>42
,p_name=>'LOGO_HEADER_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175877267636657303)
,p_css_classes=>'t-Login-region--headerHidden'
,p_group_id=>wwv_flow_api.id(144754302230842263)
,p_template_types=>'REGION'
,p_help_text=>'Hides both the Region Icon and Title from the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145001948003842372)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(145001450572842370)
,p_css_classes=>'t-CardsRegion--styleA'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145002296775842372)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(145001450572842370)
,p_css_classes=>'t-CardsRegion--styleB'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145002723749842373)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Style C'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(145001450572842370)
,p_css_classes=>'t-CardsRegion--styleC'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145003068984842373)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(145001450572842370)
,p_css_classes=>'u-colors'
,p_template_types=>'REGION'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145036551475842391)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(175893411395657312)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145038439797842391)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175896199859657314)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145039754394842392)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175893963744657312)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145041010021842392)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_css_classes=>'js-navCollapsed--hidden'
,p_group_id=>wwv_flow_api.id(144738720775842258)
,p_template_types=>'LIST'
,p_help_text=>'Completely hide the navigation menu when it is collapsed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145041402069842394)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145042083488842394)
,p_theme_id=>42
,p_name=>'ICON_DEFAULT'
,p_display_name=>'Icon (Default)'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_css_classes=>'js-navCollapsed--default'
,p_group_id=>wwv_flow_api.id(144738720775842258)
,p_template_types=>'LIST'
,p_help_text=>'Display icons when the navigation menu is collapsed for large screens.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145051183473842397)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(175897325042657314)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145059219983842402)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145059590811842403)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Displays a callout arrow that points to where the menu was activated from.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145060059567842403)
,p_theme_id=>42
,p_name=>'FULL_WIDTH'
,p_display_name=>'Full Width'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'t-MegaMenu--fullWidth'
,p_template_types=>'LIST'
,p_help_text=>'Stretches the menu to fill the width of the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145060463121842403)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'t-MegaMenu--layout2Cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145060831518842403)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'t-MegaMenu--layout3Cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145061257225842403)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'t-MegaMenu--layout4Cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145061617257842403)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'t-MegaMenu--layout5Cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145062047311842403)
,p_theme_id=>42
,p_name=>'CUSTOM'
,p_display_name=>'Custom'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'t-MegaMenu--layoutCustom'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145062420923842403)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(145058717013842402)
,p_css_classes=>'t-MegaMenu--layoutStacked'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145112378324842428)
,p_theme_id=>42
,p_name=>'ALIGNMENT_TOP'
,p_display_name=>'Top'
,p_display_sequence=>100
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--alignTop'
,p_group_id=>wwv_flow_api.id(144763130588842266)
,p_template_types=>'REPORT'
,p_help_text=>'Aligns the content to the top of the row. This is useful when you expect that yours rows will vary in height (e.g. some rows will have longer descriptions than others).'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145112841503842428)
,p_theme_id=>42
,p_name=>'ACTIONS_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--hideActions'
,p_group_id=>wwv_flow_api.id(144760292386842264)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Actions column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145113236800842428)
,p_theme_id=>42
,p_name=>'DESCRIPTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--hideDescription'
,p_group_id=>wwv_flow_api.id(144760689847842264)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Description from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145113648916842428)
,p_theme_id=>42
,p_name=>'ICON_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--hideIcon'
,p_group_id=>wwv_flow_api.id(144761469760842264)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Icon from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145114007407842430)
,p_theme_id=>42
,p_name=>'MISC_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--hideMisc'
,p_group_id=>wwv_flow_api.id(144761895418842264)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Misc column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145114366659842430)
,p_theme_id=>42
,p_name=>'SELECTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--hideSelection'
,p_group_id=>wwv_flow_api.id(144762286298842264)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Selection column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145114802676842430)
,p_theme_id=>42
,p_name=>'TITLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--hideTitle'
,p_group_id=>wwv_flow_api.id(144761136673842264)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Title from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(145115200814842430)
,p_theme_id=>42
,p_name=>'STYLE_COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(145111888852842428)
,p_css_classes=>'t-ContentRow--styleCompact'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
,p_help_text=>'This option reduces the padding and font sizes to present a compact display of the same information.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161363447983499661)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(175861297939657290)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161372537937499669)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(175862196956657293)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161383801737499672)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(175866027859657295)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161391110571499675)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(175863240118657293)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161394757053499675)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(175867084347657295)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161395182521499675)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(175867084347657295)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161403703088499678)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(175863997791657293)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161411004257499680)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(175864976047657295)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161414654072499681)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(175867417265657295)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161415126073499681)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(175867417265657295)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161417541880499686)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(144745483677842259)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161418332390499688)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(144745483677842259)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161427991654499691)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175873863790657301)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161433186994499692)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161450013337499699)
,p_theme_id=>42
,p_name=>'ICONS_PLUS_OR_MINUS'
,p_display_name=>'Plus or Minus'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--hideShowIconsMath'
,p_group_id=>wwv_flow_api.id(144748715021842261)
,p_template_types=>'REGION'
,p_help_text=>'Use the plus and minus icons for the expand and collapse button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161450658599499700)
,p_theme_id=>42
,p_name=>'CONRTOLS_POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--controlsPosEnd'
,p_group_id=>wwv_flow_api.id(144749150956842261)
,p_template_types=>'REGION'
,p_help_text=>'Position the expand / collapse button to the end of the region header.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161451119384499700)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161464426954499705)
,p_theme_id=>42
,p_name=>'ICONS_CIRCULAR'
,p_display_name=>'Circle'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175876766361657303)
,p_css_classes=>'t-HeroRegion--iconsCircle'
,p_group_id=>wwv_flow_api.id(144751526832842261)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a circle.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161465097235499705)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175876766361657303)
,p_css_classes=>'t-HeroRegion--iconsSquare'
,p_group_id=>wwv_flow_api.id(144751526832842261)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a square.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161465493426499705)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175876766361657303)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161466216959499705)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175876766361657303)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161466880836499705)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175876766361657303)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161467548805499705)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175876766361657303)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(144750285829842261)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161472447517499706)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161472863769499708)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161480786887499710)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161481473285499710)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161482165366499711)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161482848364499711)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161483558541499711)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161484260768499711)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161484966781499711)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161485698032499711)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161486402829499713)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161487106651499713)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161487736730499713)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161488454185499713)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161511676926499722)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175880723465657304)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161517010750499731)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(161516502917499725)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161517429884499731)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(161516502917499725)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(144755941996842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161517814645499731)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(161516502917499725)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(144755941996842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161518150913499731)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(161516502917499725)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(144755941996842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161518585108499731)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(161516502917499725)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(144747928268842261)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161519013207499731)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(161516502917499725)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(144747928268842261)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161519334892499731)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(161516502917499725)
,p_css_classes=>'t-ContentBlock--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161522116506499733)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161522435987499733)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(144749904641842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161522932411499733)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(144749904641842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161523269502499733)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_api.id(144749904641842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161523685183499733)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161524133294499733)
,p_theme_id=>42
,p_name=>'REMOVE_PAGE_OVERLAY'
,p_display_name=>'Remove Page Overlay'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-popup-noOverlay'
,p_template_types=>'REGION'
,p_help_text=>'This option will display the inline dialog without an overlay on the background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161524467650499733)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(161521131458499731)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(144749904641842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161525501444499736)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161526146662499736)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161526929510499736)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161537233410499741)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(144740729028842259)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161537576104499741)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161538252519499741)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161539018490499741)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161539678163499742)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(144737471688842258)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161540409261499742)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(144737471688842258)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161541122757499742)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(144740729028842259)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161558923269499753)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(144740729028842259)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161559613561499755)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(144740729028842259)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161560004629499755)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161560716414499755)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(144742678403842259)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161568835456499758)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175896199859657314)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161570217921499760)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161570865048499760)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_css_classes=>'t-TreeNav--styleA'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation A'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161571551798499760)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_css_classes=>'t-TreeNav--styleB'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation B'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161572258688499760)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Classic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_css_classes=>'t-TreeNav--classic'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
,p_help_text=>'Classic Style'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161581076592499763)
,p_theme_id=>42
,p_name=>'WIZARD_PROGRESS_LINKS'
,p_display_name=>'Make Wizard Steps Clickable'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(175894944660657314)
,p_css_classes=>'js-wizardProgressLinks'
,p_template_types=>'LIST'
,p_help_text=>'This option will make the wizard steps clickable links.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161581505745499763)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175894944660657314)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161584702245499766)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(161584162435499764)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_api.id(144742320528842259)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161585062428499766)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(161584162435499764)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_api.id(144742320528842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161585533078499766)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(161584162435499764)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_api.id(144739507769842258)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161585846505499766)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(161584162435499764)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_api.id(144739507769842258)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161586265649499766)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(161584162435499764)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_api.id(144739507769842258)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161587613178499769)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161588304522499769)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161589001801499769)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161599265982499774)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(144763944391842266)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161600004632499774)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161600361910499774)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161601036350499774)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(144758679115842264)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161601823286499774)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(144758679115842264)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161602497661499774)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(144763944391842266)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161616119435499780)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175885770674657307)
,p_css_classes=>'t-Comments--iconsRounded'
,p_group_id=>wwv_flow_api.id(144763944391842266)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161616828189499780)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175885770674657307)
,p_css_classes=>'t-Comments--iconsSquare'
,p_group_id=>wwv_flow_api.id(144763944391842266)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161636800541499789)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161637168799499789)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161637593508499789)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161638001118499789)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161638351931499789)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161638755047499789)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(144763944391842266)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161639229451499789)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(144763944391842266)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161639557276499789)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(144766277759842266)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161639977717499789)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161640344461499789)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161640785982499789)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161641143824499789)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161641622350499791)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_api.id(161636266526499788)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161644342336499800)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(175898296301657315)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(144729869572842256)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161645120513499800)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(175898296301657315)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(144729869572842256)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161647072739499802)
,p_theme_id=>42
,p_name=>'HIDE_LABEL_ON_MOBILE'
,p_display_name=>'Hide Label on Mobile'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(175898514445657317)
,p_css_classes=>'t-Button--mobileHideLabel'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button label on small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161647770779499802)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(175898514445657317)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(144729869572842256)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(161648506529499802)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(175898514445657317)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(144729869572842256)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175867988122657296)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175868253827657298)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(144745119971842259)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175868417080657298)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(144745879785842259)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175868539875657298)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(144745119971842259)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175868754062657298)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(144744750064842259)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175868852277657298)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(144745879785842259)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175868981896657298)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(144745119971842259)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175869069534657298)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(144745879785842259)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175869141325657298)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(144745879785842259)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175869218233657298)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175867836860657296)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(144744750064842259)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175869791344657300)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175869890322657300)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870024325657300)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870099902657300)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870359660657300)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(144757899251842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870463164657300)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(144757899251842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870568224657300)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(144757899251842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870589810657300)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(144757899251842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870739843657300)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175870825712657300)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871003033657300)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871145434657300)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871191224657300)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871339859657300)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871471050657300)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871631524657300)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(144746333162842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871765511657300)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(144746333162842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175871940302657300)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(144747085386842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175872098849657300)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(144750748909842261)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175872341146657300)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175872437005657300)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175872492244657300)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(144750748909842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175872609731657301)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(144747085386842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175872754089657301)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175872825279657301)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175869428677657298)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175873253544657301)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(144749904641842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175873332015657301)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(144749904641842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175873428502657301)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(144749904641842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175873528054657301)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175873627979657301)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175873781903657301)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175872966531657301)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175874145931657301)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175873863790657301)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175874287052657301)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(175873863790657301)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(144747523023842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175874477909657301)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(175873863790657301)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175874555005657301)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(175873863790657301)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(144747523023842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175874952567657301)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875037527657301)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875130459657303)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875231193657303)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875463422657303)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(144749513214842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875551260657303)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(144749513214842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875594904657303)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875772879657303)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875882567657303)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175875937761657303)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175876024058657303)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175876182619657303)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(144747085386842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175876251445657303)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175876323182657303)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175876434279657303)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175876549668657303)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(144747085386842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175876642574657303)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175874646339657301)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175877012249657303)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175876966761657303)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175877176875657303)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175876966761657303)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175877715940657303)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175877876001657303)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175877887655657303)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878055028657303)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(144746733219842261)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878174063657303)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878223547657303)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878326593657303)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878403470657303)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878526783657303)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878642780657303)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(144744280317842259)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878696157657303)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(144747085386842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878876290657303)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(144750748909842261)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175878927822657303)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175879014533657303)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175879151371657303)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175879219813657303)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(144750748909842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175879346157657303)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(144747085386842261)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175879429851657303)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175877470433657303)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(144756674454842263)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175879838466657304)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175879544698657303)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175880072161657304)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175879544698657303)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(144753909217842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175880222245657304)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175879544698657303)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(144757088264842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175880406523657304)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175879544698657303)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(144757481738842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175880558945657304)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175879544698657303)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(144757481738842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175880676537657304)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175879544698657303)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(144757088264842264)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175880856750657304)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175880723465657304)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175881042509657304)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175880723465657304)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(144755941996842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175881185435657304)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(175880723465657304)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(144755941996842263)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175881577813657304)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(175881195642657304)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(144751080989842261)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175881641577657304)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175881195642657304)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(144751080989842261)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175881724027657304)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(175881195642657304)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882092897657306)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882277773657306)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882297772657306)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882444756657306)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882509469657306)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882664292657306)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882718179657306)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175882932244657306)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(144759103354842264)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883004524657306)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(144759103354842264)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883195927657306)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(144759103354842264)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883353468657306)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883477590657306)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(144759103354842264)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883568395657306)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(175881966059657306)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(144759103354842264)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883728654657306)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883841843657306)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175883974588657306)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175884142689657306)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175884299712657306)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175884469635657306)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175884502005657306)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175884762122657306)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(144759473987842264)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175884822970657306)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(144759473987842264)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175884937439657307)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(144759473987842264)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175885124773657307)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(144763499360842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175885191810657307)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(144763499360842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175885348532657307)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175885388394657307)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175885525443657307)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(144759473987842264)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175885593237657307)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(175883627845657306)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175885973467657307)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175885770674657307)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(144762742238842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175886052789657307)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175885770674657307)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(144762742238842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175886447604657307)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(144758344164842264)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175886635700657307)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(144765546749842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175886751897657307)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(144765546749842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175886808095657307)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(144765546749842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887028486657307)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(144765891693842266)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887185968657307)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(144765891693842266)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887225639657307)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(144758344164842264)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887380545657307)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887456313657307)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175886244775657307)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(144765546749842266)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887781333657307)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887882706657307)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175887970984657309)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888057572657309)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888159084657309)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888227527657309)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888369556657309)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888390193657309)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(175887515539657307)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888642384657309)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888783370657309)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888797817657309)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175888910510657309)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175889046732657309)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(144764755306842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175889101312657309)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175889187695657309)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175889357644657309)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(175888506732657309)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(144764309504842266)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175889584795657309)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(175889463251657309)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(144766713513842266)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175889818362657310)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(144737940936842258)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890058368657310)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890146225657310)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890197031657310)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890335594657310)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890450099657310)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890533494657310)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890652471657310)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890715040657310)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(144737940936842258)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175890876455657310)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(144737940936842258)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891078275657310)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(144737940936842258)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891100703657310)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891203828657310)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(175889630959657309)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(144737940936842258)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891432493657310)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891517729657310)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891606089657310)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891837134657310)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175891991224657310)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175892140131657310)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175892246382657310)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175892404765657310)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(144738356700842258)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175892549642657310)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(144738356700842258)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175892595300657310)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(144738356700842258)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175892838192657310)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(144740275463842258)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175892948430657312)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(144740275463842258)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175893035297657312)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175893101618657312)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175893241850657312)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(144738356700842258)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175893314719657312)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175893522833657312)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(175893411395657312)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175893610257657312)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175893411395657312)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175893856233657312)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175893411395657312)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175894160019657314)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(175894001230657312)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175894240966657314)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175894001230657312)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(144740275463842258)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175894304817657314)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175894001230657312)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(144740275463842258)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175894581875657314)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175894001230657312)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(144742678403842259)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175894659508657314)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175894001230657312)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175894727963657314)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175894001230657312)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175894876964657314)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(175894001230657312)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(144742678403842259)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175895094611657314)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175894944660657314)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(144741484640842259)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175895277292657314)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175894944660657314)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(144741484640842259)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175895354318657314)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175894944660657314)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(144741484640842259)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175895487054657314)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175895481641657314)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(144743155002842259)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175895659997657314)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175895481641657314)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175895745954657314)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175895481641657314)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175895825522657314)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175895481641657314)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896042489657314)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175895481641657314)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(144739940101842258)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896097891657314)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175895481641657314)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(144739940101842258)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896444670657314)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896546470657314)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896627501657314)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896784690657314)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896841682657314)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(144741966168842259)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175896977737657314)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175897048296657314)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175897172074657314)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(175896292823657314)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175897397476657315)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(175897325042657314)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175897499448657315)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(175897325042657314)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175897780480657315)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(175897325042657314)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175898775015657317)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(175898514445657317)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(144730359154842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(175898821236657317)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(175898514445657317)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(144730359154842256)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/globalization/language
begin
wwv_flow_api.create_language_map(
 p_id=>wwv_flow_api.id(146002339425179986)
,p_translation_flow_id=>128
,p_translation_flow_language_cd=>'en'
,p_direction_right_to_left=>'N'
);
end;
/
prompt --application/shared_components/globalization/translations
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128894840844730237)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497968064864386.128)
,p_translate_from_id=>wwv_flow_api.id(135497968064864386)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128895035320730245)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497827509864384.128)
,p_translate_from_id=>wwv_flow_api.id(135497827509864384)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''PRE_ID'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''PRE_ID'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128895153377730248)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497968064864386.128)
,p_translate_from_id=>wwv_flow_api.id(135497968064864386)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P10_PAR_ID'
,p_translate_from_text=>'P10_PAR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128895401331730248)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497827509864384.128)
,p_translate_from_id=>wwv_flow_api.id(135497827509864384)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PRE_ID'
,p_translate_from_text=>'PRE_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128895620703730249)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497968064864386.128)
,p_translate_from_id=>wwv_flow_api.id(135497968064864386)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P10_PAR_ID'
,p_translate_from_text=>'P10_PAR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128895737915730249)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497827509864384.128)
,p_translate_from_id=>wwv_flow_api.id(135497827509864384)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PRE_ID'
,p_translate_from_text=>'PRE_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128896022800730253)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497968064864386.128)
,p_translate_from_id=>wwv_flow_api.id(135497968064864386)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128896169214730253)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497827509864384.128)
,p_translate_from_id=>wwv_flow_api.id(135497827509864384)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128896367423730254)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497968064864386.128)
,p_translate_from_id=>wwv_flow_api.id(135497968064864386)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(128896618473730254)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135497827509864384.128)
,p_translate_from_id=>wwv_flow_api.id(135497827509864384)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146002456285184589)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>6.128
,p_translate_from_id=>6
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameters'
,p_translate_from_text=>'Parameter administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146002529775184589)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>7.128
,p_translate_from_id=>7
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit parameter'
,p_translate_from_text=>'Parameter bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146002748751184591)
,p_page_id=>1
,p_translated_flow_id=>128
,p_translate_to_id=>1.128
,p_translate_from_id=>1
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT Administration'
,p_translate_from_text=>'PIT-Administration'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146002903242184591)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>11.128
,p_translate_from_id=>11
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Output Module'
,p_translate_from_text=>'Ausgabemodul administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146003158534184591)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>2.128
,p_translate_from_id=>2
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146003283367184591)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>8.128
,p_translate_from_id=>8
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit arameter group'
,p_translate_from_text=>'Parametergruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146003516744184591)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>12.128
,p_translate_from_id=>12
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context Toggle'
,p_translate_from_text=>'Kontext-Toggle administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146003674528184591)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>4.128
,p_translate_from_id=>4
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146003918137184591)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>101.128
,p_translate_from_id=>101
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Login Page'
,p_translate_from_text=>'Login Page'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146004102903184591)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>5.128
,p_translate_from_id=>5
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich einstellen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146004276610184591)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>10.128
,p_translate_from_id=>10
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context'
,p_translate_from_text=>'Kontext administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146004547553184591)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>3.128
,p_translate_from_id=>3
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Meldung editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146004685045184591)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>9.128
,p_translate_from_id=>9
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146004959576184591)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>16.128
,p_translate_from_id=>16
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export and translate master data'
,p_translate_from_text=>unistr('Stammdaten exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146005118231184594)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>6.128
,p_translate_from_id=>6
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameters'
,p_translate_from_text=>'Parameter administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146005348944184594)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>7.128
,p_translate_from_id=>7
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit parameter'
,p_translate_from_text=>'Parameter bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146005483263184594)
,p_page_id=>1
,p_translated_flow_id=>128
,p_translate_to_id=>1.128
,p_translate_from_id=>1
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT Administration'
,p_translate_from_text=>'PIT-Administration'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146005761896184594)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>11.128
,p_translate_from_id=>11
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Output Module'
,p_translate_from_text=>'Ausgabemodul administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146005940235184594)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>2.128
,p_translate_from_id=>2
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146006083176184594)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>8.128
,p_translate_from_id=>8
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit parameter group'
,p_translate_from_text=>'Parametergruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146006336695184594)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>12.128
,p_translate_from_id=>12
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context Toggle'
,p_translate_from_text=>'Kontext-Toggle administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146006564862184594)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>4.128
,p_translate_from_id=>4
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146006759997184594)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>101.128
,p_translate_from_id=>101
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT-Administration - Log In'
,p_translate_from_text=>'PIT-Administration - Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146006867406184594)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>5.128
,p_translate_from_id=>5
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich einstellen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146007089119184594)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>10.128
,p_translate_from_id=>10
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Context'
,p_translate_from_text=>'Kontext administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146007312657184594)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>3.128
,p_translate_from_id=>3
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Meldung editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146007527020184594)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>9.128
,p_translate_from_id=>9
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146007672481184594)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>16.128
,p_translate_from_id=>16
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export and translate master data'
,p_translate_from_text=>unistr('Stammdaten exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146007916832184603)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>6.128
,p_translate_from_id=>6
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146008091458184603)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>7.128
,p_translate_from_id=>7
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146008291620184603)
,p_page_id=>1
,p_translated_flow_id=>128
,p_translate_to_id=>1.128
,p_translate_from_id=>1
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>'No help is available for this page.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146008495818184603)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>11.128
,p_translate_from_id=>11
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146008717778184603)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>2.128
,p_translate_from_id=>2
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>'No help is available for this page.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146008937506184603)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>8.128
,p_translate_from_id=>8
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146009071757184603)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>12.128
,p_translate_from_id=>12
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146009276327184603)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>10.128
,p_translate_from_id=>10
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146009483894184603)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>3.128
,p_translate_from_id=>3
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>'No help is available for this page.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146009702246184603)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>9.128
,p_translate_from_id=>9
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146009906548184603)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>16.128
,p_translate_from_id=>16
,p_translate_column_id=>12
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No help is available for this page.'
,p_translate_from_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146010077621184605)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767252976752325.128)
,p_translate_from_id=>wwv_flow_api.id(177767252976752325)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146010278290184605)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634940220914934.128)
,p_translate_from_id=>wwv_flow_api.id(177634940220914934)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Context'
,p_translate_from_text=>'Kontext erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146010491668184606)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165720027482286476.128)
,p_translate_from_id=>wwv_flow_api.id(165720027482286476)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung laden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146010749843184606)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912362281870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912362281870284)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146010930125184606)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767076905752325.128)
,p_translate_from_id=>wwv_flow_api.id(177767076905752325)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Context'
,p_translate_from_text=>'Kontext erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146011126521184606)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793714102192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793714102192860)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146011282377184606)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717824805286454.128)
,p_translate_from_id=>wwv_flow_api.id(165717824805286454)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export translatable item'
,p_translate_from_text=>'Begriffe exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146011510999184606)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538017486809330.128)
,p_translate_from_id=>wwv_flow_api.id(147538017486809330)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich setzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146011744679184606)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716256717286438.128)
,p_translate_from_id=>wwv_flow_api.id(165716256717286438)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create toggle'
,p_translate_from_text=>'Toggle erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146011876508184606)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389862440150577.128)
,p_translate_from_id=>wwv_flow_api.id(165389862440150577)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146012160304184606)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793686029192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793686029192860)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146012350028184606)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147580465598367178.128)
,p_translate_from_id=>wwv_flow_api.id(147580465598367178)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146012471890184606)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177646305350141182.128)
,p_translate_from_id=>wwv_flow_api.id(177646305350141182)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146012724530184606)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912955027870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912955027870284)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146012889170184606)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841865199058114.128)
,p_translate_from_id=>wwv_flow_api.id(177841865199058114)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export Parameter groups'
,p_translate_from_text=>'Parametergruppen exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146013106004184606)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904459318657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904459318657339)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Log In'
,p_translate_from_text=>'Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146013304241184606)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175927379412870429.128)
,p_translate_from_id=>wwv_flow_api.id(175927379412870429)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create message'
,p_translate_from_text=>'Meldung erzeugen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146013508992184606)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177646090441141182.128)
,p_translate_from_id=>wwv_flow_api.id(177646090441141182)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146013745513184606)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912213488870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912213488870284)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create message'
,p_translate_from_text=>'Meldug erzeugen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146013914241184606)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177840843056058104.128)
,p_translate_from_id=>wwv_flow_api.id(177840843056058104)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export Messages'
,p_translate_from_text=>'Meldungen exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146014154588184606)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165718512962286461.128)
,p_translate_from_id=>wwv_flow_api.id(165718512962286461)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146014284177184606)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147578459188367173.128)
,p_translate_from_id=>wwv_flow_api.id(147578459188367173)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146014484029184608)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170956145329513093.128)
,p_translate_from_id=>wwv_flow_api.id(170956145329513093)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help with Oracle error mappings'
,p_translate_from_text=>'Hilfe zu Oracle-Fehlermappings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146014706116184608)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467655306508660.128)
,p_translate_from_id=>wwv_flow_api.id(177467655306508660)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>unistr('\00C4nderungen anwenden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146014953223184608)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170954638008513078.128)
,p_translate_from_id=>wwv_flow_api.id(170954638008513078)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'Hilfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146015067301184608)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767168119752325.128)
,p_translate_from_id=>wwv_flow_api.id(177767168119752325)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146015270717184608)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716879012286445.128)
,p_translate_from_id=>wwv_flow_api.id(165716879012286445)
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
 p_id=>wwv_flow_api.id(146015562935184608)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170954998701513081.128)
,p_translate_from_id=>wwv_flow_api.id(170954998701513081)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'Hilfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146015739660184608)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389649223150574.128)
,p_translate_from_id=>wwv_flow_api.id(165389649223150574)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146015937821184608)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177636013283914945.128)
,p_translate_from_id=>wwv_flow_api.id(177636013283914945)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146016076052184608)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716594846286442.128)
,p_translate_from_id=>wwv_flow_api.id(165716594846286442)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export local parameters'
,p_translate_from_text=>'Lokale Parameter exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146016356340184608)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632080113914905.128)
,p_translate_from_id=>wwv_flow_api.id(177632080113914905)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameter Group'
,p_translate_from_text=>'Parametergruppen verwalten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146016505394184608)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719926511286475.128)
,p_translate_from_id=>wwv_flow_api.id(165719926511286475)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung laden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146016755756184608)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717876749286455.128)
,p_translate_from_id=>wwv_flow_api.id(165717876749286455)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Translate translatable item'
,p_translate_from_text=>unistr('Begriffe \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146016959336184608)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165718192387286458.128)
,p_translate_from_id=>wwv_flow_api.id(165718192387286458)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146017080416184608)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467693091508660.128)
,p_translate_from_id=>wwv_flow_api.id(177467693091508660)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146017340087184608)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467567628508660.128)
,p_translate_from_id=>wwv_flow_api.id(177467567628508660)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create'
,p_translate_from_text=>'Erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146017527207184608)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635018696914935.128)
,p_translate_from_id=>wwv_flow_api.id(177635018696914935)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create toggle'
,p_translate_from_text=>'Toggle erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146017750386184608)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170955304235513084.128)
,p_translate_from_id=>wwv_flow_api.id(170955304235513084)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'HIlfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146017955711184608)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767716161752326.128)
,p_translate_from_id=>wwv_flow_api.id(177767716161752326)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146018103584184608)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646205742373529.128)
,p_translate_from_id=>wwv_flow_api.id(174646205742373529)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146018349905184609)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912400015870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912400015870284)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete message'
,p_translate_from_text=>'Meldung entfernen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146018535050184609)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177487371498508804.128)
,p_translate_from_id=>wwv_flow_api.id(177487371498508804)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Parameter'
,p_translate_from_text=>'Parameter erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146018736194184609)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177468282903508660.128)
,p_translate_from_id=>wwv_flow_api.id(177468282903508660)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146018956577184611)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177470975776508765.128)
,p_translate_from_id=>wwv_flow_api.id(177470975776508765)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146019091249184611)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170953624155513068.128)
,p_translate_from_id=>wwv_flow_api.id(170953624155513068)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'editierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146019328516184611)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177795858415192862.128)
,p_translate_from_id=>wwv_flow_api.id(177795858415192862)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146019481174184611)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717530408286451.128)
,p_translate_from_id=>wwv_flow_api.id(165717530408286451)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146019743914184611)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471245421508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471245421508767)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146019925912184611)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770176129752329.128)
,p_translate_from_id=>wwv_flow_api.id(177770176129752329)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Rowid'
,p_translate_from_text=>'Rowid'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146020160999184611)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633157929914916.128)
,p_translate_from_id=>wwv_flow_api.id(177633157929914916)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Gather timing'
,p_translate_from_text=>'Zeitinformation erfassen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146020324048184613)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634578799914930.128)
,p_translate_from_id=>wwv_flow_api.id(177634578799914930)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Allow Toggles'
,p_translate_from_text=>'Toggles verwenden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146020480565184613)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904376490657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904376490657339)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Password'
,p_translate_from_text=>'Passwort'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146020739254184613)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147575986253367164.128)
,p_translate_from_id=>wwv_flow_api.id(147575986253367164)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Id'
,p_translate_from_text=>'Par Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146020902837184613)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538196215809332.128)
,p_translate_from_id=>wwv_flow_api.id(147538196215809332)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actual realm'
,p_translate_from_text=>unistr('aktueller G\00FCltigkeitsbereich')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146021124204184613)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177796603156192864.128)
,p_translate_from_id=>wwv_flow_api.id(177796603156192864)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'assigned context'
,p_translate_from_text=>'zugeordneter Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146021297604184613)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177840710921058103.128)
,p_translate_from_id=>wwv_flow_api.id(177840710921058103)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146021541549184613)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471990025508770.128)
,p_translate_from_id=>wwv_flow_api.id(177471990025508770)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text value'
,p_translate_from_text=>'Textwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146021668893184613)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388698406150565.128)
,p_translate_from_id=>wwv_flow_api.id(165388698406150565)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'XML value'
,p_translate_from_text=>'XML-Wert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146021893907184613)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177472465193508770.128)
,p_translate_from_id=>wwv_flow_api.id(177472465193508770)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer value'
,p_translate_from_text=>'Ganzzahlwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146022144230184613)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473637814508771.128)
,p_translate_from_id=>wwv_flow_api.id(177473637814508771)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp value'
,p_translate_from_text=>'Zeitstempelwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146022306950184613)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177474416938508771.128)
,p_translate_from_id=>wwv_flow_api.id(177474416938508771)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Boolean value'
,p_translate_from_text=>'Wahrheitswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146022489063184613)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916744011870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916744011870395)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message'
,p_translate_from_text=>'Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146022754271184613)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633001336914915.128)
,p_translate_from_id=>wwv_flow_api.id(177633001336914915)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Trace-Level'
,p_translate_from_text=>'Trace-Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146022943164184613)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632915416914914.128)
,p_translate_from_id=>wwv_flow_api.id(177632915416914914)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Debug-Level'
,p_translate_from_text=>'Debug-Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146023078032184613)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717617663286452.128)
,p_translate_from_id=>wwv_flow_api.id(165717617663286452)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Hint pti'
,p_translate_from_text=>'Hint pti'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146023272162184613)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475285797508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475285797508773)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text type'
,p_translate_from_text=>'Texttyp'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146023531945184613)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904238193657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904238193657339)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Username'
,p_translate_from_text=>'Benutzer'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146023689727184613)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916351760870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916351760870395)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146023935871184613)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175917166306870395.128)
,p_translate_from_id=>wwv_flow_api.id(175917166306870395)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity'
,p_translate_from_text=>'Schweregrad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146024148266184614)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175917538597870396.128)
,p_translate_from_id=>wwv_flow_api.id(175917538597870396)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error number'
,p_translate_from_text=>'Fehlernummer'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146024276026184614)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475625746508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475625746508773)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Validation expression'
,p_translate_from_text=>'Validierungsausdruck'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146024528847184614)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177476006802508773.128)
,p_translate_from_id=>wwv_flow_api.id(177476006802508773)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error message'
,p_translate_from_text=>'Fehlermeldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146024687264184614)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177796276699192864.128)
,p_translate_from_id=>wwv_flow_api.id(177796276699192864)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Package list'
,p_translate_from_text=>'Liste der Packages'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146024869463184614)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797055859192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797055859192864)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146025118857184614)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369640503199491.128)
,p_translate_from_id=>wwv_flow_api.id(168369640503199491)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146025323639184614)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177631745019914902.128)
,p_translate_from_id=>wwv_flow_api.id(177631745019914902)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parmetergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146025520746184614)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177771385842752348.128)
,p_translate_from_id=>wwv_flow_api.id(177771385842752348)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146025666305184614)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147576806748367168.128)
,p_translate_from_id=>wwv_flow_api.id(147576806748367168)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146025875579184614)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716818084286444.128)
,p_translate_from_id=>wwv_flow_api.id(165716818084286444)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146026157800184614)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237871654886333.128)
,p_translate_from_id=>wwv_flow_api.id(171237871654886333)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Group'
,p_translate_from_text=>'Gruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146026364967184616)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177474859048508773.128)
,p_translate_from_id=>wwv_flow_api.id(177474859048508773)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'prohibit editing'
,p_translate_from_text=>'editieren untersagen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146026488549184616)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177472788053508770.128)
,p_translate_from_id=>wwv_flow_api.id(177472788053508770)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number value'
,p_translate_from_text=>unistr('Flie\00DFkommazahlwert')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146026759186184616)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473231405508770.128)
,p_translate_from_id=>wwv_flow_api.id(177473231405508770)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date value'
,p_translate_from_text=>'Datumswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146026869428184616)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633245112914917.128)
,p_translate_from_id=>wwv_flow_api.id(177633245112914917)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output modules'
,p_translate_from_text=>'Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146027121007184616)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841756138058113.128)
,p_translate_from_id=>wwv_flow_api.id(177841756138058113)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146027356193184616)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717742054286453.128)
,p_translate_from_id=>wwv_flow_api.id(165717742054286453)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146027558611184616)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237937942886334.128)
,p_translate_from_id=>wwv_flow_api.id(171237937942886334)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146027727324184616)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916069416870392.128)
,p_translate_from_id=>wwv_flow_api.id(175916069416870392)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146027880643184616)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168370083383199496.128)
,p_translate_from_id=>wwv_flow_api.id(168370083383199496)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146028108591184616)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770582041752346.128)
,p_translate_from_id=>wwv_flow_api.id(177770582041752346)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146028273622184616)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147576354468367167.128)
,p_translate_from_id=>wwv_flow_api.id(147576354468367167)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Pgr Id'
,p_translate_from_text=>'Par Pgr Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146028554970184616)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471609148508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471609148508767)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Besschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146028765628184616)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717007523286446.128)
,p_translate_from_id=>wwv_flow_api.id(165717007523286446)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Hint pms'
,p_translate_from_text=>'Hint pms'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146028940217184616)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719808601286474.128)
,p_translate_from_id=>wwv_flow_api.id(165719808601286474)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Import XLIFF file'
,p_translate_from_text=>'XLIFF-Datei importieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146029161933184616)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165720079801286477.128)
,p_translate_from_id=>wwv_flow_api.id(165720079801286477)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Import XLIFF file'
,p_translate_from_text=>'XLIFF-Datei importieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146029348876184619)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389302851150571.128)
,p_translate_from_id=>wwv_flow_api.id(165389302851150571)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146029489324184619)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538043263809331.128)
,p_translate_from_id=>wwv_flow_api.id(147538043263809331)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146029688262184619)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369959067199494.128)
,p_translate_from_id=>wwv_flow_api.id(168369959067199494)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146029936396184619)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386783311150546.128)
,p_translate_from_id=>wwv_flow_api.id(165386783311150546)
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
 p_id=>wwv_flow_api.id(146030105539184619)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716094890286437.128)
,p_translate_from_id=>wwv_flow_api.id(165716094890286437)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146030360960184619)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716489726286441.128)
,p_translate_from_id=>wwv_flow_api.id(165716489726286441)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146030471936184619)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388593584150564.128)
,p_translate_from_id=>wwv_flow_api.id(165388593584150564)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146030704192184619)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717984051286456.128)
,p_translate_from_id=>wwv_flow_api.id(165717984051286456)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146030878959184619)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153468053813101581.128)
,p_translate_from_id=>wwv_flow_api.id(153468053813101581)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146031132763184619)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389402916150572.128)
,p_translate_from_id=>wwv_flow_api.id(165389402916150572)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146031343093184620)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171236704243886322.128)
,p_translate_from_id=>wwv_flow_api.id(171236704243886322)
,p_translate_column_id=>17
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error while saving the message:<br>#SQLERRM#'
,p_translate_from_text=>'Fehler beim Speichern der Meldung:<br>#SQLERRM#'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146031527322184623)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171236704243886322.128)
,p_translate_from_id=>wwv_flow_api.id(171236704243886322)
,p_translate_column_id=>18
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message was saved.'
,p_translate_from_text=>'Meldung wurde gespeichert.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146031732767184623)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177478461640508776.128)
,p_translate_from_id=>wwv_flow_api.id(177478461640508776)
,p_translate_column_id=>18
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Action processed.'
,p_translate_from_text=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146031878276184627)
,p_page_id=>1
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175905472462657342.128)
,p_translate_from_id=>wwv_flow_api.id(175905472462657342)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumbs'
,p_translate_from_text=>'Breadcrumbs'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146032094895184627)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175928855898870434.128)
,p_translate_from_id=>wwv_flow_api.id(175928855898870434)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Breadcrumb'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146032314647184627)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467143155508657.128)
,p_translate_from_id=>wwv_flow_api.id(177467143155508657)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit parameter'
,p_translate_from_text=>'Parameter bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146032549266184627)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177489420351508807.128)
,p_translate_from_id=>wwv_flow_api.id(177489420351508807)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146032737687184627)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912499148870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912499148870284)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146032898745184627)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386916685150547.128)
,p_translate_from_id=>wwv_flow_api.id(165386916685150547)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'List of parameters'
,p_translate_from_text=>'Liste der Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146033151406184627)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633978626914924.128)
,p_translate_from_id=>wwv_flow_api.id(177633978626914924)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Available Toggles'
,p_translate_from_text=>unistr('Verf\00FCgbare Toggles')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146033319722184628)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633793004914923.128)
,p_translate_from_id=>wwv_flow_api.id(177633793004914923)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Information about the debugging filter'
,p_translate_from_text=>'Informationen zum Filter des Debuggings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146033565201184628)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767337246752325.128)
,p_translate_from_id=>wwv_flow_api.id(177767337246752325)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146033734918184628)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717263633286449.128)
,p_translate_from_id=>wwv_flow_api.id(165717263633286449)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'right column'
,p_translate_from_text=>'rechte Spalte'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146033941215184628)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632690908914912.128)
,p_translate_from_id=>wwv_flow_api.id(177632690908914912)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Hints for Output Modules'
,p_translate_from_text=>'Hinweise zu Ausgabemodulen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146034122886184628)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177760055211572884.128)
,p_translate_from_id=>wwv_flow_api.id(177760055211572884)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Available Contexts'
,p_translate_from_text=>unistr('Verf\00FCgbare Kontexte')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146034297212184628)
,p_page_id=>1
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175907801138782004.128)
,p_translate_from_id=>wwv_flow_api.id(175907801138782004)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Application areas'
,p_translate_from_text=>'Anwendungsbereiche'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146034497337184628)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147578084847367173.128)
,p_translate_from_id=>wwv_flow_api.id(147578084847367173)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146034741764184628)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170956078448513092.128)
,p_translate_from_id=>wwv_flow_api.id(170956078448513092)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Help with Oracle error mappings'
,p_translate_from_text=>'HIlfe zu Oracle-Fehlermappings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146034939575184628)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165718144958286457.128)
,p_translate_from_id=>wwv_flow_api.id(165718144958286457)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146035111861184628)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177668810526218648.128)
,p_translate_from_id=>wwv_flow_api.id(177668810526218648)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Installed Output modules'
,p_translate_from_text=>'Installierte Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146035279423184628)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467843304508660.128)
,p_translate_from_id=>wwv_flow_api.id(177467843304508660)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146035468242184628)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793985346192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793985346192860)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146035733523184628)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386713245150545.128)
,p_translate_from_id=>wwv_flow_api.id(165386713245150545)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146035909489184628)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904094044657335.128)
,p_translate_from_id=>wwv_flow_api.id(175904094044657335)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Log In'
,p_translate_from_text=>'Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146036155028184628)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153395368662398406.128)
,p_translate_from_id=>wwv_flow_api.id(153395368662398406)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Deviating parameter values for realms'
,p_translate_from_text=>unistr('Abweichende Parameterwerte f\00FCr G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146036335155184628)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177642516318141173.128)
,p_translate_from_id=>wwv_flow_api.id(177642516318141173)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit parameter group'
,p_translate_from_text=>'Parametergruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146036556372184628)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170955590522513087.128)
,p_translate_from_id=>wwv_flow_api.id(170955590522513087)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Current debug settings'
,p_translate_from_text=>'Aktuelle Debugeinstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146036677932184628)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841159392058107.128)
,p_translate_from_id=>wwv_flow_api.id(177841159392058107)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Create, edit and translate messages'
,p_translate_from_text=>unistr('Meldungen exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146036960211184628)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177488806740508807.128)
,p_translate_from_id=>wwv_flow_api.id(177488806740508807)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146037072338184628)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177657817071214582.128)
,p_translate_from_id=>wwv_flow_api.id(177657817071214582)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146037328265184628)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165874029504037196.128)
,p_translate_from_id=>wwv_flow_api.id(165874029504037196)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146037540505184630)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147575686690367160.128)
,p_translate_from_id=>wwv_flow_api.id(147575686690367160)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Create Form'
,p_translate_from_text=>'Create Form'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146037679799184630)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632816171914913.128)
,p_translate_from_id=>wwv_flow_api.id(177632816171914913)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Hints for Contexts'
,p_translate_from_text=>'Hinweise zu Kontexten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146037907114184630)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717165203286448.128)
,p_translate_from_id=>wwv_flow_api.id(165717165203286448)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'left column'
,p_translate_from_text=>'linke Spalte'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146038111879184630)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717438326286450.128)
,p_translate_from_id=>wwv_flow_api.id(165717438326286450)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Export and translate translatable items'
,p_translate_from_text=>unistr('Begriffe exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146038335430184630)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175922718445870421.128)
,p_translate_from_id=>wwv_flow_api.id(175922718445870421)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Messages'
,p_translate_from_text=>'Meldungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146038469882184630)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175911811137870284.128)
,p_translate_from_id=>wwv_flow_api.id(175911811137870284)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Meldung editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146038756358184630)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633751662914922.128)
,p_translate_from_id=>wwv_flow_api.id(177633751662914922)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Filter Debugging by Package (Toggles)'
,p_translate_from_text=>'Debugging nach Package filtern (Toggles)'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146038907227184630)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389533861150573.128)
,p_translate_from_id=>wwv_flow_api.id(165389533861150573)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146039121491184630)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841220613058108.128)
,p_translate_from_id=>wwv_flow_api.id(177841220613058108)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Export Parameters'
,p_translate_from_text=>'Parameter exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146039313944184630)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177819593089567060.128)
,p_translate_from_id=>wwv_flow_api.id(177819593089567060)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146039475020184630)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177766667613752325.128)
,p_translate_from_id=>wwv_flow_api.id(177766667613752325)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Context'
,p_translate_from_text=>'Kontext administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146039700025184630)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165634247226845599.128)
,p_translate_from_id=>wwv_flow_api.id(165634247226845599)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Output Module'
,p_translate_from_text=>'Ausgabemodul administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146039961647184630)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793232726192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793232726192860)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Context Toggle'
,p_translate_from_text=>'Kontext-Toggle administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146040156708184633)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633978626914924.128)
,p_translate_from_id=>wwv_flow_api.id(177633978626914924)
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
 p_id=>wwv_flow_api.id(146040348174184633)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633793004914923.128)
,p_translate_from_id=>wwv_flow_api.id(177633793004914923)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146040522908184633)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632690908914912.128)
,p_translate_from_id=>wwv_flow_api.id(177632690908914912)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146040727643184633)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170956078448513092.128)
,p_translate_from_id=>wwv_flow_api.id(170956078448513092)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146040925086184633)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170955590522513087.128)
,p_translate_from_id=>wwv_flow_api.id(170955590522513087)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'return pit_ui.get_active_context; '
,p_translate_from_text=>'return pit_ui.get_active_context; '
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146041100209184633)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632816171914913.128)
,p_translate_from_id=>wwv_flow_api.id(177632816171914913)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146041349405184644)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175903784483657328.128)
,p_translate_from_id=>wwv_flow_api.id(175903784483657328)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Log Out'
,p_translate_from_text=>'Log Out'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146041487998184644)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177811992993486492.128)
,p_translate_from_id=>wwv_flow_api.id(177811992993486492)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Master Data'
,p_translate_from_text=>'Stammdaten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146041722298184644)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(176704677738762887.128)
,p_translate_from_id=>wwv_flow_api.id(176704677738762887)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameters'
,p_translate_from_text=>'Parameter administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146041887876184644)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904997398657340.128)
,p_translate_from_id=>wwv_flow_api.id(175904997398657340)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Home'
,p_translate_from_text=>'Startseite'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146042158981184644)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177657362161214579.128)
,p_translate_from_id=>wwv_flow_api.id(177657362161214579)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146042319838184644)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175921775232870403.128)
,p_translate_from_id=>wwv_flow_api.id(175921775232870403)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146042501830184658)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177668810526218648.128)
,p_translate_from_id=>wwv_flow_api.id(177668810526218648)
,p_translate_column_id=>36
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No data found'
,p_translate_from_text=>'Keine Daten gefunden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146042748396184658)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177760055211572884.128)
,p_translate_from_id=>wwv_flow_api.id(177760055211572884)
,p_translate_column_id=>36
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No data found'
,p_translate_from_text=>'Keine Daten gefunden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146042912530184706)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>63
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Search Dialog'
,p_translate_from_text=>'Search Dialog'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146043020414184713)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>66
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_translate_from_text=>'<div class="t-PopupLOV-actions t-Form--large">'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146043213045184714)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>67
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'</div>'
,p_translate_from_text=>'</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146043442621184720)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>70
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-links">'
,p_translate_from_text=>'<div class="t-PopupLOV-links">'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146043626370184722)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>71
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'</div>'
,p_translate_from_text=>'</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146043805651184723)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>72
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Search'
,p_translate_from_text=>'Search'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146043997466184725)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>73
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>'Close'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146044192615184727)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>74
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Next &gt;'
,p_translate_from_text=>'Next &gt;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146044450700184730)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>75
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&lt; Previous'
,p_translate_from_text=>'&lt; Previous'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146044579132184736)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175914362817870285.128)
,p_translate_from_id=>wwv_flow_api.id(175914362817870285)
,p_translate_column_id=>79
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Please confirm that the data should be deleted.'
,p_translate_from_text=>unistr('Bitte best\00E4tigen Sie, dass die Daten gel\00F6scht werden sollen.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146044838949184772)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175905320607657342.128)
,p_translate_from_id=>wwv_flow_api.id(175905320607657342)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Home'
,p_translate_from_text=>'Startseite'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146044905157184772)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175928623491870432.128)
,p_translate_from_id=>wwv_flow_api.id(175928623491870432)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146045152867184772)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177658193802214584.128)
,p_translate_from_id=>wwv_flow_api.id(177658193802214584)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146045290395184772)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177820052373567060.128)
,p_translate_from_id=>wwv_flow_api.id(177820052373567060)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export and translate master data'
,p_translate_from_text=>unistr('Stammdaten exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146045514482184772)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177488593016508804.128)
,p_translate_from_id=>wwv_flow_api.id(177488593016508804)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameter Group'
,p_translate_from_text=>'Parameter verwalten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146045727581184778)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(156261721979962549.128)
,p_translate_from_id=>wwv_flow_api.id(156261721979962549)
,p_translate_column_id=>103
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Editieren sperren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146045866377184781)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177796603156192864.128)
,p_translate_from_id=>wwv_flow_api.id(177796603156192864)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select context'
,p_translate_from_text=>unistr('- Kontext w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146046110917184781)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475285797508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475285797508773)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146046310987184781)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916351760870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916351760870395)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select laguage'
,p_translate_from_text=>unistr('- Sprache w\00E4hlen -')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146046512838184781)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369640503199491.128)
,p_translate_from_id=>wwv_flow_api.id(168369640503199491)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146046730203184783)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177631745019914902.128)
,p_translate_from_id=>wwv_flow_api.id(177631745019914902)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>'- Alle'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146046949868184783)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147576806748367168.128)
,p_translate_from_id=>wwv_flow_api.id(147576806748367168)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146047088319184783)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716818084286444.128)
,p_translate_from_id=>wwv_flow_api.id(165716818084286444)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select target language'
,p_translate_from_text=>unistr('- Zielsprache w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146047294529184783)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237871654886333.128)
,p_translate_from_id=>wwv_flow_api.id(171237871654886333)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146047470625184783)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717742054286453.128)
,p_translate_from_id=>wwv_flow_api.id(165717742054286453)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select target language'
,p_translate_from_text=>unistr('- Zielsprache w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146047675979184783)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237937942886334.128)
,p_translate_from_id=>wwv_flow_api.id(171237937942886334)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146047886965184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634358481914928.128)
,p_translate_from_id=>wwv_flow_api.id(177634358481914928)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Package list'
,p_translate_from_text=>'Liste der Packages'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146048074042184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177761825930572889.128)
,p_translate_from_id=>wwv_flow_api.id(177761825930572889)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Settings'
,p_translate_from_text=>'Einstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146048290394184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632351773914908.128)
,p_translate_from_id=>wwv_flow_api.id(177632351773914908)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'active'
,p_translate_from_text=>'aktiv'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146048549183184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174645676256373524.128)
,p_translate_from_id=>wwv_flow_api.id(174645676256373524)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message'
,p_translate_from_text=>'Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146048677696184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177761398457572889.128)
,p_translate_from_id=>wwv_flow_api.id(177761398457572889)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146048875372184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633301834914918.128)
,p_translate_from_id=>wwv_flow_api.id(177633301834914918)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146049091178184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170955838521513090.128)
,p_translate_from_id=>wwv_flow_api.id(170955838521513090)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Gather timing'
,p_translate_from_text=>'Zeitinformationen erfassen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146049303486184784)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170955625327513088.128)
,p_translate_from_id=>wwv_flow_api.id(170955625327513088)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Debug Level'
,p_translate_from_text=>'Debug Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146049527179184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170955726832513089.128)
,p_translate_from_id=>wwv_flow_api.id(170955726832513089)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Trace Level'
,p_translate_from_text=>'Trace Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146049698870184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632277692914907.128)
,p_translate_from_id=>wwv_flow_api.id(177632277692914907)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'available'
,p_translate_from_text=>unistr('verf\00FCgbar')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146049885572184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632439963914909.128)
,p_translate_from_id=>wwv_flow_api.id(177632439963914909)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146050136261184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632112214914906.128)
,p_translate_from_id=>wwv_flow_api.id(177632112214914906)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output module'
,p_translate_from_text=>'Ausgabemodul'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146050346232184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177761034834572889.128)
,p_translate_from_id=>wwv_flow_api.id(177761034834572889)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146050490478184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634118818914926.128)
,p_translate_from_id=>wwv_flow_api.id(177634118818914926)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Toggle name'
,p_translate_from_text=>'Toggle-Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146050729021184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170955916132513091.128)
,p_translate_from_id=>wwv_flow_api.id(170955916132513091)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output modules'
,p_translate_from_text=>'Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146050928874184786)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634458909914929.128)
,p_translate_from_id=>wwv_flow_api.id(177634458909914929)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146051102501184788)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634084854914925.128)
,p_translate_from_id=>wwv_flow_api.id(177634084854914925)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146051281258184788)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633301834914918.128)
,p_translate_from_id=>wwv_flow_api.id(177633301834914918)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146051482909184788)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632439963914909.128)
,p_translate_from_id=>wwv_flow_api.id(177632439963914909)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146051751578184791)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632277692914907.128)
,p_translate_from_id=>wwv_flow_api.id(177632277692914907)
,p_translate_column_id=>108
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa #MODULE_AVAILABLE#"/>'
,p_translate_from_text=>'<i class="fa #MODULE_AVAILABLE#"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146051893532184791)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632351773914908.128)
,p_translate_from_id=>wwv_flow_api.id(177632351773914908)
,p_translate_column_id=>108
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa #MODULE_ACTIVE#"/>'
,p_translate_from_text=>'<i class="fa #MODULE_ACTIVE#"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146052070821184795)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177470975776508765.128)
,p_translate_from_id=>wwv_flow_api.id(177470975776508765)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Enter a unique identifier for this parameter set. The name must conform to Oracle naming conventions and must not contain special characters.'
,p_translate_from_text=>unistr('Geben Sie einen eindeutigen Bezeichner f\00FCr diese Parametergruppe ein. Der Name muss den Oracle-Benennungskonventionen entsprechen und darf keine Sonderzeichen enthalten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146052279077184795)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471245421508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471245421508767)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the parameter group to which this parameter should belong.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Parametergruppe, zu der dieser Parameter geh\00F6ren soll.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146052548303184795)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633157929914916.128)
,p_translate_from_id=>wwv_flow_api.id(177633157929914916)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Should time information be collected?'
,p_translate_from_text=>'Sollen Zeitinformationen gesammelt werden?'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146052689736184795)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916744011870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916744011870395)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message text.<br>Replacement of parameters #1# to #50# according to number value.<br>Passed parameters are numbered positionally and distributed to the replacement marks.'
,p_translate_from_text=>unistr('Meldungstext.<br>Ersetzung der Parameter #1# bis #50# gem\00E4\00DF Zahlwert.<br>\00DCbergebene Parameter werden positional nummeriert und auf die Ersetzungsmarken verteilt.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146052896596184795)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633001336914915.128)
,p_translate_from_id=>wwv_flow_api.id(177633001336914915)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Maximum trace level allowed by this context.'
,p_translate_from_text=>'Maximaler Tracelevel, der durch diesen Kontext erlaubt wird.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146053079762184795)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632915416914914.128)
,p_translate_from_id=>wwv_flow_api.id(177632915416914914)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Maximum severity allowed by this context.<br>If an output module has a lower response threshold, messages may not be output even though the threshold specified here has been undershot.'
,p_translate_from_text=>'Maximaler Schweregrad, der durch diesen Kontext erlaubt wird.<br>Sollte ein Ausgabemodule eine niedrigere Ansprechschwelle haben, kann es sein, dass Meldungen nicht ausgegeben werden, obwohl der hier angegebene Schwellwert unterschritten wurde.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146053300148184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475285797508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475285797508773)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'This attribute allows you to specify what type of text should be saved as a text parameter. This controls which editor is offered to you for editing.'
,p_translate_from_text=>unistr('Mit diesem Attribut k\00F6nnen Sie festlegen, welche Art Text als Textparameter gespeichert werden soll. Dies kontrolliert, welcher Editor Ihnen zur Bearbeitung angeboten wird.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146053510027184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916351760870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916351760870395)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message language'
,p_translate_from_text=>'Sprache der Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146053699326184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175917166306870395.128)
,p_translate_from_id=>wwv_flow_api.id(175917166306870395)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity of the error message'
,p_translate_from_text=>'Schweregrad der Fehlermeldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146053907993184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175917538597870396.128)
,p_translate_from_id=>wwv_flow_api.id(175917538597870396)
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
 p_id=>wwv_flow_api.id(146054084220184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475625746508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475625746508773)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<p>The validation string is used to check the parameter value.</p><p>The following text anchors are available to reference the parameter value:<ul><li>#STRING#</li><li>#DATE#</li><li>#FLOAT#</li><li>#INTEGER#</li><li>#BOOLEAN#</li></ul></p>'
,p_translate_from_text=>unistr('<p>Der Validierungsstring wird genutzt, um den Parameterwert zu pr\00FCfen.</p><p>Es stehen folgende Textanker zur Verf\00FCgung, um den Parameterwert zu referenzieren:<ul><li>#STRING#</li><li>#DATE#</li><li>#FLOAT#</li><li>#INTEGER#</li><li>#BOOLEAN#</li></')
||'ul></p>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146054303334184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177771385842752348.128)
,p_translate_from_id=>wwv_flow_api.id(177771385842752348)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Optional description of the scope of the context'
,p_translate_from_text=>'Optionale Beschreibung des Einsatzbereichs des Kontexts'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146054479033184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147576806748367168.128)
,p_translate_from_id=>wwv_flow_api.id(147576806748367168)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set the realm for the current environment. This has a direct effect on the parameter values if deviating parameter values have been agreed for this realm.'
,p_translate_from_text=>unistr('Setzen Sie den G\00FCltigkeitsbereich f\00FCr die aktuelle Umgebung. Dies hat direkte Auswirkungen auf die Parameterwerte, falls f\00FCr diesen G\00FCltigkeitsbereich abweichende Parameterwerte vereinbart wurden.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146054729384184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716818084286444.128)
,p_translate_from_id=>wwv_flow_api.id(165716818084286444)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the target language into which you want to translate the messages.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146054942288184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177474859048508773.128)
,p_translate_from_id=>wwv_flow_api.id(177474859048508773)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'If the group allows editing, this can be suppressed for individual parameters.'
,p_translate_from_text=>unistr('Falls die Gruppe das Editieren erlaubt, kann dies f\00FCr einzelne Parameter unterdr\00FCckt werden.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146055077053184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717742054286453.128)
,p_translate_from_id=>wwv_flow_api.id(165717742054286453)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the target language into which you want to translate the messages.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146055327818184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633245112914917.128)
,p_translate_from_id=>wwv_flow_api.id(177633245112914917)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'List of output modules that should output log information.'
,p_translate_from_text=>'Liste der Ausgabemodule, die Log-Informationen ausgeben sollen.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146055556836184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841756138058113.128)
,p_translate_from_id=>wwv_flow_api.id(177841756138058113)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Move all parameter groups you want to export to the right column.'
,p_translate_from_text=>unistr('Bewegen Sie alle Parametergruppen, die Sie exportieren m\00F6chten, in die rechte Spalte.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146055701046184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168370083383199496.128)
,p_translate_from_id=>wwv_flow_api.id(168370083383199496)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Optional Description.<br>Can be used to give additional instructions to the user in case of an error.'
,p_translate_from_text=>unistr('Optionale Beschreibung.<br>Kann verwendet werden, um im Fehlerfall zus\00E4tzliche Handlungsanweisungen an den Anwender zu geben.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146055943666184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916069416870392.128)
,p_translate_from_id=>wwv_flow_api.id(175916069416870392)
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
 p_id=>wwv_flow_api.id(146056117478184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770582041752346.128)
,p_translate_from_id=>wwv_flow_api.id(177770582041752346)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Unique identifier of the context. Without special characters and spaces. The name is case-sensitive and must conform to the naming rules of an Oracle identifier.'
,p_translate_from_text=>unistr('Eindeutiger Bezeichner des Kontexts. Ohne Sonderzeichen und Leerzeichen. Der Name wird in Gro\00DFschreibung \00FCberf\00FChrt und muss den Namensregeln eines Oracle-Bezeichners entsprechen.')
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146056353106184797)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471609148508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471609148508767)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Enter an optional description of the parameter.'
,p_translate_from_text=>'Geben Sie eine optionale Beschreibung des Parameters ein.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146056503646184800)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175899148282657318.128)
,p_translate_from_id=>wwv_flow_api.id(175899148282657318)
,p_translate_column_id=>112
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_translate_from_text=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146056708233184998)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(212627799475128490.128)
,p_translate_from_id=>wwv_flow_api.id(212627799475128490)
,p_translate_column_id=>237
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CodeMirror'
,p_translate_from_text=>'CodeMirror'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146056803739185000)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(212627799475128490.128)
,p_translate_from_id=>wwv_flow_api.id(212627799475128490)
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
 p_id=>wwv_flow_api.id(146057023614185045)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177470975776508765.128)
,p_translate_from_id=>wwv_flow_api.id(177470975776508765)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146057172489185045)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170953624155513068.128)
,p_translate_from_id=>wwv_flow_api.id(170953624155513068)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146057414217185045)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770960042752348.128)
,p_translate_from_id=>wwv_flow_api.id(177770960042752348)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146057579884185045)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177795858415192862.128)
,p_translate_from_id=>wwv_flow_api.id(177795858415192862)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146057830832185045)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717530408286451.128)
,p_translate_from_id=>wwv_flow_api.id(165717530408286451)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146057975687185045)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471245421508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471245421508767)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146058248083185045)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770176129752329.128)
,p_translate_from_id=>wwv_flow_api.id(177770176129752329)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146058376940185045)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633157929914916.128)
,p_translate_from_id=>wwv_flow_api.id(177633157929914916)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146058654034185045)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634578799914930.128)
,p_translate_from_id=>wwv_flow_api.id(177634578799914930)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146058798923185045)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904376490657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904376490657339)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146058983138185047)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147575986253367164.128)
,p_translate_from_id=>wwv_flow_api.id(147575986253367164)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146059225887185047)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538196215809332.128)
,p_translate_from_id=>wwv_flow_api.id(147538196215809332)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146059428653185047)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177796603156192864.128)
,p_translate_from_id=>wwv_flow_api.id(177796603156192864)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146059598552185047)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177840710921058103.128)
,p_translate_from_id=>wwv_flow_api.id(177840710921058103)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146059836679185047)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471990025508770.128)
,p_translate_from_id=>wwv_flow_api.id(177471990025508770)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146060043929185047)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388698406150565.128)
,p_translate_from_id=>wwv_flow_api.id(165388698406150565)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146060169775185047)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177474416938508771.128)
,p_translate_from_id=>wwv_flow_api.id(177474416938508771)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146060453727185047)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916744011870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916744011870395)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146060609395185047)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633001336914915.128)
,p_translate_from_id=>wwv_flow_api.id(177633001336914915)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146060852945185047)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632915416914914.128)
,p_translate_from_id=>wwv_flow_api.id(177632915416914914)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146061053093185047)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717617663286452.128)
,p_translate_from_id=>wwv_flow_api.id(165717617663286452)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146061180323185047)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475285797508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475285797508773)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146061385208185047)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904238193657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904238193657339)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146061592481185047)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916351760870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916351760870395)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146061809819185047)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175917166306870395.128)
,p_translate_from_id=>wwv_flow_api.id(175917166306870395)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146061987053185047)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475625746508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475625746508773)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146062230267185047)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177476006802508773.128)
,p_translate_from_id=>wwv_flow_api.id(177476006802508773)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146062463978185047)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632565747914910.128)
,p_translate_from_id=>wwv_flow_api.id(177632565747914910)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146062576512185047)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177796276699192864.128)
,p_translate_from_id=>wwv_flow_api.id(177796276699192864)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146062773635185047)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797055859192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797055859192864)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146063001699185047)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369640503199491.128)
,p_translate_from_id=>wwv_flow_api.id(168369640503199491)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146063239897185047)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177631745019914902.128)
,p_translate_from_id=>wwv_flow_api.id(177631745019914902)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146063369071185047)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177771385842752348.128)
,p_translate_from_id=>wwv_flow_api.id(177771385842752348)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146063606842185048)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177771745464752348.128)
,p_translate_from_id=>wwv_flow_api.id(177771745464752348)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146063802458185048)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635499285914940.128)
,p_translate_from_id=>wwv_flow_api.id(177635499285914940)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146064053445185048)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147576806748367168.128)
,p_translate_from_id=>wwv_flow_api.id(147576806748367168)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146064249849185048)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716818084286444.128)
,p_translate_from_id=>wwv_flow_api.id(165716818084286444)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146064456953185048)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237871654886333.128)
,p_translate_from_id=>wwv_flow_api.id(171237871654886333)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146064590592185048)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177474859048508773.128)
,p_translate_from_id=>wwv_flow_api.id(177474859048508773)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'1'
,p_translate_from_text=>'1'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146064798578185048)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175915671870870375.128)
,p_translate_from_id=>wwv_flow_api.id(175915671870870375)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146065037718185048)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633245112914917.128)
,p_translate_from_id=>wwv_flow_api.id(177633245112914917)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146065261952185048)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841756138058113.128)
,p_translate_from_id=>wwv_flow_api.id(177841756138058113)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'MOVE'
,p_translate_from_text=>'MOVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146065446519185048)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717742054286453.128)
,p_translate_from_id=>wwv_flow_api.id(165717742054286453)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146065596105185048)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237937942886334.128)
,p_translate_from_id=>wwv_flow_api.id(171237937942886334)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146065800933185048)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916069416870392.128)
,p_translate_from_id=>wwv_flow_api.id(175916069416870392)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146065970062185048)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168370083383199496.128)
,p_translate_from_id=>wwv_flow_api.id(168370083383199496)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146066241523185048)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770582041752346.128)
,p_translate_from_id=>wwv_flow_api.id(177770582041752346)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146066413891185048)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147576354468367167.128)
,p_translate_from_id=>wwv_flow_api.id(147576354468367167)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146066665005185048)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471609148508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471609148508767)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146066819320185048)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717007523286446.128)
,p_translate_from_id=>wwv_flow_api.id(165717007523286446)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146067003333185048)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719808601286474.128)
,p_translate_from_id=>wwv_flow_api.id(165719808601286474)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APEX_APPLICATION_TEMP_FILES'
,p_translate_from_text=>'APEX_APPLICATION_TEMP_FILES'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146067217262185048)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165720079801286477.128)
,p_translate_from_id=>wwv_flow_api.id(165720079801286477)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APEX_APPLICATION_TEMP_FILES'
,p_translate_from_text=>'APEX_APPLICATION_TEMP_FILES'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146067422788185052)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177470975776508765.128)
,p_translate_from_id=>wwv_flow_api.id(177470975776508765)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146067631954185052)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177795858415192862.128)
,p_translate_from_id=>wwv_flow_api.id(177795858415192862)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146067848897185052)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471245421508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471245421508767)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146067998827185052)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538196215809332.128)
,p_translate_from_id=>wwv_flow_api.id(147538196215809332)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146068202020185052)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177796603156192864.128)
,p_translate_from_id=>wwv_flow_api.id(177796603156192864)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146068434582185052)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471990025508770.128)
,p_translate_from_id=>wwv_flow_api.id(177471990025508770)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146068636694185052)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388698406150565.128)
,p_translate_from_id=>wwv_flow_api.id(165388698406150565)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146068840188185052)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916744011870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916744011870395)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146069047699185052)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633001336914915.128)
,p_translate_from_id=>wwv_flow_api.id(177633001336914915)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146069224227185052)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177632915416914914.128)
,p_translate_from_id=>wwv_flow_api.id(177632915416914914)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146069448186185052)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717617663286452.128)
,p_translate_from_id=>wwv_flow_api.id(165717617663286452)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146069596259185053)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475285797508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475285797508773)
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
 p_id=>wwv_flow_api.id(146069774205185053)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904238193657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904238193657339)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146070000137185053)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916351760870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916351760870395)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146070176407185053)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175917166306870395.128)
,p_translate_from_id=>wwv_flow_api.id(175917166306870395)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146070411622185053)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475625746508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475625746508773)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146070601321185053)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177476006802508773.128)
,p_translate_from_id=>wwv_flow_api.id(177476006802508773)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146070767977185053)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797055859192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797055859192864)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146071040979185053)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369640503199491.128)
,p_translate_from_id=>wwv_flow_api.id(168369640503199491)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146071185579185053)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177631745019914902.128)
,p_translate_from_id=>wwv_flow_api.id(177631745019914902)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146071422153185053)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177771385842752348.128)
,p_translate_from_id=>wwv_flow_api.id(177771385842752348)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146071574263185053)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147576806748367168.128)
,p_translate_from_id=>wwv_flow_api.id(147576806748367168)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146071818466185053)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716818084286444.128)
,p_translate_from_id=>wwv_flow_api.id(165716818084286444)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146071977535185053)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237871654886333.128)
,p_translate_from_id=>wwv_flow_api.id(171237871654886333)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146072195019185053)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717742054286453.128)
,p_translate_from_id=>wwv_flow_api.id(165717742054286453)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146072397213185053)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171237937942886334.128)
,p_translate_from_id=>wwv_flow_api.id(171237937942886334)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146072643867185053)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916069416870392.128)
,p_translate_from_id=>wwv_flow_api.id(175916069416870392)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146072800186185053)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168370083383199496.128)
,p_translate_from_id=>wwv_flow_api.id(168370083383199496)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146073036241185053)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770582041752346.128)
,p_translate_from_id=>wwv_flow_api.id(177770582041752346)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146073193901185053)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471609148508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471609148508767)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146073416306185053)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717007523286446.128)
,p_translate_from_id=>wwv_flow_api.id(165717007523286446)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146073592244185056)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471990025508770.128)
,p_translate_from_id=>wwv_flow_api.id(177471990025508770)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146073856233185056)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388698406150565.128)
,p_translate_from_id=>wwv_flow_api.id(165388698406150565)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146074047105185056)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177472465193508770.128)
,p_translate_from_id=>wwv_flow_api.id(177472465193508770)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146074191925185056)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916744011870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916744011870395)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146074392526185056)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175917538597870396.128)
,p_translate_from_id=>wwv_flow_api.id(175917538597870396)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146074640191185058)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177771385842752348.128)
,p_translate_from_id=>wwv_flow_api.id(177771385842752348)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146074830214185058)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177472788053508770.128)
,p_translate_from_id=>wwv_flow_api.id(177472788053508770)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146075025540185058)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168370083383199496.128)
,p_translate_from_id=>wwv_flow_api.id(168370083383199496)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146075258595185059)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177470975776508765.128)
,p_translate_from_id=>wwv_flow_api.id(177470975776508765)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146075439450185059)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177795858415192862.128)
,p_translate_from_id=>wwv_flow_api.id(177795858415192862)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146075578906185059)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538196215809332.128)
,p_translate_from_id=>wwv_flow_api.id(147538196215809332)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146075799676185059)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471990025508770.128)
,p_translate_from_id=>wwv_flow_api.id(177471990025508770)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146075968330185059)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388698406150565.128)
,p_translate_from_id=>wwv_flow_api.id(165388698406150565)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146076184374185059)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473637814508771.128)
,p_translate_from_id=>wwv_flow_api.id(177473637814508771)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146076368351185059)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916744011870395.128)
,p_translate_from_id=>wwv_flow_api.id(175916744011870395)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146076662815185059)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717617663286452.128)
,p_translate_from_id=>wwv_flow_api.id(165717617663286452)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146076808160185059)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904238193657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904238193657339)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146077064435185059)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475625746508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475625746508773)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146077225813185059)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177476006802508773.128)
,p_translate_from_id=>wwv_flow_api.id(177476006802508773)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146077420148185059)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797055859192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797055859192864)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146077583325185061)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177771385842752348.128)
,p_translate_from_id=>wwv_flow_api.id(177771385842752348)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146077865906185061)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473231405508770.128)
,p_translate_from_id=>wwv_flow_api.id(177473231405508770)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146077997691185061)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916069416870392.128)
,p_translate_from_id=>wwv_flow_api.id(175916069416870392)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146078178559185061)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168370083383199496.128)
,p_translate_from_id=>wwv_flow_api.id(168370083383199496)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146078389258185061)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770582041752346.128)
,p_translate_from_id=>wwv_flow_api.id(177770582041752346)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146078603810185061)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471609148508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471609148508767)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146078789182185061)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717007523286446.128)
,p_translate_from_id=>wwv_flow_api.id(165717007523286446)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146079048688185063)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177470975776508765.128)
,p_translate_from_id=>wwv_flow_api.id(177470975776508765)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146079253447185064)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177795858415192862.128)
,p_translate_from_id=>wwv_flow_api.id(177795858415192862)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146079415976185064)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473637814508771.128)
,p_translate_from_id=>wwv_flow_api.id(177473637814508771)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146079580118185064)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904238193657339.128)
,p_translate_from_id=>wwv_flow_api.id(175904238193657339)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146079819466185064)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177475625746508773.128)
,p_translate_from_id=>wwv_flow_api.id(177475625746508773)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146080020396185064)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177476006802508773.128)
,p_translate_from_id=>wwv_flow_api.id(177476006802508773)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146080180686185064)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797055859192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797055859192864)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146080421765185064)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473231405508770.128)
,p_translate_from_id=>wwv_flow_api.id(177473231405508770)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146080650112185064)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175916069416870392.128)
,p_translate_from_id=>wwv_flow_api.id(175916069416870392)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146080816979185064)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177770582041752346.128)
,p_translate_from_id=>wwv_flow_api.id(177770582041752346)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146080991660185064)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177471609148508767.128)
,p_translate_from_id=>wwv_flow_api.id(177471609148508767)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146081252130185067)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473231405508770.128)
,p_translate_from_id=>wwv_flow_api.id(177473231405508770)
,p_translate_column_id=>274
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146081408032185067)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177473637814508771.128)
,p_translate_from_id=>wwv_flow_api.id(177473637814508771)
,p_translate_column_id=>274
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146081628799185072)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719808601286474.128)
,p_translate_from_id=>wwv_flow_api.id(165719808601286474)
,p_translate_column_id=>276
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'REQUEST'
,p_translate_from_text=>'REQUEST'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146081780879185072)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165720079801286477.128)
,p_translate_from_id=>wwv_flow_api.id(165720079801286477)
,p_translate_column_id=>276
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'REQUEST'
,p_translate_from_text=>'REQUEST'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146082006049185073)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719808601286474.128)
,p_translate_from_id=>wwv_flow_api.id(165719808601286474)
,p_translate_column_id=>277
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146082209425185073)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165720079801286477.128)
,p_translate_from_id=>wwv_flow_api.id(165720079801286477)
,p_translate_column_id=>277
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146082439012185077)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147581682822367179.128)
,p_translate_from_id=>wwv_flow_api.id(147581682822367179)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146082651036185077)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177774547817752353.128)
,p_translate_from_id=>wwv_flow_api.id(177774547817752353)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146082796158185077)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175920679007870400.128)
,p_translate_from_id=>wwv_flow_api.id(175920679007870400)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146083048185185077)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171236704243886322.128)
,p_translate_from_id=>wwv_flow_api.id(171236704243886322)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146083181809185077)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165641707012845629.128)
,p_translate_from_id=>wwv_flow_api.id(165641707012845629)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146083432983185077)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386177261150540.128)
,p_translate_from_id=>wwv_flow_api.id(165386177261150540)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146083598844185077)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633427738914919.128)
,p_translate_from_id=>wwv_flow_api.id(177633427738914919)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146083781078185077)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177478461640508776.128)
,p_translate_from_id=>wwv_flow_api.id(177478461640508776)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146084032726185077)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153396720554398419.128)
,p_translate_from_id=>wwv_flow_api.id(153396720554398419)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146084255626185077)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177478820007508776.128)
,p_translate_from_id=>wwv_flow_api.id(177478820007508776)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146084436977185077)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797404361192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797404361192864)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146084653715185077)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165878681697037206.128)
,p_translate_from_id=>wwv_flow_api.id(165878681697037206)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146084809997185077)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904831554657340.128)
,p_translate_from_id=>wwv_flow_api.id(175904831554657340)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146085004599185083)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147581682822367179.128)
,p_translate_from_id=>wwv_flow_api.id(147581682822367179)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_set_realm;'
,p_translate_from_text=>'pit_ui.process_set_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146085168895185083)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171236704243886322.128)
,p_translate_from_id=>wwv_flow_api.id(171236704243886322)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_pms;'
,p_translate_from_text=>'pit_ui.process_edit_pms;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146085404688185083)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165641707012845629.128)
,p_translate_from_id=>wwv_flow_api.id(165641707012845629)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_module;'
,p_translate_from_text=>'pit_ui.process_edit_module;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146085619710185083)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386177261150540.128)
,p_translate_from_id=>wwv_flow_api.id(165386177261150540)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_pgr;'
,p_translate_from_text=>'pit_ui.process_edit_pgr;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146085816210185083)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633427738914919.128)
,p_translate_from_id=>wwv_flow_api.id(177633427738914919)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_context;'
,p_translate_from_text=>'pit_ui.process_edit_context;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146086058632185084)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177478461640508776.128)
,p_translate_from_id=>wwv_flow_api.id(177478461640508776)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_par;'
,p_translate_from_text=>'pit_ui.process_edit_par;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146086204362185084)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153396720554398419.128)
,p_translate_from_id=>wwv_flow_api.id(153396720554398419)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_par_realm;'
,p_translate_from_text=>'pit_ui.process_edit_par_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146086445621185084)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797404361192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797404361192864)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_toggle;'
,p_translate_from_text=>'pit_ui.process_edit_toggle;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146086617541185084)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165878681697037206.128)
,p_translate_from_id=>wwv_flow_api.id(165878681697037206)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_pmg;'
,p_translate_from_text=>'pit_ui.process_edit_pmg;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146086864200185086)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147581682822367179.128)
,p_translate_from_id=>wwv_flow_api.id(147581682822367179)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146087060139185086)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171236704243886322.128)
,p_translate_from_id=>wwv_flow_api.id(171236704243886322)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146087209466185086)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165641707012845629.128)
,p_translate_from_id=>wwv_flow_api.id(165641707012845629)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146087399690185086)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386177261150540.128)
,p_translate_from_id=>wwv_flow_api.id(165386177261150540)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146087608582185086)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633427738914919.128)
,p_translate_from_id=>wwv_flow_api.id(177633427738914919)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146087797946185086)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177478461640508776.128)
,p_translate_from_id=>wwv_flow_api.id(177478461640508776)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146088016941185086)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153396720554398419.128)
,p_translate_from_id=>wwv_flow_api.id(153396720554398419)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146088263872185086)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797404361192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797404361192864)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146088370734185086)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165878681697037206.128)
,p_translate_from_id=>wwv_flow_api.id(165878681697037206)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146088593533185089)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147581682822367179.128)
,p_translate_from_id=>wwv_flow_api.id(147581682822367179)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146088832893185089)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171236704243886322.128)
,p_translate_from_id=>wwv_flow_api.id(171236704243886322)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146089048913185089)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165641707012845629.128)
,p_translate_from_id=>wwv_flow_api.id(165641707012845629)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146089223419185089)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386177261150540.128)
,p_translate_from_id=>wwv_flow_api.id(165386177261150540)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146089392048185089)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633427738914919.128)
,p_translate_from_id=>wwv_flow_api.id(177633427738914919)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146089612674185089)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177478461640508776.128)
,p_translate_from_id=>wwv_flow_api.id(177478461640508776)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146089845146185089)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153396720554398419.128)
,p_translate_from_id=>wwv_flow_api.id(153396720554398419)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146089997512185089)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177797404361192864.128)
,p_translate_from_id=>wwv_flow_api.id(177797404361192864)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146090174215185089)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165878681697037206.128)
,p_translate_from_id=>wwv_flow_api.id(165878681697037206)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146090423365185098)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634688115914932.128)
,p_translate_from_id=>wwv_flow_api.id(177634688115914932)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146090582484185098)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177634826379914933.128)
,p_translate_from_id=>wwv_flow_api.id(177634826379914933)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146090819447185098)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388990555150568.128)
,p_translate_from_id=>wwv_flow_api.id(165388990555150568)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146091014897185098)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717125445286447.128)
,p_translate_from_id=>wwv_flow_api.id(165717125445286447)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'condes.pit.utils.controlExportItems();'
,p_translate_from_text=>'condes.pit.utils.controlExportItems();'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146091264811185098)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171238338474886338.128)
,p_translate_from_id=>wwv_flow_api.id(171238338474886338)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146091428406185098)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719220073286468.128)
,p_translate_from_id=>wwv_flow_api.id(165719220073286468)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''PMG_NAME'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''PMG_NAME'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146091636838185098)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(171238452354886339.128)
,p_translate_from_id=>wwv_flow_api.id(171238452354886339)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146091823064185098)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389214969150570.128)
,p_translate_from_id=>wwv_flow_api.id(165389214969150570)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'STATIC_ASSIGNMENT'
,p_translate_from_text=>'STATIC_ASSIGNMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146092046648185100)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369776992199493.128)
,p_translate_from_id=>wwv_flow_api.id(168369776992199493)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''P3_PMS_NAME'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''P3_PMS_NAME'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146092254573185100)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719463895286471.128)
,p_translate_from_id=>wwv_flow_api.id(165719463895286471)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.harmonize_sql_name(''PGR_ID'');'
,p_translate_from_text=>'pit_ui.harmonize_sql_name(''PGR_ID'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146092393562185100)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635806538914943.128)
,p_translate_from_id=>wwv_flow_api.id(177635806538914943)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146092595463185100)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635915820914944.128)
,p_translate_from_id=>wwv_flow_api.id(177635915820914944)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146092840246185100)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538391795809334.128)
,p_translate_from_id=>wwv_flow_api.id(147538391795809334)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'SQL_STATEMENT'
,p_translate_from_text=>'SQL_STATEMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146093045345185100)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389072808150569.128)
,p_translate_from_id=>wwv_flow_api.id(165389072808150569)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'STATIC_ASSIGNMENT'
,p_translate_from_text=>'STATIC_ASSIGNMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146093226550185100)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635230280914937.128)
,p_translate_from_id=>wwv_flow_api.id(177635230280914937)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.set_allow_toggles;'
,p_translate_from_text=>'pit_ui.set_allow_toggles;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146093373388185100)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635294184914938.128)
,p_translate_from_id=>wwv_flow_api.id(177635294184914938)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.set_allow_toggles;'
,p_translate_from_text=>'pit_ui.set_allow_toggles;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146093598670185102)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719220073286468.128)
,p_translate_from_id=>wwv_flow_api.id(165719220073286468)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PMG_NAME'
,p_translate_from_text=>'PMG_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146093832910185102)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369776992199493.128)
,p_translate_from_id=>wwv_flow_api.id(168369776992199493)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P3_PMS_NAME'
,p_translate_from_text=>'P3_PMS_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146094053976185102)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719463895286471.128)
,p_translate_from_id=>wwv_flow_api.id(165719463895286471)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PGR_ID'
,p_translate_from_text=>'PGR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146094208724185102)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389072808150569.128)
,p_translate_from_id=>wwv_flow_api.id(165389072808150569)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'-20000'
,p_translate_from_text=>'-20000'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146094456715185102)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635230280914937.128)
,p_translate_from_id=>wwv_flow_api.id(177635230280914937)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P9_ALLOW_TOGGLE'
,p_translate_from_text=>'P9_ALLOW_TOGGLE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146094589689185102)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635294184914938.128)
,p_translate_from_id=>wwv_flow_api.id(177635294184914938)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P9_ALLOW_TOGGLE'
,p_translate_from_text=>'P9_ALLOW_TOGGLE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146094783688185105)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719220073286468.128)
,p_translate_from_id=>wwv_flow_api.id(165719220073286468)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PMG_NAME'
,p_translate_from_text=>'PMG_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146095027351185105)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369776992199493.128)
,p_translate_from_id=>wwv_flow_api.id(168369776992199493)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P3_PMS_NAME'
,p_translate_from_text=>'P3_PMS_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146095256152185105)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719463895286471.128)
,p_translate_from_id=>wwv_flow_api.id(165719463895286471)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PGR_ID'
,p_translate_from_text=>'PGR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146095395866185105)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538391795809334.128)
,p_translate_from_id=>wwv_flow_api.id(147538391795809334)
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
 p_id=>wwv_flow_api.id(146095647216185106)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719220073286468.128)
,p_translate_from_id=>wwv_flow_api.id(165719220073286468)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146095852317185106)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369776992199493.128)
,p_translate_from_id=>wwv_flow_api.id(168369776992199493)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146096002621185106)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719463895286471.128)
,p_translate_from_id=>wwv_flow_api.id(165719463895286471)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146096182827185109)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719220073286468.128)
,p_translate_from_id=>wwv_flow_api.id(165719220073286468)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146096372705185109)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168369776992199493.128)
,p_translate_from_id=>wwv_flow_api.id(168369776992199493)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146096618833185109)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719463895286471.128)
,p_translate_from_id=>wwv_flow_api.id(165719463895286471)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146096831412185109)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635230280914937.128)
,p_translate_from_id=>wwv_flow_api.id(177635230280914937)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146097039055185109)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177635294184914938.128)
,p_translate_from_id=>wwv_flow_api.id(177635294184914938)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146097182301185114)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538391795809334.128)
,p_translate_from_id=>wwv_flow_api.id(147538391795809334)
,p_translate_column_id=>295
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146097450716185116)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389072808150569.128)
,p_translate_from_id=>wwv_flow_api.id(165389072808150569)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146097649491185116)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389214969150570.128)
,p_translate_from_id=>wwv_flow_api.id(165389214969150570)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146097788577185117)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147538391795809334.128)
,p_translate_from_id=>wwv_flow_api.id(147538391795809334)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146098026224185120)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(161163822489463303.128)
,p_translate_from_id=>wwv_flow_api.id(161163822489463303)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146098227543185120)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175860939759657285.128)
,p_translate_from_id=>wwv_flow_api.id(175860939759657285)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146098421212185120)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175861085923657285.128)
,p_translate_from_id=>wwv_flow_api.id(175861085923657285)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146098627076185120)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168324702035932402.128)
,p_translate_from_id=>wwv_flow_api.id(168324702035932402)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'classic'
,p_translate_from_text=>'classic'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146098801091185120)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(168324659056932402.128)
,p_translate_from_id=>wwv_flow_api.id(168324659056932402)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'LEGACY'
,p_translate_from_text=>'LEGACY'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146099046034185122)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(144599502921826103.128)
,p_translate_from_id=>wwv_flow_api.id(144599502921826103)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'fa-star'
,p_translate_from_text=>'fa-star'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146099197972185122)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(144598973683826102.128)
,p_translate_from_id=>wwv_flow_api.id(144598973683826102)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146099428747185123)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(144598973683826102.128)
,p_translate_from_id=>wwv_flow_api.id(144598973683826102)
,p_translate_column_id=>299
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
 p_id=>wwv_flow_api.id(146099793540185125)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175861085923657285.128)
,p_translate_from_id=>wwv_flow_api.id(175861085923657285)
,p_translate_column_id=>300
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146100054560185127)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(144599502921826103.128)
,p_translate_from_id=>wwv_flow_api.id(144599502921826103)
,p_translate_column_id=>301
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'#VALUE#'
,p_translate_from_text=>'#VALUE#'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146100418731185130)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175861085923657285.128)
,p_translate_from_id=>wwv_flow_api.id(175861085923657285)
,p_translate_column_id=>302
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'SWITCH_CB'
,p_translate_from_text=>'SWITCH_CB'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146100570414185139)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467143155508657.128)
,p_translate_from_id=>wwv_flow_api.id(177467143155508657)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146100818692185139)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912499148870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912499148870284)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146101012687185139)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767337246752325.128)
,p_translate_from_id=>wwv_flow_api.id(177767337246752325)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146101205856185141)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717263633286449.128)
,p_translate_from_id=>wwv_flow_api.id(165717263633286449)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146101435727185141)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147578084847367173.128)
,p_translate_from_id=>wwv_flow_api.id(147578084847367173)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146101646622185141)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165718144958286457.128)
,p_translate_from_id=>wwv_flow_api.id(165718144958286457)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146101854581185141)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467843304508660.128)
,p_translate_from_id=>wwv_flow_api.id(177467843304508660)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146101971779185141)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793985346192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793985346192860)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146102233452185141)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386713245150545.128)
,p_translate_from_id=>wwv_flow_api.id(165386713245150545)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146102424181185141)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904094044657335.128)
,p_translate_from_id=>wwv_flow_api.id(175904094044657335)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146102648639185141)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841159392058107.128)
,p_translate_from_id=>wwv_flow_api.id(177841159392058107)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146102829261185141)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717165203286448.128)
,p_translate_from_id=>wwv_flow_api.id(165717165203286448)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146102994984185141)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717438326286450.128)
,p_translate_from_id=>wwv_flow_api.id(165717438326286450)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146103258274185141)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175911811137870284.128)
,p_translate_from_id=>wwv_flow_api.id(175911811137870284)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146103388654185141)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633751662914922.128)
,p_translate_from_id=>wwv_flow_api.id(177633751662914922)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146103572689185141)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389533861150573.128)
,p_translate_from_id=>wwv_flow_api.id(165389533861150573)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146103863266185141)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841220613058108.128)
,p_translate_from_id=>wwv_flow_api.id(177841220613058108)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146104007628185141)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177766667613752325.128)
,p_translate_from_id=>wwv_flow_api.id(177766667613752325)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146104214868185141)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793232726192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793232726192860)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146104368671185144)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467143155508657.128)
,p_translate_from_id=>wwv_flow_api.id(177467143155508657)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146104652406185144)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912499148870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912499148870284)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146104854381185144)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767337246752325.128)
,p_translate_from_id=>wwv_flow_api.id(177767337246752325)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146105049135185144)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717263633286449.128)
,p_translate_from_id=>wwv_flow_api.id(165717263633286449)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146105227685185144)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147578084847367173.128)
,p_translate_from_id=>wwv_flow_api.id(147578084847367173)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146105461726185144)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165718144958286457.128)
,p_translate_from_id=>wwv_flow_api.id(165718144958286457)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146105611526185144)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467843304508660.128)
,p_translate_from_id=>wwv_flow_api.id(177467843304508660)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146105863393185144)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793985346192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793985346192860)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146106049745185144)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386713245150545.128)
,p_translate_from_id=>wwv_flow_api.id(165386713245150545)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146106203104185144)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904094044657335.128)
,p_translate_from_id=>wwv_flow_api.id(175904094044657335)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146106441297185144)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841159392058107.128)
,p_translate_from_id=>wwv_flow_api.id(177841159392058107)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146106641904185144)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717165203286448.128)
,p_translate_from_id=>wwv_flow_api.id(165717165203286448)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146106785418185144)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165717438326286450.128)
,p_translate_from_id=>wwv_flow_api.id(165717438326286450)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146107058980185144)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175911811137870284.128)
,p_translate_from_id=>wwv_flow_api.id(175911811137870284)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146107228219185144)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177633751662914922.128)
,p_translate_from_id=>wwv_flow_api.id(177633751662914922)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146107434069185145)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165389533861150573.128)
,p_translate_from_id=>wwv_flow_api.id(165389533861150573)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146107599502185145)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177841220613058108.128)
,p_translate_from_id=>wwv_flow_api.id(177841220613058108)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146107840958185145)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177766667613752325.128)
,p_translate_from_id=>wwv_flow_api.id(177766667613752325)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146107972277185145)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793232726192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793232726192860)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146108182547185147)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467143155508657.128)
,p_translate_from_id=>wwv_flow_api.id(177467143155508657)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146108369625185147)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175912499148870284.128)
,p_translate_from_id=>wwv_flow_api.id(175912499148870284)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146108665660185147)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177767337246752325.128)
,p_translate_from_id=>wwv_flow_api.id(177767337246752325)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146108789553185147)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(147578084847367173.128)
,p_translate_from_id=>wwv_flow_api.id(147578084847367173)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146109005973185147)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177467843304508660.128)
,p_translate_from_id=>wwv_flow_api.id(177467843304508660)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146109202062185147)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793985346192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793985346192860)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146109407136185147)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175904094044657335.128)
,p_translate_from_id=>wwv_flow_api.id(175904094044657335)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146109625055185147)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175911811137870284.128)
,p_translate_from_id=>wwv_flow_api.id(175911811137870284)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146109860548185148)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177766667613752325.128)
,p_translate_from_id=>wwv_flow_api.id(177766667613752325)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146110021101185148)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177793232726192860.128)
,p_translate_from_id=>wwv_flow_api.id(177793232726192860)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146110169857185163)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719808601286474.128)
,p_translate_from_id=>wwv_flow_api.id(165719808601286474)
,p_translate_column_id=>318
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'application/xliff+xml'
,p_translate_from_text=>'application/xliff+xml'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146110382044185163)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165720079801286477.128)
,p_translate_from_id=>wwv_flow_api.id(165720079801286477)
,p_translate_column_id=>318
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'application/xliff+xml'
,p_translate_from_text=>'application/xliff+xml'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146110609084185164)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719808601286474.128)
,p_translate_from_id=>wwv_flow_api.id(165719808601286474)
,p_translate_column_id=>319
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NATIVE'
,p_translate_from_text=>'NATIVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146110736919185164)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165720079801286477.128)
,p_translate_from_id=>wwv_flow_api.id(165720079801286477)
,p_translate_column_id=>319
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NATIVE'
,p_translate_from_text=>'NATIVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146110964414185264)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177811992993486492.128)
,p_translate_from_id=>wwv_flow_api.id(177811992993486492)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung und Export')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146111020647185264)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(176704677738762887.128)
,p_translate_from_id=>wwv_flow_api.id(176704677738762887)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create and edit parameter values'
,p_translate_from_text=>'Parameter erstellen und editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146111247580185264)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177657362161214579.128)
,p_translate_from_id=>wwv_flow_api.id(177657362161214579)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer actual PIT settings'
,p_translate_from_text=>'Einsatzeinstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146111414444185264)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175921775232870403.128)
,p_translate_from_id=>wwv_flow_api.id(175921775232870403)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create, edit and translate messages'
,p_translate_from_text=>'Meldungen erzeugen und editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146111601907185267)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177811992993486492.128)
,p_translate_from_id=>wwv_flow_api.id(177811992993486492)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Allows the creation of script files for export or translation'
,p_translate_from_text=>unistr('Erlaubt die Erstellung von Skriptdateien zum Export oder zum \00DCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146111842702185267)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(177657362161214579.128)
,p_translate_from_id=>wwv_flow_api.id(177657362161214579)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Controls contexts, toggles and shows the current parameterization'
,p_translate_from_text=>'Kontrolliert Kontexte, Toggles und zeigt die aktuelle Parametrierung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146111970755185267)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175921775232870403.128)
,p_translate_from_id=>wwv_flow_api.id(175921775232870403)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Management of new messages and modification of existing ones'
,p_translate_from_text=>unistr('Verwaltung neuer Meldungen und \00C4nderung bestehender')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146112213329185302)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(175903650235657326.128)
,p_translate_from_id=>wwv_flow_api.id(175903650235657326)
,p_translate_column_id=>397
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Desktop'
,p_translate_from_text=>'Desktop'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146112378775185336)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165877505065037204.128)
,p_translate_from_id=>wwv_flow_api.id(165877505065037204)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message Amt.'
,p_translate_from_text=>'Anzahl Meldungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146112594475185338)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165636292160845624.128)
,p_translate_from_id=>wwv_flow_api.id(165636292160845624)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Id'
,p_translate_from_text=>'Par Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146112768624185338)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(131738211202223948.128)
,p_translate_from_id=>wwv_flow_api.id(131738211202223948)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Pms Pse Id'
,p_translate_from_text=>'Pms Pse Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146113021817185338)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647153105373538.128)
,p_translate_from_id=>wwv_flow_api.id(174647153105373538)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error ID'
,p_translate_from_text=>'Fehler-ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146113200944185338)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397783822398430.128)
,p_translate_from_id=>wwv_flow_api.id(153397783822398430)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Boolean value'
,p_translate_from_text=>'Wahrheitswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146113397890185338)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165641097333845627.128)
,p_translate_from_id=>wwv_flow_api.id(165641097333845627)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Flag'
,p_translate_from_text=>'Flag'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146113575048185338)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165385820627150536.128)
,p_translate_from_id=>wwv_flow_api.id(165385820627150536)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'modifizierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146113785333185338)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646908228373536.128)
,p_translate_from_id=>wwv_flow_api.id(174646908228373536)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text'
,p_translate_from_text=>'Text'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146114058023185338)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170953805187513069.128)
,p_translate_from_id=>wwv_flow_api.id(170953805187513069)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146114201748185338)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397280885398425.128)
,p_translate_from_id=>wwv_flow_api.id(153397280885398425)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text value'
,p_translate_from_text=>'Textwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146114432117185338)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719664257286473.128)
,p_translate_from_id=>wwv_flow_api.id(165719664257286473)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter Amt.'
,p_translate_from_text=>'Anz. Parameter'
);
end;
/
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146114574099185338)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646605379373533.128)
,p_translate_from_id=>wwv_flow_api.id(174646605379373533)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146114848394185338)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647254176373539.128)
,p_translate_from_id=>wwv_flow_api.id(174647254176373539)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error number'
,p_translate_from_text=>'Fehlernr'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146114980043185338)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387651408150554.128)
,p_translate_from_id=>wwv_flow_api.id(165387651408150554)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text type'
,p_translate_from_text=>'Texttyp'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146115209909185338)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165876949813037204.128)
,p_translate_from_id=>wwv_flow_api.id(165876949813037204)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146115439875185338)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397600020398428.128)
,p_translate_from_id=>wwv_flow_api.id(153397600020398428)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date value'
,p_translate_from_text=>'Datumswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146115639456185338)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165637463168845626.128)
,p_translate_from_id=>wwv_flow_api.id(165637463168845626)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146115845065185338)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165638103035845626.128)
,p_translate_from_id=>wwv_flow_api.id(165638103035845626)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'String'
,p_translate_from_text=>'Zeichenkette'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146115995752185338)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716047134286436.128)
,p_translate_from_id=>wwv_flow_api.id(165716047134286436)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'overwritten'
,p_translate_from_text=>unistr('\00FCberschrieben')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146116189706185338)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387180446150550.128)
,p_translate_from_id=>wwv_flow_api.id(165387180446150550)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146116380954185339)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646748229373534.128)
,p_translate_from_id=>wwv_flow_api.id(174646748229373534)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language ID'
,p_translate_from_text=>'Sprache-ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146116654544185339)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(131738289931223949.128)
,p_translate_from_id=>wwv_flow_api.id(131738289931223949)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Validation String'
,p_translate_from_text=>'Par Validation String'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146116848727185339)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388842578150566.128)
,p_translate_from_id=>wwv_flow_api.id(165388842578150566)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter value'
,p_translate_from_text=>'Parameterwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146117048723185339)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397650680398429.128)
,p_translate_from_id=>wwv_flow_api.id(153397650680398429)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp value'
,p_translate_from_text=>'Zeitstempelwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146117248970185339)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165385565806150534.128)
,p_translate_from_id=>wwv_flow_api.id(165385565806150534)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146117379726185339)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165639282322845627.128)
,p_translate_from_id=>wwv_flow_api.id(165639282322845627)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number'
,p_translate_from_text=>'Zahl'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146117595324185339)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397348730398426.128)
,p_translate_from_id=>wwv_flow_api.id(153397348730398426)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer value'
,p_translate_from_text=>'Ganzzahlwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146117799763185339)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165638690083845626.128)
,p_translate_from_id=>wwv_flow_api.id(165638690083845626)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer'
,p_translate_from_text=>'Ganzzahl'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146117999590185339)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165876333108037202.128)
,p_translate_from_id=>wwv_flow_api.id(165876333108037202)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146118185843185339)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153396838309398421.128)
,p_translate_from_id=>wwv_flow_api.id(153396838309398421)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Area'
,p_translate_from_text=>'Bereich'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146118405062185339)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165640510513845627.128)
,p_translate_from_id=>wwv_flow_api.id(165640510513845627)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp'
,p_translate_from_text=>'Zeitstempel'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146118569225185339)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646486453373532.128)
,p_translate_from_id=>wwv_flow_api.id(174646486453373532)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146118861347185339)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646980706373537.128)
,p_translate_from_id=>wwv_flow_api.id(174646980706373537)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity'
,p_translate_from_text=>'Schweregrad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146119019781185339)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647335254373540.128)
,p_translate_from_id=>wwv_flow_api.id(174647335254373540)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146119194067185339)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387344377150551.128)
,p_translate_from_id=>wwv_flow_api.id(165387344377150551)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Pgr id'
,p_translate_from_text=>'Pgr id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146119397833185339)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387468346150553.128)
,p_translate_from_id=>wwv_flow_api.id(165387468346150553)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146119586869185339)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646871808373535.128)
,p_translate_from_id=>wwv_flow_api.id(174646871808373535)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146119843986185339)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388451646150562.128)
,p_translate_from_id=>wwv_flow_api.id(165388451646150562)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'modifizierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146120023476185339)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165385761455150535.128)
,p_translate_from_id=>wwv_flow_api.id(165385761455150535)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146120244580185339)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165636936176845626.128)
,p_translate_from_id=>wwv_flow_api.id(165636936176845626)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Pgr Id'
,p_translate_from_text=>'Par Pgr Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146120449635185341)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165639909553845627.128)
,p_translate_from_id=>wwv_flow_api.id(165639909553845627)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date'
,p_translate_from_text=>'Datum'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146120597575185341)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387447888150552.128)
,p_translate_from_id=>wwv_flow_api.id(165387447888150552)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146120779801185341)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397494662398427.128)
,p_translate_from_id=>wwv_flow_api.id(153397494662398427)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number value'
,p_translate_from_text=>unistr('Flie\00DFkommazahlwert')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146121050747185342)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165636292160845624.128)
,p_translate_from_id=>wwv_flow_api.id(165636292160845624)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146121206119185342)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397783822398430.128)
,p_translate_from_id=>wwv_flow_api.id(153397783822398430)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146121394827185342)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165641097333845627.128)
,p_translate_from_id=>wwv_flow_api.id(165641097333845627)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146121572626185342)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165385820627150536.128)
,p_translate_from_id=>wwv_flow_api.id(165385820627150536)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146121767784185342)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386089711150539.128)
,p_translate_from_id=>wwv_flow_api.id(165386089711150539)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146122063267185342)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646908228373536.128)
,p_translate_from_id=>wwv_flow_api.id(174646908228373536)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146122235760185342)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165878108586037204.128)
,p_translate_from_id=>wwv_flow_api.id(165878108586037204)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146122461306185342)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397280885398425.128)
,p_translate_from_id=>wwv_flow_api.id(153397280885398425)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146122633549185342)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646605379373533.128)
,p_translate_from_id=>wwv_flow_api.id(174646605379373533)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146122776787185344)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165875235481037201.128)
,p_translate_from_id=>wwv_flow_api.id(165875235481037201)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146123020278185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387651408150554.128)
,p_translate_from_id=>wwv_flow_api.id(165387651408150554)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146123177693185344)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153468266993101583.128)
,p_translate_from_id=>wwv_flow_api.id(153468266993101583)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146123461214185344)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165716047134286436.128)
,p_translate_from_id=>wwv_flow_api.id(165716047134286436)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa &PAR_IS_LOCAL."/>'
,p_translate_from_text=>'<i class="fa &PAR_IS_LOCAL."/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146123643540185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387180446150550.128)
,p_translate_from_id=>wwv_flow_api.id(165387180446150550)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146123814395185344)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153396927529398422.128)
,p_translate_from_id=>wwv_flow_api.id(153396927529398422)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146124064896185344)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165715909640286435.128)
,p_translate_from_id=>wwv_flow_api.id(165715909640286435)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146124194388185344)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646748229373534.128)
,p_translate_from_id=>wwv_flow_api.id(174646748229373534)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146124425607185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(131738289931223949.128)
,p_translate_from_id=>wwv_flow_api.id(131738289931223949)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146124630387185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388842578150566.128)
,p_translate_from_id=>wwv_flow_api.id(165388842578150566)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146124801242185344)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386432751150542.128)
,p_translate_from_id=>wwv_flow_api.id(165386432751150542)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146125013452185344)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646980706373537.128)
,p_translate_from_id=>wwv_flow_api.id(174646980706373537)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146125237703185344)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647335254373540.128)
,p_translate_from_id=>wwv_flow_api.id(174647335254373540)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146125440447185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387344377150551.128)
,p_translate_from_id=>wwv_flow_api.id(165387344377150551)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146125616519185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387468346150553.128)
,p_translate_from_id=>wwv_flow_api.id(165387468346150553)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146125780153185344)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646871808373535.128)
,p_translate_from_id=>wwv_flow_api.id(174646871808373535)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146125999629185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388451646150562.128)
,p_translate_from_id=>wwv_flow_api.id(165388451646150562)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
,p_translate_from_text=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146126201314185344)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165636936176845626.128)
,p_translate_from_id=>wwv_flow_api.id(165636936176845626)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146126396604185344)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397118199398423.128)
,p_translate_from_id=>wwv_flow_api.id(153397118199398423)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146126607469185344)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165635199867845621.128)
,p_translate_from_id=>wwv_flow_api.id(165635199867845621)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146126819459185344)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387447888150552.128)
,p_translate_from_id=>wwv_flow_api.id(165387447888150552)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146127039475185347)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165877505065037204.128)
,p_translate_from_id=>wwv_flow_api.id(165877505065037204)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146127176166185347)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386089711150539.128)
,p_translate_from_id=>wwv_flow_api.id(165386089711150539)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146127410033185347)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646908228373536.128)
,p_translate_from_id=>wwv_flow_api.id(174646908228373536)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146127581988185347)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397280885398425.128)
,p_translate_from_id=>wwv_flow_api.id(153397280885398425)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146127774362185347)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165719664257286473.128)
,p_translate_from_id=>wwv_flow_api.id(165719664257286473)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146128026728185347)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646605379373533.128)
,p_translate_from_id=>wwv_flow_api.id(174646605379373533)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146128197964185347)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165875235481037201.128)
,p_translate_from_id=>wwv_flow_api.id(165875235481037201)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146128379041185347)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387651408150554.128)
,p_translate_from_id=>wwv_flow_api.id(165387651408150554)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146128614752185348)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153468266993101583.128)
,p_translate_from_id=>wwv_flow_api.id(153468266993101583)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146128859895185348)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165637463168845626.128)
,p_translate_from_id=>wwv_flow_api.id(165637463168845626)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146129005630185348)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387180446150550.128)
,p_translate_from_id=>wwv_flow_api.id(165387180446150550)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146129182451185348)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646748229373534.128)
,p_translate_from_id=>wwv_flow_api.id(174646748229373534)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146129398226185348)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(131738289931223949.128)
,p_translate_from_id=>wwv_flow_api.id(131738289931223949)
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
 p_id=>wwv_flow_api.id(146129605085185348)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388842578150566.128)
,p_translate_from_id=>wwv_flow_api.id(165388842578150566)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146129859093185348)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646980706373537.128)
,p_translate_from_id=>wwv_flow_api.id(174646980706373537)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146130019963185348)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647335254373540.128)
,p_translate_from_id=>wwv_flow_api.id(174647335254373540)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146130231762185348)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387344377150551.128)
,p_translate_from_id=>wwv_flow_api.id(165387344377150551)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146130386224185348)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387468346150553.128)
,p_translate_from_id=>wwv_flow_api.id(165387468346150553)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146130661134185348)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646871808373535.128)
,p_translate_from_id=>wwv_flow_api.id(174646871808373535)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146130822160185348)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165635199867845621.128)
,p_translate_from_id=>wwv_flow_api.id(165635199867845621)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146131065622185348)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387447888150552.128)
,p_translate_from_id=>wwv_flow_api.id(165387447888150552)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146131229935185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(131738211202223948.128)
,p_translate_from_id=>wwv_flow_api.id(131738211202223948)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146131405115185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647153105373538.128)
,p_translate_from_id=>wwv_flow_api.id(174647153105373538)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146131611878185352)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165386089711150539.128)
,p_translate_from_id=>wwv_flow_api.id(165386089711150539)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146131771263185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646908228373536.128)
,p_translate_from_id=>wwv_flow_api.id(174646908228373536)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146131989012185352)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397280885398425.128)
,p_translate_from_id=>wwv_flow_api.id(153397280885398425)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146132174029185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646605379373533.128)
,p_translate_from_id=>wwv_flow_api.id(174646605379373533)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146132463823185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647254176373539.128)
,p_translate_from_id=>wwv_flow_api.id(174647254176373539)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146132615168185352)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165875235481037201.128)
,p_translate_from_id=>wwv_flow_api.id(165875235481037201)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146132862550185352)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387651408150554.128)
,p_translate_from_id=>wwv_flow_api.id(165387651408150554)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146133001862185352)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153468266993101583.128)
,p_translate_from_id=>wwv_flow_api.id(153468266993101583)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146133200481185352)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387180446150550.128)
,p_translate_from_id=>wwv_flow_api.id(165387180446150550)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146133394345185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646748229373534.128)
,p_translate_from_id=>wwv_flow_api.id(174646748229373534)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146133637812185352)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(131738289931223949.128)
,p_translate_from_id=>wwv_flow_api.id(131738289931223949)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146133783671185352)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388842578150566.128)
,p_translate_from_id=>wwv_flow_api.id(165388842578150566)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146133999387185352)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397348730398426.128)
,p_translate_from_id=>wwv_flow_api.id(153397348730398426)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146134202179185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646980706373537.128)
,p_translate_from_id=>wwv_flow_api.id(174646980706373537)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146134380419185352)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647335254373540.128)
,p_translate_from_id=>wwv_flow_api.id(174647335254373540)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146134656622185353)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387344377150551.128)
,p_translate_from_id=>wwv_flow_api.id(165387344377150551)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146134839817185353)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387468346150553.128)
,p_translate_from_id=>wwv_flow_api.id(165387468346150553)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146135023612185353)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646871808373535.128)
,p_translate_from_id=>wwv_flow_api.id(174646871808373535)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146135245574185353)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165635199867845621.128)
,p_translate_from_id=>wwv_flow_api.id(165635199867845621)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146135370947185353)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387447888150552.128)
,p_translate_from_id=>wwv_flow_api.id(165387447888150552)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146135647953185353)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397494662398427.128)
,p_translate_from_id=>wwv_flow_api.id(153397494662398427)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146135857824185355)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646908228373536.128)
,p_translate_from_id=>wwv_flow_api.id(174646908228373536)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146136002419185355)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397280885398425.128)
,p_translate_from_id=>wwv_flow_api.id(153397280885398425)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146136216729185355)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646605379373533.128)
,p_translate_from_id=>wwv_flow_api.id(174646605379373533)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146136404660185355)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387651408150554.128)
,p_translate_from_id=>wwv_flow_api.id(165387651408150554)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146136615382185355)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397600020398428.128)
,p_translate_from_id=>wwv_flow_api.id(153397600020398428)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146136784924185355)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387180446150550.128)
,p_translate_from_id=>wwv_flow_api.id(165387180446150550)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146137001082185355)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646748229373534.128)
,p_translate_from_id=>wwv_flow_api.id(174646748229373534)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146137184360185355)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(131738289931223949.128)
,p_translate_from_id=>wwv_flow_api.id(131738289931223949)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146137459437185356)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165388842578150566.128)
,p_translate_from_id=>wwv_flow_api.id(165388842578150566)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146137609153185356)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165640510513845627.128)
,p_translate_from_id=>wwv_flow_api.id(165640510513845627)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146137848861185356)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646980706373537.128)
,p_translate_from_id=>wwv_flow_api.id(174646980706373537)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146138016648185356)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174647335254373540.128)
,p_translate_from_id=>wwv_flow_api.id(174647335254373540)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146138233020185356)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387344377150551.128)
,p_translate_from_id=>wwv_flow_api.id(165387344377150551)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146138371558185356)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387468346150553.128)
,p_translate_from_id=>wwv_flow_api.id(165387468346150553)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146138595081185356)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646871808373535.128)
,p_translate_from_id=>wwv_flow_api.id(174646871808373535)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146138806248185356)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165639909553845627.128)
,p_translate_from_id=>wwv_flow_api.id(165639909553845627)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146139011043185356)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165387447888150552.128)
,p_translate_from_id=>wwv_flow_api.id(165387447888150552)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146139243381185358)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165876949813037204.128)
,p_translate_from_id=>wwv_flow_api.id(165876949813037204)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146139374469185358)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397600020398428.128)
,p_translate_from_id=>wwv_flow_api.id(153397600020398428)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146139645733185359)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165638103035845626.128)
,p_translate_from_id=>wwv_flow_api.id(165638103035845626)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146139800345185359)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397650680398429.128)
,p_translate_from_id=>wwv_flow_api.id(153397650680398429)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146140000469185359)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165385565806150534.128)
,p_translate_from_id=>wwv_flow_api.id(165385565806150534)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146140263534185359)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165639282322845627.128)
,p_translate_from_id=>wwv_flow_api.id(165639282322845627)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146140447946185359)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165638690083845626.128)
,p_translate_from_id=>wwv_flow_api.id(165638690083845626)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146140653073185359)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165876333108037202.128)
,p_translate_from_id=>wwv_flow_api.id(165876333108037202)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146140773129185359)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165640510513845627.128)
,p_translate_from_id=>wwv_flow_api.id(165640510513845627)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146141005544185359)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646486453373532.128)
,p_translate_from_id=>wwv_flow_api.id(174646486453373532)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146141246521185359)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165385761455150535.128)
,p_translate_from_id=>wwv_flow_api.id(165385761455150535)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146141423225185359)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165639909553845627.128)
,p_translate_from_id=>wwv_flow_api.id(165639909553845627)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146141569423185363)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153397600020398428.128)
,p_translate_from_id=>wwv_flow_api.id(153397600020398428)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146141768972185364)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165640510513845627.128)
,p_translate_from_id=>wwv_flow_api.id(165640510513845627)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146141966581185364)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165639909553845627.128)
,p_translate_from_id=>wwv_flow_api.id(165639909553845627)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146142258069185397)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165875677548037201.128)
,p_translate_from_id=>wwv_flow_api.id(165875677548037201)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146142414502185397)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165635743249845623.128)
,p_translate_from_id=>wwv_flow_api.id(165635743249845623)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146142606357185402)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(153396838309398421.128)
,p_translate_from_id=>wwv_flow_api.id(153396838309398421)
,p_translate_column_id=>450
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146143039536185403)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(174646386868373531.128)
,p_translate_from_id=>wwv_flow_api.id(174646386868373531)
,p_translate_column_id=>451
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146143250087185403)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(170953805187513069.128)
,p_translate_from_id=>wwv_flow_api.id(170953805187513069)
,p_translate_column_id=>451
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146143381892185414)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165874507834037198.128)
,p_translate_from_id=>wwv_flow_api.id(165874507834037198)
,p_translate_column_id=>457
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Message Group'
,p_translate_from_text=>'Meldungsgruppe erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146143577848185414)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(165385443860150532.128)
,p_translate_from_id=>wwv_flow_api.id(165385443860150532)
,p_translate_column_id=>457
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Parameter Group'
,p_translate_from_text=>'Parametergruppe erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146143807526185447)
,p_translated_flow_id=>128
,p_translate_to_id=>300.128
,p_translate_from_id=>300
,p_translate_column_id=>476
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PIT Administration'
,p_translate_from_text=>'PIT-Administration'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146715749052976264)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>13.128
,p_translate_from_id=>13
,p_translate_column_id=>5
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich administrieren')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146715788072976273)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>13.128
,p_translate_from_id=>13
,p_translate_column_id=>6
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich administrieren')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146715989524976284)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135493679210864343.128)
,p_translate_from_id=>wwv_flow_api.id(135493679210864343)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich verwalten')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146716247401976284)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135493947833864345.128)
,p_translate_from_id=>wwv_flow_api.id(135493947833864345)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146716465257976289)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135494221308864348.128)
,p_translate_from_id=>wwv_flow_api.id(135494221308864348)
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
 p_id=>wwv_flow_api.id(146716621793976298)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135493849239864344.128)
,p_translate_from_id=>wwv_flow_api.id(135493849239864344)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146716827313976298)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146700520455825167.128)
,p_translate_from_id=>wwv_flow_api.id(146700520455825167)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Realms'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146717050448976514)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146700520455825167.128)
,p_translate_from_id=>wwv_flow_api.id(146700520455825167)
,p_translate_column_id=>143
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realms'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146717104335976780)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146707285750825197.128)
,p_translate_from_id=>wwv_flow_api.id(146707285750825197)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146717183106976786)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146707285750825197.128)
,p_translate_from_id=>wwv_flow_api.id(146707285750825197)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pit_ui.process_edit_realm;'
,p_translate_from_text=>'pit_ui.process_edit_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146717526086976789)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146707285750825197.128)
,p_translate_from_id=>wwv_flow_api.id(146707285750825197)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146717688618976791)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146707285750825197.128)
,p_translate_from_id=>wwv_flow_api.id(146707285750825197)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146717939166976842)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135493849239864344.128)
,p_translate_from_id=>wwv_flow_api.id(135493849239864344)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146718117488976845)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(135493849239864344.128)
,p_translate_from_id=>wwv_flow_api.id(135493849239864344)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146718267976977064)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146706341953825195.128)
,p_translate_from_id=>wwv_flow_api.id(146706341953825195)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'active'
,p_translate_from_text=>'aktiv'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146718446707977064)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146705292114825195.128)
,p_translate_from_id=>wwv_flow_api.id(146705292114825195)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146718601162977066)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146704327151825194.128)
,p_translate_from_id=>wwv_flow_api.id(146704327151825194)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realm'
,p_translate_from_text=>'Bezeichner'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146718772738977067)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146706341953825195.128)
,p_translate_from_id=>wwv_flow_api.id(146706341953825195)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146719051614977067)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146701850876825175.128)
,p_translate_from_id=>wwv_flow_api.id(146701850876825175)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146719175745977067)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146705292114825195.128)
,p_translate_from_id=>wwv_flow_api.id(146705292114825195)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146719455974977070)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146701850876825175.128)
,p_translate_from_id=>wwv_flow_api.id(146701850876825175)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146719569995977070)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146705292114825195.128)
,p_translate_from_id=>wwv_flow_api.id(146705292114825195)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146719787350977073)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146701850876825175.128)
,p_translate_from_id=>wwv_flow_api.id(146701850876825175)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146720035325977073)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146705292114825195.128)
,p_translate_from_id=>wwv_flow_api.id(146705292114825195)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146720252390977075)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146705292114825195.128)
,p_translate_from_id=>wwv_flow_api.id(146705292114825195)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146720460803977078)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146704327151825194.128)
,p_translate_from_id=>wwv_flow_api.id(146704327151825194)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146720575294977119)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146702314993825175.128)
,p_translate_from_id=>wwv_flow_api.id(146702314993825175)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(146729683694163723)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(146726665440062733.128)
,p_translate_from_id=>wwv_flow_api.id(146726665440062733)
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
 p_id=>wwv_flow_api.id(146499394705677931)
,p_name=>'BOOLEAN_N'
,p_message_language=>'de'
,p_message_text=>'Nein'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128897552335740717)
,p_name=>'BOOLEAN_N'
,p_message_text=>'No'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(146499227240677106)
,p_name=>'BOOLEAN_Y'
,p_message_language=>'de'
,p_message_text=>'Ja'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128897484982740717)
,p_name=>'BOOLEAN_Y'
,p_message_text=>'Yes'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(145903070775092120)
,p_name=>'HELP_CONTEXT'
,p_message_language=>'de'
,p_message_text=>unistr('<p>Ein Kontext fasst das Debug- und Traceverhalten von PIT unter einem Namen zusammen.</p><p>W\00E4hrend der Anwendung kann der Kontext global oder nur f\00FCr einen Benutzer ge\00E4ndert werden. Dadurch wird feingranular gesteuert, welche Einstellungen aktuell ')
||unistr('gelten sollen.</p><p>Der Standard-Kontext \00BBDEFAULT\00AB wird gew\00E4hlt, wenn kein anderer Kontext ausgew\00E4hlt wurde. Daher kann dieser Kontext nicht gel\00F6scht werden.<br>Sie k\00F6nnen beliebig viele Kontexte anlegen.</p><p>Die Kontextbezeichner \00BBDEFAULT\00AB und \00BBA')
||unistr('CTIVE\00AB werden intern verwendet und sind daher nicht erlaubt.</p>')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128897107979740715)
,p_name=>'HELP_CONTEXT'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>A context summarizes the debug and trace behavior of PIT under one name.</p><p>.',
'During the application, the context can be changed globally or only for a user. This provides fine-grained control over which settings should currently apply.</p><p>.',
'The default context "DEFAULT" is selected if no other context is selected. Therefore, this context cannot be deleted.<br>You can create as many contexts as you like.</p><p>.',
'The context identifiers "DEFAULT" and "ACTIVE" are used internally and are therefore not allowed.</p>'))
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(145902228347048528)
,p_name=>'HELP_OUTPUT_MODULES'
,p_message_language=>'de'
,p_message_text=>unistr('<p>Ausgabemodule werden verwendet, um Nachrichten von PIT an Tabellen, Dateien, APEX oder beliebige weitere Ziele zu senden.<br>Angezeigt werden alle Module, die derzeit in der Datenbank installiert sind. Sie k\00F6nnen an der Spalte \00BBverf\00FCgbar\00AB sehen, o')
||unistr('b es bei der Installation des Ausgabemoduls Probleme gab oder ob das Modul einsatzbereit ist.<br>Spalte \00BBaktiv\00AB zeigt an, ob das Modul aktuell zur Ausgabe von Meldungen verwendet wird.</p>')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128896961538740715)
,p_name=>'HELP_OUTPUT_MODULES'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Output modules are used to send messages from PIT to tables, files, APEX or any other destination.',
'All modules that are currently installed in the database are displayed. You can see from the "available" column whether there were problems during the installation of the output module or whether the module is ready for use.<br>',
'Column "active" shows whether the module is currently usead for the output of messages.',
''))
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(145903363363098803)
,p_name=>'HELP_TOGGLE'
,p_message_language=>'de'
,p_message_text=>unistr('Das Debugging kann global f\00FCr alle Anwendungspackages eingestellt werden, indem Kontexte verwendet werden.<br>Zus\00E4tzlich ist es m\00F6glich, Das Logging f\00FCr einzelne Packages ein- oder auszuschalten. Hierf\00FCr wird eine Liste von Packages verwaltet, denen ')
||unistr('jeweils ein benannter Kontext zugeordnet wird.<br>Wird eines dieser Packages ausgef\00FChrt, schaltet PIT den zugeordneten Kontext aktiv. Wird das Package verlassen, wird wieder der vorherige Kontext aktiv.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128897148204740715)
,p_name=>'HELP_TOGGLE'
,p_message_text=>'Debugging can be set globally for all application packages by using contexts.<br>In addition, it is possible to enable or disable logging for individual packages. To do this, a list of packages is managed, to each of which a named context is assigned'
||'.<br>If one of these packages is executed, PIT activates the assigned context. If the package is left, the previous context becomes active again.'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(146399527554367258)
,p_name=>'HINT_PMS'
,p_message_language=>'de'
,p_message_text=>unistr('Falls Sie die Meldungen \00FCbersetzen m\00F6chten, w\00E4hlen Sie eine Zielsprache.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128897336390740715)
,p_name=>'HINT_PMS'
,p_message_text=>'If you want to translate the messages, select a target language.'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(146400089021374780)
,p_name=>'HINT_PTI'
,p_message_language=>'de'
,p_message_text=>unistr('Falls Sie die Begriffe \00FCbersetzen m\00F6chten, w\00E4hlen Sie eine Zielsprache.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128897423816740717)
,p_name=>'HINT_PTI'
,p_message_text=>'If you want to translate the translatable items, select a target language.'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(177823567434807717)
,p_name=>'ORACLE_ERROR_HINT'
,p_message_language=>'de'
,p_message_text=>unistr('<h2>Oracle-Fehlermapping</h2><p>Wenn Sie einen Oracle-Fehler auf eine PIT-Meldung abbilden m\00F6chten, beachten Sie:</p><ul><li>Bereits vordefinierte Fehler k\00F6nnen nicht \00FCberschrieben werden (z.B. NO_DATA_FOUND)</li><li>Oracle-Fehlernummern k\00F6nnen nur e')
||unistr('inmal von PIT \00FCberschrieben werden</li></ul><p>Da Oracle-Fehler nur einmal gemappt werden k\00F6nnen, sollte der Bezeichner m\00F6glichst generisch gew\00E4hlt werden.<br>Verwenden Sie eine Namenskonvention mit Schema- oder Bereichspr\00E4fixen, beachten Sie, dass d')
||unistr('iese Fehlermappings \00FCbergreifend verwendet werden m\00FCssen und daher eine entsprechende Namenskonvention ben\00F6tigen.</p><p>Um einen Oracle-Fehler mit mehreren Meldungen zu verbinden, definieren Sie eine Oracle-Fehlernachricht und separate Meldungen. Im ')
||'Exception-Block des Codes fangen Sie dann den benannten Oracle-Fehler und geben die spezifische Nachricht aus.</p>'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(128897658096740717)
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
 p_id=>wwv_flow_api.id(175914362817870285)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>unistr('Bitte best\00E4tigen Sie, dass die Daten gel\00F6scht werden sollen.')
);
end;
/
prompt --application/shared_components/security/authentications/apex
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(175903795896657329)
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
 p_id=>wwv_flow_api.id(212627799475128490)
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
 p_id=>wwv_flow_api.id(212628502161148140)
,p_plugin_id=>wwv_flow_api.id(212627799475128490)
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
 p_id=>wwv_flow_api.id(212629089479154003)
,p_plugin_attribute_id=>wwv_flow_api.id(212628502161148140)
,p_display_sequence=>10
,p_display_value=>'SQL bzw. PL/SQL'
,p_return_value=>'text/x-plsql'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212629902985157884)
,p_plugin_attribute_id=>wwv_flow_api.id(212628502161148140)
,p_display_sequence=>20
,p_display_value=>'JavaScript'
,p_return_value=>'text/javascript'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212630274719159130)
,p_plugin_attribute_id=>wwv_flow_api.id(212628502161148140)
,p_display_sequence=>30
,p_display_value=>'JavaScript JSON'
,p_return_value=>'application/json'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212630788917163238)
,p_plugin_attribute_id=>wwv_flow_api.id(212628502161148140)
,p_display_sequence=>40
,p_display_value=>'XML'
,p_return_value=>'application/xml'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212631193073164478)
,p_plugin_attribute_id=>wwv_flow_api.id(212628502161148140)
,p_display_sequence=>50
,p_display_value=>'HTML'
,p_return_value=>'text/html'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212639198397575953)
,p_plugin_attribute_id=>wwv_flow_api.id(212628502161148140)
,p_display_sequence=>60
,p_display_value=>'CSS'
,p_return_value=>'text/css'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(212634385265449167)
,p_plugin_id=>wwv_flow_api.id(212627799475128490)
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
 p_id=>wwv_flow_api.id(212634987343449716)
,p_plugin_attribute_id=>wwv_flow_api.id(212634385265449167)
,p_display_sequence=>10
,p_display_value=>'Night'
,p_return_value=>'night'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212635388728450185)
,p_plugin_attribute_id=>wwv_flow_api.id(212634385265449167)
,p_display_sequence=>20
,p_display_value=>'Neat'
,p_return_value=>'neat'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212635791845451036)
,p_plugin_attribute_id=>wwv_flow_api.id(212634385265449167)
,p_display_sequence=>30
,p_display_value=>'Elegant'
,p_return_value=>'elegant'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(212636193923451655)
,p_plugin_attribute_id=>wwv_flow_api.id(212634385265449167)
,p_display_sequence=>40
,p_display_value=>'Default'
,p_return_value=>'default'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(212632174503168571)
,p_plugin_id=>wwv_flow_api.id(212627799475128490)
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
 p_id=>wwv_flow_api.id(177456580609334640)
,p_plugin_id=>wwv_flow_api.id(212627799475128490)
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
 p_id=>wwv_flow_api.id(175903650235657326)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN_DESKTOP:&SESSION.'
,p_theme_style_by_user_pref=>false
,p_navigation_list_id=>wwv_flow_api.id(175861208437657285)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(175897261667657314)
,p_nav_list_template_options=>'#DEFAULT#'
,p_include_legacy_javascript=>'18'
,p_include_jquery_migrate=>true
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(175903579527657326)
,p_nav_bar_list_template_id=>wwv_flow_api.id(175893963744657312)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'PIT-Administration'
,p_alias=>'MAIN'
,p_step_title=>'PIT-Administration'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(176699484451373914)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142332'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(175905472462657342)
,p_plug_name=>'Breadcrumbs'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175880723465657304)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(175904963419657340)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(175898982340657317)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(175907801138782004)
,p_plug_name=>'Anwendungsbereiche'
,p_component_template_options=>'#DEFAULT#:t-Cards--featured force-fa-lg:t-Cards--displayIcons:t-Cards--4cols:t-Cards--desc-2ln:u-colors:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(168330395671949782)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(175891339968657310)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Meldungen administrieren'
,p_alias=>'ADMIN_PMS'
,p_step_title=>'Meldungen administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(176699523686374634)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127142313'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(175922718445870421)
,p_plug_name=>'Meldungen'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
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
 p_id=>wwv_flow_api.id(131738211202223948)
,p_name=>'PMS_PSE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_PSE_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>110
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(174646386868373531)
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
 p_id=>wwv_flow_api.id(174646486453373532)
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
 p_id=>wwv_flow_api.id(174646605379373533)
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
 p_id=>wwv_flow_api.id(174646748229373534)
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
 p_id=>wwv_flow_api.id(174646871808373535)
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
 p_id=>wwv_flow_api.id(174646908228373536)
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
 p_id=>wwv_flow_api.id(174646980706373537)
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
 p_id=>wwv_flow_api.id(174647153105373538)
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
 p_id=>wwv_flow_api.id(174647254176373539)
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
 p_id=>wwv_flow_api.id(174647335254373540)
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
 p_id=>wwv_flow_api.id(174646359916373530)
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
 p_id=>wwv_flow_api.id(168352808958094358)
,p_interactive_grid_id=>wwv_flow_api.id(174646359916373530)
,p_static_id=>'158019'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(168352941397094358)
,p_report_id=>wwv_flow_api.id(168352808958094358)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(145123465228849092)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(131738211202223948)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168353474683094363)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(174646386868373531)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168353895700094368)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(174646486453373532)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>319
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168354408733094369)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(174646605379373533)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168354907157094371)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(174646748229373534)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168355436463094372)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(174646871808373535)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168355936670094374)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(174646908228373536)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168356463834094375)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(174646980706373537)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>109
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168356964244094377)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(174647153105373538)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168357461206094379)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(174647254176373539)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>68
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(168357957648094380)
,p_view_id=>wwv_flow_api.id(168352941397094358)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(174647335254373540)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(175928855898870434)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175880723465657304)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(175904963419657340)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(175898982340657317)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(174646205742373529)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(175922718445870421)
,p_button_name=>'EDIT_PMG'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Meldungsgruppe bearbeiten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMG:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(175927379412870429)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(175922718445870421)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Meldung erzeugen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMS:&SESSION.::&DEBUG.:RP,3::'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(171237871654886333)
,p_name=>'P2_PMG_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(175922718445870421)
,p_prompt=>'Gruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_GROUP'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(171237937942886334)
,p_name=>'P2_PML_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(175922718445870421)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PML_NAME_IN_USE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(175926430403870429)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(175922718445870421)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(175926969782870429)
,p_event_id=>wwv_flow_api.id(175926430403870429)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(175922718445870421)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(175927777754870431)
,p_name=>'Create Button - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(175927379412870429)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(175928231558870431)
,p_event_id=>wwv_flow_api.id(175927777754870431)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(175922718445870421)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(171238012880886335)
,p_name=>'Refresh Report'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_PML_NAME,P2_PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(171238147135886336)
,p_event_id=>wwv_flow_api.id(171238012880886335)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(175922718445870421)
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Meldung editieren'
,p_alias=>'EDIT_PMS'
,p_page_mode=>'MODAL'
,p_step_title=>'Meldung editieren'
,p_reload_on_submit=>'A'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(176699523686374634)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_step_template=>wwv_flow_api.id(175867084347657295)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'800'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127143829'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170956078448513092)
,p_plug_name=>'HIlfe zu Oracle-Fehlermappings'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175872966531657301)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(175911811137870284)
,p_plug_name=>'Meldung editieren'
,p_region_name=>'EDIT_PMS_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
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
 p_id=>wwv_flow_api.id(175912499148870284)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(175912955027870284)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(175912499148870284)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(175912400015870284)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(175912499148870284)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Meldung entfernen'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(175912362281870284)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(175912499148870284)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(175912213488870284)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(175912499148870284)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Meldug erzeugen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(170956145329513093)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(175911811137870284)
,p_button_name=>'SHOW_HELP'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898296301657315)
,p_button_image_alt=>'Hilfe zu Oracle-Fehlermappings'
,p_button_position=>'TOP'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168369640503199491)
,p_name=>'P3_PMS_PMG_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
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
,p_field_template=>wwv_flow_api.id(175898106051657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168370083383199496)
,p_name=>'P3_PMS_DESCRIPTION'
,p_source_data_type=>'CLOB'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
,p_prompt=>'Beschreibung'
,p_source=>'PMS_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_help_text=>unistr('Optionale Beschreibung.<br>Kann verwendet werden, um im Fehlerfall zus\00E4tzliche Handlungsanweisungen an den Anwender zu geben.')
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(175915671870870375)
,p_name=>'P3_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(175916069416870392)
,p_name=>'P3_PMS_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
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
,p_field_template=>wwv_flow_api.id(175898106051657315)
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
 p_id=>wwv_flow_api.id(175916351760870395)
,p_name=>'P3_PMS_PML_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
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
,p_field_template=>wwv_flow_api.id(175898106051657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Sprache der Meldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(175916744011870395)
,p_name=>'P3_PMS_TEXT'
,p_source_data_type=>'CLOB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
,p_prompt=>'Meldung'
,p_source=>'PMS_TEXT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(175898106051657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Meldungstext.<br>Ersetzung der Parameter #1# bis #50# gem\00E4\00DF Zahlwert.<br>\00DCbergebene Parameter werden positional nummeriert und auf die Ersetzungsmarken verteilt.')
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(175917166306870395)
,p_name=>'P3_PMS_PSE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_default=>'70'
,p_prompt=>'Schweregrad'
,p_source=>'PMS_PSE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Schweregrad der Fehlermeldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(175917538597870396)
,p_name=>'P3_PMS_CUSTOM_ERROR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(175911811137870284)
,p_item_source_plug_id=>wwv_flow_api.id(175911811137870284)
,p_prompt=>'Fehlernummer'
,p_source=>'PMS_CUSTOM_ERROR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Optionale Fehlernummer.<br>Muss bei eigenen Fehlern nicht angegeben werden, dient dem Mappen Oracle-definierter Fehler auf Fehlermeldungen.<br>Wird eine Fehlernummer doppelt belegt, wird ein Fehler geworfen.<br>Insbesondere darf keine Fehlernummer im'
||' Bereich - 20999 bis -20001 angegben werden, PIT verwaltet diese Fehlernummer automatisch.'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168369959067199494)
,p_validation_name=>'Validate EDIT_PMS'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.edit_pms_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(175913043603870284)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(175912955027870284)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(175913796521870285)
,p_event_id=>wwv_flow_api.id(175913043603870284)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(171238237235886337)
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
 p_id=>wwv_flow_api.id(171238338474886338)
,p_event_id=>wwv_flow_api.id(171238237235886337)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(171238452354886339)
,p_event_id=>wwv_flow_api.id(171238237235886337)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165389072808150569)
,p_event_id=>wwv_flow_api.id(171238237235886337)
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
 p_id=>wwv_flow_api.id(165389214969150570)
,p_event_id=>wwv_flow_api.id(171238237235886337)
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
 p_id=>wwv_flow_api.id(168369763335199492)
,p_name=>'Format PMS_NAME'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_PMS_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168369776992199493)
,p_event_id=>wwv_flow_api.id(168369763335199492)
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
 p_id=>wwv_flow_api.id(165388882269150567)
,p_name=>'Initialize Page'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165388990555150568)
,p_event_id=>wwv_flow_api.id(165388882269150567)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_PML_NAME'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(170956304822513094)
,p_name=>'Show help region'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(170956145329513093)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(170956314425513095)
,p_event_id=>wwv_flow_api.id(170956304822513094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170956078448513092)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(175919866063870400)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(175911811137870284)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_PMS'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(171236704243886322)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(175911811137870284)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_PMS'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_pms_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_process_error_message=>'Fehler beim Speichern der Meldung:<br>#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Meldung wurde gespeichert.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(175920679007870400)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(175912400015870284)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(175921001845870400)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Meldungsgruppe bearbeiten'
,p_alias=>'EDIT_PMG'
,p_page_mode=>'MODAL'
,p_step_title=>'Meldungsgruppe bearbeiten'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'900'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127143607'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165718144958286457)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165874029504037196)
,p_plug_name=>'Meldungsgruppe bearbeiten'
,p_region_name=>'EDIT_PMG_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175876966761657303)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_PMG'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(111120530417883309)
,p_name=>'PMG_ERROR_PREFIX'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMG_ERROR_PREFIX'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Prefix'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>6
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
 p_id=>wwv_flow_api.id(111120631124883310)
,p_name=>'PMG_ERROR_POSTFIX'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMG_ERROR_POSTFIX'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Postfix'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>6
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
 p_id=>wwv_flow_api.id(165875235481037201)
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
 p_id=>wwv_flow_api.id(165875677548037201)
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
 p_id=>wwv_flow_api.id(165876333108037202)
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
,p_readonly_condition=>'&PMG_AMOUNT. > 0'
,p_readonly_condition2=>'PLSQL'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(165876949813037204)
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
 p_id=>wwv_flow_api.id(165877505065037204)
,p_name=>'PMG_AMOUNT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMG_AMOUNT'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'# Meldungen'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>70
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
 p_id=>wwv_flow_api.id(165878108586037204)
,p_name=>'ALLOWED_OPERATIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ALLOWED_OPERATIONS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(165874507834037198)
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
 p_id=>wwv_flow_api.id(165874928389037199)
,p_interactive_grid_id=>wwv_flow_api.id(165874507834037198)
,p_static_id=>'158028'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(165874969564037199)
,p_report_id=>wwv_flow_api.id(165874928389037199)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(111328858795668487)
,p_view_id=>wwv_flow_api.id(165874969564037199)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(111120530417883309)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(111329752549668492)
,p_view_id=>wwv_flow_api.id(165874969564037199)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(111120631124883310)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165876101119037202)
,p_view_id=>wwv_flow_api.id(165874969564037199)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(165875677548037201)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165876733994037204)
,p_view_id=>wwv_flow_api.id(165874969564037199)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(165876333108037202)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165877299122037204)
,p_view_id=>wwv_flow_api.id(165874969564037199)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(165876949813037204)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>369
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165877885418037204)
,p_view_id=>wwv_flow_api.id(165874969564037199)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(165877505065037204)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88.5
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165878525426037204)
,p_view_id=>wwv_flow_api.id(165874969564037199)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(165878108586037204)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165718192387286458)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165718144958286457)
,p_button_name=>'CANCEL'
,p_button_static_id=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165718512962286461)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165718144958286457)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165717984051286456)
,p_tabular_form_region_id=>wwv_flow_api.id(165874029504037196)
,p_validation_name=>'Validate EDIT_PMG'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.edit_pmg_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165718334136286459)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165718192387286458)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165718392134286460)
,p_event_id=>wwv_flow_api.id(165718334136286459)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165719093741286467)
,p_name=>'Format PMG_NAME'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(165874029504037196)
,p_triggering_element=>'PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165719220073286468)
,p_event_id=>wwv_flow_api.id(165719093741286467)
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
 p_id=>wwv_flow_api.id(165878681697037206)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(165874029504037196)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PMG'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_pmg_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165718742663286463)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>unistr('G\00FCltigkeitsbereich einstellen')
,p_alias=>'SET_REALM'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('G\00FCltigkeitsbereich einstellen')
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(176699612104375939)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220125170909'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(147575686690367160)
,p_plug_name=>'Create Form'
,p_region_name=>'SET_REALM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
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
 p_id=>wwv_flow_api.id(147578084847367173)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(147578459188367173)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(147578084847367173)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(147580465598367178)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(147578084847367173)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_PRE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(111120756206883311)
,p_name=>'P5_PRE_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(147575686690367160)
,p_item_source_plug_id=>wwv_flow_api.id(147575686690367160)
,p_prompt=>unistr('G\00FCltigkeitsbereich')
,p_source=>'PRE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_PARAMETER_REALM'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(111120804931883312)
,p_name=>'P5_PRE_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(147575686690367160)
,p_item_source_plug_id=>wwv_flow_api.id(147575686690367160)
,p_prompt=>'Beschreibung'
,p_source=>'PRE_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>255
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(111120931969883313)
,p_name=>'P5_PRE_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(147575686690367160)
,p_item_source_plug_id=>wwv_flow_api.id(147575686690367160)
,p_prompt=>'aktiv'
,p_source=>'PRE_IS_ACTIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(147538043263809331)
,p_validation_name=>'Validate SET_REALM'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.set_realm_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(147578631124367173)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(147578459188367173)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147579419611367175)
,p_event_id=>wwv_flow_api.id(147578631124367173)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(147581682822367179)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(147575686690367160)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process SET_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.set_realm_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(147582115920367179)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(147581278124367178)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(147575686690367160)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Parameter administrieren'
,p_alias=>'ADMIN_PARAM'
,p_step_title=>'Parameter administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(176699612104375939)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127142249'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165386916685150547)
,p_plug_name=>'Liste der Parameter'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
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
 p_id=>wwv_flow_api.id(131738289931223949)
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
 p_id=>wwv_flow_api.id(165387180446150550)
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
 p_id=>wwv_flow_api.id(165387344377150551)
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
 p_id=>wwv_flow_api.id(165387447888150552)
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
 p_id=>wwv_flow_api.id(165387468346150553)
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
 p_id=>wwv_flow_api.id(165387651408150554)
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
 p_id=>wwv_flow_api.id(165388451646150562)
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
 p_id=>wwv_flow_api.id(165388842578150566)
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
 p_id=>wwv_flow_api.id(170953805187513069)
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
 p_id=>wwv_flow_api.id(165386987256150548)
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
 p_id=>wwv_flow_api.id(165444654068602410)
,p_interactive_grid_id=>wwv_flow_api.id(165386987256150548)
,p_static_id=>'158032'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(165444718688602410)
,p_report_id=>wwv_flow_api.id(165444654068602410)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(145128985350858114)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(131738289931223949)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(158985888961923288)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(170953805187513069)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>42
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165445672205602416)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(165387180446150550)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>216
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165446210636602418)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(165387344377150551)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165446572772602418)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(165387447888150552)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165447104596602420)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(165387468346150553)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>502
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165447596640602421)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(165387651408150554)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165451625101602429)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(165388451646150562)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>119
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165494601393849890)
,p_view_id=>wwv_flow_api.id(165444718688602410)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(165388842578150566)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>373
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177488806740508807)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175880723465657304)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(175904963419657340)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(175898982340657317)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(147538017486809330)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165386916685150547)
,p_button_name=>'SET_REALM'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('G\00FCltigkeitsbereich setzen')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:SET_REALM:&SESSION.::&DEBUG.:RP,:P5_PRE_ID:REALM'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135493679210864343)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165386916685150547)
,p_button_name=>'EDIT_REALM'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('G\00FCltigkeitsbereich verwalten')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_REALM:&SESSION.::&DEBUG.:RP,::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177632080113914905)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(165386916685150547)
,p_button_name=>'EDIT_PGR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Parametergruppen verwalten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PGR:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177487371498508804)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(165386916685150547)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Parameter erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PAR:&SESSION.::&DEBUG.:RP,:P7_PAR_ID,P7_PAR_PGR_ID:,&P6_PGR_ID.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(147538196215809332)
,p_name=>'P6_REALM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(165386916685150547)
,p_prompt=>unistr('aktueller G\00FCltigkeitsbereich')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from pit_ui_admin_par_realm'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_PARAMETER_REALM'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177631745019914902)
,p_name=>'P6_PGR_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(165386916685150547)
,p_prompt=>'Parmetergruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177487699754508804)
,p_name=>unistr('Schaltfl\00E4che erstellen - Dialog geschlossen')
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(165386916685150547)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177488187348508804)
,p_event_id=>wwv_flow_api.id(177487699754508804)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(165386916685150547)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147538391795809334)
,p_event_id=>wwv_flow_api.id(177487699754508804)
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
 p_id=>wwv_flow_api.id(177631878976914903)
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
 p_id=>wwv_flow_api.id(135494486509864351)
,p_event_id=>wwv_flow_api.id(177631878976914903)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(177487371498508804)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177631977686914904)
,p_event_id=>wwv_flow_api.id(177631878976914903)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(165386916685150547)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135494406113864350)
,p_event_id=>wwv_flow_api.id(177631878976914903)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(177487371498508804)
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Parameter bearbeiten'
,p_alias=>'EDIT_PAR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parameter bearbeiten'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(176699612104375939)
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
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140544'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(153395368662398406)
,p_plug_name=>unistr('Abweichende Parameterwerte f\00FCr G\00FCltigkeitsbereiche')
,p_region_name=>'EDIT_PAR_REALM'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
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
 p_id=>wwv_flow_api.id(153396838309398421)
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
,p_lov_id=>wwv_flow_api.id(153453428970054090)
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
 p_id=>wwv_flow_api.id(153396927529398422)
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
 p_id=>wwv_flow_api.id(153397118199398423)
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
 p_id=>wwv_flow_api.id(153397280885398425)
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
 p_id=>wwv_flow_api.id(153397348730398426)
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
 p_id=>wwv_flow_api.id(153397494662398427)
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
 p_id=>wwv_flow_api.id(153397600020398428)
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
 p_id=>wwv_flow_api.id(153397650680398429)
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
 p_id=>wwv_flow_api.id(153397783822398430)
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
 p_id=>wwv_flow_api.id(153468197530101582)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(153468266993101583)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(153396787423398420)
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
 p_id=>wwv_flow_api.id(153459430473100931)
,p_interactive_grid_id=>wwv_flow_api.id(153396787423398420)
,p_static_id=>'158034'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(153459549570100931)
,p_report_id=>wwv_flow_api.id(153459430473100931)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153460119603100934)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(153396838309398421)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153460579724100937)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(153396927529398422)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153461061929100940)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(153397118199398423)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153462038695100942)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(153397280885398425)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153462538483100944)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(153397348730398426)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153463106036100945)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(153397494662398427)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153463600324100947)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(153397600020398428)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153464048281100947)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(153397650680398429)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153464538977100948)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(153397783822398430)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(153474651807112125)
,p_view_id=>wwv_flow_api.id(153459549570100931)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(153468197530101582)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177467143155508657)
,p_plug_name=>'Parameter bearbeiten'
,p_region_name=>'EDIT_PAR_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
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
 p_id=>wwv_flow_api.id(177467843304508660)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177489420351508807)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175880723465657304)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(175904963419657340)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(175898982340657317)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177468282903508660)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177467843304508660)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177467693091508660)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(177467843304508660)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177467655306508660)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(177467843304508660)
,p_button_name=>'SAVE'
,p_button_static_id=>'B7_SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\00C4nderungen anwenden')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177467567628508660)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(177467843304508660)
,p_button_name=>'CREATE'
,p_button_static_id=>'P7_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165388698406150565)
,p_name=>'P7_PAR_XML_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'XML-Wert'
,p_source=>'PAR_XML_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(170953624155513068)
,p_name=>'P7_PGR_IS_MODIFIABLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
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
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177470975776508765)
,p_name=>'P7_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Parameter'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>128
,p_read_only_when=>'P7_PAR_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(175898106051657315)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Geben Sie einen eindeutigen Bezeichner f\00FCr diese Parametergruppe ein. Der Name muss den Oracle-Benennungskonventionen entsprechen und darf keine Sonderzeichen enthalten.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
,p_attribute_06=>'UPPER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177471245421508767)
,p_name=>'P7_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
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
,p_field_template=>wwv_flow_api.id(175898106051657315)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('W\00E4hlen Sie die Parametergruppe, zu der dieser Parameter geh\00F6ren soll.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177471609148508767)
,p_name=>'P7_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Besschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Geben Sie eine optionale Beschreibung des Parameters ein.'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177471990025508770)
,p_name=>'P7_PAR_STRING_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Textwert'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177472465193508770)
,p_name=>'P7_PAR_INTEGER_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Ganzzahlwert'
,p_source=>'PAR_INTEGER_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177472788053508770)
,p_name=>'P7_PAR_FLOAT_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>unistr('Flie\00DFkommazahlwert')
,p_source=>'PAR_FLOAT_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177473231405508770)
,p_name=>'P7_PAR_DATE_VALUE'
,p_source_data_type=>'DATE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Datumswert'
,p_source=>'PAR_DATE_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177473637814508771)
,p_name=>'P7_PAR_TIMESTAMP_VALUE'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Zeitstempelwert'
,p_source=>'PAR_TIMESTAMP_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177474416938508771)
,p_name=>'P7_PAR_BOOLEAN_VALUE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Wahrheitswert'
,p_source=>'PAR_BOOLEAN_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177474859048508773)
,p_name=>'P7_PAR_IS_MODIFIABLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'editieren untersagen'
,p_source=>'PAR_IS_MODIFIABLE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_PAR_IS_MODIFIABLE'
,p_lov=>'.'||wwv_flow_api.id(156261449181962546)||'.'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>0
,p_display_when=>':P7_PGR_IS_MODIFIABLE = pit_util.C_TRUE'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(175897790679657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Falls die Gruppe das Editieren erlaubt, kann dies f\00FCr einzelne Parameter unterdr\00FCckt werden.')
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177475285797508773)
,p_name=>'P7_PAR_PAT_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Texttyp'
,p_source=>'PAR_PAT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_TYPE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Mit diesem Attribut k\00F6nnen Sie festlegen, welche Art Text als Textparameter gespeichert werden soll. Dies kontrolliert, welcher Editor Ihnen zur Bearbeitung angeboten wird.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177475625746508773)
,p_name=>'P7_PAR_VALIDATION_STRING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Validierungsausdruck'
,p_source=>'PAR_VALIDATION_STRING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_api.id(175897918384657315)
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
 p_id=>wwv_flow_api.id(177476006802508773)
,p_name=>'P7_PAR_VALIDATION_MESSAGE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(177467143155508657)
,p_item_source_plug_id=>wwv_flow_api.id(177467143155508657)
,p_prompt=>'Fehlermeldung'
,p_source=>'PAR_VALIDATION_MESSAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165388593584150564)
,p_validation_name=>'Validate EDIT_PAR'
,p_validation_sequence=>120
,p_validation=>'return pit_ui.edit_par_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(153468053813101581)
,p_tabular_form_region_id=>wwv_flow_api.id(153395368662398406)
,p_validation_name=>'Validate EDIT_PAR_REALM'
,p_validation_sequence=>130
,p_validation=>'return pit_ui.edit_par_realm_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177468329538508660)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(177468282903508660)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177469101937508664)
,p_event_id=>wwv_flow_api.id(177468329538508660)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177478043296508776)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(177467143155508657)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_PAR'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177478461640508776)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(177467143155508657)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_PAR'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_par_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(153396720554398419)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(153395368662398406)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PAR_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_par_realm_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177478820007508776)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(177467693091508660)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177479189931508778)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Parametergruppe bearbeiten'
,p_alias=>'EDIT_PGR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parametergruppe bearbeiten'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(176699612104375939)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1000'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140557'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165386713245150545)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177642516318141173)
,p_plug_name=>'Parametergruppe bearbeiten'
,p_region_name=>'EDIT_PGR_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175876966761657303)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_PGR'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(165385565806150534)
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
 p_id=>wwv_flow_api.id(165385761455150535)
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
 p_id=>wwv_flow_api.id(165385820627150536)
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
 p_id=>wwv_flow_api.id(165386013928150538)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>40
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(165386089711150539)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(165386432751150542)
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
 p_id=>wwv_flow_api.id(165719664257286473)
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
 p_id=>wwv_flow_api.id(165385443860150532)
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
 p_id=>wwv_flow_api.id(165393888726162435)
,p_interactive_grid_id=>wwv_flow_api.id(165385443860150532)
,p_static_id=>'158041'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(165394045761162435)
,p_report_id=>wwv_flow_api.id(165393888726162435)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165395049818162443)
,p_view_id=>wwv_flow_api.id(165394045761162435)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(165385565806150534)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165395554698162445)
,p_view_id=>wwv_flow_api.id(165394045761162435)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(165385761455150535)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>437
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165396041949162446)
,p_view_id=>wwv_flow_api.id(165394045761162435)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(165385820627150536)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>99
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165399880517187156)
,p_view_id=>wwv_flow_api.id(165394045761162435)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(165386013928150538)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165400858015187159)
,p_view_id=>wwv_flow_api.id(165394045761162435)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(165386432751150542)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165993371667490029)
,p_view_id=>wwv_flow_api.id(165394045761162435)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(165719664257286473)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>107
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177646305350141182)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165386713245150545)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177646090441141182)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165386713245150545)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165386783311150546)
,p_tabular_form_region_id=>wwv_flow_api.id(177642516318141173)
,p_validation_name=>'Validate EDIT_PGR'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.edit_pgr_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165386519879150543)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(177646090441141182)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165386628029150544)
,p_event_id=>wwv_flow_api.id(165386519879150543)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165719386425286470)
,p_name=>'Format PGR'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(177642516318141173)
,p_triggering_element=>'PGR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165719463895286471)
,p_event_id=>wwv_flow_api.id(165719386425286470)
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
 p_id=>wwv_flow_api.id(165386177261150540)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(177642516318141173)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PGR'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_pgr_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177650412015141190)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'PIT administrieren'
,p_alias=>'ADMIN_PIT'
,p_step_title=>'PIT administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(177659936448238992)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220125170238'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(170955590522513087)
,p_name=>'Aktuelle Debugeinstellungen'
,p_template=>wwv_flow_api.id(175877470433657303)
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_ADMIN_PIT_ACTIVE_CONTEXT'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(175886244775657307)
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
 p_id=>wwv_flow_api.id(170955625327513088)
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
 p_id=>wwv_flow_api.id(170955726832513089)
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
 p_id=>wwv_flow_api.id(170955838521513090)
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
 p_id=>wwv_flow_api.id(170955916132513091)
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
 p_id=>wwv_flow_api.id(177632690908914912)
,p_plug_name=>'Hinweise zu Ausgabemodulen'
,p_region_name=>'output_modules'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(175872966531657301)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177632816171914913)
,p_plug_name=>'Hinweise zu Kontexten'
,p_region_name=>'contexts'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(175872966531657301)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177633751662914922)
,p_plug_name=>'Debugging nach Package filtern (Toggles)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(177633978626914924)
,p_name=>unistr('Verf\00FCgbare Toggles')
,p_parent_plug_id=>wwv_flow_api.id(177633751662914922)
,p_template=>wwv_flow_api.id(175877470433657303)
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
,p_query_row_template=>wwv_flow_api.id(175886244775657307)
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
 p_id=>wwv_flow_api.id(177634084854914925)
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
 p_id=>wwv_flow_api.id(177634118818914926)
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
 p_id=>wwv_flow_api.id(177634248007914927)
,p_query_column_id=>3
,p_column_alias=>'PAR_PGR_ID'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(177634358481914928)
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
 p_id=>wwv_flow_api.id(177634458909914929)
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
 p_id=>wwv_flow_api.id(177633793004914923)
,p_plug_name=>'Informationen zum Filter des Debuggings'
,p_region_name=>'toggles'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(175872966531657301)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177657817071214582)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175880723465657304)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(175904963419657340)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(175898982340657317)
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(177668810526218648)
,p_name=>'Installierte Ausgabemodule'
,p_template=>wwv_flow_api.id(175877470433657303)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_ADMIN_PIT_MODULE'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(175886244775657307)
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
 p_id=>wwv_flow_api.id(177632439963914909)
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
 p_id=>wwv_flow_api.id(177632112214914906)
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
 p_id=>wwv_flow_api.id(174645676256373524)
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
 p_id=>wwv_flow_api.id(177632277692914907)
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
 p_id=>wwv_flow_api.id(177632351773914908)
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
 p_id=>wwv_flow_api.id(177760055211572884)
,p_name=>unistr('Verf\00FCgbare Kontexte')
,p_template=>wwv_flow_api.id(175877470433657303)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_ADMIN_PIT_CONTEXT'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(175886244775657307)
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
 p_id=>wwv_flow_api.id(177633301834914918)
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
 p_id=>wwv_flow_api.id(131738380122223950)
,p_query_column_id=>2
,p_column_alias=>'PAR_ID'
,p_column_display_sequence=>14
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(177761034834572889)
,p_query_column_id=>3
,p_column_alias=>'CONTEXT_NAME'
,p_column_display_sequence=>2
,p_column_heading=>'Kontext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(177761398457572889)
,p_query_column_id=>4
,p_column_alias=>'CONTEXT_DESCRIPTION'
,p_column_display_sequence=>3
,p_column_heading=>'Beschreibung'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(177761825930572889)
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
 p_id=>wwv_flow_api.id(170954638008513078)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177668810526218648)
,p_button_name=>'HELP_OUTPUT_MODULES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898296301657315)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(170954998701513081)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177633751662914922)
,p_button_name=>'HELP_TOGGLES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898296301657315)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177634940220914934)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177760055211572884)
,p_button_name=>'CREATE_CONTEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_CONTEXT:&SESSION.::&DEBUG.:RP,10:P10_ROWID:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177635018696914935)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177633978626914924)
,p_button_name=>'CREATE_TOGGLE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_TOGGLE:&SESSION.::&DEBUG.:RP,12:P12_ROWID:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(170955304235513084)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(177760055211572884)
,p_button_name=>'HELP_CONTEXTS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898296301657315)
,p_button_image_alt=>'HIlfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177634578799914930)
,p_name=>'P9_ALLOW_TOGGLE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(177633751662914922)
,p_use_cache_before_default=>'NO'
,p_item_default=>'utl_apex.get_bool(pit_ui.allows_toggles)'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Toggles verwenden'
,p_display_as=>'NATIVE_YES_NO'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177693506772218665)
,p_name=>'Bericht bearbeiten - Dialog geschlossen'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(177668810526218648)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177694080034218667)
,p_event_id=>wwv_flow_api.id(177693506772218665)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177668810526218648)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177633573764914920)
,p_name=>'Kontext bearbeiten - Dialog geschlossen'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(177760055211572884)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177633634176914921)
,p_event_id=>wwv_flow_api.id(177633573764914920)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177760055211572884)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177634612148914931)
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
 p_id=>wwv_flow_api.id(177634688115914932)
,p_event_id=>wwv_flow_api.id(177634612148914931)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177633978626914924)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177634826379914933)
,p_event_id=>wwv_flow_api.id(177634612148914931)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177633978626914924)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177635806538914943)
,p_event_id=>wwv_flow_api.id(177634612148914931)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(177635018696914935)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177635915820914944)
,p_event_id=>wwv_flow_api.id(177634612148914931)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(177635018696914935)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177635230280914937)
,p_event_id=>wwv_flow_api.id(177634612148914931)
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
 p_id=>wwv_flow_api.id(177635294184914938)
,p_event_id=>wwv_flow_api.id(177634612148914931)
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
 p_id=>wwv_flow_api.id(177635644224914941)
,p_name=>'Toggle bearbeiten - Dialog geschlossen'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(177633751662914922)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177635746729914942)
,p_event_id=>wwv_flow_api.id(177635644224914941)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177633978626914924)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(170954746787513079)
,p_name=>'Show output module help'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(170954638008513078)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(170954879811513080)
,p_event_id=>wwv_flow_api.id(170954746787513079)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177632690908914912)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(170955056548513082)
,p_name=>'Show toggle help'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(170954998701513081)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(170955156769513083)
,p_event_id=>wwv_flow_api.id(170955056548513082)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177633793004914923)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(170955379209513085)
,p_name=>'Show context help'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(170955304235513084)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(170955460272513086)
,p_event_id=>wwv_flow_api.id(170955379209513085)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(177632816171914913)
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Kontext administrieren'
,p_alias=>'EDIT_CONTEXT'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(177659936448238992)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_protection_level=>'C'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140610'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177766667613752325)
,p_plug_name=>'Kontext administrieren'
,p_region_name=>'EDIT_CONTEXT_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
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
 p_id=>wwv_flow_api.id(177767337246752325)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177767252976752325)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(177767337246752325)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
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
 p_id=>wwv_flow_api.id(177767168119752325)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(177767337246752325)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177767076905752325)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(177767337246752325)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177767716161752326)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177767337246752325)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177632915416914914)
,p_name=>'P10_PSE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_default=>'10'
,p_prompt=>'Debug-Level'
,p_source=>'PSE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Maximaler Schweregrad, der durch diesen Kontext erlaubt wird.<br>Sollte ein Ausgabemodule eine niedrigere Ansprechschwelle haben, kann es sein, dass Meldungen nicht ausgegeben werden, obwohl der hier angegebene Schwellwert unterschritten wurde.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177633001336914915)
,p_name=>'P10_PTL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_prompt=>'Trace-Level'
,p_source=>'PTL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_TRACE_LEVEL'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Maximaler Tracelevel, der durch diesen Kontext erlaubt wird.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177633157929914916)
,p_name=>'P10_CTX_TIMING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_prompt=>'Zeitinformation erfassen'
,p_source=>'CTX_TIMING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Sollen Zeitinformationen gesammelt werden?'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177633245112914917)
,p_name=>'P10_CTX_OUTPUT_MODULES'
,p_source_data_type=>'CLOB'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_prompt=>'Ausgabemodule'
,p_source=>'CTX_OUTPUT_MODULES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_OUTPUT_MODULES'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_help_text=>'Liste der Ausgabemodule, die Log-Informationen ausgeben sollen.'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177770176129752329)
,p_name=>'P10_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Rowid'
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177770582041752346)
,p_name=>'P10_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_prompt=>'Kontext'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>120
,p_read_only_when=>'pit_ui.is_default_context'
,p_read_only_when2=>'PLSQL'
,p_read_only_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(175898106051657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Eindeutiger Bezeichner des Kontexts. Ohne Sonderzeichen und Leerzeichen. Der Name wird in Gro\00DFschreibung \00FCberf\00FChrt und muss den Namensregeln eines Oracle-Bezeichners entsprechen.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177770960042752348)
,p_name=>'P10_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177771385842752348)
,p_name=>'P10_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>800
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Optionale Beschreibung des Einsatzbereichs des Kontexts'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177771745464752348)
,p_name=>'P10_PAR_STRING_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(177766667613752325)
,p_item_source_plug_id=>wwv_flow_api.id(177766667613752325)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165716489726286441)
,p_validation_name=>'Validate EDIT_CONTEXT'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.edit_context_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177767875440752326)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(177767716161752326)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177768642190752326)
,p_event_id=>wwv_flow_api.id(177767875440752326)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135497870396864385)
,p_name=>'Format P10_PAR_ID'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_PAR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135497968064864386)
,p_event_id=>wwv_flow_api.id(135497870396864385)
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
 p_id=>wwv_flow_api.id(177773700262752353)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(177766667613752325)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PIT_UI_EDIT_CONTEXT'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177633427738914919)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(177766667613752325)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_CONTEXT'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_context_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177774547817752353)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(177767252976752325)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177774927858752353)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Ausgabemodul administrieren'
,p_alias=>'EDIT_MODULE'
,p_page_mode=>'MODAL'
,p_step_title=>'Ausgabemodul administrieren'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(177659936448238992)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1200'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140622'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165389533861150573)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165634247226845599)
,p_plug_name=>'Ausgabemodul administrieren'
,p_region_name=>'EDIT_MODULE_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175876966761657303)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_MODULE'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(165635199867845621)
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
 p_id=>wwv_flow_api.id(165635743249845623)
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
 p_id=>wwv_flow_api.id(165636292160845624)
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
 p_id=>wwv_flow_api.id(165636936176845626)
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
 p_id=>wwv_flow_api.id(165637463168845626)
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
 p_id=>wwv_flow_api.id(165638103035845626)
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
 p_id=>wwv_flow_api.id(165638690083845626)
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
 p_id=>wwv_flow_api.id(165639282322845627)
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
 p_id=>wwv_flow_api.id(165639909553845627)
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
 p_id=>wwv_flow_api.id(165640510513845627)
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
 p_id=>wwv_flow_api.id(165641097333845627)
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
 p_id=>wwv_flow_api.id(165715909640286435)
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
 p_id=>wwv_flow_api.id(165716047134286436)
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
 p_id=>wwv_flow_api.id(165634587976845618)
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
 p_id=>wwv_flow_api.id(165634890328845620)
,p_interactive_grid_id=>wwv_flow_api.id(165634587976845618)
,p_static_id=>'158051'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(165635023902845620)
,p_report_id=>wwv_flow_api.id(165634890328845620)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165636066140845623)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(165635743249845623)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165636682004845626)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(165636292160845624)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165637286116845626)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(165636936176845626)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165637933446845626)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(165637463168845626)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>347
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165638487063845626)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(165638103035845626)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>273
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165639124902845626)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(165638690083845626)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165639675978845627)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(165639282322845627)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>53
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165640291202845627)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(165639909553845627)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165640885503845627)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(165640510513845627)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165641469945845627)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(165641097333845627)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>54
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165731645470505890)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(165715909640286435)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(165734706065647085)
,p_view_id=>wwv_flow_api.id(165635023902845620)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(165716047134286436)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>115
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165389862440150577)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165389533861150573)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165389649223150574)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165389533861150573)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177632565747914910)
,p_name=>'P11_PIT_MODULE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(165634247226845599)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165389402916150572)
,p_tabular_form_region_id=>wwv_flow_api.id(165634247226845599)
,p_validation_name=>'Validate EDIT_MODULE'
,p_validation_sequence=>110
,p_validation=>'return pit_ui.edit_module_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165389734355150575)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165389649223150574)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165389806763150576)
,p_event_id=>wwv_flow_api.id(165389734355150575)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165641707012845629)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(165634247226845599)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_MODULE'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_module_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177730798712286667)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Kontext-Toggle administrieren'
,p_alias=>'EDIT_TOGGLE'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext-Toggle administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(177659936448238992)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140408'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177793232726192860)
,p_plug_name=>'Kontext-Toggle administrieren'
,p_region_name=>'EDIT_TOGGLE_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PIT_UI_EDIT_TOGGLE'
,p_include_rowid_column=>true
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177793985346192860)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177636013283914945)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(177793985346192860)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165716256717286438)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(177793985346192860)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177793714102192860)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(177793985346192860)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177793686029192860)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177793985346192860)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177635499285914940)
,p_name=>'P12_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(177793232726192860)
,p_item_source_plug_id=>wwv_flow_api.id(177793232726192860)
,p_use_cache_before_default=>'NO'
,p_source=>'ROW_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177795858415192862)
,p_name=>'P12_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(177793232726192860)
,p_item_source_plug_id=>wwv_flow_api.id(177793232726192860)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>120
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177796276699192864)
,p_name=>'P12_TOGGLE_MODULE_LIST'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(177793232726192860)
,p_item_source_plug_id=>wwv_flow_api.id(177793232726192860)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Liste der Packages'
,p_source=>'TOGGLE_MODULE_LIST'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_AVAILABLE_PACKAGES'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177796603156192864)
,p_name=>'P12_TOGGLE_CONTEXT_NAME'
,p_source_data_type=>'CLOB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(177793232726192860)
,p_item_source_plug_id=>wwv_flow_api.id(177793232726192860)
,p_use_cache_before_default=>'NO'
,p_prompt=>'zugeordneter Kontext'
,p_source=>'TOGGLE_CONTEXT_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CONTEXT'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Kontext w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177797055859192864)
,p_name=>'P12_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(177793232726192860)
,p_item_source_plug_id=>wwv_flow_api.id(177793232726192860)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165716094890286437)
,p_validation_name=>'Validate EDIT_TOGGLE'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.edit_toggle_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177794669696192860)
,p_name=>'Dialog abbrechen'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(177793686029192860)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(177795162091192860)
,p_event_id=>wwv_flow_api.id(177794669696192860)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177797404361192864)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(177793232726192860)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_TOGGLE'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_toggle_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177797982861192864)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177635417223914939)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(177793232726192860)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>unistr('G\00FCltigkeitsbereich administrieren')
,p_alias=>'EDIT_REALM'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('G\00FCltigkeitsbereich administrieren')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140649'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135493849239864344)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175873863790657301)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(146700520455825167)
,p_plug_name=>unistr('G\00FCltigkeitsbereiche')
,p_region_name=>'EDIT_REALM_FORM'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175876966761657303)
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
 p_id=>wwv_flow_api.id(146701850876825175)
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
 p_id=>wwv_flow_api.id(146702314993825175)
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
 p_id=>wwv_flow_api.id(146704327151825194)
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
 p_id=>wwv_flow_api.id(146705292114825195)
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
 p_id=>wwv_flow_api.id(146706341953825195)
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
 p_id=>wwv_flow_api.id(146700996084825169)
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
 p_id=>wwv_flow_api.id(146701397062825170)
,p_interactive_grid_id=>wwv_flow_api.id(146700996084825169)
,p_static_id=>'179029'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(146701570846825170)
,p_report_id=>wwv_flow_api.id(146701397062825170)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(146702677357825177)
,p_view_id=>wwv_flow_api.id(146701570846825170)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(146702314993825175)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(146704697850825195)
,p_view_id=>wwv_flow_api.id(146701570846825170)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(146704327151825194)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(146705720169825195)
,p_view_id=>wwv_flow_api.id(146701570846825170)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(146705292114825195)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(146706693053825195)
,p_view_id=>wwv_flow_api.id(146701570846825170)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(146706341953825195)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(146726665440062733)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(135493849239864344)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135493947833864345)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(135493849239864344)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(135494221308864348)
,p_validation_name=>'Validate EDIT_REALM'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.edit_realm_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135493980725864346)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(135493947833864345)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135494107612864347)
,p_event_id=>wwv_flow_api.id(135493980725864346)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135497711059864383)
,p_name=>'Format PRE_ID'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(146700520455825167)
,p_triggering_element=>'PRE_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135497827509864384)
,p_event_id=>wwv_flow_api.id(135497711059864383)
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
 p_id=>wwv_flow_api.id(146707285750825197)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(146700520455825167)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pit_ui.edit_realm_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135494340038864349)
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
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>unistr('Stammdaten exportieren und \00FCbersetzen')
,p_alias=>'EXPORT'
,p_step_title=>unistr('Stammdaten exportieren und \00FCbersetzen')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(177814299970504385)
,p_javascript_file_urls=>'#APP_IMAGES#condes.pit.utils.js'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220125165437'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165717165203286448)
,p_plug_name=>'linke Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165717438326286450)
,p_plug_name=>unistr('Begriffe exportieren und \00FCbersetzen')
,p_parent_plug_id=>wwv_flow_api.id(165717165203286448)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
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
 p_id=>wwv_flow_api.id(177841159392058107)
,p_plug_name=>unistr('Meldungen exportieren und \00FCbersetzen')
,p_parent_plug_id=>wwv_flow_api.id(165717165203286448)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165717263633286449)
,p_plug_name=>'rechte Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175869342903657298)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177841220613058108)
,p_plug_name=>'Parameter exportieren'
,p_parent_plug_id=>wwv_flow_api.id(165717263633286449)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177819593089567060)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(175880723465657304)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(175904963419657340)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(175898982340657317)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165719926511286475)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165717438326286450)
,p_button_name=>'IMPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('\00DCbersetzung laden')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165720027482286476)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177841159392058107)
,p_button_name=>'IMPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('\00DCbersetzung laden')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165716879012286445)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(177841159392058107)
,p_button_name=>'TRANSLATE_PMS'
,p_button_static_id=>'TRANSLATE_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('Meldung \00FCbersetzen')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165717876749286455)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165717438326286450)
,p_button_name=>'TRANSLATE_PTI'
,p_button_static_id=>'TRANSLATE_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>unistr('Begriffe \00FCbersetzen')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165717824805286454)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(165717438326286450)
,p_button_name=>'EXPORT_PTI'
,p_button_static_id=>'EXPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Begriffe exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177840843056058104)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(177841159392058107)
,p_button_name=>'EXPORT_PMS'
,p_button_static_id=>'EXPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Meldungen exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165716594846286442)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177841220613058108)
,p_button_name=>'EXPORT_LOCAL_PAR'
,p_button_static_id=>'EXPORT_LOCAL_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Lokale Parameter exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'pit_ui.has_local_parameters'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(177841865199058114)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(177841220613058108)
,p_button_name=>'EXPORT_PAR'
,p_button_static_id=>'EXPORT_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_image_alt=>'Parametergruppen exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165716818084286444)
,p_name=>'P16_PMS_PML_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(177841159392058107)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Zielsprache w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165717007523286446)
,p_name=>'P16_HINT_PMS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(177841159392058107)
,p_prompt=>'Hint pms'
,p_source=>'apex_lang.message(''HINT_PMS'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(175897790679657315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165717530408286451)
,p_name=>'P16_PTI_PMG_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(165717438326286450)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PMS_PMG_IN_USE'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165717617663286452)
,p_name=>'P16_HINT_PTI'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(165717438326286450)
,p_prompt=>'Hint pti'
,p_source=>'apex_lang.message(''HINT_PTI'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(175897790679657315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165717742054286453)
,p_name=>'P16_PTI_PML_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(165717438326286450)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Zielsprache w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165719808601286474)
,p_name=>'P16_PTI_XLIFF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(165717438326286450)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
,p_attribute_12=>'NATIVE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165720079801286477)
,p_name=>'P16_PMS_XLIFF'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(177841159392058107)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
,p_attribute_12=>'NATIVE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177840710921058103)
,p_name=>'P16_PMS_PMG_LIST'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(177841159392058107)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PMS_PMG_IN_USE'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(177841756138058113)
,p_name=>'P16_PAR_PGR_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(177841220613058108)
,p_prompt=>'Parametergruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Bewegen Sie alle Parametergruppen, die Sie exportieren m\00F6chten, in die rechte Spalte.')
,p_attribute_01=>'MOVE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165389302851150571)
,p_validation_name=>'Validate EXPORT'
,p_validation_sequence=>10
,p_validation=>'return pit_ui.export_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(177842081619058116)
,p_name=>'ControlExportItems'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.control-export'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165717125445286447)
,p_event_id=>wwv_flow_api.id(177842081619058116)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'condes.pit.utils.controlExportItems();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165720174244286478)
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
 p_id=>wwv_flow_api.id(165720301560286479)
,p_event_id=>wwv_flow_api.id(165720174244286478)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(165720027482286476)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165720370352286480)
,p_event_id=>wwv_flow_api.id(165720174244286478)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(165720027482286476)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166026483512278732)
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
 p_id=>wwv_flow_api.id(166026633808278733)
,p_event_id=>wwv_flow_api.id(166026483512278732)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(165719926511286475)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166026757362278734)
,p_event_id=>wwv_flow_api.id(166026483512278732)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(165719926511286475)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(177840966562058105)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EXPORT'
,p_process_sql_clob=>'pit_ui.export_process;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(175903650235657326)
,p_name=>'Login Page'
,p_alias=>'LOGIN_DESKTOP'
,p_step_title=>'PIT-Administration - Log In'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(175865725302657295)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201221134959'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(175904094044657335)
,p_plug_name=>'Log In'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(175877470433657303)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(175904459318657339)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(175904094044657335)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(175898387589657317)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Log In'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_alignment=>'LEFT'
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(175904238193657339)
,p_name=>'P101_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(175904094044657335)
,p_prompt=>'Benutzer'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(175904376490657339)
,p_name=>'P101_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(175904094044657335)
,p_prompt=>'Passwort'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(175897918384657315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(175904614540657340)
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
 p_id=>wwv_flow_api.id(175904498430657339)
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
 p_id=>wwv_flow_api.id(175904831554657340)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(175904754056657340)
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
 p_id=>wwv_flow_api.id(177659642106228870)
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
