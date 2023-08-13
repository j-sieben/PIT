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
,p_default_id_offset=>400024909171861626
,p_default_owner=>'ADC_APP'
);
end;
/
 
prompt APPLICATION 300 - PIT-Administration
--
-- Application Export:
--   Application:     300
--   Name:            PIT-Administration
--   Date and Time:   09:10 Tuesday August 1, 2023
--   Exported By:     ADC_ADMIN
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     15
--       Items:                   58
--       Validations:             11
--       Processes:               32
--       Regions:                 44
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
--         LOVs:                  16
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
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'PITA')
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
,p_authentication_id=>wwv_flow_api.id(431329863893692930)
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
,p_last_upd_yyyymmddhh24miss=>'20230801091023'
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
 p_id=>wwv_flow_api.id(423756463668985383)
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
 p_id=>wwv_flow_api.id(431287276434692886)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(431331065395692941)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Startseite'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:MAIN:&SESSION.'
,p_list_item_icon=>'fa-dot-circle-o'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from PITA_UI_list_active_for_page',
' where page_group = ''MAIN'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(433083430158250180)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'PIT administrieren'
,p_list_item_link_target=>'F?p=&APP_ALIAS.:ADMIN_PIT:&SESSION.'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_api.id(431331065395692941)
,p_list_text_01=>'Einsatzeinstellungen'
,p_list_text_02=>'Kontrolliert Kontexte, Toggles und zeigt die aktuelle Parametrierung'
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from PITA_UI_list_active_for_page',
' where page_group = ''PIT'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(431347843229906004)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Meldungen administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_list_item_icon=>'fa-comment-o'
,p_parent_list_item_id=>wwv_flow_api.id(431331065395692941)
,p_list_text_01=>'Meldungen erzeugen und editieren'
,p_list_text_02=>unistr('Verwaltung neuer Meldungen und \00C4nderung bestehender')
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from PITA_UI_list_active_for_page',
' where page_group = ''MESSAGE'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(432130745735798488)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Parameter administrieren'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_PARAM:&SESSION.'
,p_list_item_icon=>'fa-cog'
,p_parent_list_item_id=>wwv_flow_api.id(431331065395692941)
,p_list_text_01=>'Parameter erstellen und editieren'
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from PITA_UI_list_active_for_page',
' where page_group = ''PARAMETER'''))
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(433238060990522093)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Stammdaten'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:EXPORT:&SESSION.'
,p_list_item_icon=>'fa-exchange'
,p_parent_list_item_id=>wwv_flow_api.id(431331065395692941)
,p_list_text_01=>unistr('\00DCbersetzung und Export')
,p_list_text_02=>unistr('Erlaubt die Erstellung von Skriptdateien zum Export oder zum \00DCbersetzen')
,p_translate_list_text_y_n=>'Y'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from PITA_UI_list_active_for_page',
' where page_group = ''EXPORT'''))
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_bar
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(431329647524692927)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(431329852480692929)
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
 p_id=>wwv_flow_api.id(421270098143458663)
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
 p_id=>wwv_flow_api.id(400025041680861703)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(400025570918861704)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attribute_01=>'fa-star'
,p_attribute_04=>'#VALUE#'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(416589890486498904)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_RICH_TEXT_EDITOR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(423750727053968003)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'LEGACY'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(423750770032968003)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'classic'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(431287007756692886)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(431287153920692886)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH_CB'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(431287190874692886)
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
 p_id=>wwv_flow_api.id(433230154529353657)
,p_lov_name=>'LOV_AVAILABLE_PACKAGES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_AVAILABLE_PACKAGES'
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
 p_id=>wwv_flow_api.id(401080039962345526)
,p_lov_name=>'LOV_AVAILABLE_TRANSLATIONS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_MESSAGE_LANGUAGE'
,p_query_where=>'pml_default_order > 0'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_context
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(433231093304386469)
,p_lov_name=>'LOV_CONTEXT'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_CONTEXT'
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
 p_id=>wwv_flow_api.id(433205290013920383)
,p_lov_name=>'LOV_OUTPUT_MODULES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_OUTPUT_MODULES'
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
 p_id=>wwv_flow_api.id(432156131881884752)
,p_lov_name=>'LOV_PARAMETER_GROUP'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_PARAMETER_GROUP'
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
 p_id=>wwv_flow_api.id(408879496967089691)
,p_lov_name=>'LOV_PARAMETER_REALM'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_PARAMETER_REALM'
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
 p_id=>wwv_flow_api.id(432156293372887338)
,p_lov_name=>'LOV_PARAMETER_TYPE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_PARAMETER_TYPE'
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
 p_id=>wwv_flow_api.id(411687517178998147)
,p_lov_name=>'LOV_PAR_IS_MODIFIABLE'
,p_lov_query=>'.'||wwv_flow_api.id(411687517178998147)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(411687789976998150)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Editieren sperren'
,p_lov_return_value=>'Nein'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pit_message_group
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(423792515813171301)
,p_lov_name=>'LOV_PIT_MESSAGE_GROUP'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_MESSAGE_GROUP'
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
 p_id=>wwv_flow_api.id(431386898943652874)
,p_lov_name=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_MESSAGE_LANGUAGE'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'PML_DEFAULT_ORDER'
,p_default_sort_direction=>'DESC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pit_message_severity
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(431380592444425363)
,p_lov_name=>'LOV_PIT_MESSAGE_SEVERITY'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_MESSAGE_SEVERITY'
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
 p_id=>wwv_flow_api.id(431380851551428496)
,p_lov_name=>'LOV_PIT_TRACE_LEVEL'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_TRACE_LEVEL'
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
 p_id=>wwv_flow_api.id(423794429220207047)
,p_lov_name=>'LOV_PML_NAME_IN_USE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_MESSAGE_LANGUAGE'
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
 p_id=>wwv_flow_api.id(421287213507367900)
,p_lov_name=>'LOV_PMS_PMG_IN_USE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_MESSAGE_GROUP'
,p_query_where=>'has_message = 1'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_pti_pmg_in_use
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(372182931632285407)
,p_lov_name=>'LOV_PTI_PMG_IN_USE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'PITA_UI_LOV_MESSAGE_GROUP'
,p_query_where=>'has_translatable_item = 1'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_uttm_type
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(372626631704189335)
,p_lov_name=>'LOV_UTTM_TYPE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'PITA_UI_LOV_UTTM_TYPE'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(433240367967539986)
,p_group_name=>'EXPORT'
,p_group_desc=>'Export von Stammdaten'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(432125552448409515)
,p_group_name=>'MAIN'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(432125591683410235)
,p_group_name=>'MESSAGE'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(432125680101411540)
,p_group_name=>'PARAMETER'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(433086004445274593)
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
 p_id=>wwv_flow_api.id(431331031416692941)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(431331388604692943)
,p_parent_id=>0
,p_short_name=>'Startseite'
,p_link=>'f?p=&APP_ALIAS.:MAIN:&SESSION.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(431354691488906033)
,p_parent_id=>wwv_flow_api.id(431331388604692943)
,p_short_name=>'Meldungen administrieren'
,p_link=>'f?p=&APP_ALIAS.:ADMIN_PMS:&SESSION.'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(432914661013544405)
,p_parent_id=>wwv_flow_api.id(431331388604692943)
,p_short_name=>'Parameter verwalten'
,p_link=>'f?p=&APP_ID.:6:&SESSION.'
,p_page_id=>6
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(433084261799250185)
,p_parent_id=>wwv_flow_api.id(431331388604692943)
,p_short_name=>'PIT administrieren'
,p_link=>'f?p=&APP_ID.:9:&SESSION.'
,p_page_id=>9
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(433246120370602661)
,p_parent_id=>wwv_flow_api.id(431331388604692943)
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
 p_id=>wwv_flow_api.id(431287365936692891)
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
 p_id=>wwv_flow_api.id(400264386274877898)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400264884137877898)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400265363440877898)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400265885739877899)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400266417307877899)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400266846728877899)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400267432488877899)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400267875343877899)
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
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
 p_id=>wwv_flow_api.id(431288264953692894)
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
 p_id=>wwv_flow_api.id(400272547474877904)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400273037773877904)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400273581014877904)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400274065163877904)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400274596204877904)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400275098491877904)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400275545791877906)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400276092596877906)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400276556536877906)
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
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
 p_id=>wwv_flow_api.id(431289308115692894)
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
 p_id=>wwv_flow_api.id(400296962215877914)
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400297441844877914)
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400298004452877914)
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400298450016877914)
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400299010260877914)
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400299464919877914)
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400299952890877914)
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
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
 p_id=>wwv_flow_api.id(431290065788692894)
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
 p_id=>wwv_flow_api.id(400307901251877917)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400308362115877917)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400308851530877917)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400309382803877918)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400309873058877918)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400310414448877918)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400310837927877918)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400311414564877918)
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
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
 p_id=>wwv_flow_api.id(431291044044692896)
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
 p_id=>wwv_flow_api.id(400315273553877920)
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400315747002877920)
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400316244124877920)
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400316827081877920)
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400317313972877920)
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400317762093877920)
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400318292952877920)
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
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
 p_id=>wwv_flow_api.id(431291793299692896)
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
 p_id=>wwv_flow_api.id(400278438504877906)
,p_page_template_id=>wwv_flow_api.id(431291793299692896)
,p_name=>'Body Footer'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400279012047877906)
,p_page_template_id=>wwv_flow_api.id(431291793299692896)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400279519529877906)
,p_page_template_id=>wwv_flow_api.id(431291793299692896)
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
 p_id=>wwv_flow_api.id(431292095856692896)
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
 p_id=>wwv_flow_api.id(400289058404877910)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400289562959877910)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400290087249877910)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400290624151877910)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400291127007877912)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400291571969877912)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400292050873877912)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400292572638877912)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400293049624877912)
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
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
 p_id=>wwv_flow_api.id(431293152344692896)
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
 p_id=>wwv_flow_api.id(400302310977877915)
,p_page_template_id=>wwv_flow_api.id(431293152344692896)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400302757531877915)
,p_page_template_id=>wwv_flow_api.id(431293152344692896)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400303281587877915)
,p_page_template_id=>wwv_flow_api.id(431293152344692896)
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
 p_id=>wwv_flow_api.id(431293485262692896)
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
 p_id=>wwv_flow_api.id(400320589722877921)
,p_page_template_id=>wwv_flow_api.id(431293485262692896)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400321104767877921)
,p_page_template_id=>wwv_flow_api.id(431293485262692896)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(400321538740877921)
,p_page_template_id=>wwv_flow_api.id(431293485262692896)
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
 p_id=>wwv_flow_api.id(431324364298692916)
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
 p_id=>wwv_flow_api.id(431324455586692918)
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
 p_id=>wwv_flow_api.id(431324582442692918)
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
 p_id=>wwv_flow_api.id(400427518569877971)
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
 p_id=>wwv_flow_api.id(416942570914535326)
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
 p_id=>wwv_flow_api.id(416945737281535332)
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
 p_id=>wwv_flow_api.id(400332232385877929)
,p_plug_template_id=>wwv_flow_api.id(416945737281535332)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(400332675438877929)
,p_plug_template_id=>wwv_flow_api.id(416945737281535332)
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
 p_id=>wwv_flow_api.id(416947199455535332)
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
 p_id=>wwv_flow_api.id(400381199066877951)
,p_plug_template_id=>wwv_flow_api.id(416947199455535332)
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
 p_id=>wwv_flow_api.id(431293904857692897)
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
 p_id=>wwv_flow_api.id(400323430272877926)
,p_plug_template_id=>wwv_flow_api.id(431293904857692897)
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
 p_id=>wwv_flow_api.id(431295410900692899)
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
 p_id=>wwv_flow_api.id(431295496674692899)
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
 p_id=>wwv_flow_api.id(400339133521877932)
,p_plug_template_id=>wwv_flow_api.id(431295496674692899)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(400339573007877932)
,p_plug_template_id=>wwv_flow_api.id(431295496674692899)
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
 p_id=>wwv_flow_api.id(431299034528692902)
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
 p_id=>wwv_flow_api.id(400376712756877948)
,p_plug_template_id=>wwv_flow_api.id(431299034528692902)
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
 p_id=>wwv_flow_api.id(431299931787692902)
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
 p_id=>wwv_flow_api.id(400334304089877929)
,p_plug_template_id=>wwv_flow_api.id(431299931787692902)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(400334793021877931)
,p_plug_template_id=>wwv_flow_api.id(431299931787692902)
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
 p_id=>wwv_flow_api.id(431300714336692902)
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
 p_id=>wwv_flow_api.id(400355271879877939)
,p_plug_template_id=>wwv_flow_api.id(431300714336692902)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(400355740588877939)
,p_plug_template_id=>wwv_flow_api.id(431300714336692902)
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
 p_id=>wwv_flow_api.id(431302834358692904)
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
 p_id=>wwv_flow_api.id(400372163258877946)
,p_plug_template_id=>wwv_flow_api.id(431302834358692904)
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
 p_id=>wwv_flow_api.id(431303034758692904)
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
 p_id=>wwv_flow_api.id(431303335633692904)
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
 p_id=>wwv_flow_api.id(400393807687877956)
,p_plug_template_id=>wwv_flow_api.id(431303335633692904)
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
 p_id=>wwv_flow_api.id(431303538430692904)
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
 p_id=>wwv_flow_api.id(400399295148877957)
,p_plug_template_id=>wwv_flow_api.id(431303538430692904)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(400399818858877957)
,p_plug_template_id=>wwv_flow_api.id(431303538430692904)
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
 p_id=>wwv_flow_api.id(431305612695692904)
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
 p_id=>wwv_flow_api.id(400418451434877967)
,p_plug_template_id=>wwv_flow_api.id(431305612695692904)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(400419019767877967)
,p_plug_template_id=>wwv_flow_api.id(431305612695692904)
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
 p_id=>wwv_flow_api.id(431306791462692905)
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
 p_id=>wwv_flow_api.id(431307263639692905)
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
 p_id=>wwv_flow_api.id(400425570348877970)
,p_plug_template_id=>wwv_flow_api.id(431307263639692905)
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
 p_id=>wwv_flow_api.id(400484785010878003)
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
 p_id=>wwv_flow_api.id(417010230432535365)
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
 p_id=>wwv_flow_api.id(431315698956692910)
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
 p_id=>wwv_flow_api.id(431317407965692911)
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
 p_id=>wwv_flow_api.id(431319479392692913)
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
 p_id=>wwv_flow_api.id(431320031741692913)
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
 p_id=>wwv_flow_api.id(431320069227692913)
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
 p_id=>wwv_flow_api.id(431321012657692915)
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
 p_id=>wwv_flow_api.id(431321549638692915)
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
 p_id=>wwv_flow_api.id(431322267856692915)
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
 p_id=>wwv_flow_api.id(431322360820692915)
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
 p_id=>wwv_flow_api.id(431323329664692915)
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
 p_id=>wwv_flow_api.id(431323393039692915)
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
 p_id=>wwv_flow_api.id(400537956849878029)
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
 p_id=>wwv_flow_api.id(417062334523535389)
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
 p_id=>wwv_flow_api.id(431307877578692905)
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
 p_id=>wwv_flow_api.id(431308034056692907)
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
 p_id=>wwv_flow_api.id(431309695842692907)
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
 p_id=>wwv_flow_api.id(431311838671692908)
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
 p_id=>wwv_flow_api.id(431312252810692908)
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
 p_id=>wwv_flow_api.id(431312312772692908)
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
 p_id=>wwv_flow_api.id(431312312772692908)
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
 p_id=>wwv_flow_api.id(431313583536692908)
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
 p_id=>wwv_flow_api.id(431314574729692910)
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
 p_id=>wwv_flow_api.id(431315531248692910)
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
 p_id=>wwv_flow_api.id(417068847426535395)
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
 p_id=>wwv_flow_api.id(417069164255535395)
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
 p_id=>wwv_flow_api.id(431323858676692916)
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
 p_id=>wwv_flow_api.id(431323986381692916)
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
 p_id=>wwv_flow_api.id(431324130711692916)
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
 p_id=>wwv_flow_api.id(431324174048692916)
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
 p_id=>wwv_flow_api.id(431324349211692916)
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
 p_id=>wwv_flow_api.id(431325050337692918)
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
 p_id=>wwv_flow_api.id(431325216279692919)
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
 p_id=>wwv_flow_api.id(431325122776692918)
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
 p_id=>wwv_flow_api.id(431325620894692922)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(431291044044692896)
,p_default_dialog_template=>wwv_flow_api.id(431293152344692896)
,p_error_template=>wwv_flow_api.id(431291793299692896)
,p_printer_friendly_template=>wwv_flow_api.id(431291044044692896)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(431291793299692896)
,p_default_button_template=>wwv_flow_api.id(431324455586692918)
,p_default_region_template=>wwv_flow_api.id(431303538430692904)
,p_default_chart_template=>wwv_flow_api.id(431303538430692904)
,p_default_form_template=>wwv_flow_api.id(431303538430692904)
,p_default_reportr_template=>wwv_flow_api.id(431303538430692904)
,p_default_tabform_template=>wwv_flow_api.id(431303538430692904)
,p_default_wizard_template=>wwv_flow_api.id(431303538430692904)
,p_default_menur_template=>wwv_flow_api.id(431306791462692905)
,p_default_listr_template=>wwv_flow_api.id(431303538430692904)
,p_default_irr_template=>wwv_flow_api.id(431303034758692904)
,p_default_report_template=>wwv_flow_api.id(431312312772692908)
,p_default_label_template=>wwv_flow_api.id(431323986381692916)
,p_default_menu_template=>wwv_flow_api.id(431325050337692918)
,p_default_calendar_template=>wwv_flow_api.id(431325122776692918)
,p_default_list_template=>wwv_flow_api.id(431321549638692915)
,p_default_nav_list_template=>wwv_flow_api.id(431323393039692915)
,p_default_top_nav_list_temp=>wwv_flow_api.id(431323393039692915)
,p_default_side_nav_list_temp=>wwv_flow_api.id(431323329664692915)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(431299931787692902)
,p_default_dialogr_template=>wwv_flow_api.id(431295410900692899)
,p_default_option_label=>wwv_flow_api.id(431323986381692916)
,p_default_required_label=>wwv_flow_api.id(431324174048692916)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(431320031741692913)
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
 p_id=>wwv_flow_api.id(400033316926877809)
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
 p_id=>wwv_flow_api.id(400033692160877810)
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
 p_id=>wwv_flow_api.id(400034131302877810)
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
 p_id=>wwv_flow_api.id(400034533121877810)
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
 p_id=>wwv_flow_api.id(400034838977877810)
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
 p_id=>wwv_flow_api.id(400035320417877810)
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
 p_id=>wwv_flow_api.id(400155572791877856)
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
 p_id=>wwv_flow_api.id(400155937569877857)
,p_theme_id=>42
,p_name=>'ICON_HOVER_ANIMATION'
,p_display_name=>'Icon Hover Animation'
,p_display_sequence=>55
,p_template_types=>'BUTTON'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400156427151877857)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400156811850877857)
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
 p_id=>wwv_flow_api.id(400157192954877857)
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
 p_id=>wwv_flow_api.id(400157572234877857)
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
 p_id=>wwv_flow_api.id(400157972292877857)
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
 p_id=>wwv_flow_api.id(400158393202877857)
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
 p_id=>wwv_flow_api.id(400158739387877857)
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
 p_id=>wwv_flow_api.id(400159168215877857)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400159585745877857)
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
 p_id=>wwv_flow_api.id(400159947417877857)
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
 p_id=>wwv_flow_api.id(400160394135877857)
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
 p_id=>wwv_flow_api.id(400160818800877857)
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
 p_id=>wwv_flow_api.id(400161176733877857)
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
 p_id=>wwv_flow_api.id(400161535786877859)
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
 p_id=>wwv_flow_api.id(400161949612877859)
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
 p_id=>wwv_flow_api.id(400162400107877859)
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
 p_id=>wwv_flow_api.id(400162803520877859)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400163147021877859)
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
 p_id=>wwv_flow_api.id(400163539685877859)
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
 p_id=>wwv_flow_api.id(400164008933877859)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400164424697877859)
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
 p_id=>wwv_flow_api.id(400164788772877859)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE'
,p_display_name=>'Collapse Mode'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400165159341877859)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400165575766877859)
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
 p_id=>wwv_flow_api.id(400166008098877859)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400166343460877859)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400166797025877860)
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
 p_id=>wwv_flow_api.id(400167193594877860)
,p_theme_id=>42
,p_name=>'ICON_STYLE'
,p_display_name=>'Icon Style'
,p_display_sequence=>35
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400167552637877860)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400168034165877860)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400168388525877860)
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
 p_id=>wwv_flow_api.id(400168746400877860)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400169222999877860)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400169628153877860)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND'
,p_display_name=>'Page Background'
,p_display_sequence=>20
,p_template_types=>'PAGE'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400169969776877860)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT'
,p_display_name=>'Page Layout'
,p_display_sequence=>10
,p_template_types=>'PAGE'
,p_null_text=>'Floating (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400170348314877860)
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
 p_id=>wwv_flow_api.id(400170818061877860)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400171187968877860)
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
 p_id=>wwv_flow_api.id(400171551674877860)
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
 p_id=>wwv_flow_api.id(400171947782877860)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400172401159877862)
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
 p_id=>wwv_flow_api.id(400172801216877862)
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
 p_id=>wwv_flow_api.id(400173153383877862)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400173591020877862)
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
 p_id=>wwv_flow_api.id(400173996265877862)
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
 p_id=>wwv_flow_api.id(400174419499877862)
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
 p_id=>wwv_flow_api.id(400174783018877862)
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
 p_id=>wwv_flow_api.id(400175218953877862)
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
 p_id=>wwv_flow_api.id(400175581211877862)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400175972638877862)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400176353826877862)
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
 p_id=>wwv_flow_api.id(400176816906877862)
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
 p_id=>wwv_flow_api.id(400177148986877862)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400177594829877862)
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
 p_id=>wwv_flow_api.id(400177985548877864)
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
 p_id=>wwv_flow_api.id(400178404717877864)
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
 p_id=>wwv_flow_api.id(400178818808877864)
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
 p_id=>wwv_flow_api.id(400179222893877864)
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
 p_id=>wwv_flow_api.id(400179597611877864)
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
 p_id=>wwv_flow_api.id(400179977214877864)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400180370227877864)
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
 p_id=>wwv_flow_api.id(400180782339877864)
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
 p_id=>wwv_flow_api.id(400181175691877864)
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
 p_id=>wwv_flow_api.id(400181632422877864)
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
 p_id=>wwv_flow_api.id(400182009993877864)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400182344461877864)
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
 p_id=>wwv_flow_api.id(400182742451877864)
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
 p_id=>wwv_flow_api.id(400183156261877865)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400183549735877865)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400183967248877865)
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
 p_id=>wwv_flow_api.id(400184412161877865)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400184747112877865)
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
 p_id=>wwv_flow_api.id(400185171351877865)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400185541984877865)
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
 p_id=>wwv_flow_api.id(400185957085877865)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400186360383877865)
,p_theme_id=>42
,p_name=>'COL_ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>150
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400186757844877865)
,p_theme_id=>42
,p_name=>'COL_CONTENT_DESCRIPTION'
,p_display_name=>'Description'
,p_display_sequence=>130
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400187204670877865)
,p_theme_id=>42
,p_name=>'COL_CONTENT_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>120
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400187537757877865)
,p_theme_id=>42
,p_name=>'COL_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>110
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400187963415877865)
,p_theme_id=>42
,p_name=>'COL_MISC'
,p_display_name=>'Misc'
,p_display_sequence=>140
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400188354295877865)
,p_theme_id=>42
,p_name=>'COL_SELECTION'
,p_display_name=>'Selection'
,p_display_sequence=>100
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400188810235877867)
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
 p_id=>wwv_flow_api.id(400189198585877867)
,p_theme_id=>42
,p_name=>'CONTENT_ALIGNMENT'
,p_display_name=>'Content Alignment'
,p_display_sequence=>90
,p_template_types=>'REPORT'
,p_null_text=>'Center (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400189567357877867)
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
 p_id=>wwv_flow_api.id(400190012388877867)
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
 p_id=>wwv_flow_api.id(400190377501877867)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400190823303877867)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400191200575877867)
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
 p_id=>wwv_flow_api.id(400191614746877867)
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
 p_id=>wwv_flow_api.id(400191959690877867)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400192345756877867)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(400192781510877867)
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
 p_id=>wwv_flow_api.id(400213925117877878)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(400159947417877857)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400214573384877878)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(400180782339877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400215320299877878)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(400159947417877857)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400216024103877878)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(400180782339877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400216648608877878)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(400159947417877857)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400217420642877878)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(400180782339877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400218086567877879)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(400159947417877857)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400218824202877879)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(400180782339877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400219500008877879)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(400161176733877857)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400220178617877879)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(400181175691877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400220868867877879)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(400161176733877857)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400221616324877879)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(400181175691877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400222332610877881)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(400161176733877857)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400222986876877881)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(400181175691877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400223637394877881)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(400161176733877857)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400224370370877881)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(400181175691877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400225050257877881)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(400162400107877859)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400225815911877881)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(400181632422877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400226449983877881)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(400162400107877859)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400227160345877882)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(400181632422877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400227838980877882)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(400162400107877859)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400228616547877882)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(400181632422877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400229242050877882)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(400162400107877859)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400230012854877882)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(400181632422877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400230687681877882)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(400163147021877859)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400231414260877884)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(400182344461877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400232101187877884)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(400163147021877859)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400232792061877884)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(400182344461877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400233531881877884)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(400163147021877859)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400234156348877884)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(400182344461877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400234908221877884)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(400163147021877859)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400235624755877885)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(400182344461877864)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400236247491877885)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(400156811850877857)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400237017119877885)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(400159168215877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400237661559877885)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(400157572234877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400238425236877885)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(400157972292877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400239088074877885)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(400157192954877857)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400239815830877885)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(400158393202877857)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400240439202877887)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(400158739387877857)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400241158246877887)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(400158739387877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400241868273877887)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(400157192954877857)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400242605069877887)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(400157572234877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400243245885877887)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(400157972292877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400243987446877889)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(400158393202877857)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400244651924877889)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(400155572791877856)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400245342839877889)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(400155572791877856)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400246129781877889)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(400155572791877856)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400246749798877889)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(400159168215877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400247508558877889)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(400158739387877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400248225527877890)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(400156811850877857)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400248852027877890)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(400159585745877857)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400249545431877890)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(400159168215877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400250235396877890)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(400156811850877857)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400250977832877890)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(400159168215877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400251681395877890)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(400179597611877864)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400252381261877890)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(400178404717877864)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400253120402877892)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(400179222893877864)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400253809708877892)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(400177985548877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400254455886877892)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(400177985548877864)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400255159511877892)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(400178818808877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400255835229877892)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(400178404717877864)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400256594899877892)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(400160394135877857)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400257287485877892)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(400160818800877857)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400258018153877893)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(400162803520877859)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400258711126877893)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(400162803520877859)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400259389006877893)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(400161949612877859)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400259808789877893)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400260488078877893)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_api.id(400191200575877867)
,p_template_types=>'REPORT'
,p_help_text=>'This option will hide the pagination when all rows are displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400280327863877907)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT_SPLIT'
,p_display_name=>'Split'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(431291793299692896)
,p_css_classes=>'t-LoginPage--split'
,p_group_id=>wwv_flow_api.id(400169969776877860)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400281024552877907)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_1'
,p_display_name=>'Background 1'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(431291793299692896)
,p_css_classes=>'t-LoginPage--bg1'
,p_group_id=>wwv_flow_api.id(400169628153877860)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400281705366877907)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_2'
,p_display_name=>'Background 2'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(431291793299692896)
,p_css_classes=>'t-LoginPage--bg2'
,p_group_id=>wwv_flow_api.id(400169628153877860)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400282387239877907)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_3'
,p_display_name=>'Background 3'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_api.id(431291793299692896)
,p_css_classes=>'t-LoginPage--bg3'
,p_group_id=>wwv_flow_api.id(400169628153877860)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400381675741877951)
,p_theme_id=>42
,p_name=>'DISPLAY_POPUP_CALLOUT'
,p_display_name=>'Display Popup Callout'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-popup-callout'
,p_template_types=>'REGION'
,p_help_text=>'Use this option to add display a callout for the popup. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400382432824877951)
,p_theme_id=>42
,p_name=>'BEFORE'
,p_display_name=>'Before'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-popup-pos-before'
,p_group_id=>wwv_flow_api.id(400174419499877862)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout before or typically to the left of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400383091212877951)
,p_theme_id=>42
,p_name=>'AFTER'
,p_display_name=>'After'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-popup-pos-after'
,p_group_id=>wwv_flow_api.id(400174419499877862)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout after or typically to the right of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400383793701877951)
,p_theme_id=>42
,p_name=>'ABOVE'
,p_display_name=>'Above'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-popup-pos-above'
,p_group_id=>wwv_flow_api.id(400174419499877862)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout above or typically on top of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400384510752877953)
,p_theme_id=>42
,p_name=>'BELOW'
,p_display_name=>'Below'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-popup-pos-below'
,p_group_id=>wwv_flow_api.id(400174419499877862)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout below or typically to the bottom of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400385190436877953)
,p_theme_id=>42
,p_name=>'INSIDE'
,p_display_name=>'Inside'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-popup-pos-inside'
,p_group_id=>wwv_flow_api.id(400174419499877862)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout inside of the parent. This is useful when the parent is sufficiently large, such as a report or large region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400394588546877956)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303335633692904)
,p_css_classes=>'t-Login-region--headerIcon'
,p_group_id=>wwv_flow_api.id(400180370227877864)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Icon in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400395320953877956)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303335633692904)
,p_css_classes=>'t-Login-region--headerTitle'
,p_group_id=>wwv_flow_api.id(400180370227877864)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Title in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400396012347877956)
,p_theme_id=>42
,p_name=>'LOGO_HEADER_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431303335633692904)
,p_css_classes=>'t-Login-region--headerHidden'
,p_group_id=>wwv_flow_api.id(400180370227877864)
,p_template_types=>'REGION'
,p_help_text=>'Hides both the Region Icon and Title from the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400428016000877973)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(400427518569877971)
,p_css_classes=>'t-CardsRegion--styleA'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400428364772877973)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(400427518569877971)
,p_css_classes=>'t-CardsRegion--styleB'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400428791746877974)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Style C'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(400427518569877971)
,p_css_classes=>'t-CardsRegion--styleC'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400429136981877974)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(400427518569877971)
,p_css_classes=>'u-colors'
,p_template_types=>'REGION'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400462619472877992)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(431319479392692913)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400464507794877992)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431322267856692915)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400465822391877993)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431320031741692913)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400467078018877993)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_css_classes=>'js-navCollapsed--hidden'
,p_group_id=>wwv_flow_api.id(400164788772877859)
,p_template_types=>'LIST'
,p_help_text=>'Completely hide the navigation menu when it is collapsed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400467470066877995)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400468151485877995)
,p_theme_id=>42
,p_name=>'ICON_DEFAULT'
,p_display_name=>'Icon (Default)'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_css_classes=>'js-navCollapsed--default'
,p_group_id=>wwv_flow_api.id(400164788772877859)
,p_template_types=>'LIST'
,p_help_text=>'Display icons when the navigation menu is collapsed for large screens.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400477251470877998)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(431323393039692915)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400485287980878003)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400485658808878004)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Displays a callout arrow that points to where the menu was activated from.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400486127564878004)
,p_theme_id=>42
,p_name=>'FULL_WIDTH'
,p_display_name=>'Full Width'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'t-MegaMenu--fullWidth'
,p_template_types=>'LIST'
,p_help_text=>'Stretches the menu to fill the width of the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400486531118878004)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'t-MegaMenu--layout2Cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400486899515878004)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'t-MegaMenu--layout3Cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400487325222878004)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'t-MegaMenu--layout4Cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400487685254878004)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'t-MegaMenu--layout5Cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400488115308878004)
,p_theme_id=>42
,p_name=>'CUSTOM'
,p_display_name=>'Custom'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'t-MegaMenu--layoutCustom'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400488488920878004)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(400484785010878003)
,p_css_classes=>'t-MegaMenu--layoutStacked'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400538446321878029)
,p_theme_id=>42
,p_name=>'ALIGNMENT_TOP'
,p_display_name=>'Top'
,p_display_sequence=>100
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--alignTop'
,p_group_id=>wwv_flow_api.id(400189198585877867)
,p_template_types=>'REPORT'
,p_help_text=>'Aligns the content to the top of the row. This is useful when you expect that yours rows will vary in height (e.g. some rows will have longer descriptions than others).'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400538909500878029)
,p_theme_id=>42
,p_name=>'ACTIONS_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--hideActions'
,p_group_id=>wwv_flow_api.id(400186360383877865)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Actions column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400539304797878029)
,p_theme_id=>42
,p_name=>'DESCRIPTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--hideDescription'
,p_group_id=>wwv_flow_api.id(400186757844877865)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Description from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400539716913878029)
,p_theme_id=>42
,p_name=>'ICON_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--hideIcon'
,p_group_id=>wwv_flow_api.id(400187537757877865)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Icon from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400540075404878031)
,p_theme_id=>42
,p_name=>'MISC_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--hideMisc'
,p_group_id=>wwv_flow_api.id(400187963415877865)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Misc column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400540434656878031)
,p_theme_id=>42
,p_name=>'SELECTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--hideSelection'
,p_group_id=>wwv_flow_api.id(400188354295877865)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Selection column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400540870673878031)
,p_theme_id=>42
,p_name=>'TITLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--hideTitle'
,p_group_id=>wwv_flow_api.id(400187204670877865)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Title from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(400541268811878031)
,p_theme_id=>42
,p_name=>'STYLE_COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(400537956849878029)
,p_css_classes=>'t-ContentRow--styleCompact'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
,p_help_text=>'This option reduces the padding and font sizes to present a compact display of the same information.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416789515980535262)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(431287365936692891)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416798605934535270)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(431288264953692894)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416809869734535273)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(431292095856692896)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416817178568535276)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(431289308115692894)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416820825050535276)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(431293152344692896)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416821250518535276)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(431293152344692896)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416829771085535279)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(431290065788692894)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416837072254535281)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(431291044044692896)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416840722069535282)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(431293485262692896)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416841194070535282)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(431293485262692896)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416843609877535287)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(400171551674877860)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416844400387535289)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(400171551674877860)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416854059651535292)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431299931787692902)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416859254991535293)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416876081334535300)
,p_theme_id=>42
,p_name=>'ICONS_PLUS_OR_MINUS'
,p_display_name=>'Plus or Minus'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--hideShowIconsMath'
,p_group_id=>wwv_flow_api.id(400174783018877862)
,p_template_types=>'REGION'
,p_help_text=>'Use the plus and minus icons for the expand and collapse button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416876726596535301)
,p_theme_id=>42
,p_name=>'CONRTOLS_POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--controlsPosEnd'
,p_group_id=>wwv_flow_api.id(400175218953877862)
,p_template_types=>'REGION'
,p_help_text=>'Position the expand / collapse button to the end of the region header.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416877187381535301)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416890494951535306)
,p_theme_id=>42
,p_name=>'ICONS_CIRCULAR'
,p_display_name=>'Circle'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431302834358692904)
,p_css_classes=>'t-HeroRegion--iconsCircle'
,p_group_id=>wwv_flow_api.id(400177594829877862)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a circle.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416891165232535306)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431302834358692904)
,p_css_classes=>'t-HeroRegion--iconsSquare'
,p_group_id=>wwv_flow_api.id(400177594829877862)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a square.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416891561423535306)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431302834358692904)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416892284956535306)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431302834358692904)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416892948833535306)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431302834358692904)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416893616802535306)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431302834358692904)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(400176353826877862)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416898515514535307)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416898931766535309)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416906854884535311)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416907541282535311)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416908233363535312)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416908916361535312)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416909626538535312)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416910328765535312)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416911034778535312)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416911766029535312)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416912470826535314)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416913174648535314)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416913804727535314)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416914522182535314)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416937744923535323)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431306791462692905)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416943078747535332)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(416942570914535326)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416943497881535332)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(416942570914535326)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(400182009993877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416943882642535332)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(416942570914535326)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(400182009993877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416944218910535332)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(416942570914535326)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(400182009993877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416944653105535332)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(416942570914535326)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(400173996265877862)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416945081204535332)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(416942570914535326)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(400173996265877862)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416945402889535332)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(416942570914535326)
,p_css_classes=>'t-ContentBlock--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416948184503535334)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416948503984535334)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(400175972638877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416949000408535334)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(400175972638877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416949337499535334)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_api.id(400175972638877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416949753180535334)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416950201291535334)
,p_theme_id=>42
,p_name=>'REMOVE_PAGE_OVERLAY'
,p_display_name=>'Remove Page Overlay'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-popup-noOverlay'
,p_template_types=>'REGION'
,p_help_text=>'This option will display the inline dialog without an overlay on the background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416950535647535334)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(416947199455535332)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(400175972638877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416951569441535337)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416952214659535337)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416952997507535337)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416963301407535342)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(400166797025877860)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416963644101535342)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416964320516535342)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416965086487535342)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416965746160535343)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(400163539685877859)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416966477258535343)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(400163539685877859)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416967190754535343)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(400166797025877860)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416984991266535354)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(400166797025877860)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416985681558535356)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(400166797025877860)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416986072626535356)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416986784411535356)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(400168746400877860)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416994903453535359)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431322267856692915)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416996285918535361)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416996933045535361)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_css_classes=>'t-TreeNav--styleA'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation A'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416997619795535361)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_css_classes=>'t-TreeNav--styleB'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation B'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(416998326685535361)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Classic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_css_classes=>'t-TreeNav--classic'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
,p_help_text=>'Classic Style'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417007144589535364)
,p_theme_id=>42
,p_name=>'WIZARD_PROGRESS_LINKS'
,p_display_name=>'Make Wizard Steps Clickable'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(431321012657692915)
,p_css_classes=>'js-wizardProgressLinks'
,p_template_types=>'LIST'
,p_help_text=>'This option will make the wizard steps clickable links.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417007573742535364)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431321012657692915)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417010770242535367)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(417010230432535365)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_api.id(400168388525877860)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417011130425535367)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(417010230432535365)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_api.id(400168388525877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417011601075535367)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(417010230432535365)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_api.id(400165575766877859)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417011914502535367)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(417010230432535365)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_api.id(400165575766877859)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417012333646535367)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(417010230432535365)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_api.id(400165575766877859)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417013681175535370)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417014372519535370)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417015069798535370)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417025333979535375)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(400190012388877867)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417026072629535375)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417026429907535375)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417027104347535375)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(400184747112877865)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417027891283535375)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(400184747112877865)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417028565658535375)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(400190012388877867)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417042187432535381)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431311838671692908)
,p_css_classes=>'t-Comments--iconsRounded'
,p_group_id=>wwv_flow_api.id(400190012388877867)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417042896186535381)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431311838671692908)
,p_css_classes=>'t-Comments--iconsSquare'
,p_group_id=>wwv_flow_api.id(400190012388877867)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417062868538535390)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417063236796535390)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417063661505535390)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417064069115535390)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417064419928535390)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417064823044535390)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(400190012388877867)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417065297448535390)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(400190012388877867)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417065625273535390)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(400192345756877867)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417066045714535390)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417066412458535390)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417066853979535390)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417067211821535390)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417067690347535392)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_api.id(417062334523535389)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417070410333535401)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(431324364298692916)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(400155937569877857)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417071188510535401)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(431324364298692916)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(400155937569877857)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417073140736535403)
,p_theme_id=>42
,p_name=>'HIDE_LABEL_ON_MOBILE'
,p_display_name=>'Hide Label on Mobile'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(431324582442692918)
,p_css_classes=>'t-Button--mobileHideLabel'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button label on small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417073838776535403)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(431324582442692918)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(400155937569877857)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(417074574526535403)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(431324582442692918)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(400155937569877857)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431294056119692897)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431294321824692899)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(400171187968877860)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431294485077692899)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(400171947782877860)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431294607872692899)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(400171187968877860)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431294822059692899)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(400170818061877860)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431294920274692899)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(400171947782877860)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431295049893692899)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(400171187968877860)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431295137531692899)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(400171947782877860)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431295209322692899)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(400171947782877860)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431295286230692899)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431293904857692897)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(400170818061877860)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431295859341692901)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431295958319692901)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296092322692901)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296167899692901)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296427657692901)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(400183967248877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296531161692901)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(400183967248877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296636221692901)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(400183967248877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296657807692901)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(400183967248877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296807840692901)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431296893709692901)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431297071030692901)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431297213431692901)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431297259221692901)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431297407856692901)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431297539047692901)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431297699521692901)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(400172401159877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431297833508692901)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(400172401159877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298008299692901)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(400173153383877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298166846692901)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(400176816906877862)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298409143692901)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298505002692901)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298560241692901)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(400176816906877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298677728692902)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(400173153383877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298822086692902)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431298893276692902)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431295496674692899)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431299321541692902)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(400175972638877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431299400012692902)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(400175972638877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431299496499692902)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(400175972638877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431299596051692902)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431299695976692902)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431299849900692902)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431299034528692902)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431300213928692902)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431299931787692902)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431300355049692902)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(431299931787692902)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(400173591020877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431300545906692902)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(431299931787692902)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431300623002692902)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(431299931787692902)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(400173591020877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301020564692902)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301105524692902)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301198456692904)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301299190692904)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301531419692904)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(400175581211877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301619257692904)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(400175581211877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301662901692904)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301840876692904)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431301950564692904)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302005758692904)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302092055692904)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302250616692904)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(400173153383877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302319442692904)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302391179692904)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302502276692904)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302617665692904)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(400173153383877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431302710571692904)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431300714336692902)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431303080246692904)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303034758692904)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431303244872692904)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303034758692904)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431303783937692904)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431303943998692904)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431303955652692904)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304123025692904)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(400172801216877862)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304242060692904)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304291544692904)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304394590692904)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304471467692904)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304594780692904)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304710777692904)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(400170348314877860)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304764154692904)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(400173153383877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304944287692904)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(400176816906877862)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431304995819692904)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431305082530692904)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431305219368692904)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431305287810692904)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(400176816906877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431305414154692904)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(400173153383877862)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431305497848692904)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431303538430692904)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(400182742451877864)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431305906463692905)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431305612695692904)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431306140158692905)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431305612695692904)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(400179977214877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431306290242692905)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431305612695692904)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(400183156261877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431306474520692905)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431305612695692904)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(400183549735877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431306626942692905)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431305612695692904)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(400183549735877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431306744534692905)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431305612695692904)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(400183156261877865)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431306924747692905)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431306791462692905)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431307110506692905)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431306791462692905)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(400182009993877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431307253432692905)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(431306791462692905)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(400182009993877864)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431307645810692905)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(431307263639692905)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(400177148986877862)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431307709574692905)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431307263639692905)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(400177148986877862)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431307792024692905)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(431307263639692905)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431308160894692907)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431308345770692907)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431308365769692907)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431308512753692907)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431308577466692907)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431308732289692907)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431308786176692907)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309000241692907)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(400185171351877865)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309072521692907)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(400185171351877865)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309263924692907)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(400185171351877865)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309421465692907)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309545587692907)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(400185171351877865)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309636392692907)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(431308034056692907)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(400185171351877865)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309796651692907)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431309909840692907)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431310042585692907)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431310210686692907)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431310367709692907)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431310537632692907)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431310570002692907)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431310830119692907)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(400185541984877865)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431310890967692907)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(400185541984877865)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431311005436692908)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(400185541984877865)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431311192770692908)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(400189567357877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431311259807692908)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(400189567357877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431311416529692908)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431311456391692908)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431311593440692908)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(400185541984877865)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431311661234692908)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(431309695842692907)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431312041464692908)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431311838671692908)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(400188810235877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431312120786692908)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431311838671692908)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(400188810235877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431312515601692908)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(400184412161877865)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431312703697692908)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(400191614746877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431312819894692908)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(400191614746877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431312876092692908)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(400191614746877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431313096483692908)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(400191959690877867)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431313253965692908)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(400191959690877867)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431313293636692908)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(400184412161877865)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431313448542692908)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431313524310692908)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431312312772692908)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(400191614746877867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431313849330692908)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431313950703692908)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314038981692910)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314125569692910)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314227081692910)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314295524692910)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314437553692910)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314458190692910)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(431313583536692908)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314710381692910)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314851367692910)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314865814692910)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431314978507692910)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431315114729692910)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(400190823303877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431315169309692910)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431315255692692910)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431315425641692910)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(431314574729692910)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(400190377501877867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431315652792692910)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(431315531248692910)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(400192781510877867)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431315886359692911)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(400164008933877859)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316126365692911)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316214222692911)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316265028692911)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316403591692911)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316518096692911)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316601491692911)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316720468692911)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316783037692911)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(400164008933877859)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431316944452692911)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(400164008933877859)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431317146272692911)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(400164008933877859)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431317168700692911)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431317271825692911)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(431315698956692910)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(400164008933877859)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431317500490692911)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431317585726692911)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431317674086692911)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431317905131692911)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431318059221692911)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431318208128692911)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431318314379692911)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431318472762692911)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(400164424697877859)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431318617639692911)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(400164424697877859)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431318663297692911)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(400164424697877859)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431318906189692911)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(400166343460877859)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319016427692913)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(400166343460877859)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319103294692913)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319169615692913)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319309847692913)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(400164424697877859)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319382716692913)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319590830692913)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(431319479392692913)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319678254692913)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431319479392692913)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431319924230692913)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431319479392692913)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431320228016692915)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(431320069227692913)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431320308963692915)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431320069227692913)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(400166343460877859)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431320372814692915)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431320069227692913)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(400166343460877859)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431320649872692915)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431320069227692913)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(400168746400877860)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431320727505692915)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431320069227692913)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431320795960692915)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431320069227692913)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431320944961692915)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(431320069227692913)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(400168746400877860)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431321162608692915)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431321012657692915)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(400167552637877860)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431321345289692915)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431321012657692915)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(400167552637877860)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431321422315692915)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431321012657692915)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(400167552637877860)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431321555051692915)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431321549638692915)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(400169222999877860)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431321727994692915)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431321549638692915)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431321813951692915)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431321549638692915)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431321893519692915)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431321549638692915)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431322110486692915)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431321549638692915)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(400166008098877859)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431322165888692915)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431321549638692915)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(400166008098877859)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431322512667692915)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431322614467692915)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431322695498692915)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431322852687692915)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431322909679692915)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(400168034165877860)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431323045734692915)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431323116293692915)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431323240071692915)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(431322360820692915)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431323465473692916)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(431323393039692915)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431323567445692916)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(431323393039692915)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431323848477692916)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(431323393039692915)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431324843012692918)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(431324582442692918)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(400156427151877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(431324889233692918)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(431324582442692918)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(400156427151877857)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/globalization/language
begin
wwv_flow_api.create_language_map(
 p_id=>wwv_flow_api.id(401428407422215587)
,p_translation_flow_id=>128
,p_translation_flow_language_cd=>'en'
,p_direction_right_to_left=>'N'
);
end;
/
prompt --application/shared_components/globalization/translations
begin
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384320908841765838)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390924036061899987.128)
,p_translate_from_id=>wwv_flow_api.id(390924036061899987)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
,p_translate_from_text=>'pita_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384321103317765846)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390923895506899985.128)
,p_translate_from_id=>wwv_flow_api.id(390923895506899985)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.harmonize_sql_name(''PRE_ID'');'
,p_translate_from_text=>'pita_ui.harmonize_sql_name(''PRE_ID'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384321221374765849)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390924036061899987.128)
,p_translate_from_id=>wwv_flow_api.id(390924036061899987)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P10_PAR_ID'
,p_translate_from_text=>'P10_PAR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384321469328765849)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390923895506899985.128)
,p_translate_from_id=>wwv_flow_api.id(390923895506899985)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PRE_ID'
,p_translate_from_text=>'PRE_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384321688700765850)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390924036061899987.128)
,p_translate_from_id=>wwv_flow_api.id(390924036061899987)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P10_PAR_ID'
,p_translate_from_text=>'P10_PAR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384321805912765850)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390923895506899985.128)
,p_translate_from_id=>wwv_flow_api.id(390923895506899985)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PRE_ID'
,p_translate_from_text=>'PRE_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384322090797765854)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390924036061899987.128)
,p_translate_from_id=>wwv_flow_api.id(390924036061899987)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384322237211765854)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390923895506899985.128)
,p_translate_from_id=>wwv_flow_api.id(390923895506899985)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384322435420765855)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390924036061899987.128)
,p_translate_from_id=>wwv_flow_api.id(390924036061899987)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(384322686470765855)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390923895506899985.128)
,p_translate_from_id=>wwv_flow_api.id(390923895506899985)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401428524282220190)
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
 p_id=>wwv_flow_api.id(401428597772220190)
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
 p_id=>wwv_flow_api.id(401428816748220192)
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
 p_id=>wwv_flow_api.id(401428971239220192)
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
 p_id=>wwv_flow_api.id(401429226531220192)
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
 p_id=>wwv_flow_api.id(401429351364220192)
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
 p_id=>wwv_flow_api.id(401429584741220192)
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
 p_id=>wwv_flow_api.id(401429742525220192)
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
 p_id=>wwv_flow_api.id(401429986134220192)
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
 p_id=>wwv_flow_api.id(401430170900220192)
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
 p_id=>wwv_flow_api.id(401430344607220192)
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
 p_id=>wwv_flow_api.id(401430615550220192)
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
 p_id=>wwv_flow_api.id(401430753042220192)
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
 p_id=>wwv_flow_api.id(401431027573220192)
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
 p_id=>wwv_flow_api.id(401431186228220195)
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
 p_id=>wwv_flow_api.id(401431416941220195)
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
 p_id=>wwv_flow_api.id(401431551260220195)
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
 p_id=>wwv_flow_api.id(401431829893220195)
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
 p_id=>wwv_flow_api.id(401432008232220195)
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
 p_id=>wwv_flow_api.id(401432151173220195)
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
 p_id=>wwv_flow_api.id(401432404692220195)
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
 p_id=>wwv_flow_api.id(401432632859220195)
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
 p_id=>wwv_flow_api.id(401432827994220195)
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
 p_id=>wwv_flow_api.id(401432935403220195)
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
 p_id=>wwv_flow_api.id(401433157116220195)
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
 p_id=>wwv_flow_api.id(401433380654220195)
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
 p_id=>wwv_flow_api.id(401433595017220195)
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
 p_id=>wwv_flow_api.id(401433740478220195)
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
 p_id=>wwv_flow_api.id(401433984829220204)
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
 p_id=>wwv_flow_api.id(401434159455220204)
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
 p_id=>wwv_flow_api.id(401434359617220204)
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
 p_id=>wwv_flow_api.id(401434563815220204)
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
 p_id=>wwv_flow_api.id(401434785775220204)
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
 p_id=>wwv_flow_api.id(401435005503220204)
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
 p_id=>wwv_flow_api.id(401435139754220204)
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
 p_id=>wwv_flow_api.id(401435344324220204)
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
 p_id=>wwv_flow_api.id(401435551891220204)
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
 p_id=>wwv_flow_api.id(401435770243220204)
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
 p_id=>wwv_flow_api.id(401435974545220204)
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
 p_id=>wwv_flow_api.id(401436145618220206)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193320973787926.128)
,p_translate_from_id=>wwv_flow_api.id(433193320973787926)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401436346287220206)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061008217950535.128)
,p_translate_from_id=>wwv_flow_api.id(433061008217950535)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Context'
,p_translate_from_text=>'Kontext erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401436559665220207)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421146095479322077.128)
,p_translate_from_id=>wwv_flow_api.id(421146095479322077)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung laden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401436817840220207)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431338430278905885.128)
,p_translate_from_id=>wwv_flow_api.id(431338430278905885)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401436998122220207)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193144902787926.128)
,p_translate_from_id=>wwv_flow_api.id(433193144902787926)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Context'
,p_translate_from_text=>'Kontext erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401437194518220207)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433219782099228461.128)
,p_translate_from_id=>wwv_flow_api.id(433219782099228461)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401437350374220207)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143892802322055.128)
,p_translate_from_id=>wwv_flow_api.id(421143892802322055)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export translatable item'
,p_translate_from_text=>'Begriffe exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401437578996220207)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964085483844931.128)
,p_translate_from_id=>wwv_flow_api.id(402964085483844931)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich setzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401437812676220207)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142324714322039.128)
,p_translate_from_id=>wwv_flow_api.id(421142324714322039)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create toggle'
,p_translate_from_text=>'Toggle erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401437944505220207)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815930437186178.128)
,p_translate_from_id=>wwv_flow_api.id(420815930437186178)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401438228301220207)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433219754026228461.128)
,p_translate_from_id=>wwv_flow_api.id(433219754026228461)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401438418025220207)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403006533595402779.128)
,p_translate_from_id=>wwv_flow_api.id(403006533595402779)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401438539887220207)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433072373347176783.128)
,p_translate_from_id=>wwv_flow_api.id(433072373347176783)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401438792527220207)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431339023024905885.128)
,p_translate_from_id=>wwv_flow_api.id(431339023024905885)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401438957167220207)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267933196093715.128)
,p_translate_from_id=>wwv_flow_api.id(433267933196093715)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export Parameter groups'
,p_translate_from_text=>'Parametergruppen exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401439174001220207)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330527315692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330527315692940)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Log In'
,p_translate_from_text=>'Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401439372238220207)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431353447409906030.128)
,p_translate_from_id=>wwv_flow_api.id(431353447409906030)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create message'
,p_translate_from_text=>'Meldung erzeugen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401439576989220207)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433072158438176783.128)
,p_translate_from_id=>wwv_flow_api.id(433072158438176783)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401439813510220207)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431338281485905885.128)
,p_translate_from_id=>wwv_flow_api.id(431338281485905885)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create message'
,p_translate_from_text=>'Meldug erzeugen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401439982238220207)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433266911053093705.128)
,p_translate_from_id=>wwv_flow_api.id(433266911053093705)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export Messages'
,p_translate_from_text=>'Meldungen exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401440222585220207)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421144580959322062.128)
,p_translate_from_id=>wwv_flow_api.id(421144580959322062)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>unistr('Schlie\00DFen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401440352174220207)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403004527185402774.128)
,p_translate_from_id=>wwv_flow_api.id(403004527185402774)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401440552026220209)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426382213326548694.128)
,p_translate_from_id=>wwv_flow_api.id(426382213326548694)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help with Oracle error mappings'
,p_translate_from_text=>'Hilfe zu Oracle-Fehlermappings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401440774113220209)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893723303544261.128)
,p_translate_from_id=>wwv_flow_api.id(432893723303544261)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>unistr('\00C4nderungen anwenden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401441021220220209)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426380706005548679.128)
,p_translate_from_id=>wwv_flow_api.id(426380706005548679)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'Hilfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401441135298220209)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193236116787926.128)
,p_translate_from_id=>wwv_flow_api.id(433193236116787926)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Save'
,p_translate_from_text=>'Speichern'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401441338714220209)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142947009322046.128)
,p_translate_from_id=>wwv_flow_api.id(421142947009322046)
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
 p_id=>wwv_flow_api.id(401441630932220209)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381066698548682.128)
,p_translate_from_id=>wwv_flow_api.id(426381066698548682)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'Hilfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401441807657220209)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815717220186175.128)
,p_translate_from_id=>wwv_flow_api.id(420815717220186175)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401442005818220209)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433062081280950546.128)
,p_translate_from_id=>wwv_flow_api.id(433062081280950546)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401442144049220209)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142662843322043.128)
,p_translate_from_id=>wwv_flow_api.id(421142662843322043)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export local parameters'
,p_translate_from_text=>'Lokale Parameter exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401442424337220209)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058148110950506.128)
,p_translate_from_id=>wwv_flow_api.id(433058148110950506)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameter Group'
,p_translate_from_text=>'Parametergruppen verwalten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401442573391220209)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145994508322076.128)
,p_translate_from_id=>wwv_flow_api.id(421145994508322076)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung laden')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401442823753220209)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143944746322056.128)
,p_translate_from_id=>wwv_flow_api.id(421143944746322056)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Translate translatable item'
,p_translate_from_text=>unistr('Begriffe \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401443027333220209)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421144260384322059.128)
,p_translate_from_id=>wwv_flow_api.id(421144260384322059)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401443148413220209)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893761088544261.128)
,p_translate_from_id=>wwv_flow_api.id(432893761088544261)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete'
,p_translate_from_text=>unistr('L\00F6schen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401443408084220209)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893635625544261.128)
,p_translate_from_id=>wwv_flow_api.id(432893635625544261)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create'
,p_translate_from_text=>'Erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401443595204220209)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061086693950536.128)
,p_translate_from_id=>wwv_flow_api.id(433061086693950536)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create toggle'
,p_translate_from_text=>'Toggle erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401443818383220209)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381372232548685.128)
,p_translate_from_id=>wwv_flow_api.id(426381372232548685)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Help'
,p_translate_from_text=>'HIlfe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401444023708220209)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193784158787927.128)
,p_translate_from_id=>wwv_flow_api.id(433193784158787927)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401444171581220209)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072273739409130.128)
,p_translate_from_id=>wwv_flow_api.id(430072273739409130)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401444417902220210)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431338468012905885.128)
,p_translate_from_id=>wwv_flow_api.id(431338468012905885)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Delete message'
,p_translate_from_text=>'Meldung entfernen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401444603047220210)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432913439495544405.128)
,p_translate_from_id=>wwv_flow_api.id(432913439495544405)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Parameter'
,p_translate_from_text=>'Parameter erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401444804191220210)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432894350900544261.128)
,p_translate_from_id=>wwv_flow_api.id(432894350900544261)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401445024574220212)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897043773544366.128)
,p_translate_from_id=>wwv_flow_api.id(432897043773544366)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401445159246220212)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426379692152548669.128)
,p_translate_from_id=>wwv_flow_api.id(426379692152548669)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'editierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401445396513220212)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433221926412228463.128)
,p_translate_from_id=>wwv_flow_api.id(433221926412228463)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401445549171220212)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143598405322052.128)
,p_translate_from_id=>wwv_flow_api.id(421143598405322052)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401445811911220212)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897313418544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897313418544368)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401445993909220212)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196244126787930.128)
,p_translate_from_id=>wwv_flow_api.id(433196244126787930)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Rowid'
,p_translate_from_text=>'Rowid'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401446228996220212)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059225926950517.128)
,p_translate_from_id=>wwv_flow_api.id(433059225926950517)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Gather timing'
,p_translate_from_text=>'Zeitinformation erfassen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401446392045220214)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060646796950531.128)
,p_translate_from_id=>wwv_flow_api.id(433060646796950531)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Allow Toggles'
,p_translate_from_text=>'Toggles verwenden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401446548562220214)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330444487692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330444487692940)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Password'
,p_translate_from_text=>'Passwort'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401446807251220214)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002054250402765.128)
,p_translate_from_id=>wwv_flow_api.id(403002054250402765)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Id'
,p_translate_from_text=>'Par Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401446970834220214)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964264212844933.128)
,p_translate_from_id=>wwv_flow_api.id(402964264212844933)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actual realm'
,p_translate_from_text=>unistr('aktueller G\00FCltigkeitsbereich')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401447192201220214)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433222671153228465.128)
,p_translate_from_id=>wwv_flow_api.id(433222671153228465)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'assigned context'
,p_translate_from_text=>'zugeordneter Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401447365601220214)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433266778918093704.128)
,p_translate_from_id=>wwv_flow_api.id(433266778918093704)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401447609546220214)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898058022544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898058022544371)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text value'
,p_translate_from_text=>'Textwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401447736890220214)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814766403186166.128)
,p_translate_from_id=>wwv_flow_api.id(420814766403186166)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'XML value'
,p_translate_from_text=>'XML-Wert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401447961904220214)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898533190544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898533190544371)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer value'
,p_translate_from_text=>'Ganzzahlwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401448212227220214)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899705811544372.128)
,p_translate_from_id=>wwv_flow_api.id(432899705811544372)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp value'
,p_translate_from_text=>'Zeitstempelwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401448374947220214)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432900484935544372.128)
,p_translate_from_id=>wwv_flow_api.id(432900484935544372)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Boolean value'
,p_translate_from_text=>'Wahrheitswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401448557060220214)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342812008905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342812008905996)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message'
,p_translate_from_text=>'Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401448822268220214)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059069333950516.128)
,p_translate_from_id=>wwv_flow_api.id(433059069333950516)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Trace-Level'
,p_translate_from_text=>'Trace-Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401449011161220214)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058983413950515.128)
,p_translate_from_id=>wwv_flow_api.id(433058983413950515)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Debug-Level'
,p_translate_from_text=>'Debug-Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401449146029220214)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143685660322053.128)
,p_translate_from_id=>wwv_flow_api.id(421143685660322053)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Hint pti'
,p_translate_from_text=>'Hint pti'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401449340159220214)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901353794544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901353794544374)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text type'
,p_translate_from_text=>'Texttyp'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401449599942220214)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330306190692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330306190692940)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Username'
,p_translate_from_text=>'Benutzer'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401449757724220214)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342419757905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342419757905996)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401450003868220214)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431343234303905996.128)
,p_translate_from_id=>wwv_flow_api.id(431343234303905996)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity'
,p_translate_from_text=>'Schweregrad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401450216263220215)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431343606594905997.128)
,p_translate_from_id=>wwv_flow_api.id(431343606594905997)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error number'
,p_translate_from_text=>'Fehlernummer'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401450344023220215)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901693743544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901693743544374)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Validation expression'
,p_translate_from_text=>'Validierungsausdruck'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401450596844220215)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432902074799544374.128)
,p_translate_from_id=>wwv_flow_api.id(432902074799544374)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error message'
,p_translate_from_text=>'Fehlermeldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401450755261220215)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433222344696228465.128)
,p_translate_from_id=>wwv_flow_api.id(433222344696228465)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Package list'
,p_translate_from_text=>'Liste der Packages'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401450937460220215)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223123856228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223123856228465)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401451186854220215)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795708500235092.128)
,p_translate_from_id=>wwv_flow_api.id(423795708500235092)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401451391636220215)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433057813016950503.128)
,p_translate_from_id=>wwv_flow_api.id(433057813016950503)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parmetergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401451588743220215)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197453839787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197453839787949)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401451734302220215)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002874745402769.128)
,p_translate_from_id=>wwv_flow_api.id(403002874745402769)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401451943576220215)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142886081322045.128)
,p_translate_from_id=>wwv_flow_api.id(421142886081322045)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401452225797220215)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426663939651921934.128)
,p_translate_from_id=>wwv_flow_api.id(426663939651921934)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Group'
,p_translate_from_text=>'Gruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401452432964220217)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432900927045544374.128)
,p_translate_from_id=>wwv_flow_api.id(432900927045544374)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'prohibit editing'
,p_translate_from_text=>'editieren untersagen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401452556546220217)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898856050544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898856050544371)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number value'
,p_translate_from_text=>unistr('Flie\00DFkommazahlwert')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401452827183220217)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899299402544371.128)
,p_translate_from_id=>wwv_flow_api.id(432899299402544371)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date value'
,p_translate_from_text=>'Datumswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401452937425220217)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059313109950518.128)
,p_translate_from_id=>wwv_flow_api.id(433059313109950518)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output modules'
,p_translate_from_text=>'Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401453189004220217)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267824135093714.128)
,p_translate_from_id=>wwv_flow_api.id(433267824135093714)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401453424190220217)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143810051322054.128)
,p_translate_from_id=>wwv_flow_api.id(421143810051322054)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401453626608220217)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426664005939921935.128)
,p_translate_from_id=>wwv_flow_api.id(426664005939921935)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401453795321220217)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342137413905993.128)
,p_translate_from_id=>wwv_flow_api.id(431342137413905993)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401453948640220217)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423796151380235097.128)
,p_translate_from_id=>wwv_flow_api.id(423796151380235097)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401454176588220217)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196650038787947.128)
,p_translate_from_id=>wwv_flow_api.id(433196650038787947)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401454341619220217)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002422465402768.128)
,p_translate_from_id=>wwv_flow_api.id(403002422465402768)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Pgr Id'
,p_translate_from_text=>'Par Pgr Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401454622967220217)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897677145544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897677145544368)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Besschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401454833625220217)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143075520322047.128)
,p_translate_from_id=>wwv_flow_api.id(421143075520322047)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Hint pms'
,p_translate_from_text=>'Hint pms'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401455008214220217)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145876598322075.128)
,p_translate_from_id=>wwv_flow_api.id(421145876598322075)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Import XLIFF file'
,p_translate_from_text=>'XLIFF-Datei importieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401455229930220217)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421146147798322078.128)
,p_translate_from_id=>wwv_flow_api.id(421146147798322078)
,p_translate_column_id=>14
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Import XLIFF file'
,p_translate_from_text=>'XLIFF-Datei importieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401455416873220220)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815370848186172.128)
,p_translate_from_id=>wwv_flow_api.id(420815370848186172)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401455557321220220)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964111260844932.128)
,p_translate_from_id=>wwv_flow_api.id(402964111260844932)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401455756259220220)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423796027064235095.128)
,p_translate_from_id=>wwv_flow_api.id(423796027064235095)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401456004393220220)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812851308186147.128)
,p_translate_from_id=>wwv_flow_api.id(420812851308186147)
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
 p_id=>wwv_flow_api.id(401456173536220220)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142162887322038.128)
,p_translate_from_id=>wwv_flow_api.id(421142162887322038)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401456428957220220)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142557723322042.128)
,p_translate_from_id=>wwv_flow_api.id(421142557723322042)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401456539933220220)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814661581186165.128)
,p_translate_from_id=>wwv_flow_api.id(420814661581186165)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401456772189220220)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421144052048322057.128)
,p_translate_from_id=>wwv_flow_api.id(421144052048322057)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401456946956220220)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408894121810137182.128)
,p_translate_from_id=>wwv_flow_api.id(408894121810137182)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'FOO'
,p_translate_from_text=>'FOO'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401457200760220220)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815470913186173.128)
,p_translate_from_id=>wwv_flow_api.id(420815470913186173)
,p_translate_column_id=>16
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Foo'
,p_translate_from_text=>'Foo'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401457411090220221)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426662772240921923.128)
,p_translate_from_id=>wwv_flow_api.id(426662772240921923)
,p_translate_column_id=>17
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error while saving the message:<br>#SQLERRM#'
,p_translate_from_text=>'Fehler beim Speichern der Meldung:<br>#SQLERRM#'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401457595319220224)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426662772240921923.128)
,p_translate_from_id=>wwv_flow_api.id(426662772240921923)
,p_translate_column_id=>18
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message was saved.'
,p_translate_from_text=>'Meldung wurde gespeichert.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401457800764220224)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432904529637544377.128)
,p_translate_from_id=>wwv_flow_api.id(432904529637544377)
,p_translate_column_id=>18
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Action processed.'
,p_translate_from_text=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401457946273220228)
,p_page_id=>1
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431331540459692943.128)
,p_translate_from_id=>wwv_flow_api.id(431331540459692943)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumbs'
,p_translate_from_text=>'Breadcrumbs'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401458162892220228)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431354923895906035.128)
,p_translate_from_id=>wwv_flow_api.id(431354923895906035)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Breadcrumb'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401458382644220228)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893211152544258.128)
,p_translate_from_id=>wwv_flow_api.id(432893211152544258)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit parameter'
,p_translate_from_text=>'Parameter bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401458617263220228)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432915488348544408.128)
,p_translate_from_id=>wwv_flow_api.id(432915488348544408)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401458805684220228)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431338567145905885.128)
,p_translate_from_id=>wwv_flow_api.id(431338567145905885)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401458966742220228)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812984682186148.128)
,p_translate_from_id=>wwv_flow_api.id(420812984682186148)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'List of parameters'
,p_translate_from_text=>'Liste der Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401459219403220228)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060046623950525.128)
,p_translate_from_id=>wwv_flow_api.id(433060046623950525)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Available Toggles'
,p_translate_from_text=>unistr('Verf\00FCgbare Toggles')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401459387719220229)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059861001950524.128)
,p_translate_from_id=>wwv_flow_api.id(433059861001950524)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Information about the debugging filter'
,p_translate_from_text=>'Informationen zum Filter des Debuggings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401459633198220229)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193405243787926.128)
,p_translate_from_id=>wwv_flow_api.id(433193405243787926)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401459802915220229)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143331630322050.128)
,p_translate_from_id=>wwv_flow_api.id(421143331630322050)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'right column'
,p_translate_from_text=>'rechte Spalte'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401460009212220229)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058758905950513.128)
,p_translate_from_id=>wwv_flow_api.id(433058758905950513)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Hints for Output Modules'
,p_translate_from_text=>'Hinweise zu Ausgabemodulen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401460190883220229)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433186123208608485.128)
,p_translate_from_id=>wwv_flow_api.id(433186123208608485)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Available Contexts'
,p_translate_from_text=>unistr('Verf\00FCgbare Kontexte')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401460365209220229)
,p_page_id=>1
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431333869135817605.128)
,p_translate_from_id=>wwv_flow_api.id(431333869135817605)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Application areas'
,p_translate_from_text=>'Anwendungsbereiche'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401460565334220229)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403004152844402774.128)
,p_translate_from_id=>wwv_flow_api.id(403004152844402774)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401460809761220229)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426382146445548693.128)
,p_translate_from_id=>wwv_flow_api.id(426382146445548693)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Help with Oracle error mappings'
,p_translate_from_text=>'HIlfe zu Oracle-Fehlermappings'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401461007572220229)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421144212955322058.128)
,p_translate_from_id=>wwv_flow_api.id(421144212955322058)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401461179858220229)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433094878523254249.128)
,p_translate_from_id=>wwv_flow_api.id(433094878523254249)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Installed Output modules'
,p_translate_from_text=>'Installierte Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401461347420220229)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893911301544261.128)
,p_translate_from_id=>wwv_flow_api.id(432893911301544261)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401461536239220229)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433220053343228461.128)
,p_translate_from_id=>wwv_flow_api.id(433220053343228461)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>unistr('Schaltfl\00E4chen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401461801520220229)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812781242186146.128)
,p_translate_from_id=>wwv_flow_api.id(420812781242186146)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401461977486220229)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330162041692936.128)
,p_translate_from_id=>wwv_flow_api.id(431330162041692936)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Log In'
,p_translate_from_text=>'Log In'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401462223025220229)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408821436659434007.128)
,p_translate_from_id=>wwv_flow_api.id(408821436659434007)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Deviating parameter values for realms'
,p_translate_from_text=>unistr('Abweichende Parameterwerte f\00FCr G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401462403152220229)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433068584315176774.128)
,p_translate_from_id=>wwv_flow_api.id(433068584315176774)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit parameter group'
,p_translate_from_text=>'Parametergruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401462624369220229)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381658519548688.128)
,p_translate_from_id=>wwv_flow_api.id(426381658519548688)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Current debug settings'
,p_translate_from_text=>'Aktuelle Debugeinstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401462745929220229)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267227389093708.128)
,p_translate_from_id=>wwv_flow_api.id(433267227389093708)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Create, edit and translate messages'
,p_translate_from_text=>unistr('Meldungen exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401463028208220229)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432914874737544408.128)
,p_translate_from_id=>wwv_flow_api.id(432914874737544408)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401463140335220229)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433083885068250183.128)
,p_translate_from_id=>wwv_flow_api.id(433083885068250183)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401463396262220229)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421300097501072797.128)
,p_translate_from_id=>wwv_flow_api.id(421300097501072797)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit message group'
,p_translate_from_text=>'Meldungsgruppe bearbeiten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401463608502220231)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403001754687402761.128)
,p_translate_from_id=>wwv_flow_api.id(403001754687402761)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Create Form'
,p_translate_from_text=>'Create Form'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401463747796220231)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058884168950514.128)
,p_translate_from_id=>wwv_flow_api.id(433058884168950514)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Hints for Contexts'
,p_translate_from_text=>'Hinweise zu Kontexten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401463975111220231)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143233200322049.128)
,p_translate_from_id=>wwv_flow_api.id(421143233200322049)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'left column'
,p_translate_from_text=>'linke Spalte'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401464179876220231)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143506323322051.128)
,p_translate_from_id=>wwv_flow_api.id(421143506323322051)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Export and translate translatable items'
,p_translate_from_text=>unistr('Begriffe exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401464403427220231)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431348786442906022.128)
,p_translate_from_id=>wwv_flow_api.id(431348786442906022)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Messages'
,p_translate_from_text=>'Meldungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401464537879220231)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431337879134905885.128)
,p_translate_from_id=>wwv_flow_api.id(431337879134905885)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Meldung editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401464824355220231)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059819659950523.128)
,p_translate_from_id=>wwv_flow_api.id(433059819659950523)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Filter Debugging by Package (Toggles)'
,p_translate_from_text=>'Debugging nach Package filtern (Toggles)'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401464975224220231)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815601858186174.128)
,p_translate_from_id=>wwv_flow_api.id(420815601858186174)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401465189488220231)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267288610093709.128)
,p_translate_from_id=>wwv_flow_api.id(433267288610093709)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Export Parameters'
,p_translate_from_text=>'Parameter exportieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401465381941220231)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433245661086602661.128)
,p_translate_from_id=>wwv_flow_api.id(433245661086602661)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Breadcrumb'
,p_translate_from_text=>'Navigationspfad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401465543017220231)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433192735610787926.128)
,p_translate_from_id=>wwv_flow_api.id(433192735610787926)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Context'
,p_translate_from_text=>'Kontext administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401465768022220231)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421060315223881200.128)
,p_translate_from_id=>wwv_flow_api.id(421060315223881200)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Output Module'
,p_translate_from_text=>'Ausgabemodul administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401466029644220231)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433219300723228461.128)
,p_translate_from_id=>wwv_flow_api.id(433219300723228461)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Administer Context Toggle'
,p_translate_from_text=>'Kontext-Toggle administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401466224705220234)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060046623950525.128)
,p_translate_from_id=>wwv_flow_api.id(433060046623950525)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, par_id, par_pgr_id, toggle_module_list, toggle_context_name',
'  from PITA_UI_admin_pit_toggle'))
,p_translate_from_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, par_id, par_pgr_id, toggle_module_list, toggle_context_name',
'  from PITA_UI_admin_pit_toggle'))
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401466416171220234)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059861001950524.128)
,p_translate_from_id=>wwv_flow_api.id(433059861001950524)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401466590905220234)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058758905950513.128)
,p_translate_from_id=>wwv_flow_api.id(433058758905950513)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401466795640220234)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426382146445548693.128)
,p_translate_from_id=>wwv_flow_api.id(426382146445548693)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401466993083220234)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381658519548688.128)
,p_translate_from_id=>wwv_flow_api.id(426381658519548688)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'return pita_ui.get_active_context; '
,p_translate_from_text=>'return pita_ui.get_active_context; '
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401467168206220234)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058884168950514.128)
,p_translate_from_id=>wwv_flow_api.id(433058884168950514)
,p_translate_column_id=>21
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
,p_translate_from_text=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401467417402220245)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431329852480692929.128)
,p_translate_from_id=>wwv_flow_api.id(431329852480692929)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Log Out'
,p_translate_from_text=>'Log Out'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401467555995220245)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433238060990522093.128)
,p_translate_from_id=>wwv_flow_api.id(433238060990522093)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Master Data'
,p_translate_from_text=>'Stammdaten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401467790295220245)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432130745735798488.128)
,p_translate_from_id=>wwv_flow_api.id(432130745735798488)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameters'
,p_translate_from_text=>'Parameter administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401467955873220245)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431331065395692941.128)
,p_translate_from_id=>wwv_flow_api.id(431331065395692941)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Home'
,p_translate_from_text=>'Startseite'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401468226978220245)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433083430158250180.128)
,p_translate_from_id=>wwv_flow_api.id(433083430158250180)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401468387835220245)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431347843229906004.128)
,p_translate_from_id=>wwv_flow_api.id(431347843229906004)
,p_translate_column_id=>28
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401468569827220259)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433094878523254249.128)
,p_translate_from_id=>wwv_flow_api.id(433094878523254249)
,p_translate_column_id=>36
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No data found'
,p_translate_from_text=>'Keine Daten gefunden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401468816393220259)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433186123208608485.128)
,p_translate_from_id=>wwv_flow_api.id(433186123208608485)
,p_translate_column_id=>36
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'No data found'
,p_translate_from_text=>'Keine Daten gefunden'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401468980527220307)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>63
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Search Dialog'
,p_translate_from_text=>'Search Dialog'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401469088411220314)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>66
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_translate_from_text=>'<div class="t-PopupLOV-actions t-Form--large">'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401469281042220315)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>67
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'</div>'
,p_translate_from_text=>'</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401469510618220321)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>70
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-links">'
,p_translate_from_text=>'<div class="t-PopupLOV-links">'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401469694367220323)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>71
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'</div>'
,p_translate_from_text=>'</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401469873648220324)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
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
 p_id=>wwv_flow_api.id(401470065463220326)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>73
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Close'
,p_translate_from_text=>'Close'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401470260612220328)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>74
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Next &gt;'
,p_translate_from_text=>'Next &gt;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401470518697220331)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>75
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&lt; Previous'
,p_translate_from_text=>'&lt; Previous'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401470647129220337)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431340430814905886.128)
,p_translate_from_id=>wwv_flow_api.id(431340430814905886)
,p_translate_column_id=>79
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Please confirm that the data should be deleted.'
,p_translate_from_text=>unistr('Bitte best\00E4tigen Sie, dass die Daten gel\00F6scht werden sollen.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401470906946220373)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431331388604692943.128)
,p_translate_from_id=>wwv_flow_api.id(431331388604692943)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Home'
,p_translate_from_text=>'Startseite'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401470973154220373)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431354691488906033.128)
,p_translate_from_id=>wwv_flow_api.id(431354691488906033)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Messages'
,p_translate_from_text=>'Meldungen administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401471220864220373)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433084261799250185.128)
,p_translate_from_id=>wwv_flow_api.id(433084261799250185)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer PIT'
,p_translate_from_text=>'PIT administrieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401471358392220373)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433246120370602661.128)
,p_translate_from_id=>wwv_flow_api.id(433246120370602661)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Export and translate master data'
,p_translate_from_text=>unistr('Stammdaten exportieren und \00FCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401471582479220373)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432914661013544405.128)
,p_translate_from_id=>wwv_flow_api.id(432914661013544405)
,p_translate_column_id=>100
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Parameter Group'
,p_translate_from_text=>'Parameter verwalten'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401471795578220379)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(411687789976998150.128)
,p_translate_from_id=>wwv_flow_api.id(411687789976998150)
,p_translate_column_id=>103
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Edit message'
,p_translate_from_text=>'Editieren sperren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401471934374220382)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433222671153228465.128)
,p_translate_from_id=>wwv_flow_api.id(433222671153228465)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select context'
,p_translate_from_text=>unistr('- Kontext w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401472178914220382)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901353794544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901353794544374)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401472378984220382)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342419757905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342419757905996)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select laguage'
,p_translate_from_text=>unistr('- Sprache w\00E4hlen -')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401472580835220382)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795708500235092.128)
,p_translate_from_id=>wwv_flow_api.id(423795708500235092)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401472798200220384)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433057813016950503.128)
,p_translate_from_id=>wwv_flow_api.id(433057813016950503)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>'- Alle'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401473017865220384)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002874745402769.128)
,p_translate_from_id=>wwv_flow_api.id(403002874745402769)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401473156316220384)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142886081322045.128)
,p_translate_from_id=>wwv_flow_api.id(421142886081322045)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select target language'
,p_translate_from_text=>unistr('- Zielsprache w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401473362526220384)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426663939651921934.128)
,p_translate_from_id=>wwv_flow_api.id(426663939651921934)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401473538622220384)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143810051322054.128)
,p_translate_from_id=>wwv_flow_api.id(421143810051322054)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- Select target language'
,p_translate_from_text=>unistr('- Zielsprache w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401473743976220384)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426664005939921935.128)
,p_translate_from_id=>wwv_flow_api.id(426664005939921935)
,p_translate_column_id=>105
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select optionally'
,p_translate_from_text=>unistr('- optional w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401473954962220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060426478950529.128)
,p_translate_from_id=>wwv_flow_api.id(433060426478950529)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Package list'
,p_translate_from_text=>'Liste der Packages'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401474142039220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433187893927608490.128)
,p_translate_from_id=>wwv_flow_api.id(433187893927608490)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Settings'
,p_translate_from_text=>'Einstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401474358391220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058419770950509.128)
,p_translate_from_id=>wwv_flow_api.id(433058419770950509)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'active'
,p_translate_from_text=>'aktiv'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401474617180220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430071744253409125.128)
,p_translate_from_id=>wwv_flow_api.id(430071744253409125)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message'
,p_translate_from_text=>'Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401474745693220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433187466454608490.128)
,p_translate_from_id=>wwv_flow_api.id(433187466454608490)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401474943369220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059369831950519.128)
,p_translate_from_id=>wwv_flow_api.id(433059369831950519)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401475159175220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381906518548691.128)
,p_translate_from_id=>wwv_flow_api.id(426381906518548691)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Gather timing'
,p_translate_from_text=>'Zeitinformationen erfassen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401475371483220385)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381693324548689.128)
,p_translate_from_id=>wwv_flow_api.id(426381693324548689)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Debug Level'
,p_translate_from_text=>'Debug Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401475595176220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381794829548690.128)
,p_translate_from_id=>wwv_flow_api.id(426381794829548690)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Trace Level'
,p_translate_from_text=>'Trace Level'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401475766867220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058345689950508.128)
,p_translate_from_id=>wwv_flow_api.id(433058345689950508)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'available'
,p_translate_from_text=>unistr('verf\00FCgbar')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401475953569220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058507960950510.128)
,p_translate_from_id=>wwv_flow_api.id(433058507960950510)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401476204258220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058180211950507.128)
,p_translate_from_id=>wwv_flow_api.id(433058180211950507)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output module'
,p_translate_from_text=>'Ausgabemodul'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401476414229220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433187102831608490.128)
,p_translate_from_id=>wwv_flow_api.id(433187102831608490)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401476558475220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060186815950527.128)
,p_translate_from_id=>wwv_flow_api.id(433060186815950527)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Toggle name'
,p_translate_from_text=>'Toggle-Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401476797018220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426381984129548692.128)
,p_translate_from_id=>wwv_flow_api.id(426381984129548692)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Output modules'
,p_translate_from_text=>'Ausgabemodule'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401476996871220387)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060526906950530.128)
,p_translate_from_id=>wwv_flow_api.id(433060526906950530)
,p_translate_column_id=>106
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Context'
,p_translate_from_text=>'Kontext'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401477170498220389)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060152851950526.128)
,p_translate_from_id=>wwv_flow_api.id(433060152851950526)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401477349255220389)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059369831950519.128)
,p_translate_from_id=>wwv_flow_api.id(433059369831950519)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401477550906220389)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058507960950510.128)
,p_translate_from_id=>wwv_flow_api.id(433058507960950510)
,p_translate_column_id=>107
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401477819575220392)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058345689950508.128)
,p_translate_from_id=>wwv_flow_api.id(433058345689950508)
,p_translate_column_id=>108
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa #MODULE_AVAILABLE#"/>'
,p_translate_from_text=>'<i class="fa #MODULE_AVAILABLE#"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401477961529220392)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058419770950509.128)
,p_translate_from_id=>wwv_flow_api.id(433058419770950509)
,p_translate_column_id=>108
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa #MODULE_ACTIVE#"/>'
,p_translate_from_text=>'<i class="fa #MODULE_ACTIVE#"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401478138818220396)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897043773544366.128)
,p_translate_from_id=>wwv_flow_api.id(432897043773544366)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Enter a unique identifier for this parameter set. The name must conform to Oracle naming conventions and must not contain special characters.'
,p_translate_from_text=>unistr('Geben Sie einen eindeutigen Bezeichner f\00FCr diese Parametergruppe ein. Der Name muss den Oracle-Benennungskonventionen entsprechen und darf keine Sonderzeichen enthalten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401478347074220396)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897313418544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897313418544368)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the parameter group to which this parameter should belong.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Parametergruppe, zu der dieser Parameter geh\00F6ren soll.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401478616300220396)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059225926950517.128)
,p_translate_from_id=>wwv_flow_api.id(433059225926950517)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Should time information be collected?'
,p_translate_from_text=>'Sollen Zeitinformationen gesammelt werden?'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401478757733220396)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342812008905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342812008905996)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message text.<br>Replacement of parameters #1# to #50# according to number value.<br>Passed parameters are numbered positionally and distributed to the replacement marks.'
,p_translate_from_text=>unistr('Meldungstext.<br>Ersetzung der Parameter #1# bis #50# gem\00E4\00DF Zahlwert.<br>\00DCbergebene Parameter werden positional nummeriert und auf die Ersetzungsmarken verteilt.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401478964593220396)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059069333950516.128)
,p_translate_from_id=>wwv_flow_api.id(433059069333950516)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Maximum trace level allowed by this context.'
,p_translate_from_text=>'Maximaler Tracelevel, der durch diesen Kontext erlaubt wird.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401479147759220396)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058983413950515.128)
,p_translate_from_id=>wwv_flow_api.id(433058983413950515)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Maximum severity allowed by this context.<br>If an output module has a lower response threshold, messages may not be output even though the threshold specified here has been undershot.'
,p_translate_from_text=>'Maximaler Schweregrad, der durch diesen Kontext erlaubt wird.<br>Sollte ein Ausgabemodule eine niedrigere Ansprechschwelle haben, kann es sein, dass Meldungen nicht ausgegeben werden, obwohl der hier angegebene Schwellwert unterschritten wurde.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401479368145220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901353794544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901353794544374)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'This attribute allows you to specify what type of text should be saved as a text parameter. This controls which editor is offered to you for editing.'
,p_translate_from_text=>unistr('Mit diesem Attribut k\00F6nnen Sie festlegen, welche Art Text als Textparameter gespeichert werden soll. Dies kontrolliert, welcher Editor Ihnen zur Bearbeitung angeboten wird.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401479578024220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342419757905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342419757905996)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message language'
,p_translate_from_text=>'Sprache der Meldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401479767323220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431343234303905996.128)
,p_translate_from_id=>wwv_flow_api.id(431343234303905996)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity of the error message'
,p_translate_from_text=>'Schweregrad der Fehlermeldung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401479975990220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431343606594905997.128)
,p_translate_from_id=>wwv_flow_api.id(431343606594905997)
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
 p_id=>wwv_flow_api.id(401480152217220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901693743544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901693743544374)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<p>The validation string is used to check the parameter value.</p><p>The following text anchors are available to reference the parameter value:<ul><li>#STRING#</li><li>#DATE#</li><li>#FLOAT#</li><li>#INTEGER#</li><li>#BOOLEAN#</li></ul></p>'
,p_translate_from_text=>unistr('<p>Der Validierungsstring wird genutzt, um den Parameterwert zu pr\00FCfen.</p><p>Es stehen folgende Textanker zur Verf\00FCgung, um den Parameterwert zu referenzieren:<ul><li>#STRING#</li><li>#DATE#</li><li>#FLOAT#</li><li>#INTEGER#</li><li>#BOOLEAN#</li></')
||'ul></p>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401480371331220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197453839787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197453839787949)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Optional description of the scope of the context'
,p_translate_from_text=>'Optionale Beschreibung des Einsatzbereichs des Kontexts'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401480547030220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002874745402769.128)
,p_translate_from_id=>wwv_flow_api.id(403002874745402769)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Set the realm for the current environment. This has a direct effect on the parameter values if deviating parameter values have been agreed for this realm.'
,p_translate_from_text=>unistr('Setzen Sie den G\00FCltigkeitsbereich f\00FCr die aktuelle Umgebung. Dies hat direkte Auswirkungen auf die Parameterwerte, falls f\00FCr diesen G\00FCltigkeitsbereich abweichende Parameterwerte vereinbart wurden.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401480797381220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142886081322045.128)
,p_translate_from_id=>wwv_flow_api.id(421142886081322045)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the target language into which you want to translate the messages.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401481010285220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432900927045544374.128)
,p_translate_from_id=>wwv_flow_api.id(432900927045544374)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'If the group allows editing, this can be suppressed for individual parameters.'
,p_translate_from_text=>unistr('Falls die Gruppe das Editieren erlaubt, kann dies f\00FCr einzelne Parameter unterdr\00FCckt werden.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401481145050220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143810051322054.128)
,p_translate_from_id=>wwv_flow_api.id(421143810051322054)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Select the target language into which you want to translate the messages.'
,p_translate_from_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401481395815220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059313109950518.128)
,p_translate_from_id=>wwv_flow_api.id(433059313109950518)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'List of output modules that should output log information.'
,p_translate_from_text=>'Liste der Ausgabemodule, die Log-Informationen ausgeben sollen.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401481624833220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267824135093714.128)
,p_translate_from_id=>wwv_flow_api.id(433267824135093714)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Move all parameter groups you want to export to the right column.'
,p_translate_from_text=>unistr('Bewegen Sie alle Parametergruppen, die Sie exportieren m\00F6chten, in die rechte Spalte.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401481769043220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423796151380235097.128)
,p_translate_from_id=>wwv_flow_api.id(423796151380235097)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Optional Description.<br>Can be used to give additional instructions to the user in case of an error.'
,p_translate_from_text=>unistr('Optionale Beschreibung.<br>Kann verwendet werden, um im Fehlerfall zus\00E4tzliche Handlungsanweisungen an den Anwender zu geben.')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401482011663220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342137413905993.128)
,p_translate_from_id=>wwv_flow_api.id(431342137413905993)
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
 p_id=>wwv_flow_api.id(401482185475220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196650038787947.128)
,p_translate_from_id=>wwv_flow_api.id(433196650038787947)
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
 p_id=>wwv_flow_api.id(401482421103220398)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897677145544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897677145544368)
,p_translate_column_id=>111
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Enter an optional description of the parameter.'
,p_translate_from_text=>'Geben Sie eine optionale Beschreibung des Parameters ein.'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401482571643220401)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431325216279692919.128)
,p_translate_from_id=>wwv_flow_api.id(431325216279692919)
,p_translate_column_id=>112
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_translate_from_text=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401482776230220599)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(468053867472164091.128)
,p_translate_from_id=>wwv_flow_api.id(468053867472164091)
,p_translate_column_id=>237
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CodeMirror'
,p_translate_from_text=>'CodeMirror'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401482871736220601)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(468053867472164091.128)
,p_translate_from_id=>wwv_flow_api.id(468053867472164091)
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
 p_id=>wwv_flow_api.id(401483091611220646)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897043773544366.128)
,p_translate_from_id=>wwv_flow_api.id(432897043773544366)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401483240486220646)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426379692152548669.128)
,p_translate_from_id=>wwv_flow_api.id(426379692152548669)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401483482214220646)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197028039787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197028039787949)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401483647881220646)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433221926412228463.128)
,p_translate_from_id=>wwv_flow_api.id(433221926412228463)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401483898829220646)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143598405322052.128)
,p_translate_from_id=>wwv_flow_api.id(421143598405322052)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401484043684220646)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897313418544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897313418544368)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401484316080220646)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196244126787930.128)
,p_translate_from_id=>wwv_flow_api.id(433196244126787930)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401484444937220646)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059225926950517.128)
,p_translate_from_id=>wwv_flow_api.id(433059225926950517)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401484722031220646)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060646796950531.128)
,p_translate_from_id=>wwv_flow_api.id(433060646796950531)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401484866920220646)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330444487692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330444487692940)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401485051135220648)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002054250402765.128)
,p_translate_from_id=>wwv_flow_api.id(403002054250402765)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401485293884220648)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964264212844933.128)
,p_translate_from_id=>wwv_flow_api.id(402964264212844933)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401485496650220648)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433222671153228465.128)
,p_translate_from_id=>wwv_flow_api.id(433222671153228465)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401485666549220648)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433266778918093704.128)
,p_translate_from_id=>wwv_flow_api.id(433266778918093704)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401485904676220648)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898058022544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898058022544371)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401486111926220648)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814766403186166.128)
,p_translate_from_id=>wwv_flow_api.id(420814766403186166)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401486237772220648)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432900484935544372.128)
,p_translate_from_id=>wwv_flow_api.id(432900484935544372)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401486521724220648)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342812008905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342812008905996)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401486677392220648)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059069333950516.128)
,p_translate_from_id=>wwv_flow_api.id(433059069333950516)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401486920942220648)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058983413950515.128)
,p_translate_from_id=>wwv_flow_api.id(433058983413950515)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401487121090220648)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143685660322053.128)
,p_translate_from_id=>wwv_flow_api.id(421143685660322053)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401487248320220648)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901353794544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901353794544374)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401487453205220648)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330306190692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330306190692940)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401487660478220648)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342419757905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342419757905996)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401487877816220648)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431343234303905996.128)
,p_translate_from_id=>wwv_flow_api.id(431343234303905996)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401488055050220648)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901693743544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901693743544374)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401488298264220648)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432902074799544374.128)
,p_translate_from_id=>wwv_flow_api.id(432902074799544374)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401488531975220648)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058633744950511.128)
,p_translate_from_id=>wwv_flow_api.id(433058633744950511)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401488644509220648)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433222344696228465.128)
,p_translate_from_id=>wwv_flow_api.id(433222344696228465)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401488841632220648)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223123856228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223123856228465)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401489069696220648)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795708500235092.128)
,p_translate_from_id=>wwv_flow_api.id(423795708500235092)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401489307894220648)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433057813016950503.128)
,p_translate_from_id=>wwv_flow_api.id(433057813016950503)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401489437068220648)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197453839787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197453839787949)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401489674839220649)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197813461787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197813461787949)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401489870455220649)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061567282950541.128)
,p_translate_from_id=>wwv_flow_api.id(433061567282950541)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401490121442220649)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002874745402769.128)
,p_translate_from_id=>wwv_flow_api.id(403002874745402769)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401490317846220649)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142886081322045.128)
,p_translate_from_id=>wwv_flow_api.id(421142886081322045)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401490524950220649)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426663939651921934.128)
,p_translate_from_id=>wwv_flow_api.id(426663939651921934)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401490658589220649)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432900927045544374.128)
,p_translate_from_id=>wwv_flow_api.id(432900927045544374)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'1'
,p_translate_from_text=>'1'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401490866575220649)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431341739867905976.128)
,p_translate_from_id=>wwv_flow_api.id(431341739867905976)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401491105715220649)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059313109950518.128)
,p_translate_from_id=>wwv_flow_api.id(433059313109950518)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'ALL'
,p_translate_from_text=>'ALL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401491329949220649)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267824135093714.128)
,p_translate_from_id=>wwv_flow_api.id(433267824135093714)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'MOVE'
,p_translate_from_text=>'MOVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401491514516220649)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143810051322054.128)
,p_translate_from_id=>wwv_flow_api.id(421143810051322054)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401491664102220649)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426664005939921935.128)
,p_translate_from_id=>wwv_flow_api.id(426664005939921935)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401491868930220649)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342137413905993.128)
,p_translate_from_id=>wwv_flow_api.id(431342137413905993)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401492038059220649)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423796151380235097.128)
,p_translate_from_id=>wwv_flow_api.id(423796151380235097)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401492309520220649)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196650038787947.128)
,p_translate_from_id=>wwv_flow_api.id(433196650038787947)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401492481888220649)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002422465402768.128)
,p_translate_from_id=>wwv_flow_api.id(403002422465402768)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401492733002220649)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897677145544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897677145544368)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401492887317220649)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143075520322047.128)
,p_translate_from_id=>wwv_flow_api.id(421143075520322047)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401493071330220649)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145876598322075.128)
,p_translate_from_id=>wwv_flow_api.id(421145876598322075)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APEX_APPLICATION_TEMP_FILES'
,p_translate_from_text=>'APEX_APPLICATION_TEMP_FILES'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401493285259220649)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421146147798322078.128)
,p_translate_from_id=>wwv_flow_api.id(421146147798322078)
,p_translate_column_id=>268
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APEX_APPLICATION_TEMP_FILES'
,p_translate_from_text=>'APEX_APPLICATION_TEMP_FILES'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401493490785220653)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897043773544366.128)
,p_translate_from_id=>wwv_flow_api.id(432897043773544366)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401493699951220653)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433221926412228463.128)
,p_translate_from_id=>wwv_flow_api.id(433221926412228463)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401493916894220653)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897313418544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897313418544368)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401494066824220653)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964264212844933.128)
,p_translate_from_id=>wwv_flow_api.id(402964264212844933)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401494270017220653)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433222671153228465.128)
,p_translate_from_id=>wwv_flow_api.id(433222671153228465)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401494502579220653)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898058022544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898058022544371)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401494704691220653)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814766403186166.128)
,p_translate_from_id=>wwv_flow_api.id(420814766403186166)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401494908185220653)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342812008905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342812008905996)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401495115696220653)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059069333950516.128)
,p_translate_from_id=>wwv_flow_api.id(433059069333950516)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401495292224220653)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433058983413950515.128)
,p_translate_from_id=>wwv_flow_api.id(433058983413950515)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401495516183220653)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143685660322053.128)
,p_translate_from_id=>wwv_flow_api.id(421143685660322053)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401495664256220654)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901353794544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901353794544374)
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
 p_id=>wwv_flow_api.id(401495842202220654)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330306190692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330306190692940)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401496068134220654)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342419757905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342419757905996)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401496244404220654)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431343234303905996.128)
,p_translate_from_id=>wwv_flow_api.id(431343234303905996)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401496479619220654)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901693743544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901693743544374)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401496669318220654)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432902074799544374.128)
,p_translate_from_id=>wwv_flow_api.id(432902074799544374)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401496835974220654)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223123856228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223123856228465)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401497108976220654)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795708500235092.128)
,p_translate_from_id=>wwv_flow_api.id(423795708500235092)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401497253576220654)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433057813016950503.128)
,p_translate_from_id=>wwv_flow_api.id(433057813016950503)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401497490150220654)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197453839787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197453839787949)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401497642260220654)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403002874745402769.128)
,p_translate_from_id=>wwv_flow_api.id(403002874745402769)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401497886463220654)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142886081322045.128)
,p_translate_from_id=>wwv_flow_api.id(421142886081322045)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401498045532220654)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426663939651921934.128)
,p_translate_from_id=>wwv_flow_api.id(426663939651921934)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401498263016220654)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143810051322054.128)
,p_translate_from_id=>wwv_flow_api.id(421143810051322054)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401498465210220654)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426664005939921935.128)
,p_translate_from_id=>wwv_flow_api.id(426664005939921935)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401498711864220654)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342137413905993.128)
,p_translate_from_id=>wwv_flow_api.id(431342137413905993)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401498868183220654)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423796151380235097.128)
,p_translate_from_id=>wwv_flow_api.id(423796151380235097)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401499104238220654)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196650038787947.128)
,p_translate_from_id=>wwv_flow_api.id(433196650038787947)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401499261898220654)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897677145544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897677145544368)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401499484303220654)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143075520322047.128)
,p_translate_from_id=>wwv_flow_api.id(421143075520322047)
,p_translate_column_id=>269
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401499660241220657)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898058022544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898058022544371)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401499924230220657)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814766403186166.128)
,p_translate_from_id=>wwv_flow_api.id(420814766403186166)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401500115102220657)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898533190544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898533190544371)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401500259922220657)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342812008905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342812008905996)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401500460523220657)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431343606594905997.128)
,p_translate_from_id=>wwv_flow_api.id(431343606594905997)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401500708188220659)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197453839787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197453839787949)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401500898211220659)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898856050544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898856050544371)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401501093537220659)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423796151380235097.128)
,p_translate_from_id=>wwv_flow_api.id(423796151380235097)
,p_translate_column_id=>270
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401501326592220660)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897043773544366.128)
,p_translate_from_id=>wwv_flow_api.id(432897043773544366)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401501507447220660)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433221926412228463.128)
,p_translate_from_id=>wwv_flow_api.id(433221926412228463)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401501646903220660)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964264212844933.128)
,p_translate_from_id=>wwv_flow_api.id(402964264212844933)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401501867673220660)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432898058022544371.128)
,p_translate_from_id=>wwv_flow_api.id(432898058022544371)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401502036327220660)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814766403186166.128)
,p_translate_from_id=>wwv_flow_api.id(420814766403186166)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401502252371220660)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899705811544372.128)
,p_translate_from_id=>wwv_flow_api.id(432899705811544372)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401502436348220660)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342812008905996.128)
,p_translate_from_id=>wwv_flow_api.id(431342812008905996)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401502730812220660)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143685660322053.128)
,p_translate_from_id=>wwv_flow_api.id(421143685660322053)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401502876157220660)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330306190692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330306190692940)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401503132432220660)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901693743544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901693743544374)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401503293810220660)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432902074799544374.128)
,p_translate_from_id=>wwv_flow_api.id(432902074799544374)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401503488145220660)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223123856228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223123856228465)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401503651322220662)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433197453839787949.128)
,p_translate_from_id=>wwv_flow_api.id(433197453839787949)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401503933903220662)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899299402544371.128)
,p_translate_from_id=>wwv_flow_api.id(432899299402544371)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401504065688220662)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342137413905993.128)
,p_translate_from_id=>wwv_flow_api.id(431342137413905993)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401504246556220662)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423796151380235097.128)
,p_translate_from_id=>wwv_flow_api.id(423796151380235097)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401504457255220662)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196650038787947.128)
,p_translate_from_id=>wwv_flow_api.id(433196650038787947)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401504671807220662)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897677145544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897677145544368)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401504857179220662)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143075520322047.128)
,p_translate_from_id=>wwv_flow_api.id(421143075520322047)
,p_translate_column_id=>271
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401505116685220664)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897043773544366.128)
,p_translate_from_id=>wwv_flow_api.id(432897043773544366)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401505321444220665)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433221926412228463.128)
,p_translate_from_id=>wwv_flow_api.id(433221926412228463)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401505483973220665)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899705811544372.128)
,p_translate_from_id=>wwv_flow_api.id(432899705811544372)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401505648115220665)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330306190692940.128)
,p_translate_from_id=>wwv_flow_api.id(431330306190692940)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401505887463220665)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432901693743544374.128)
,p_translate_from_id=>wwv_flow_api.id(432901693743544374)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401506088393220665)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432902074799544374.128)
,p_translate_from_id=>wwv_flow_api.id(432902074799544374)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401506248683220665)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223123856228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223123856228465)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401506489762220665)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899299402544371.128)
,p_translate_from_id=>wwv_flow_api.id(432899299402544371)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401506718109220665)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431342137413905993.128)
,p_translate_from_id=>wwv_flow_api.id(431342137413905993)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401506884976220665)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433196650038787947.128)
,p_translate_from_id=>wwv_flow_api.id(433196650038787947)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401507059657220665)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432897677145544368.128)
,p_translate_from_id=>wwv_flow_api.id(432897677145544368)
,p_translate_column_id=>272
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401507320127220668)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899299402544371.128)
,p_translate_from_id=>wwv_flow_api.id(432899299402544371)
,p_translate_column_id=>274
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401507476029220668)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432899705811544372.128)
,p_translate_from_id=>wwv_flow_api.id(432899705811544372)
,p_translate_column_id=>274
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401507696796220673)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145876598322075.128)
,p_translate_from_id=>wwv_flow_api.id(421145876598322075)
,p_translate_column_id=>276
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'REQUEST'
,p_translate_from_text=>'REQUEST'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401507848876220673)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421146147798322078.128)
,p_translate_from_id=>wwv_flow_api.id(421146147798322078)
,p_translate_column_id=>276
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'REQUEST'
,p_translate_from_text=>'REQUEST'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401508074046220674)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145876598322075.128)
,p_translate_from_id=>wwv_flow_api.id(421145876598322075)
,p_translate_column_id=>277
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401508277422220674)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421146147798322078.128)
,p_translate_from_id=>wwv_flow_api.id(421146147798322078)
,p_translate_column_id=>277
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401508507009220678)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403007750819402780.128)
,p_translate_from_id=>wwv_flow_api.id(403007750819402780)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401508719033220678)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433200615814787954.128)
,p_translate_from_id=>wwv_flow_api.id(433200615814787954)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401508864155220678)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431346747004906001.128)
,p_translate_from_id=>wwv_flow_api.id(431346747004906001)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401509116182220678)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426662772240921923.128)
,p_translate_from_id=>wwv_flow_api.id(426662772240921923)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401509249806220678)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421067775009881230.128)
,p_translate_from_id=>wwv_flow_api.id(421067775009881230)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401509500980220678)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812245258186141.128)
,p_translate_from_id=>wwv_flow_api.id(420812245258186141)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401509666841220678)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059495735950520.128)
,p_translate_from_id=>wwv_flow_api.id(433059495735950520)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401509849075220678)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432904529637544377.128)
,p_translate_from_id=>wwv_flow_api.id(432904529637544377)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401510100723220678)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408822788551434020.128)
,p_translate_from_id=>wwv_flow_api.id(408822788551434020)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401510323623220678)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432904888004544377.128)
,p_translate_from_id=>wwv_flow_api.id(432904888004544377)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401510504974220678)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223472358228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223472358228465)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401510721712220678)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421304749694072807.128)
,p_translate_from_id=>wwv_flow_api.id(421304749694072807)
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
 p_id=>wwv_flow_api.id(401510877994220678)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330899551692941.128)
,p_translate_from_id=>wwv_flow_api.id(431330899551692941)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'CLEAR_CACHE_CURRENT_PAGE'
,p_translate_from_text=>'CLEAR_CACHE_CURRENT_PAGE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401511072596220684)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403007750819402780.128)
,p_translate_from_id=>wwv_flow_api.id(403007750819402780)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_set_realm;'
,p_translate_from_text=>'pita_ui.process_set_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401511236892220684)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426662772240921923.128)
,p_translate_from_id=>wwv_flow_api.id(426662772240921923)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_pms;'
,p_translate_from_text=>'pita_ui.process_edit_pms;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401511472685220684)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421067775009881230.128)
,p_translate_from_id=>wwv_flow_api.id(421067775009881230)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_module;'
,p_translate_from_text=>'pita_ui.process_edit_module;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401511687707220684)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812245258186141.128)
,p_translate_from_id=>wwv_flow_api.id(420812245258186141)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_pgr;'
,p_translate_from_text=>'pita_ui.process_edit_pgr;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401511884207220684)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059495735950520.128)
,p_translate_from_id=>wwv_flow_api.id(433059495735950520)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_context;'
,p_translate_from_text=>'pita_ui.process_edit_context;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401512126629220685)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432904529637544377.128)
,p_translate_from_id=>wwv_flow_api.id(432904529637544377)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_par;'
,p_translate_from_text=>'pita_ui.process_edit_par;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401512272359220685)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408822788551434020.128)
,p_translate_from_id=>wwv_flow_api.id(408822788551434020)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_par_realm;'
,p_translate_from_text=>'pita_ui.process_edit_par_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401512513618220685)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223472358228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223472358228465)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_toggle;'
,p_translate_from_text=>'pita_ui.process_edit_toggle;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401512685538220685)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421304749694072807.128)
,p_translate_from_id=>wwv_flow_api.id(421304749694072807)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_pmg;'
,p_translate_from_text=>'pita_ui.process_edit_pmg;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401512932197220687)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403007750819402780.128)
,p_translate_from_id=>wwv_flow_api.id(403007750819402780)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401513128136220687)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426662772240921923.128)
,p_translate_from_id=>wwv_flow_api.id(426662772240921923)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401513277463220687)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421067775009881230.128)
,p_translate_from_id=>wwv_flow_api.id(421067775009881230)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401513467687220687)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812245258186141.128)
,p_translate_from_id=>wwv_flow_api.id(420812245258186141)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401513676579220687)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059495735950520.128)
,p_translate_from_id=>wwv_flow_api.id(433059495735950520)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401513865943220687)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432904529637544377.128)
,p_translate_from_id=>wwv_flow_api.id(432904529637544377)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401514084938220687)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408822788551434020.128)
,p_translate_from_id=>wwv_flow_api.id(408822788551434020)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401514331869220687)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223472358228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223472358228465)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401514438731220687)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421304749694072807.128)
,p_translate_from_id=>wwv_flow_api.id(421304749694072807)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401514661530220690)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403007750819402780.128)
,p_translate_from_id=>wwv_flow_api.id(403007750819402780)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401514900890220690)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426662772240921923.128)
,p_translate_from_id=>wwv_flow_api.id(426662772240921923)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401515116910220690)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421067775009881230.128)
,p_translate_from_id=>wwv_flow_api.id(421067775009881230)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401515291416220690)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812245258186141.128)
,p_translate_from_id=>wwv_flow_api.id(420812245258186141)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401515460045220690)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059495735950520.128)
,p_translate_from_id=>wwv_flow_api.id(433059495735950520)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401515680671220690)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432904529637544377.128)
,p_translate_from_id=>wwv_flow_api.id(432904529637544377)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401515913143220690)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408822788551434020.128)
,p_translate_from_id=>wwv_flow_api.id(408822788551434020)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401516065509220690)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433223472358228465.128)
,p_translate_from_id=>wwv_flow_api.id(433223472358228465)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401516242212220690)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421304749694072807.128)
,p_translate_from_id=>wwv_flow_api.id(421304749694072807)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401516491362220699)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060756112950533.128)
,p_translate_from_id=>wwv_flow_api.id(433060756112950533)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401516650481220699)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433060894376950534.128)
,p_translate_from_id=>wwv_flow_api.id(433060894376950534)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401516887444220699)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815058552186169.128)
,p_translate_from_id=>wwv_flow_api.id(420815058552186169)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401517082894220699)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143193442322048.128)
,p_translate_from_id=>wwv_flow_api.id(421143193442322048)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'condes.pit.utils.controlExportItems();'
,p_translate_from_text=>'condes.pit.utils.controlExportItems();'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401517332808220699)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426664406471921939.128)
,p_translate_from_id=>wwv_flow_api.id(426664406471921939)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401517496403220699)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145288070322069.128)
,p_translate_from_id=>wwv_flow_api.id(421145288070322069)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.harmonize_sql_name(''PMG_NAME'');'
,p_translate_from_text=>'pita_ui.harmonize_sql_name(''PMG_NAME'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401517704835220699)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426664520351921940.128)
,p_translate_from_id=>wwv_flow_api.id(426664520351921940)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401517891061220699)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815282966186171.128)
,p_translate_from_id=>wwv_flow_api.id(420815282966186171)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'STATIC_ASSIGNMENT'
,p_translate_from_text=>'STATIC_ASSIGNMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401518114645220701)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795844989235094.128)
,p_translate_from_id=>wwv_flow_api.id(423795844989235094)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.harmonize_sql_name(''P3_PMS_NAME'');'
,p_translate_from_text=>'pita_ui.harmonize_sql_name(''P3_PMS_NAME'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401518322570220701)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145531892322072.128)
,p_translate_from_id=>wwv_flow_api.id(421145531892322072)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.harmonize_sql_name(''PGR_ID'');'
,p_translate_from_text=>'pita_ui.harmonize_sql_name(''PGR_ID'');'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401518461559220701)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061874535950544.128)
,p_translate_from_id=>wwv_flow_api.id(433061874535950544)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401518663460220701)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061983817950545.128)
,p_translate_from_id=>wwv_flow_api.id(433061983817950545)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401518908243220701)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964459792844935.128)
,p_translate_from_id=>wwv_flow_api.id(402964459792844935)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'SQL_STATEMENT'
,p_translate_from_text=>'SQL_STATEMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401519113342220701)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815140805186170.128)
,p_translate_from_id=>wwv_flow_api.id(420815140805186170)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'STATIC_ASSIGNMENT'
,p_translate_from_text=>'STATIC_ASSIGNMENT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401519294547220701)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061298277950538.128)
,p_translate_from_id=>wwv_flow_api.id(433061298277950538)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.set_allow_toggles;'
,p_translate_from_text=>'pita_ui.set_allow_toggles;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401519441385220701)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061362181950539.128)
,p_translate_from_id=>wwv_flow_api.id(433061362181950539)
,p_translate_column_id=>288
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.set_allow_toggles;'
,p_translate_from_text=>'pita_ui.set_allow_toggles;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401519666667220703)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145288070322069.128)
,p_translate_from_id=>wwv_flow_api.id(421145288070322069)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PMG_NAME'
,p_translate_from_text=>'PMG_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401519900907220703)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795844989235094.128)
,p_translate_from_id=>wwv_flow_api.id(423795844989235094)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P3_PMS_NAME'
,p_translate_from_text=>'P3_PMS_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401520121973220703)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145531892322072.128)
,p_translate_from_id=>wwv_flow_api.id(421145531892322072)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PGR_ID'
,p_translate_from_text=>'PGR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401520276721220703)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815140805186170.128)
,p_translate_from_id=>wwv_flow_api.id(420815140805186170)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'-20000'
,p_translate_from_text=>'-20000'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401520524712220703)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061298277950538.128)
,p_translate_from_id=>wwv_flow_api.id(433061298277950538)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P9_ALLOW_TOGGLE'
,p_translate_from_text=>'P9_ALLOW_TOGGLE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401520657686220703)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061362181950539.128)
,p_translate_from_id=>wwv_flow_api.id(433061362181950539)
,p_translate_column_id=>289
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P9_ALLOW_TOGGLE'
,p_translate_from_text=>'P9_ALLOW_TOGGLE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401520851685220706)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145288070322069.128)
,p_translate_from_id=>wwv_flow_api.id(421145288070322069)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PMG_NAME'
,p_translate_from_text=>'PMG_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401521095348220706)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795844989235094.128)
,p_translate_from_id=>wwv_flow_api.id(423795844989235094)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'P3_PMS_NAME'
,p_translate_from_text=>'P3_PMS_NAME'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401521324149220706)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145531892322072.128)
,p_translate_from_id=>wwv_flow_api.id(421145531892322072)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PGR_ID'
,p_translate_from_text=>'PGR_ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401521463863220706)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964459792844935.128)
,p_translate_from_id=>wwv_flow_api.id(402964459792844935)
,p_translate_column_id=>290
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from PITA_UI_admin_par_realm'))
,p_translate_from_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from PITA_UI_admin_par_realm'))
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401521715213220707)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145288070322069.128)
,p_translate_from_id=>wwv_flow_api.id(421145288070322069)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401521920314220707)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795844989235094.128)
,p_translate_from_id=>wwv_flow_api.id(423795844989235094)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401522070618220707)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145531892322072.128)
,p_translate_from_id=>wwv_flow_api.id(421145531892322072)
,p_translate_column_id=>291
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401522250824220710)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145288070322069.128)
,p_translate_from_id=>wwv_flow_api.id(421145288070322069)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401522440702220710)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423795844989235094.128)
,p_translate_from_id=>wwv_flow_api.id(423795844989235094)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401522686830220710)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145531892322072.128)
,p_translate_from_id=>wwv_flow_api.id(421145531892322072)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401522899409220710)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061298277950538.128)
,p_translate_from_id=>wwv_flow_api.id(433061298277950538)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401523107052220710)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433061362181950539.128)
,p_translate_from_id=>wwv_flow_api.id(433061362181950539)
,p_translate_column_id=>292
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL'
,p_translate_from_text=>'PLSQL'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401523250298220715)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964459792844935.128)
,p_translate_from_id=>wwv_flow_api.id(402964459792844935)
,p_translate_column_id=>295
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401523518713220717)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815140805186170.128)
,p_translate_from_id=>wwv_flow_api.id(420815140805186170)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401523717488220717)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815282966186171.128)
,p_translate_from_id=>wwv_flow_api.id(420815282966186171)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401523856574220718)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402964459792844935.128)
,p_translate_from_id=>wwv_flow_api.id(402964459792844935)
,p_translate_column_id=>296
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401524094221220721)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(416589890486498904.128)
,p_translate_from_id=>wwv_flow_api.id(416589890486498904)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401524295540220721)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431287007756692886.128)
,p_translate_from_id=>wwv_flow_api.id(431287007756692886)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401524489209220721)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431287153920692886.128)
,p_translate_from_id=>wwv_flow_api.id(431287153920692886)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401524695073220721)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423750770032968003.128)
,p_translate_from_id=>wwv_flow_api.id(423750770032968003)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'classic'
,p_translate_from_text=>'classic'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401524869088220721)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(423750727053968003.128)
,p_translate_from_id=>wwv_flow_api.id(423750727053968003)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'LEGACY'
,p_translate_from_text=>'LEGACY'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401525114031220723)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(400025570918861704.128)
,p_translate_from_id=>wwv_flow_api.id(400025570918861704)
,p_translate_column_id=>298
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'fa-star'
,p_translate_from_text=>'fa-star'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401525265969220723)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(400025041680861703.128)
,p_translate_from_id=>wwv_flow_api.id(400025041680861703)
,p_translate_column_id=>298
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
 p_id=>wwv_flow_api.id(401525496744220724)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(400025041680861703.128)
,p_translate_from_id=>wwv_flow_api.id(400025041680861703)
,p_translate_column_id=>299
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401525861537220726)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431287153920692886.128)
,p_translate_from_id=>wwv_flow_api.id(431287153920692886)
,p_translate_column_id=>300
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401526122557220728)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(400025570918861704.128)
,p_translate_from_id=>wwv_flow_api.id(400025570918861704)
,p_translate_column_id=>301
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'#VALUE#'
,p_translate_from_text=>'#VALUE#'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401526486728220731)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431287153920692886.128)
,p_translate_from_id=>wwv_flow_api.id(431287153920692886)
,p_translate_column_id=>302
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'SWITCH_CB'
,p_translate_from_text=>'SWITCH_CB'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401526638411220740)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893211152544258.128)
,p_translate_from_id=>wwv_flow_api.id(432893211152544258)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401526886689220740)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431338567145905885.128)
,p_translate_from_id=>wwv_flow_api.id(431338567145905885)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401527080684220740)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193405243787926.128)
,p_translate_from_id=>wwv_flow_api.id(433193405243787926)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401527273853220742)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143331630322050.128)
,p_translate_from_id=>wwv_flow_api.id(421143331630322050)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401527503724220742)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403004152844402774.128)
,p_translate_from_id=>wwv_flow_api.id(403004152844402774)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401527714619220742)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421144212955322058.128)
,p_translate_from_id=>wwv_flow_api.id(421144212955322058)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401527922578220742)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893911301544261.128)
,p_translate_from_id=>wwv_flow_api.id(432893911301544261)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401528039776220742)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433220053343228461.128)
,p_translate_from_id=>wwv_flow_api.id(433220053343228461)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401528301449220742)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812781242186146.128)
,p_translate_from_id=>wwv_flow_api.id(420812781242186146)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401528492178220742)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330162041692936.128)
,p_translate_from_id=>wwv_flow_api.id(431330162041692936)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401528716636220742)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267227389093708.128)
,p_translate_from_id=>wwv_flow_api.id(433267227389093708)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401528897258220742)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143233200322049.128)
,p_translate_from_id=>wwv_flow_api.id(421143233200322049)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401529062981220742)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143506323322051.128)
,p_translate_from_id=>wwv_flow_api.id(421143506323322051)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401529326271220742)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431337879134905885.128)
,p_translate_from_id=>wwv_flow_api.id(431337879134905885)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401529456651220742)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059819659950523.128)
,p_translate_from_id=>wwv_flow_api.id(433059819659950523)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401529640686220742)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815601858186174.128)
,p_translate_from_id=>wwv_flow_api.id(420815601858186174)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401529931263220742)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267288610093709.128)
,p_translate_from_id=>wwv_flow_api.id(433267288610093709)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401530075625220742)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433192735610787926.128)
,p_translate_from_id=>wwv_flow_api.id(433192735610787926)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401530282865220742)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433219300723228461.128)
,p_translate_from_id=>wwv_flow_api.id(433219300723228461)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401530436668220745)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893211152544258.128)
,p_translate_from_id=>wwv_flow_api.id(432893211152544258)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401530720403220745)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431338567145905885.128)
,p_translate_from_id=>wwv_flow_api.id(431338567145905885)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401530922378220745)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193405243787926.128)
,p_translate_from_id=>wwv_flow_api.id(433193405243787926)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401531117132220745)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143331630322050.128)
,p_translate_from_id=>wwv_flow_api.id(421143331630322050)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401531295682220745)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403004152844402774.128)
,p_translate_from_id=>wwv_flow_api.id(403004152844402774)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401531529723220745)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421144212955322058.128)
,p_translate_from_id=>wwv_flow_api.id(421144212955322058)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401531679523220745)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893911301544261.128)
,p_translate_from_id=>wwv_flow_api.id(432893911301544261)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401531931390220745)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433220053343228461.128)
,p_translate_from_id=>wwv_flow_api.id(433220053343228461)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401532117742220745)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812781242186146.128)
,p_translate_from_id=>wwv_flow_api.id(420812781242186146)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401532271101220745)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330162041692936.128)
,p_translate_from_id=>wwv_flow_api.id(431330162041692936)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401532509294220745)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267227389093708.128)
,p_translate_from_id=>wwv_flow_api.id(433267227389093708)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401532709901220745)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143233200322049.128)
,p_translate_from_id=>wwv_flow_api.id(421143233200322049)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401532853415220745)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421143506323322051.128)
,p_translate_from_id=>wwv_flow_api.id(421143506323322051)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401533126977220745)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431337879134905885.128)
,p_translate_from_id=>wwv_flow_api.id(431337879134905885)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401533296216220745)
,p_page_id=>9
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433059819659950523.128)
,p_translate_from_id=>wwv_flow_api.id(433059819659950523)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401533502066220746)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420815601858186174.128)
,p_translate_from_id=>wwv_flow_api.id(420815601858186174)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401533667499220746)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433267288610093709.128)
,p_translate_from_id=>wwv_flow_api.id(433267288610093709)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401533908955220746)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433192735610787926.128)
,p_translate_from_id=>wwv_flow_api.id(433192735610787926)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401534040274220746)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433219300723228461.128)
,p_translate_from_id=>wwv_flow_api.id(433219300723228461)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'TEXT'
,p_translate_from_text=>'TEXT'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401534250544220748)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893211152544258.128)
,p_translate_from_id=>wwv_flow_api.id(432893211152544258)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401534437622220748)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431338567145905885.128)
,p_translate_from_id=>wwv_flow_api.id(431338567145905885)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401534733657220748)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433193405243787926.128)
,p_translate_from_id=>wwv_flow_api.id(433193405243787926)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401534857550220748)
,p_page_id=>5
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(403004152844402774.128)
,p_translate_from_id=>wwv_flow_api.id(403004152844402774)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401535073970220748)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432893911301544261.128)
,p_translate_from_id=>wwv_flow_api.id(432893911301544261)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401535270059220748)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433220053343228461.128)
,p_translate_from_id=>wwv_flow_api.id(433220053343228461)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401535475133220748)
,p_page_id=>101
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431330162041692936.128)
,p_translate_from_id=>wwv_flow_api.id(431330162041692936)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401535693052220748)
,p_page_id=>3
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431337879134905885.128)
,p_translate_from_id=>wwv_flow_api.id(431337879134905885)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401535928545220749)
,p_page_id=>10
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433192735610787926.128)
,p_translate_from_id=>wwv_flow_api.id(433192735610787926)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401536089098220749)
,p_page_id=>12
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433219300723228461.128)
,p_translate_from_id=>wwv_flow_api.id(433219300723228461)
,p_translate_column_id=>310
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401536237854220764)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145876598322075.128)
,p_translate_from_id=>wwv_flow_api.id(421145876598322075)
,p_translate_column_id=>318
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'application/xliff+xml'
,p_translate_from_text=>'application/xliff+xml'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401536450041220764)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421146147798322078.128)
,p_translate_from_id=>wwv_flow_api.id(421146147798322078)
,p_translate_column_id=>318
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'application/xliff+xml'
,p_translate_from_text=>'application/xliff+xml'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401536677081220765)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145876598322075.128)
,p_translate_from_id=>wwv_flow_api.id(421145876598322075)
,p_translate_column_id=>319
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NATIVE'
,p_translate_from_text=>'NATIVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401536804916220765)
,p_page_id=>16
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421146147798322078.128)
,p_translate_from_id=>wwv_flow_api.id(421146147798322078)
,p_translate_column_id=>319
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NATIVE'
,p_translate_from_text=>'NATIVE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401537032411220865)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433238060990522093.128)
,p_translate_from_id=>wwv_flow_api.id(433238060990522093)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Load XLIFF file'
,p_translate_from_text=>unistr('\00DCbersetzung und Export')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401537088644220865)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(432130745735798488.128)
,p_translate_from_id=>wwv_flow_api.id(432130745735798488)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create and edit parameter values'
,p_translate_from_text=>'Parameter erstellen und editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401537315577220865)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433083430158250180.128)
,p_translate_from_id=>wwv_flow_api.id(433083430158250180)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer actual PIT settings'
,p_translate_from_text=>'Einsatzeinstellungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401537482441220865)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431347843229906004.128)
,p_translate_from_id=>wwv_flow_api.id(431347843229906004)
,p_translate_column_id=>376
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create, edit and translate messages'
,p_translate_from_text=>'Meldungen erzeugen und editieren'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401537669904220868)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433238060990522093.128)
,p_translate_from_id=>wwv_flow_api.id(433238060990522093)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Allows the creation of script files for export or translation'
,p_translate_from_text=>unistr('Erlaubt die Erstellung von Skriptdateien zum Export oder zum \00DCbersetzen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401537910699220868)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(433083430158250180.128)
,p_translate_from_id=>wwv_flow_api.id(433083430158250180)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Controls contexts, toggles and shows the current parameterization'
,p_translate_from_text=>'Kontrolliert Kontexte, Toggles und zeigt die aktuelle Parametrierung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401538038752220868)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431347843229906004.128)
,p_translate_from_id=>wwv_flow_api.id(431347843229906004)
,p_translate_column_id=>377
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Management of new messages and modification of existing ones'
,p_translate_from_text=>unistr('Verwaltung neuer Meldungen und \00C4nderung bestehender')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401538281326220903)
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(431329718232692927.128)
,p_translate_from_id=>wwv_flow_api.id(431329718232692927)
,p_translate_column_id=>397
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Desktop'
,p_translate_from_text=>'Desktop'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401538446772220937)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421303573062072805.128)
,p_translate_from_id=>wwv_flow_api.id(421303573062072805)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message Amt.'
,p_translate_from_text=>'Anzahl Meldungen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401538662472220939)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421062360157881225.128)
,p_translate_from_id=>wwv_flow_api.id(421062360157881225)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Id'
,p_translate_from_text=>'Par Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401538836621220939)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(387164279199259549.128)
,p_translate_from_id=>wwv_flow_api.id(387164279199259549)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Pms Pse Id'
,p_translate_from_text=>'Pms Pse Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401539089814220939)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073221102409139.128)
,p_translate_from_id=>wwv_flow_api.id(430073221102409139)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error ID'
,p_translate_from_text=>'Fehler-ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401539268941220939)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823851819434031.128)
,p_translate_from_id=>wwv_flow_api.id(408823851819434031)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Boolean value'
,p_translate_from_text=>'Wahrheitswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401539465887220939)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421067165330881228.128)
,p_translate_from_id=>wwv_flow_api.id(421067165330881228)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Flag'
,p_translate_from_text=>'Flag'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401539643045220939)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420811888624186137.128)
,p_translate_from_id=>wwv_flow_api.id(420811888624186137)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'modifizierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401539853330220939)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072976225409137.128)
,p_translate_from_id=>wwv_flow_api.id(430072976225409137)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text'
,p_translate_from_text=>'Text'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401540126020220939)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426379873184548670.128)
,p_translate_from_id=>wwv_flow_api.id(426379873184548670)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'&nbsp;'
,p_translate_from_text=>'&nbsp;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401540269745220939)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823348882434026.128)
,p_translate_from_id=>wwv_flow_api.id(408823348882434026)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text value'
,p_translate_from_text=>'Textwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401540500114220939)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145732254322074.128)
,p_translate_from_id=>wwv_flow_api.id(421145732254322074)
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
 p_id=>wwv_flow_api.id(401540642096220939)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072673376409134.128)
,p_translate_from_id=>wwv_flow_api.id(430072673376409134)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401540916391220939)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073322173409140.128)
,p_translate_from_id=>wwv_flow_api.id(430073322173409140)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Error number'
,p_translate_from_text=>'Fehlernr'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401541048040220939)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813719405186155.128)
,p_translate_from_id=>wwv_flow_api.id(420813719405186155)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Text type'
,p_translate_from_text=>'Texttyp'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401541277906220939)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421303017810072805.128)
,p_translate_from_id=>wwv_flow_api.id(421303017810072805)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401541507872220939)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823668017434029.128)
,p_translate_from_id=>wwv_flow_api.id(408823668017434029)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date value'
,p_translate_from_text=>'Datumswert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401541707453220939)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421063531165881227.128)
,p_translate_from_id=>wwv_flow_api.id(421063531165881227)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401541913062220939)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421064171032881227.128)
,p_translate_from_id=>wwv_flow_api.id(421064171032881227)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'String'
,p_translate_from_text=>'Zeichenkette'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401542063749220939)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142115131322037.128)
,p_translate_from_id=>wwv_flow_api.id(421142115131322037)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'overwritten'
,p_translate_from_text=>unistr('\00FCberschrieben')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401542257703220939)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813248443186151.128)
,p_translate_from_id=>wwv_flow_api.id(420813248443186151)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter'
,p_translate_from_text=>'Parameter'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401542448951220940)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072816226409135.128)
,p_translate_from_id=>wwv_flow_api.id(430072816226409135)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language ID'
,p_translate_from_text=>'Sprache-ID'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401542722541220940)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(387164357928259550.128)
,p_translate_from_id=>wwv_flow_api.id(387164357928259550)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Validation String'
,p_translate_from_text=>'Par Validation String'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401542916724220940)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814910575186167.128)
,p_translate_from_id=>wwv_flow_api.id(420814910575186167)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter value'
,p_translate_from_text=>'Parameterwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401543116720220940)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823718677434030.128)
,p_translate_from_id=>wwv_flow_api.id(408823718677434030)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp value'
,p_translate_from_text=>'Zeitstempelwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401543316967220940)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420811633803186135.128)
,p_translate_from_id=>wwv_flow_api.id(420811633803186135)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401543447723220940)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421065350319881228.128)
,p_translate_from_id=>wwv_flow_api.id(421065350319881228)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number'
,p_translate_from_text=>'Zahl'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401543663321220940)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823416727434027.128)
,p_translate_from_id=>wwv_flow_api.id(408823416727434027)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer value'
,p_translate_from_text=>'Ganzzahlwert'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401543867760220940)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421064758080881227.128)
,p_translate_from_id=>wwv_flow_api.id(421064758080881227)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Integer'
,p_translate_from_text=>'Ganzzahl'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401544067587220940)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421302401105072803.128)
,p_translate_from_id=>wwv_flow_api.id(421302401105072803)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Message group'
,p_translate_from_text=>'Meldungsgruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401544253840220940)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408822906306434022.128)
,p_translate_from_id=>wwv_flow_api.id(408822906306434022)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Area'
,p_translate_from_text=>'Bereich'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401544473059220940)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421066578510881228.128)
,p_translate_from_id=>wwv_flow_api.id(421066578510881228)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Timestamp'
,p_translate_from_text=>'Zeitstempel'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401544637222220940)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072554450409133.128)
,p_translate_from_id=>wwv_flow_api.id(430072554450409133)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Name'
,p_translate_from_text=>'Name'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401544929344220940)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073048703409138.128)
,p_translate_from_id=>wwv_flow_api.id(430073048703409138)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Severity'
,p_translate_from_text=>'Schweregrad'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401545087778220940)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073403251409141.128)
,p_translate_from_id=>wwv_flow_api.id(430073403251409141)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401545262064220940)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813412374186152.128)
,p_translate_from_id=>wwv_flow_api.id(420813412374186152)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Pgr id'
,p_translate_from_text=>'Pgr id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401545465830220940)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813536343186154.128)
,p_translate_from_id=>wwv_flow_api.id(420813536343186154)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401545654866220940)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072939805409136.128)
,p_translate_from_id=>wwv_flow_api.id(430072939805409136)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Language'
,p_translate_from_text=>'Sprache'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401545911983220940)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814519643186163.128)
,p_translate_from_id=>wwv_flow_api.id(420814519643186163)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'modifiable'
,p_translate_from_text=>'modifizierbar'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401546091473220940)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420811829452186136.128)
,p_translate_from_id=>wwv_flow_api.id(420811829452186136)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401546312577220940)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421063004173881227.128)
,p_translate_from_id=>wwv_flow_api.id(421063004173881227)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Par Pgr Id'
,p_translate_from_text=>'Par Pgr Id'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401546517632220942)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421065977550881228.128)
,p_translate_from_id=>wwv_flow_api.id(421065977550881228)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Date'
,p_translate_from_text=>'Datum'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401546665572220942)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813515885186153.128)
,p_translate_from_id=>wwv_flow_api.id(420813515885186153)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Parameter group'
,p_translate_from_text=>'Parametergruppe'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401546847798220942)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823562659434028.128)
,p_translate_from_id=>wwv_flow_api.id(408823562659434028)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Number value'
,p_translate_from_text=>unistr('Flie\00DFkommazahlwert')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401547118744220943)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421062360157881225.128)
,p_translate_from_id=>wwv_flow_api.id(421062360157881225)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401547274116220943)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823851819434031.128)
,p_translate_from_id=>wwv_flow_api.id(408823851819434031)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401547462824220943)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421067165330881228.128)
,p_translate_from_id=>wwv_flow_api.id(421067165330881228)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401547640623220943)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420811888624186137.128)
,p_translate_from_id=>wwv_flow_api.id(420811888624186137)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401547835781220943)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812157708186140.128)
,p_translate_from_id=>wwv_flow_api.id(420812157708186140)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401548131264220943)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072976225409137.128)
,p_translate_from_id=>wwv_flow_api.id(430072976225409137)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401548303757220943)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421304176583072805.128)
,p_translate_from_id=>wwv_flow_api.id(421304176583072805)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401548529303220943)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823348882434026.128)
,p_translate_from_id=>wwv_flow_api.id(408823348882434026)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401548701546220943)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072673376409134.128)
,p_translate_from_id=>wwv_flow_api.id(430072673376409134)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401548844784220945)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421301303478072802.128)
,p_translate_from_id=>wwv_flow_api.id(421301303478072802)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401549088275220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813719405186155.128)
,p_translate_from_id=>wwv_flow_api.id(420813719405186155)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401549245690220945)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408894334990137184.128)
,p_translate_from_id=>wwv_flow_api.id(408894334990137184)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401549529211220945)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421142115131322037.128)
,p_translate_from_id=>wwv_flow_api.id(421142115131322037)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa &PAR_IS_LOCAL."/>'
,p_translate_from_text=>'<i class="fa &PAR_IS_LOCAL."/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401549711537220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813248443186151.128)
,p_translate_from_id=>wwv_flow_api.id(420813248443186151)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401549882392220945)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408822995526434023.128)
,p_translate_from_id=>wwv_flow_api.id(408822995526434023)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401550132893220945)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421141977637322036.128)
,p_translate_from_id=>wwv_flow_api.id(421141977637322036)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401550262385220945)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072816226409135.128)
,p_translate_from_id=>wwv_flow_api.id(430072816226409135)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401550493604220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(387164357928259550.128)
,p_translate_from_id=>wwv_flow_api.id(387164357928259550)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401550698384220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814910575186167.128)
,p_translate_from_id=>wwv_flow_api.id(420814910575186167)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401550869239220945)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812500748186143.128)
,p_translate_from_id=>wwv_flow_api.id(420812500748186143)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401551081449220945)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073048703409138.128)
,p_translate_from_id=>wwv_flow_api.id(430073048703409138)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401551305700220945)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073403251409141.128)
,p_translate_from_id=>wwv_flow_api.id(430073403251409141)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401551508444220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813412374186152.128)
,p_translate_from_id=>wwv_flow_api.id(420813412374186152)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401551684516220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813536343186154.128)
,p_translate_from_id=>wwv_flow_api.id(420813536343186154)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401551848150220945)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072939805409136.128)
,p_translate_from_id=>wwv_flow_api.id(430072939805409136)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401552067626220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814519643186163.128)
,p_translate_from_id=>wwv_flow_api.id(420814519643186163)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
,p_translate_from_text=>'<i class="fa &PAR_IS_MODIFIABLE."/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401552269311220945)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421063004173881227.128)
,p_translate_from_id=>wwv_flow_api.id(421063004173881227)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401552464601220945)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823186196434024.128)
,p_translate_from_id=>wwv_flow_api.id(408823186196434024)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401552675466220945)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421061267864881222.128)
,p_translate_from_id=>wwv_flow_api.id(421061267864881222)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401552887456220945)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813515885186153.128)
,p_translate_from_id=>wwv_flow_api.id(420813515885186153)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401553107472220948)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421303573062072805.128)
,p_translate_from_id=>wwv_flow_api.id(421303573062072805)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401553244163220948)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812157708186140.128)
,p_translate_from_id=>wwv_flow_api.id(420812157708186140)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401553478030220948)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072976225409137.128)
,p_translate_from_id=>wwv_flow_api.id(430072976225409137)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401553649985220948)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823348882434026.128)
,p_translate_from_id=>wwv_flow_api.id(408823348882434026)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401553842359220948)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421145732254322074.128)
,p_translate_from_id=>wwv_flow_api.id(421145732254322074)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401554094725220948)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072673376409134.128)
,p_translate_from_id=>wwv_flow_api.id(430072673376409134)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401554265961220948)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421301303478072802.128)
,p_translate_from_id=>wwv_flow_api.id(421301303478072802)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401554447038220948)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813719405186155.128)
,p_translate_from_id=>wwv_flow_api.id(420813719405186155)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401554682749220949)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408894334990137184.128)
,p_translate_from_id=>wwv_flow_api.id(408894334990137184)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401554927892220949)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421063531165881227.128)
,p_translate_from_id=>wwv_flow_api.id(421063531165881227)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'VALUE'
,p_translate_from_text=>'VALUE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401555073627220949)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813248443186151.128)
,p_translate_from_id=>wwv_flow_api.id(420813248443186151)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401555250448220949)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072816226409135.128)
,p_translate_from_id=>wwv_flow_api.id(430072816226409135)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401555466223220949)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(387164357928259550.128)
,p_translate_from_id=>wwv_flow_api.id(387164357928259550)
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
 p_id=>wwv_flow_api.id(401555673082220949)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814910575186167.128)
,p_translate_from_id=>wwv_flow_api.id(420814910575186167)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401555927090220949)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073048703409138.128)
,p_translate_from_id=>wwv_flow_api.id(430073048703409138)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401556087960220949)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073403251409141.128)
,p_translate_from_id=>wwv_flow_api.id(430073403251409141)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401556299759220949)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813412374186152.128)
,p_translate_from_id=>wwv_flow_api.id(420813412374186152)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401556454221220949)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813536343186154.128)
,p_translate_from_id=>wwv_flow_api.id(420813536343186154)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401556729131220949)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072939805409136.128)
,p_translate_from_id=>wwv_flow_api.id(430072939805409136)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401556890157220949)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421061267864881222.128)
,p_translate_from_id=>wwv_flow_api.id(421061267864881222)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401557133619220949)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813515885186153.128)
,p_translate_from_id=>wwv_flow_api.id(420813515885186153)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401557297932220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(387164279199259549.128)
,p_translate_from_id=>wwv_flow_api.id(387164279199259549)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401557473112220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073221102409139.128)
,p_translate_from_id=>wwv_flow_api.id(430073221102409139)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401557679875220953)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420812157708186140.128)
,p_translate_from_id=>wwv_flow_api.id(420812157708186140)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401557839260220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072976225409137.128)
,p_translate_from_id=>wwv_flow_api.id(430072976225409137)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401558057009220953)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823348882434026.128)
,p_translate_from_id=>wwv_flow_api.id(408823348882434026)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401558242026220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072673376409134.128)
,p_translate_from_id=>wwv_flow_api.id(430072673376409134)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401558531820220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073322173409140.128)
,p_translate_from_id=>wwv_flow_api.id(430073322173409140)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401558683165220953)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421301303478072802.128)
,p_translate_from_id=>wwv_flow_api.id(421301303478072802)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401558930547220953)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813719405186155.128)
,p_translate_from_id=>wwv_flow_api.id(420813719405186155)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401559069859220953)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408894334990137184.128)
,p_translate_from_id=>wwv_flow_api.id(408894334990137184)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401559268478220953)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813248443186151.128)
,p_translate_from_id=>wwv_flow_api.id(420813248443186151)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401559462342220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072816226409135.128)
,p_translate_from_id=>wwv_flow_api.id(430072816226409135)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401559705809220953)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(387164357928259550.128)
,p_translate_from_id=>wwv_flow_api.id(387164357928259550)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401559851668220953)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814910575186167.128)
,p_translate_from_id=>wwv_flow_api.id(420814910575186167)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401560067384220953)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823416727434027.128)
,p_translate_from_id=>wwv_flow_api.id(408823416727434027)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401560270176220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073048703409138.128)
,p_translate_from_id=>wwv_flow_api.id(430073048703409138)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401560448416220953)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073403251409141.128)
,p_translate_from_id=>wwv_flow_api.id(430073403251409141)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401560724619220954)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813412374186152.128)
,p_translate_from_id=>wwv_flow_api.id(420813412374186152)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401560907814220954)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813536343186154.128)
,p_translate_from_id=>wwv_flow_api.id(420813536343186154)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401561091609220954)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072939805409136.128)
,p_translate_from_id=>wwv_flow_api.id(430072939805409136)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401561313571220954)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421061267864881222.128)
,p_translate_from_id=>wwv_flow_api.id(421061267864881222)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401561438944220954)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813515885186153.128)
,p_translate_from_id=>wwv_flow_api.id(420813515885186153)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401561715950220954)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823562659434028.128)
,p_translate_from_id=>wwv_flow_api.id(408823562659434028)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'right'
,p_translate_from_text=>'right'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401561925821220956)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072976225409137.128)
,p_translate_from_id=>wwv_flow_api.id(430072976225409137)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401562070416220956)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823348882434026.128)
,p_translate_from_id=>wwv_flow_api.id(408823348882434026)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401562284726220956)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072673376409134.128)
,p_translate_from_id=>wwv_flow_api.id(430072673376409134)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401562472657220956)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813719405186155.128)
,p_translate_from_id=>wwv_flow_api.id(420813719405186155)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401562683379220956)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823668017434029.128)
,p_translate_from_id=>wwv_flow_api.id(408823668017434029)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401562852921220956)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813248443186151.128)
,p_translate_from_id=>wwv_flow_api.id(420813248443186151)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401563069079220956)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072816226409135.128)
,p_translate_from_id=>wwv_flow_api.id(430072816226409135)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401563252357220956)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(387164357928259550.128)
,p_translate_from_id=>wwv_flow_api.id(387164357928259550)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401563527434220957)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420814910575186167.128)
,p_translate_from_id=>wwv_flow_api.id(420814910575186167)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401563677150220957)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421066578510881228.128)
,p_translate_from_id=>wwv_flow_api.id(421066578510881228)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401563916858220957)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073048703409138.128)
,p_translate_from_id=>wwv_flow_api.id(430073048703409138)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401564084645220957)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430073403251409141.128)
,p_translate_from_id=>wwv_flow_api.id(430073403251409141)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401564301017220957)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813412374186152.128)
,p_translate_from_id=>wwv_flow_api.id(420813412374186152)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401564439555220957)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813536343186154.128)
,p_translate_from_id=>wwv_flow_api.id(420813536343186154)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401564663078220957)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072939805409136.128)
,p_translate_from_id=>wwv_flow_api.id(430072939805409136)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401564874245220957)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421065977550881228.128)
,p_translate_from_id=>wwv_flow_api.id(421065977550881228)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'button'
,p_translate_from_text=>'button'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401565079040220957)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420813515885186153.128)
,p_translate_from_id=>wwv_flow_api.id(420813515885186153)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401565311378220959)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421303017810072805.128)
,p_translate_from_id=>wwv_flow_api.id(421303017810072805)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401565442466220959)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823668017434029.128)
,p_translate_from_id=>wwv_flow_api.id(408823668017434029)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401565713730220960)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421064171032881227.128)
,p_translate_from_id=>wwv_flow_api.id(421064171032881227)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401565868342220960)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823718677434030.128)
,p_translate_from_id=>wwv_flow_api.id(408823718677434030)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401566068466220960)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420811633803186135.128)
,p_translate_from_id=>wwv_flow_api.id(420811633803186135)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401566331531220960)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421065350319881228.128)
,p_translate_from_id=>wwv_flow_api.id(421065350319881228)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401566515943220960)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421064758080881227.128)
,p_translate_from_id=>wwv_flow_api.id(421064758080881227)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401566721070220960)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421302401105072803.128)
,p_translate_from_id=>wwv_flow_api.id(421302401105072803)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401566841126220960)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421066578510881228.128)
,p_translate_from_id=>wwv_flow_api.id(421066578510881228)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401567073541220960)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072554450409133.128)
,p_translate_from_id=>wwv_flow_api.id(430072554450409133)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401567314518220960)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420811829452186136.128)
,p_translate_from_id=>wwv_flow_api.id(420811829452186136)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401567491222220960)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421065977550881228.128)
,p_translate_from_id=>wwv_flow_api.id(421065977550881228)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401567637420220964)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408823668017434029.128)
,p_translate_from_id=>wwv_flow_api.id(408823668017434029)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401567836969220965)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421066578510881228.128)
,p_translate_from_id=>wwv_flow_api.id(421066578510881228)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401568034578220965)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421065977550881228.128)
,p_translate_from_id=>wwv_flow_api.id(421065977550881228)
,p_translate_column_id=>428
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'NONE'
,p_translate_from_text=>'NONE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401568326066220998)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421301745545072802.128)
,p_translate_from_id=>wwv_flow_api.id(421301745545072802)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401568482499220998)
,p_page_id=>11
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421061811246881224.128)
,p_translate_from_id=>wwv_flow_api.id(421061811246881224)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401568674354221003)
,p_page_id=>7
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(408822906306434022.128)
,p_translate_from_id=>wwv_flow_api.id(408822906306434022)
,p_translate_column_id=>450
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'- select'
,p_translate_from_text=>unistr('- bitte w\00E4hlen')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401569107533221004)
,p_page_id=>2
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(430072454865409132.128)
,p_translate_from_id=>wwv_flow_api.id(430072454865409132)
,p_translate_column_id=>451
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401569318084221004)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(426379873184548670.128)
,p_translate_from_id=>wwv_flow_api.id(426379873184548670)
,p_translate_column_id=>451
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'<i class="fa fa-pencil"/>'
,p_translate_from_text=>'<i class="fa fa-pencil"/>'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401569449889221015)
,p_page_id=>4
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(421300575831072799.128)
,p_translate_from_id=>wwv_flow_api.id(421300575831072799)
,p_translate_column_id=>457
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Message Group'
,p_translate_from_text=>'Meldungsgruppe erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401569645845221015)
,p_page_id=>8
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(420811511857186133.128)
,p_translate_from_id=>wwv_flow_api.id(420811511857186133)
,p_translate_column_id=>457
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Create Parameter Group'
,p_translate_from_text=>'Parametergruppe erstellen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(401569875523221048)
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
 p_id=>wwv_flow_api.id(402141817050011865)
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
 p_id=>wwv_flow_api.id(402141856070011874)
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
 p_id=>wwv_flow_api.id(402142057522011885)
,p_page_id=>6
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390919747207899944.128)
,p_translate_from_id=>wwv_flow_api.id(390919747207899944)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Administer Realm'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereich verwalten')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402142315399011885)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390920015830899946.128)
,p_translate_from_id=>wwv_flow_api.id(390920015830899946)
,p_translate_column_id=>13
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Cancel'
,p_translate_from_text=>'Abbrechen'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402142533255011890)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390920289305899949.128)
,p_translate_from_id=>wwv_flow_api.id(390920289305899949)
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
 p_id=>wwv_flow_api.id(402142689791011899)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390919917236899945.128)
,p_translate_from_id=>wwv_flow_api.id(390919917236899945)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Buttons'
,p_translate_from_text=>'Buttons'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402142895311011899)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402126588452860768.128)
,p_translate_from_id=>wwv_flow_api.id(402126588452860768)
,p_translate_column_id=>20
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'Y'
,p_translate_to_text=>'Realms'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402143118446012115)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402126588452860768.128)
,p_translate_from_id=>wwv_flow_api.id(402126588452860768)
,p_translate_column_id=>143
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realms'
,p_translate_from_text=>unistr('G\00FCltigkeitsbereiche')
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402143172333012381)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402133353747860798.128)
,p_translate_from_id=>wwv_flow_api.id(402133353747860798)
,p_translate_column_id=>278
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'PLSQL_CODE'
,p_translate_from_text=>'PLSQL_CODE'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402143251104012387)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402133353747860798.128)
,p_translate_from_id=>wwv_flow_api.id(402133353747860798)
,p_translate_column_id=>281
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'pita_ui.process_edit_realm;'
,p_translate_from_text=>'pita_ui.process_edit_realm;'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402143594084012390)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402133353747860798.128)
,p_translate_from_id=>wwv_flow_api.id(402133353747860798)
,p_translate_column_id=>282
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402143756616012392)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402133353747860798.128)
,p_translate_from_id=>wwv_flow_api.id(402133353747860798)
,p_translate_column_id=>283
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402144007164012443)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390919917236899945.128)
,p_translate_from_id=>wwv_flow_api.id(390919917236899945)
,p_translate_column_id=>308
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402144185486012446)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(390919917236899945.128)
,p_translate_from_id=>wwv_flow_api.id(390919917236899945)
,p_translate_column_id=>309
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'HTML'
,p_translate_from_text=>'HTML'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402144335974012665)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402132409950860796.128)
,p_translate_from_id=>wwv_flow_api.id(402132409950860796)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'active'
,p_translate_from_text=>'aktiv'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402144514705012665)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402131360111860796.128)
,p_translate_from_id=>wwv_flow_api.id(402131360111860796)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Description'
,p_translate_from_text=>'Beschreibung'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402144669160012667)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402130395148860795.128)
,p_translate_from_id=>wwv_flow_api.id(402130395148860795)
,p_translate_column_id=>421
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Realm'
,p_translate_from_text=>'Bezeichner'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402144840736012668)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402132409950860796.128)
,p_translate_from_id=>wwv_flow_api.id(402132409950860796)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'APPLICATION'
,p_translate_from_text=>'APPLICATION'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402145119612012668)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402127918873860776.128)
,p_translate_from_id=>wwv_flow_api.id(402127918873860776)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402145243743012668)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402131360111860796.128)
,p_translate_from_id=>wwv_flow_api.id(402131360111860796)
,p_translate_column_id=>422
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402145523972012671)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402127918873860776.128)
,p_translate_from_id=>wwv_flow_api.id(402127918873860776)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Y'
,p_translate_from_text=>'Y'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402145637993012671)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402131360111860796.128)
,p_translate_from_id=>wwv_flow_api.id(402131360111860796)
,p_translate_column_id=>423
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402145855348012674)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402127918873860776.128)
,p_translate_from_id=>wwv_flow_api.id(402127918873860776)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402146103323012674)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402131360111860796.128)
,p_translate_from_id=>wwv_flow_api.id(402131360111860796)
,p_translate_column_id=>424
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'N'
,p_translate_from_text=>'N'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402146320388012676)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402131360111860796.128)
,p_translate_from_id=>wwv_flow_api.id(402131360111860796)
,p_translate_column_id=>425
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402146528801012679)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402130395148860795.128)
,p_translate_from_id=>wwv_flow_api.id(402130395148860795)
,p_translate_column_id=>426
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'BOTH'
,p_translate_from_text=>'BOTH'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402146643292012720)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402128382990860776.128)
,p_translate_from_id=>wwv_flow_api.id(402128382990860776)
,p_translate_column_id=>448
,p_translate_to_lang_code=>'en'
,p_translation_specific_to_item=>'NO'
,p_template_translatable=>'N'
,p_translate_to_text=>'Actions'
,p_translate_from_text=>'Actions'
);
wwv_flow_api.create_translation(
 p_id=>wwv_flow_api.id(402155751691199324)
,p_page_id=>13
,p_translated_flow_id=>128
,p_translate_to_id=>wwv_flow_api.id(402152733437098334.128)
,p_translate_from_id=>wwv_flow_api.id(402152733437098334)
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
 p_id=>wwv_flow_api.id(401925462702713532)
,p_name=>'BOOLEAN_N'
,p_message_language=>'de'
,p_message_text=>'Nein'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323620332776318)
,p_name=>'BOOLEAN_N'
,p_message_text=>'No'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(401925295237712707)
,p_name=>'BOOLEAN_Y'
,p_message_language=>'de'
,p_message_text=>'Ja'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323552979776318)
,p_name=>'BOOLEAN_Y'
,p_message_text=>'Yes'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(401329138772127721)
,p_name=>'HELP_CONTEXT'
,p_message_language=>'de'
,p_message_text=>unistr('<p>Ein Kontext fasst das Debug- und Traceverhalten von PIT unter einem Namen zusammen.</p><p>W\00E4hrend der Anwendung kann der Kontext global oder nur f\00FCr einen Benutzer ge\00E4ndert werden. Dadurch wird feingranular gesteuert, welche Einstellungen aktuell ')
||unistr('gelten sollen.</p><p>Der Standard-Kontext \00BBDEFAULT\00AB wird gew\00E4hlt, wenn kein anderer Kontext ausgew\00E4hlt wurde. Daher kann dieser Kontext nicht gel\00F6scht werden.<br>Sie k\00F6nnen beliebig viele Kontexte anlegen.</p><p>Die Kontextbezeichner \00BBDEFAULT\00AB und \00BBA')
||unistr('CTIVE\00AB werden intern verwendet und sind daher nicht erlaubt.</p>')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323175976776316)
,p_name=>'HELP_CONTEXT'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>A context summarizes the debug and trace behavior of PIT under one name.</p><p>.',
'During the application, the context can be changed globally or only for a user. This provides fine-grained control over which settings should currently apply.</p><p>.',
'The default context "DEFAULT" is selected if no other context is selected. Therefore, this context cannot be deleted.<br>You can create as many contexts as you like.</p><p>.',
'The context identifiers "DEFAULT" and "ACTIVE" are used internally and are therefore not allowed.</p>'))
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(401328296344084129)
,p_name=>'HELP_OUTPUT_MODULES'
,p_message_language=>'de'
,p_message_text=>unistr('<p>Ausgabemodule werden verwendet, um Nachrichten von PIT an Tabellen, Dateien, APEX oder beliebige weitere Ziele zu senden.<br>Angezeigt werden alle Module, die derzeit in der Datenbank installiert sind. Sie k\00F6nnen an der Spalte \00BBverf\00FCgbar\00AB sehen, o')
||unistr('b es bei der Installation des Ausgabemoduls Probleme gab oder ob das Modul einsatzbereit ist.<br>Spalte \00BBaktiv\00AB zeigt an, ob das Modul aktuell zur Ausgabe von Meldungen verwendet wird.</p>')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323029535776316)
,p_name=>'HELP_OUTPUT_MODULES'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Output modules are used to send messages from PIT to tables, files, APEX or any other destination.',
'All modules that are currently installed in the database are displayed. You can see from the "available" column whether there were problems during the installation of the output module or whether the module is ready for use.<br>',
'Column "active" shows whether the module is currently usead for the output of messages.',
''))
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(401329431360134404)
,p_name=>'HELP_TOGGLE'
,p_message_language=>'de'
,p_message_text=>unistr('Das Debugging kann global f\00FCr alle Anwendungspackages eingestellt werden, indem Kontexte verwendet werden.<br>Zus\00E4tzlich ist es m\00F6glich, Das Logging f\00FCr einzelne Packages ein- oder auszuschalten. Hierf\00FCr wird eine Liste von Packages verwaltet, denen ')
||unistr('jeweils ein benannter Kontext zugeordnet wird.<br>Wird eines dieser Packages ausgef\00FChrt, schaltet PIT den zugeordneten Kontext aktiv. Wird das Package verlassen, wird wieder der vorherige Kontext aktiv.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323216201776316)
,p_name=>'HELP_TOGGLE'
,p_message_text=>'Debugging can be set globally for all application packages by using contexts.<br>In addition, it is possible to enable or disable logging for individual packages. To do this, a list of packages is managed, to each of which a named context is assigned'
||'.<br>If one of these packages is executed, PIT activates the assigned context. If the package is left, the previous context becomes active again.'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(401825595551402859)
,p_name=>'HINT_PMS'
,p_message_language=>'de'
,p_message_text=>unistr('Falls Sie die Meldungen \00FCbersetzen m\00F6chten, w\00E4hlen Sie eine Zielsprache.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323404387776316)
,p_name=>'HINT_PMS'
,p_message_text=>'If you want to translate the messages, select a target language.'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(401826157018410381)
,p_name=>'HINT_PTI'
,p_message_language=>'de'
,p_message_text=>unistr('Falls Sie die Begriffe \00FCbersetzen m\00F6chten, w\00E4hlen Sie eine Zielsprache.')
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323491813776318)
,p_name=>'HINT_PTI'
,p_message_text=>'If you want to translate the translatable items, select a target language.'
);
end;
/
begin
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(433249635431843318)
,p_name=>'ORACLE_ERROR_HINT'
,p_message_language=>'de'
,p_message_text=>unistr('<h2>Oracle-Fehlermapping</h2><p>Wenn Sie einen Oracle-Fehler auf eine PIT-Meldung abbilden m\00F6chten, beachten Sie:</p><ul><li>Bereits vordefinierte Fehler k\00F6nnen nicht \00FCberschrieben werden (z.B. NO_DATA_FOUND)</li><li>Oracle-Fehlernummern k\00F6nnen nur e')
||unistr('inmal von PIT \00FCberschrieben werden</li></ul><p>Da Oracle-Fehler nur einmal gemappt werden k\00F6nnen, sollte der Bezeichner m\00F6glichst generisch gew\00E4hlt werden.<br>Verwenden Sie eine Namenskonvention mit Schema- oder Bereichspr\00E4fixen, beachten Sie, dass d')
||unistr('iese Fehlermappings \00FCbergreifend verwendet werden m\00FCssen und daher eine entsprechende Namenskonvention ben\00F6tigen.</p><p>Um einen Oracle-Fehler mit mehreren Meldungen zu verbinden, definieren Sie eine Oracle-Fehlernachricht und separate Meldungen. Im ')
||'Exception-Block des Codes fangen Sie dann den benannten Oracle-Fehler und geben die spezifische Nachricht aus.</p>'
);
wwv_flow_api.create_message(
 p_id=>wwv_flow_api.id(384323726093776318)
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
 p_id=>wwv_flow_api.id(431340430814905886)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>unistr('Bitte best\00E4tigen Sie, dass die Daten gel\00F6scht werden sollen.')
);
end;
/
prompt --application/shared_components/security/authentications/apex
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(431329863893692930)
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
 p_id=>wwv_flow_api.id(468053867472164091)
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
 p_id=>wwv_flow_api.id(468054570158183741)
,p_plugin_id=>wwv_flow_api.id(468053867472164091)
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
 p_id=>wwv_flow_api.id(468055157476189604)
,p_plugin_attribute_id=>wwv_flow_api.id(468054570158183741)
,p_display_sequence=>10
,p_display_value=>'SQL bzw. PL/SQL'
,p_return_value=>'text/x-plsql'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468055970982193485)
,p_plugin_attribute_id=>wwv_flow_api.id(468054570158183741)
,p_display_sequence=>20
,p_display_value=>'JavaScript'
,p_return_value=>'text/javascript'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468056342716194731)
,p_plugin_attribute_id=>wwv_flow_api.id(468054570158183741)
,p_display_sequence=>30
,p_display_value=>'JavaScript JSON'
,p_return_value=>'application/json'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468056856914198839)
,p_plugin_attribute_id=>wwv_flow_api.id(468054570158183741)
,p_display_sequence=>40
,p_display_value=>'XML'
,p_return_value=>'application/xml'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468057261070200079)
,p_plugin_attribute_id=>wwv_flow_api.id(468054570158183741)
,p_display_sequence=>50
,p_display_value=>'HTML'
,p_return_value=>'text/html'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468065266394611554)
,p_plugin_attribute_id=>wwv_flow_api.id(468054570158183741)
,p_display_sequence=>60
,p_display_value=>'CSS'
,p_return_value=>'text/css'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(468060453262484768)
,p_plugin_id=>wwv_flow_api.id(468053867472164091)
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
 p_id=>wwv_flow_api.id(468061055340485317)
,p_plugin_attribute_id=>wwv_flow_api.id(468060453262484768)
,p_display_sequence=>10
,p_display_value=>'Night'
,p_return_value=>'night'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468061456725485786)
,p_plugin_attribute_id=>wwv_flow_api.id(468060453262484768)
,p_display_sequence=>20
,p_display_value=>'Neat'
,p_return_value=>'neat'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468061859842486637)
,p_plugin_attribute_id=>wwv_flow_api.id(468060453262484768)
,p_display_sequence=>30
,p_display_value=>'Elegant'
,p_return_value=>'elegant'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(468062261920487256)
,p_plugin_attribute_id=>wwv_flow_api.id(468060453262484768)
,p_display_sequence=>40
,p_display_value=>'Default'
,p_return_value=>'default'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(468058242500204172)
,p_plugin_id=>wwv_flow_api.id(468053867472164091)
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
 p_id=>wwv_flow_api.id(432882648606370241)
,p_plugin_id=>wwv_flow_api.id(468053867472164091)
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
 p_id=>wwv_flow_api.id(431329718232692927)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN_DESKTOP:&SESSION.'
,p_theme_style_by_user_pref=>false
,p_navigation_list_id=>wwv_flow_api.id(431287276434692886)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(431323329664692915)
,p_nav_list_template_options=>'#DEFAULT#'
,p_include_legacy_javascript=>'18'
,p_include_jquery_migrate=>true
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(431329647524692927)
,p_nav_bar_list_template_id=>wwv_flow_api.id(431320031741692913)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'PIT-Administration'
,p_alias=>'MAIN'
,p_step_title=>'PIT-Administration'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(432125552448409515)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210104142332'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(431331540459692943)
,p_plug_name=>'Breadcrumbs'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431306791462692905)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(431331031416692941)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(431325050337692918)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(431333869135817605)
,p_plug_name=>'Anwendungsbereiche'
,p_component_template_options=>'#DEFAULT#:t-Cards--featured force-fa-lg:t-Cards--displayIcons:t-Cards--4cols:t-Cards--desc-2ln:u-colors:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(423756463668985383)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(431317407965692911)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Meldungen administrieren'
,p_alias=>'ADMIN_PMS'
,p_step_title=>'Meldungen administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(432125591683410235)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221217140018'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(431348786442906022)
,p_plug_name=>'Meldungen'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_ADMIN_PMS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P2_PMG_NAME,P2_PML_NAME'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(134943252260490196)
,p_name=>'PMS_LINK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PMS_LINK'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'&nbsp;'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'&PMS_LINK.'
,p_link_text=>'<span aria-label="Meldung bearbeiten"><span class="fa fa-edit" aria-hidden="true" title="Meldung bearbeiten"></span></span>'
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
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(387164279199259549)
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
 p_id=>wwv_flow_api.id(430072554450409133)
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
 p_id=>wwv_flow_api.id(430072673376409134)
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
 p_id=>wwv_flow_api.id(430072816226409135)
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
 p_id=>wwv_flow_api.id(430072939805409136)
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
 p_id=>wwv_flow_api.id(430072976225409137)
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
 p_id=>wwv_flow_api.id(430073048703409138)
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
 p_id=>wwv_flow_api.id(430073221102409139)
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
 p_id=>wwv_flow_api.id(430073322173409140)
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
 p_id=>wwv_flow_api.id(430073403251409141)
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
 p_id=>wwv_flow_api.id(430072427913409131)
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
 p_id=>wwv_flow_api.id(423778876955129959)
,p_interactive_grid_id=>wwv_flow_api.id(430072427913409131)
,p_static_id=>'158019'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(423779009394129959)
,p_report_id=>wwv_flow_api.id(423778876955129959)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(255440412791656204)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(134943252260490196)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(400549533225884693)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(387164279199259549)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423779963697129969)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(430072554450409133)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>319
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423780476730129970)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(430072673376409134)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423780975154129972)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(430072816226409135)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423781504460129973)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(430072939805409136)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423782004667129975)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(430072976225409137)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423782531831129976)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(430073048703409138)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>109
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423783032241129978)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(430073221102409139)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423783529203129980)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(430073322173409140)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>68
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(423784025645129981)
,p_view_id=>wwv_flow_api.id(423779009394129959)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(430073403251409141)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(431354923895906035)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431306791462692905)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(431331031416692941)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(431325050337692918)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(430072273739409130)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(431348786442906022)
,p_button_name=>'EDIT_PMG'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Meldungsgruppe bearbeiten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMG:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(431353447409906030)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(431348786442906022)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Meldung erzeugen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PMS:&SESSION.::&DEBUG.:RP,3::'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(426663939651921934)
,p_name=>'P2_PMG_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(431348786442906022)
,p_prompt=>'Gruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_GROUP'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(426664005939921935)
,p_name=>'P2_PML_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(431348786442906022)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PML_NAME_IN_USE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(431352498400906030)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(431348786442906022)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(431353037779906030)
,p_event_id=>wwv_flow_api.id(431352498400906030)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(431348786442906022)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(431353845751906032)
,p_name=>'Create Button - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(431353447409906030)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(431354299555906032)
,p_event_id=>wwv_flow_api.id(431353845751906032)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(431348786442906022)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(426664080877921936)
,p_name=>'Refresh Report'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_PML_NAME,P2_PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(426664215132921937)
,p_event_id=>wwv_flow_api.id(426664080877921936)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(431348786442906022)
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Meldung editieren'
,p_alias=>'EDIT_PMS'
,p_page_mode=>'MODAL'
,p_step_title=>'Meldung editieren'
,p_reload_on_submit=>'A'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(432125591683410235)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_step_template=>wwv_flow_api.id(431293152344692896)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'800'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221217142711'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(426382146445548693)
,p_plug_name=>'HIlfe zu Oracle-Fehlermappings'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299034528692902)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''ORACLE_ERROR_HINT''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(431337879134905885)
,p_plug_name=>'Meldung editieren'
,p_region_name=>'EDIT_PMS_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_PMS'
,p_include_rowid_column=>true
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(431338567145905885)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(431339023024905885)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(431338567145905885)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(431338468012905885)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(431338567145905885)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Meldung entfernen'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_PMS_NAME'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(431338430278905885)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(431338567145905885)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_PMS_NAME'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(431338281485905885)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(431338567145905885)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Meldug erzeugen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_PMS_NAME'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(426382213326548694)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(431337879134905885)
,p_button_name=>'SHOW_HELP'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324364298692916)
,p_button_image_alt=>'Hilfe zu Oracle-Fehlermappings'
,p_button_position=>'TOP'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134943348336490197)
,p_name=>'P3_PMS_ACTIVE_ERROR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_prompt=>'Pms Active Error'
,p_source=>'PMS_ACTIVE_ERROR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134943501389490198)
,p_name=>'P3_PMS_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_prompt=>'Pms Id'
,p_source=>'PMS_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>128
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(423795708500235092)
,p_name=>'P3_PMS_PMG_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
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
,p_field_template=>wwv_flow_api.id(431324174048692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(423796151380235097)
,p_name=>'P3_PMS_DESCRIPTION'
,p_source_data_type=>'CLOB'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_prompt=>'Beschreibung'
,p_source=>'PMS_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_help_text=>unistr('Optionale Beschreibung.<br>Kann verwendet werden, um im Fehlerfall zus\00E4tzliche Handlungsanweisungen an den Anwender zu geben.')
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(431342137413905993)
,p_name=>'P3_PMS_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_prompt=>'Name'
,p_source=>'PMS_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>128
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>'P3_PMS_NAME'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(431324174048692916)
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
 p_id=>wwv_flow_api.id(431342419757905996)
,p_name=>'P3_PMS_PML_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_default=>'return pita_ui.get_default_language;'
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
,p_field_template=>wwv_flow_api.id(431324174048692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Sprache der Meldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(431342812008905996)
,p_name=>'P3_PMS_TEXT'
,p_source_data_type=>'CLOB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_prompt=>'Meldung'
,p_source=>'PMS_TEXT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>2
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(431324174048692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Meldungstext.<br>Ersetzung der Parameter #1# bis #50# gem\00E4\00DF Zahlwert.<br>\00DCbergebene Parameter werden positional nummeriert und auf die Ersetzungsmarken verteilt.')
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(431343234303905996)
,p_name=>'P3_PMS_PSE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_default=>'70'
,p_prompt=>'Schweregrad'
,p_source=>'PMS_PSE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Schweregrad der Fehlermeldung'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(431343606594905997)
,p_name=>'P3_PMS_CUSTOM_ERROR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(431337879134905885)
,p_item_source_plug_id=>wwv_flow_api.id(431337879134905885)
,p_prompt=>'Fehlernummer'
,p_source=>'PMS_CUSTOM_ERROR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Optionale Fehlernummer.<br>Muss bei eigenen Fehlern nicht angegeben werden, dient dem Mappen Oracle-definierter Fehler auf Fehlermeldungen.<br>Wird eine Fehlernummer doppelt belegt, wird ein Fehler geworfen.<br>Insbesondere darf keine Fehlernummer im'
||' Bereich - 20999 bis -20001 angegben werden, PIT verwaltet diese Fehlernummer automatisch.'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(423796027064235095)
,p_validation_name=>'Validate EDIT_PMS'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.edit_pms_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(431339111600905885)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(431339023024905885)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(431339864518905886)
,p_event_id=>wwv_flow_api.id(431339111600905885)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(426664305232921938)
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
 p_id=>wwv_flow_api.id(426664406471921939)
,p_event_id=>wwv_flow_api.id(426664305232921938)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(426664520351921940)
,p_event_id=>wwv_flow_api.id(426664305232921938)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_CUSTOM_ERROR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420815140805186170)
,p_event_id=>wwv_flow_api.id(426664305232921938)
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
 p_id=>wwv_flow_api.id(420815282966186171)
,p_event_id=>wwv_flow_api.id(426664305232921938)
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
 p_id=>wwv_flow_api.id(423795831332235093)
,p_name=>'Format PMS_NAME'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_PMS_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(423795844989235094)
,p_event_id=>wwv_flow_api.id(423795831332235093)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pita_ui.harmonize_sql_name(''P3_PMS_NAME'');'
,p_attribute_02=>'P3_PMS_NAME'
,p_attribute_03=>'P3_PMS_NAME'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420814950266186168)
,p_name=>'Initialize Page'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420815058552186169)
,p_event_id=>wwv_flow_api.id(420814950266186168)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_PMS_PML_NAME'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(426382372819548695)
,p_name=>'Show help region'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(426382213326548694)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(426382382422548696)
,p_event_id=>wwv_flow_api.id(426382372819548695)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(426382146445548693)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(431345934060906001)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(431337879134905885)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PITA_UI_EDIT_PMS'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(426662772240921923)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(431337879134905885)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_PMS'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_pms_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_process_error_message=>'Fehler beim Speichern der Meldung:<br>#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Meldung wurde gespeichert.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(431346747004906001)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(431338468012905885)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(431347069842906001)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
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
 p_id=>wwv_flow_api.id(421144212955322058)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(421300097501072797)
,p_plug_name=>'Meldungsgruppe bearbeiten'
,p_region_name=>'EDIT_PMG_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431303034758692904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_PMG'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(366546598414918910)
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
 p_id=>wwv_flow_api.id(366546699121918911)
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
 p_id=>wwv_flow_api.id(421301303478072802)
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
 p_id=>wwv_flow_api.id(421301745545072802)
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
 p_id=>wwv_flow_api.id(421302401105072803)
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
 p_id=>wwv_flow_api.id(421303017810072805)
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
 p_id=>wwv_flow_api.id(421303573062072805)
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
 p_id=>wwv_flow_api.id(421304176583072805)
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
 p_id=>wwv_flow_api.id(421300575831072799)
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
 p_id=>wwv_flow_api.id(421300996386072800)
,p_interactive_grid_id=>wwv_flow_api.id(421300575831072799)
,p_static_id=>'158028'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(421301037561072800)
,p_report_id=>wwv_flow_api.id(421300996386072800)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(366754926792704088)
,p_view_id=>wwv_flow_api.id(421301037561072800)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(366546598414918910)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(366755820546704093)
,p_view_id=>wwv_flow_api.id(421301037561072800)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(366546699121918911)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421302169116072803)
,p_view_id=>wwv_flow_api.id(421301037561072800)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(421301745545072802)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421302801991072805)
,p_view_id=>wwv_flow_api.id(421301037561072800)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(421302401105072803)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421303367119072805)
,p_view_id=>wwv_flow_api.id(421301037561072800)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(421303017810072805)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>369
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421303953415072805)
,p_view_id=>wwv_flow_api.id(421301037561072800)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(421303573062072805)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88.5
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421304593423072805)
,p_view_id=>wwv_flow_api.id(421301037561072800)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(421304176583072805)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421144260384322059)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(421144212955322058)
,p_button_name=>'CANCEL'
,p_button_static_id=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421144580959322062)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(421144212955322058)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(421144052048322057)
,p_tabular_form_region_id=>wwv_flow_api.id(421300097501072797)
,p_validation_name=>'Validate EDIT_PMG'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.edit_pmg_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(421144402133322060)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(421144260384322059)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(421144460131322061)
,p_event_id=>wwv_flow_api.id(421144402133322060)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(421145161738322068)
,p_name=>'Format PMG_NAME'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(421300097501072797)
,p_triggering_element=>'PMG_NAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(421145288070322069)
,p_event_id=>wwv_flow_api.id(421145161738322068)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pita_ui.harmonize_sql_name(''PMG_NAME'');'
,p_attribute_02=>'PMG_NAME'
,p_attribute_03=>'PMG_NAME'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(421304749694072807)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(421300097501072797)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PMG'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_pmg_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(421144810660322064)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>unistr('G\00FCltigkeitsbereich einstellen')
,p_alias=>'SET_REALM'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('G\00FCltigkeitsbereich einstellen')
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(432125680101411540)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220125170909'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(403001754687402761)
,p_plug_name=>'Create Form'
,p_region_name=>'SET_REALM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_REALM'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(403004152844402774)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(403004527185402774)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(403004152844402774)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(403006533595402779)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(403004152844402774)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_PRE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(366546824203918912)
,p_name=>'P5_PRE_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(403001754687402761)
,p_item_source_plug_id=>wwv_flow_api.id(403001754687402761)
,p_prompt=>unistr('G\00FCltigkeitsbereich')
,p_source=>'PRE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_PARAMETER_REALM'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(366546872928918913)
,p_name=>'P5_PRE_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(403001754687402761)
,p_item_source_plug_id=>wwv_flow_api.id(403001754687402761)
,p_prompt=>'Beschreibung'
,p_source=>'PRE_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>255
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(366546999966918914)
,p_name=>'P5_PRE_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(403001754687402761)
,p_item_source_plug_id=>wwv_flow_api.id(403001754687402761)
,p_prompt=>'aktiv'
,p_source=>'PRE_IS_ACTIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(402964111260844932)
,p_validation_name=>'Validate SET_REALM'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.set_realm_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(403004699121402774)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(403004527185402774)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(403005487608402776)
,p_event_id=>wwv_flow_api.id(403004699121402774)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(403007750819402780)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(403001754687402761)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process SET_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.set_realm_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(403008183917402780)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(403007346121402779)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(403001754687402761)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Parameter administrieren'
,p_alias=>'ADMIN_PARAM'
,p_step_title=>'Parameter administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(432125680101411540)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221217140926'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(420812984682186148)
,p_plug_name=>'Liste der Parameter'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_ADMIN_PAR'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P6_PGR_ID'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(387164357928259550)
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
 p_id=>wwv_flow_api.id(420813248443186151)
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
 p_id=>wwv_flow_api.id(420813412374186152)
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
 p_id=>wwv_flow_api.id(420813515885186153)
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
 p_id=>wwv_flow_api.id(420813536343186154)
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
 p_id=>wwv_flow_api.id(420813719405186155)
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
 p_id=>wwv_flow_api.id(420814519643186163)
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
 p_id=>wwv_flow_api.id(420814910575186167)
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
 p_id=>wwv_flow_api.id(426379873184548670)
,p_name=>'Link'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_LINK'
,p_heading=>'&nbsp;'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:EDIT_PAR:&SESSION.::&DEBUG.:RP,7:P7_PAR_ID,P7_PAR_PGR_ID:&PAR_ID.,&PGR_ID.'
,p_link_text=>'<span aria-label="Parameter bearbeiten"><span class="fa fa-edit" aria-hidden="true" title="Parameter bearbeiten"></span></span>'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(420813055253186149)
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
 p_id=>wwv_flow_api.id(420870722065638011)
,p_interactive_grid_id=>wwv_flow_api.id(420813055253186149)
,p_static_id=>'158032'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(420870786685638011)
,p_report_id=>wwv_flow_api.id(420870722065638011)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(400555053347893715)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(387164357928259550)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(414411956958958889)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(426379873184548670)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>42
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420871740202638017)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(420813248443186151)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>216
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420872278633638019)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(420813412374186152)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420872640769638019)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(420813515885186153)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420873172593638021)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(420813536343186154)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>502
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420873664637638022)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(420813719405186155)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420877693098638030)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(420814519643186163)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>119
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420920669390885491)
,p_view_id=>wwv_flow_api.id(420870786685638011)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(420814910575186167)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>373
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(432914874737544408)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431306791462692905)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(431331031416692941)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(431325050337692918)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(390919747207899944)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(420812984682186148)
,p_button_name=>'EDIT_REALM'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('G\00FCltigkeitsbereich verwalten')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_REALM:&SESSION.::&DEBUG.:RP,::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433058148110950506)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(420812984682186148)
,p_button_name=>'EDIT_PGR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Parametergruppen verwalten'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PGR:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(432913439495544405)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(420812984682186148)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Parameter erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_PAR:&SESSION.::&DEBUG.:RP,:P7_PAR_ID,P7_PAR_PGR_ID:,&P6_PGR_ID.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(402964264212844933)
,p_name=>'P6_REALM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(420812984682186148)
,p_prompt=>unistr('aktueller G\00FCltigkeitsbereich')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from PITA_UI_admin_par_realm'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_PARAMETER_REALM'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433057813016950503)
,p_name=>'P6_PGR_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(420812984682186148)
,p_prompt=>'Parmetergruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(432913767751544405)
,p_name=>unistr('Schaltfl\00E4che erstellen - Dialog geschlossen')
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(420812984682186148)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(432914255345544405)
,p_event_id=>wwv_flow_api.id(432913767751544405)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(420812984682186148)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(402964459792844935)
,p_event_id=>wwv_flow_api.id(432913767751544405)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P6_REALM'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select par_string_value',
'  from PITA_UI_admin_par_realm'))
,p_attribute_08=>'Y'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433057946973950504)
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
 p_id=>wwv_flow_api.id(390920554506899952)
,p_event_id=>wwv_flow_api.id(433057946973950504)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(432913439495544405)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433058045683950505)
,p_event_id=>wwv_flow_api.id(433057946973950504)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(420812984682186148)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(390920474110899951)
,p_event_id=>wwv_flow_api.id(433057946973950504)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(432913439495544405)
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Parameter bearbeiten'
,p_alias=>'EDIT_PAR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parameter bearbeiten'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(432125680101411540)
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
,p_last_upd_yyyymmddhh24miss=>'20221217144802'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(408821436659434007)
,p_plug_name=>unistr('Abweichende Parameterwerte f\00FCr G\00FCltigkeitsbereiche')
,p_region_name=>'EDIT_PAR_REALM'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_PAR_REALM'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(408822906306434022)
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
,p_lov_id=>wwv_flow_api.id(408879496967089691)
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
 p_id=>wwv_flow_api.id(408822995526434023)
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
 p_id=>wwv_flow_api.id(408823186196434024)
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
 p_id=>wwv_flow_api.id(408823348882434026)
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
 p_id=>wwv_flow_api.id(408823416727434027)
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
 p_id=>wwv_flow_api.id(408823562659434028)
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
 p_id=>wwv_flow_api.id(408823668017434029)
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
 p_id=>wwv_flow_api.id(408823718677434030)
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
 p_id=>wwv_flow_api.id(408823851819434031)
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
 p_id=>wwv_flow_api.id(408894265527137183)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(408894334990137184)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(408822855420434021)
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
 p_id=>wwv_flow_api.id(408885498470136532)
,p_interactive_grid_id=>wwv_flow_api.id(408822855420434021)
,p_static_id=>'158034'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(408885617567136532)
,p_report_id=>wwv_flow_api.id(408885498470136532)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408886187600136535)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(408822906306434022)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408886647721136538)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(408822995526434023)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408887129926136541)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(408823186196434024)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408888106692136543)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(408823348882434026)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408888606480136545)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(408823416727434027)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408889174033136546)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(408823562659434028)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408889668321136548)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(408823668017434029)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408890116278136548)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(408823718677434030)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408890606974136549)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(408823851819434031)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(408900719804147726)
,p_view_id=>wwv_flow_api.id(408885617567136532)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(408894265527137183)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(432893211152544258)
,p_plug_name=>'Parameter bearbeiten'
,p_region_name=>'EDIT_PAR_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_PAR'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(432893911301544261)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(432915488348544408)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431306791462692905)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(431331031416692941)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(431325050337692918)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(432894350900544261)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(432893911301544261)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(432893761088544261)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(432893911301544261)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(432893723303544261)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(432893911301544261)
,p_button_name=>'SAVE'
,p_button_static_id=>'B7_SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\00C4nderungen anwenden')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(432893635625544261)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(432893911301544261)
,p_button_name=>'CREATE'
,p_button_static_id=>'P7_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420814766403186166)
,p_name=>'P7_PAR_XML_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'XML-Wert'
,p_source=>'PAR_XML_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>32767
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(426379692152548669)
,p_name=>'P7_PGR_IS_MODIFIABLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select pgr_is_modifiable',
'  from parameter_group',
' where pgr_id = :P6_PGR_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'editierbar'
,p_source=>'PGR_IS_MODIFIABLE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432897043773544366)
,p_name=>'P7_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Parameter'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>128
,p_read_only_when=>'P7_PAR_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(431324174048692916)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Geben Sie einen eindeutigen Bezeichner f\00FCr diese Parametergruppe ein. Der Name muss den Oracle-Benennungskonventionen entsprechen und darf keine Sonderzeichen enthalten.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
,p_attribute_06=>'UPPER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432897313418544368)
,p_name=>'P7_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
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
,p_field_template=>wwv_flow_api.id(431324174048692916)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('W\00E4hlen Sie die Parametergruppe, zu der dieser Parameter geh\00F6ren soll.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432897677145544368)
,p_name=>'P7_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Besschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Geben Sie eine optionale Beschreibung des Parameters ein.'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432898058022544371)
,p_name=>'P7_PAR_STRING_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Textwert'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432898533190544371)
,p_name=>'P7_PAR_INTEGER_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Ganzzahlwert'
,p_source=>'PAR_INTEGER_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432898856050544371)
,p_name=>'P7_PAR_FLOAT_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>unistr('Flie\00DFkommazahlwert')
,p_source=>'PAR_FLOAT_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432899299402544371)
,p_name=>'P7_PAR_DATE_VALUE'
,p_source_data_type=>'DATE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Datumswert'
,p_source=>'PAR_DATE_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432899705811544372)
,p_name=>'P7_PAR_TIMESTAMP_VALUE'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Zeitstempelwert'
,p_source=>'PAR_TIMESTAMP_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432900484935544372)
,p_name=>'P7_PAR_BOOLEAN_VALUE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Wahrheitswert'
,p_source=>'PAR_BOOLEAN_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432900927045544374)
,p_name=>'P7_PAR_IS_MODIFIABLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_default=>'pit_util.C_TRUE'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>'editieren untersagen'
,p_source=>'PAR_IS_MODIFIABLE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_PAR_IS_MODIFIABLE'
,p_lov=>'.'||wwv_flow_api.id(411687517178998147)||'.'
,p_begin_on_new_line=>'N'
,p_display_when=>':P7_PGR_IS_MODIFIABLE = pit_util.C_TRUE'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(431323858676692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Falls die Gruppe das Editieren erlaubt, kann dies f\00FCr einzelne Parameter unterdr\00FCckt werden.')
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432901353794544374)
,p_name=>'P7_PAR_PAT_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Texttyp'
,p_source=>'PAR_PAT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PARAMETER_TYPE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Mit diesem Attribut k\00F6nnen Sie festlegen, welche Art Text als Textparameter gespeichert werden soll. Dies kontrolliert, welcher Editor Ihnen zur Bearbeitung angeboten wird.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(432901693743544374)
,p_name=>'P7_PAR_VALIDATION_STRING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Validierungsausdruck'
,p_source=>'PAR_VALIDATION_STRING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_api.id(431323986381692916)
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
 p_id=>wwv_flow_api.id(432902074799544374)
,p_name=>'P7_PAR_VALIDATION_MESSAGE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(432893211152544258)
,p_item_source_plug_id=>wwv_flow_api.id(432893211152544258)
,p_prompt=>'Fehlermeldung'
,p_source=>'PAR_VALIDATION_MESSAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(420814661581186165)
,p_validation_name=>'Validate EDIT_PAR'
,p_validation_sequence=>120
,p_validation=>'return pita_ui.edit_par_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(408894121810137182)
,p_tabular_form_region_id=>wwv_flow_api.id(408821436659434007)
,p_validation_name=>'Validate EDIT_PAR_REALM'
,p_validation_sequence=>130
,p_validation=>'return pita_ui.edit_par_realm_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(432894397535544261)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(432894350900544261)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(432895169934544265)
,p_event_id=>wwv_flow_api.id(432894397535544261)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(432904111293544377)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(432893211152544258)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PITA_UI_EDIT_PAR'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(432904529637544377)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(432893211152544258)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_PAR'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_par_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(408822788551434020)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(408821436659434007)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PAR_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_par_realm_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(432904888004544377)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(432893761088544261)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(432905257928544379)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Parametergruppe bearbeiten'
,p_alias=>'EDIT_PGR'
,p_page_mode=>'MODAL'
,p_step_title=>'Parametergruppe bearbeiten'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(432125680101411540)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1000'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140557'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(420812781242186146)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433068584315176774)
,p_plug_name=>'Parametergruppe bearbeiten'
,p_region_name=>'EDIT_PGR_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431303034758692904)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_PGR'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(420811633803186135)
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
 p_id=>wwv_flow_api.id(420811829452186136)
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
 p_id=>wwv_flow_api.id(420811888624186137)
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
 p_id=>wwv_flow_api.id(420812081925186139)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>40
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(420812157708186140)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(420812500748186143)
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
 p_id=>wwv_flow_api.id(421145732254322074)
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
 p_id=>wwv_flow_api.id(420811511857186133)
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
 p_id=>wwv_flow_api.id(420819956723198036)
,p_interactive_grid_id=>wwv_flow_api.id(420811511857186133)
,p_static_id=>'158041'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(420820113758198036)
,p_report_id=>wwv_flow_api.id(420819956723198036)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420821117815198044)
,p_view_id=>wwv_flow_api.id(420820113758198036)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(420811633803186135)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420821622695198046)
,p_view_id=>wwv_flow_api.id(420820113758198036)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(420811829452186136)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>437
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420822109946198047)
,p_view_id=>wwv_flow_api.id(420820113758198036)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(420811888624186137)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>99
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420825948514222757)
,p_view_id=>wwv_flow_api.id(420820113758198036)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(420812081925186139)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(420826926012222760)
,p_view_id=>wwv_flow_api.id(420820113758198036)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(420812500748186143)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421419439664525630)
,p_view_id=>wwv_flow_api.id(420820113758198036)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(421145732254322074)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>107
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433072373347176783)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(420812781242186146)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433072158438176783)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(420812781242186146)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(420812851308186147)
,p_tabular_form_region_id=>wwv_flow_api.id(433068584315176774)
,p_validation_name=>'Validate EDIT_PGR'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.edit_pgr_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420812587876186144)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(433072158438176783)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420812696026186145)
,p_event_id=>wwv_flow_api.id(420812587876186144)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(421145454422322071)
,p_name=>'Format PGR'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(433068584315176774)
,p_triggering_element=>'PGR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(421145531892322072)
,p_event_id=>wwv_flow_api.id(421145454422322071)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pita_ui.harmonize_sql_name(''PGR_ID'');'
,p_attribute_02=>'PGR_ID'
,p_attribute_03=>'PGR_ID'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(420812245258186141)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(433068584315176774)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_PGR'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_pgr_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433076480012176791)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'PIT administrieren'
,p_alias=>'ADMIN_PIT'
,p_step_title=>'PIT administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(433086004445274593)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20230801091023'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(426381658519548688)
,p_name=>'Aktuelle Debugeinstellungen'
,p_template=>wwv_flow_api.id(431303538430692904)
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_ADMIN_PIT_ACTIVE_CONTEXT'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(431312312772692908)
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
 p_id=>wwv_flow_api.id(426381693324548689)
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
 p_id=>wwv_flow_api.id(426381794829548690)
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
 p_id=>wwv_flow_api.id(426381906518548691)
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
 p_id=>wwv_flow_api.id(426381984129548692)
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
 p_id=>wwv_flow_api.id(433058758905950513)
,p_plug_name=>'Hinweise zu Ausgabemodulen'
,p_region_name=>'output_modules'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(431299034528692902)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_OUTPUT_MODULES''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433058884168950514)
,p_plug_name=>'Hinweise zu Kontexten'
,p_region_name=>'contexts'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(431299034528692902)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_CONTEXT''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433059819659950523)
,p_plug_name=>'Debugging nach Package filtern (Toggles)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(433060046623950525)
,p_name=>unistr('Verf\00FCgbare Toggles')
,p_parent_plug_id=>wwv_flow_api.id(433059819659950523)
,p_template=>wwv_flow_api.id(431303538430692904)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_ADMIN_PIT_TOGGLE'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(431312312772692908)
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
 p_id=>wwv_flow_api.id(433060186815950527)
,p_query_column_id=>1
,p_column_alias=>'PAR_ID'
,p_column_display_sequence=>2
,p_column_heading=>'Toggle-Name'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:edit_toggle:&SESSION.::&DEBUG.::P12_PAR_ID:#PAR_ID#'
,p_column_linktext=>'<span aria-label="Toggle bearbeiten"><span class="fa fa-edit" aria-hidden="true" title="Toggle bearbeiten"></span></span>'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(433060316004950528)
,p_query_column_id=>2
,p_column_alias=>'PAR_PGR_ID'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(134943163355490195)
,p_query_column_id=>3
,p_column_alias=>'PAR_DESCRIPTION'
,p_column_display_sequence=>15
,p_column_heading=>'Par Description'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(433060426478950529)
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
 p_id=>wwv_flow_api.id(433060526906950530)
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
 p_id=>wwv_flow_api.id(433059861001950524)
,p_plug_name=>'Informationen zum Filter des Debuggings'
,p_region_name=>'toggles'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(431299034528692902)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'htp.p(apex_lang.message(''HELP_TOGGLE''));'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433083885068250183)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431306791462692905)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(431331031416692941)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(431325050337692918)
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(433094878523254249)
,p_name=>'Installierte Ausgabemodule'
,p_template=>wwv_flow_api.id(431303538430692904)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_ADMIN_PIT_MODULE'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(431312312772692908)
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
 p_id=>wwv_flow_api.id(433058507960950510)
,p_query_column_id=>1
,p_column_alias=>'MODULE_ID'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:EDIT_MODULE:&SESSION.::&DEBUG.:RP:P11_PIT_MODULE:#MODULE_ID#'
,p_column_linktext=>'<span aria-label="Ausgabemodul bearbeiten"><span class="fa fa-edit" aria-hidden="true" title="Ausgabemodul bearbeiten"></span></span>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(433058180211950507)
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
 p_id=>wwv_flow_api.id(430071744253409125)
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
 p_id=>wwv_flow_api.id(433058345689950508)
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
 p_id=>wwv_flow_api.id(433058419770950509)
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
 p_id=>wwv_flow_api.id(433186123208608485)
,p_name=>unistr('Verf\00FCgbare Kontexte')
,p_template=>wwv_flow_api.id(431303538430692904)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_ADMIN_PIT_CONTEXT'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(431312312772692908)
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
 p_id=>wwv_flow_api.id(387164448119259551)
,p_query_column_id=>1
,p_column_alias=>'PAR_ID'
,p_column_display_sequence=>10
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:edit_context:&SESSION.::&DEBUG.:10:P10_PAR_ID:#PAR_ID#'
,p_column_linktext=>'<span aria-label="Kontext bearbeiten"><span class="fa fa-edit" aria-hidden="true" title="Kontext bearbeiten"></span></span>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(433187102831608490)
,p_query_column_id=>2
,p_column_alias=>'CONTEXT_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Kontext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(433187466454608490)
,p_query_column_id=>3
,p_column_alias=>'CONTEXT_DESCRIPTION'
,p_column_display_sequence=>30
,p_column_heading=>'Beschreibung'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(433187893927608490)
,p_query_column_id=>4
,p_column_alias=>'CONTEXT_SETTING'
,p_column_display_sequence=>40
,p_column_heading=>'Einstellungen'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(426380706005548679)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433094878523254249)
,p_button_name=>'HELP_OUTPUT_MODULES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324364298692916)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(426381066698548682)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433059819659950523)
,p_button_name=>'HELP_TOGGLES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324364298692916)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433061008217950535)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433186123208608485)
,p_button_name=>'CREATE_CONTEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_CONTEXT:&SESSION.::&DEBUG.:RP,10:P10_ROWID:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433061086693950536)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433060046623950525)
,p_button_name=>'CREATE_TOGGLE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_TOGGLE:&SESSION.::&DEBUG.:RP,12:P12_ROWID:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(426381372232548685)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(433186123208608485)
,p_button_name=>'HELP_CONTEXTS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324364298692916)
,p_button_image_alt=>'HIlfe'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa fa-question'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433060646796950531)
,p_name=>'P9_ALLOW_TOGGLE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(433059819659950523)
,p_use_cache_before_default=>'NO'
,p_item_default=>'utl_apex.get_bool(pita_ui.allows_toggles)'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Toggles verwenden'
,p_display_as=>'NATIVE_YES_NO'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433119574769254266)
,p_name=>'Bericht bearbeiten - Dialog geschlossen'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(433094878523254249)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433120148031254268)
,p_event_id=>wwv_flow_api.id(433119574769254266)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433094878523254249)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433059641761950521)
,p_name=>'Kontext bearbeiten - Dialog geschlossen'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(433186123208608485)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433059702173950522)
,p_event_id=>wwv_flow_api.id(433059641761950521)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433186123208608485)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433060680145950532)
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
 p_id=>wwv_flow_api.id(433060756112950533)
,p_event_id=>wwv_flow_api.id(433060680145950532)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433060046623950525)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433060894376950534)
,p_event_id=>wwv_flow_api.id(433060680145950532)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433060046623950525)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433061874535950544)
,p_event_id=>wwv_flow_api.id(433060680145950532)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(433061086693950536)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433061983817950545)
,p_event_id=>wwv_flow_api.id(433060680145950532)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(433061086693950536)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433061298277950538)
,p_event_id=>wwv_flow_api.id(433060680145950532)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pita_ui.set_allow_toggles;'
,p_attribute_02=>'P9_ALLOW_TOGGLE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433061362181950539)
,p_event_id=>wwv_flow_api.id(433060680145950532)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pita_ui.set_allow_toggles;'
,p_attribute_02=>'P9_ALLOW_TOGGLE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433061712221950542)
,p_name=>'Toggle bearbeiten - Dialog geschlossen'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(433059819659950523)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433061814726950543)
,p_event_id=>wwv_flow_api.id(433061712221950542)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433060046623950525)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(426380814784548680)
,p_name=>'Show output module help'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(426380706005548679)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(426380947808548681)
,p_event_id=>wwv_flow_api.id(426380814784548680)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433058758905950513)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(426381124545548683)
,p_name=>'Show toggle help'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(426381066698548682)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(426381224766548684)
,p_event_id=>wwv_flow_api.id(426381124545548683)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433059861001950524)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(426381447206548686)
,p_name=>'Show context help'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(426381372232548685)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(426381528269548687)
,p_event_id=>wwv_flow_api.id(426381447206548686)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(433058884168950514)
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Kontext administrieren'
,p_alias=>'EDIT_CONTEXT'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(433086004445274593)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_protection_level=>'C'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20230801090653'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433192735610787926)
,p_plug_name=>'Kontext administrieren'
,p_region_name=>'EDIT_CONTEXT_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_CONTEXT'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433193405243787926)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433193320973787926)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(433193405243787926)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'not pita_ui.is_default_context and :P10_PAR_ID is not null'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433193236116787926)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(433193405243787926)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433193144902787926)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(433193405243787926)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Kontext erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433193784158787927)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433193405243787926)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433058983413950515)
,p_name=>'P10_PSE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_default=>'10'
,p_prompt=>'Debug-Level'
,p_source=>'PSE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_SEVERITY'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Maximaler Schweregrad, der durch diesen Kontext erlaubt wird.<br>Sollte ein Ausgabemodule eine niedrigere Ansprechschwelle haben, kann es sein, dass Meldungen nicht ausgegeben werden, obwohl der hier angegebene Schwellwert unterschritten wurde.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433059069333950516)
,p_name=>'P10_PTL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_prompt=>'Trace-Level'
,p_source=>'PTL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_TRACE_LEVEL'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Maximaler Tracelevel, der durch diesen Kontext erlaubt wird.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433059225926950517)
,p_name=>'P10_CTX_TIMING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_prompt=>'Zeitinformation erfassen'
,p_source=>'CTX_TIMING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Sollen Zeitinformationen gesammelt werden?'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433059313109950518)
,p_name=>'P10_CTX_OUTPUT_MODULES'
,p_source_data_type=>'CLOB'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_prompt=>'Ausgabemodule'
,p_source=>'CTX_OUTPUT_MODULES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_OUTPUT_MODULES'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_help_text=>'Liste der Ausgabemodule, die Log-Informationen ausgeben sollen.'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433196650038787947)
,p_name=>'P10_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_prompt=>'Kontext'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>128
,p_read_only_when=>'pita_ui.is_default_context'
,p_read_only_when2=>'PLSQL'
,p_read_only_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(431324174048692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Eindeutiger Bezeichner des Kontexts. Ohne Sonderzeichen und Leerzeichen. Der Name wird in Gro\00DFschreibung \00FCberf\00FChrt und muss den Namensregeln eines Oracle-Bezeichners entsprechen.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433197028039787949)
,p_name=>'P10_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433197453839787949)
,p_name=>'P10_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>200
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>'Optionale Beschreibung des Einsatzbereichs des Kontexts'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433197813461787949)
,p_name=>'P10_PAR_STRING_VALUE'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(433192735610787926)
,p_item_source_plug_id=>wwv_flow_api.id(433192735610787926)
,p_use_cache_before_default=>'NO'
,p_source=>'PAR_STRING_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(421142557723322042)
,p_validation_name=>'Validate EDIT_CONTEXT'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.edit_context_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433193943437787927)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(433193784158787927)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433194710187787927)
,p_event_id=>wwv_flow_api.id(433193943437787927)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(390923938393899986)
,p_name=>'Format P10_PAR_ID'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_PAR_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(390924036061899987)
,p_event_id=>wwv_flow_api.id(390923938393899986)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pita_ui.harmonize_sql_name(''P10_PAR_ID'', ''CONTEXT'');'
,p_attribute_02=>'P10_PAR_ID'
,p_attribute_03=>'P10_PAR_ID'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433199768259787954)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(433192735610787926)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PITA_UI_EDIT_CONTEXT'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433059495735950520)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(433192735610787926)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_CONTEXT'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_context_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433200615814787954)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(433193320973787926)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433200995855787954)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Ausgabemodul administrieren'
,p_alias=>'EDIT_MODULE'
,p_page_mode=>'MODAL'
,p_step_title=>'Ausgabemodul administrieren'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(433086004445274593)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_dialog_width=>'1200'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220127140622'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(420815601858186174)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(421060315223881200)
,p_plug_name=>'Ausgabemodul administrieren'
,p_region_name=>'EDIT_MODULE_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431303034758692904)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_MODULE'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(421061267864881222)
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
 p_id=>wwv_flow_api.id(421061811246881224)
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
 p_id=>wwv_flow_api.id(421062360157881225)
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
 p_id=>wwv_flow_api.id(421063004173881227)
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
 p_id=>wwv_flow_api.id(421063531165881227)
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
 p_id=>wwv_flow_api.id(421064171032881227)
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
 p_id=>wwv_flow_api.id(421064758080881227)
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
 p_id=>wwv_flow_api.id(421065350319881228)
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
 p_id=>wwv_flow_api.id(421065977550881228)
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
 p_id=>wwv_flow_api.id(421066578510881228)
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
 p_id=>wwv_flow_api.id(421067165330881228)
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
 p_id=>wwv_flow_api.id(421141977637322036)
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
 p_id=>wwv_flow_api.id(421142115131322037)
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
 p_id=>wwv_flow_api.id(421060655973881219)
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
 p_id=>wwv_flow_api.id(421060958325881221)
,p_interactive_grid_id=>wwv_flow_api.id(421060655973881219)
,p_static_id=>'158051'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(421061091899881221)
,p_report_id=>wwv_flow_api.id(421060958325881221)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421062134137881224)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(421061811246881224)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421062750001881227)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(421062360157881225)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421063354113881227)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(421063004173881227)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421064001443881227)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(421063531165881227)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>347
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421064555060881227)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(421064171032881227)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>273
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421065192899881227)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(421064758080881227)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421065743975881228)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(421065350319881228)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>53
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421066359199881228)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(421065977550881228)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421066953500881228)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(421066578510881228)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421067537942881228)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(421067165330881228)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>54
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421157713467541491)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(421141977637322036)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(421160774062682686)
,p_view_id=>wwv_flow_api.id(421061091899881221)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(421142115131322037)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>115
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(420815930437186178)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(420815601858186174)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(420815717220186175)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(420815601858186174)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433058633744950511)
,p_name=>'P11_PIT_MODULE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(421060315223881200)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(420815470913186173)
,p_tabular_form_region_id=>wwv_flow_api.id(421060315223881200)
,p_validation_name=>'Validate EDIT_MODULE'
,p_validation_sequence=>110
,p_validation=>'return pita_ui.edit_module_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420815802352186176)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(420815717220186175)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420815874760186177)
,p_event_id=>wwv_flow_api.id(420815802352186176)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(421067775009881230)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(421060315223881200)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_MODULE'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_module_process;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433156866709322268)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Kontext-Toggle administrieren'
,p_alias=>'EDIT_TOGGLE'
,p_page_mode=>'MODAL'
,p_step_title=>'Kontext-Toggle administrieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(433086004445274593)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20230801091001'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433219300723228461)
,p_plug_name=>'Kontext-Toggle administrieren'
,p_region_name=>'EDIT_TOGGLE_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_TOGGLE'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433220053343228461)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433062081280950546)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(433220053343228461)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P12_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421142324714322039)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(433220053343228461)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Toggle erstellen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433219782099228461)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(433220053343228461)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'P12_PAR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433219754026228461)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433220053343228461)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(133151576862296501)
,p_name=>'P12_PAR_PGR_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(433219300723228461)
,p_item_source_plug_id=>wwv_flow_api.id(433219300723228461)
,p_prompt=>'Par Pgr Id'
,p_source=>'PAR_PGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>128
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433221926412228463)
,p_name=>'P12_PAR_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(433219300723228461)
,p_item_source_plug_id=>wwv_flow_api.id(433219300723228461)
,p_prompt=>'Name'
,p_source=>'PAR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>128
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433222344696228465)
,p_name=>'P12_TOGGLE_MODULE_LIST'
,p_source_data_type=>'CLOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(433219300723228461)
,p_item_source_plug_id=>wwv_flow_api.id(433219300723228461)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Liste der Packages'
,p_source=>'TOGGLE_MODULE_LIST'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_AVAILABLE_PACKAGES'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433222671153228465)
,p_name=>'P12_TOGGLE_CONTEXT_NAME'
,p_source_data_type=>'CLOB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(433219300723228461)
,p_item_source_plug_id=>wwv_flow_api.id(433219300723228461)
,p_use_cache_before_default=>'NO'
,p_prompt=>'zugeordneter Kontext'
,p_source=>'TOGGLE_CONTEXT_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CONTEXT'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Kontext w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433223123856228465)
,p_name=>'P12_PAR_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(433219300723228461)
,p_item_source_plug_id=>wwv_flow_api.id(433219300723228461)
,p_prompt=>'Beschreibung'
,p_source=>'PAR_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(421142162887322038)
,p_validation_name=>'Validate EDIT_TOGGLE'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.edit_toggle_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433220737693228461)
,p_name=>'Dialog abbrechen'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(433219754026228461)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(433221230088228461)
,p_event_id=>wwv_flow_api.id(433220737693228461)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433223472358228465)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(433219300723228461)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process EDIT_TOGGLE'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_toggle_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433224050858228465)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433061485220950540)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(433219300723228461)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from PITA_UI_EDIT_TOGGLE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P12_PAR_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_api.create_page(
 p_id=>13
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
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
 p_id=>wwv_flow_api.id(390919917236899945)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431299931787692902)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(402126588452860768)
,p_plug_name=>unistr('G\00FCltigkeitsbereiche')
,p_region_name=>'EDIT_REALM_FORM'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431303034758692904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PITA_UI_EDIT_REALM'
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
 p_id=>wwv_flow_api.id(402127918873860776)
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
 p_id=>wwv_flow_api.id(402128382990860776)
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
 p_id=>wwv_flow_api.id(402130395148860795)
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
 p_id=>wwv_flow_api.id(402131360111860796)
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
 p_id=>wwv_flow_api.id(402132409950860796)
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
 p_id=>wwv_flow_api.id(402127064081860770)
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
 p_id=>wwv_flow_api.id(402127465059860771)
,p_interactive_grid_id=>wwv_flow_api.id(402127064081860770)
,p_static_id=>'179029'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(402127638843860771)
,p_report_id=>wwv_flow_api.id(402127465059860771)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(402128745354860778)
,p_view_id=>wwv_flow_api.id(402127638843860771)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(402128382990860776)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(402130765847860796)
,p_view_id=>wwv_flow_api.id(402127638843860771)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(402130395148860795)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(402131788166860796)
,p_view_id=>wwv_flow_api.id(402127638843860771)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(402131360111860796)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(402132761050860796)
,p_view_id=>wwv_flow_api.id(402127638843860771)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(402132409950860796)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(402152733437098334)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(390919917236899945)
,p_button_name=>'CLOSE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('Schlie\00DFen')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(390920015830899946)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(390919917236899945)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(390920289305899949)
,p_validation_name=>'Validate EDIT_REALM'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.edit_realm_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(390920048722899947)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(390920015830899946)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(390920175609899948)
,p_event_id=>wwv_flow_api.id(390920048722899947)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(390923779056899984)
,p_name=>'Format PRE_ID'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(402126588452860768)
,p_triggering_element=>'PRE_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(390923895506899985)
,p_event_id=>wwv_flow_api.id(390923779056899984)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pita_ui.harmonize_sql_name(''PRE_ID'');'
,p_attribute_02=>'PRE_ID'
,p_attribute_03=>'PRE_ID'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(402133353747860798)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(402126588452860768)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Process EDIT_REALM'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'pita_ui.edit_realm_process;'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(390920408035899950)
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
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>unistr('Stammdaten exportieren und \00FCbersetzen')
,p_alias=>'EXPORT'
,p_step_title=>unistr('Stammdaten exportieren und \00FCbersetzen')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(433240367967539986)
,p_javascript_file_urls=>'#APP_IMAGES#condes.pit.utils.js'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221217142711'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(421143233200322049)
,p_plug_name=>'linke Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(421143506323322051)
,p_plug_name=>unistr('Begriffe exportieren und \00FCbersetzen')
,p_parent_plug_id=>wwv_flow_api.id(421143233200322049)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'pita_ui.has_translatable_items'
,p_plug_display_when_cond2=>'PLSQL'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433267227389093708)
,p_plug_name=>unistr('Meldungen exportieren und \00FCbersetzen')
,p_parent_plug_id=>wwv_flow_api.id(421143233200322049)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(421143331630322050)
,p_plug_name=>'rechte Spalte'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431295410900692899)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(372593744368512707)
,p_plug_name=>'Texttemplates exportieren'
,p_parent_plug_id=>wwv_flow_api.id(421143331630322050)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433267288610093709)
,p_plug_name=>'Parameter exportieren'
,p_parent_plug_id=>wwv_flow_api.id(421143331630322050)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(433245661086602661)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(431306791462692905)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(431331031416692941)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(431325050337692918)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421145994508322076)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(421143506323322051)
,p_button_name=>'IMPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('\00DCbersetzung laden')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421146095479322077)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433267227389093708)
,p_button_name=>'IMPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('\00DCbersetzung laden')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421142947009322046)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(433267227389093708)
,p_button_name=>'TRANSLATE_PMS'
,p_button_static_id=>'TRANSLATE_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('Meldung \00FCbersetzen')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421143944746322056)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(421143506323322051)
,p_button_name=>'TRANSLATE_PTI'
,p_button_static_id=>'TRANSLATE_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>unistr('Begriffe \00FCbersetzen')
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421143892802322055)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(421143506323322051)
,p_button_name=>'EXPORT_PTI'
,p_button_static_id=>'EXPORT_PTI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Begriffe exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433266911053093705)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(433267227389093708)
,p_button_name=>'EXPORT_PMS'
,p_button_static_id=>'EXPORT_PMS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Meldungen exportieren'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(372593966732512709)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(372593744368512707)
,p_button_name=>'EXPORT_UTTM'
,p_button_static_id=>'EXPORT_UTTM'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Texttemplates exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(421142662843322043)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(433267288610093709)
,p_button_name=>'EXPORT_LOCAL_PAR'
,p_button_static_id=>'EXPORT_LOCAL_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Lokale Parameter exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'pita_ui.has_local_parameters'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(433267933196093715)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(433267288610093709)
,p_button_name=>'EXPORT_PAR'
,p_button_static_id=>'EXPORT_PAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_image_alt=>'Parametergruppen exportieren'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(372593864358512708)
,p_name=>'P16_UTTM_TYPE_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(372593744368512707)
,p_prompt=>'Parametergruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_UTTM_TYPE'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Bewegen Sie alle Parametergruppen, die Sie exportieren m\00F6chten, in die rechte Spalte.')
,p_attribute_01=>'MOVE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(421142886081322045)
,p_name=>'P16_PMS_PML_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(433267227389093708)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Zielsprache w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(421143075520322047)
,p_name=>'P16_HINT_PMS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(433267227389093708)
,p_prompt=>'Hint pms'
,p_source=>'apex_lang.message(''HINT_PMS'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(431323858676692916)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(421143598405322052)
,p_name=>'P16_PTI_PMG_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(421143506323322051)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PTI_PMG_IN_USE'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(421143685660322053)
,p_name=>'P16_HINT_PTI'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(421143506323322051)
,p_prompt=>'Hint pti'
,p_source=>'apex_lang.message(''HINT_PTI'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(431323858676692916)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(421143810051322054)
,p_name=>'P16_PTI_PML_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(421143506323322051)
,p_prompt=>'Sprache'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PIT_MESSAGE_LANGUAGE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Zielsprache w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'control-export'
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('W\00E4hlen Sie die Zielsprache, in die Sie die Meldungen \00FCbersetzen m\00F6chten.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(421145876598322075)
,p_name=>'P16_PTI_XLIFF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(421143506323322051)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
,p_attribute_12=>'NATIVE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(421146147798322078)
,p_name=>'P16_PMS_XLIFF'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(433267227389093708)
,p_prompt=>'XLIFF-Datei importieren'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'N'
,p_attribute_11=>'application/xliff+xml'
,p_attribute_12=>'NATIVE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433266778918093704)
,p_name=>'P16_PMS_PMG_LIST'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(433267227389093708)
,p_prompt=>'Meldungsgruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PMS_PMG_IN_USE'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'ALL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(433267824135093714)
,p_name=>'P16_PAR_PGR_LIST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(433267288610093709)
,p_prompt=>'Parametergruppe'
,p_display_as=>'NATIVE_SHUTTLE'
,p_named_lov=>'LOV_PARAMETER_GROUP'
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_css_classes=>'control-export'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Bewegen Sie alle Parametergruppen, die Sie exportieren m\00F6chten, in die rechte Spalte.')
,p_attribute_01=>'MOVE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(420815370848186172)
,p_validation_name=>'Validate EXPORT'
,p_validation_sequence=>10
,p_validation=>'return pita_ui.export_validate;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(433268149616093717)
,p_name=>'ControlExportItems'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.control-export'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(421143193442322048)
,p_event_id=>wwv_flow_api.id(433268149616093717)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'condes.pit.utils.controlExportItems();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(421146242241322079)
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
 p_id=>wwv_flow_api.id(421146369557322080)
,p_event_id=>wwv_flow_api.id(421146242241322079)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(421146095479322077)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(421146438349322081)
,p_event_id=>wwv_flow_api.id(421146242241322079)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(421146095479322077)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(421452551509314333)
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
 p_id=>wwv_flow_api.id(421452701805314334)
,p_event_id=>wwv_flow_api.id(421452551509314333)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(421145994508322076)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(421452825359314335)
,p_event_id=>wwv_flow_api.id(421452551509314333)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(421145994508322076)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(433267034559093706)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EXPORT'
,p_process_sql_clob=>'pita_ui.export_process;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(431329718232692927)
,p_name=>'Login Page'
,p_alias=>'LOGIN_DESKTOP'
,p_step_title=>'PIT-Administration - Log In'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(431291793299692896)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_last_updated_by=>'APP_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20201221134959'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(431330162041692936)
,p_plug_name=>'Log In'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(431303538430692904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(431330527315692940)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(431330162041692936)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(431324455586692918)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Log In'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_alignment=>'LEFT'
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(431330306190692940)
,p_name=>'P101_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(431330162041692936)
,p_prompt=>'Benutzer'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(431330444487692940)
,p_name=>'P101_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(431330162041692936)
,p_prompt=>'Passwort'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(431323986381692916)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(431330682537692941)
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
 p_id=>wwv_flow_api.id(431330566427692940)
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
 p_id=>wwv_flow_api.id(431330899551692941)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(431330822053692941)
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
 p_id=>wwv_flow_api.id(433085710103264471)
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
