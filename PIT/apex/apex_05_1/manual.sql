set define off
set verify off
set serveroutput on size 1000000
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
 
--application/set_environment
prompt  WEBSHEET APPLICATION 109 - PIT
--
-- Websheet Application Export:
--   Application:     109
--   Name:            PIT
--   Date and Time:   16:15 Donnerstag November 1, 2018
--   Exported By:     BUCH_ADMIN
--   Export Type:     Websheet Application Export
--   Version:         18.2.0.00.12
--   Instance ID:     248206643246362
--   Websheet Schema: APEX_BUCH
--
-- Import:
--   Using App Builder
--   or
--   Using SQL*Plus as the Oracle user Websheet schema, APEX_BUCH
 
-- Application Statistics:
--   Pages:                  1
--   Data Grids:             0
--   Reports:                0
 
 
--
-- ORACLE
--
-- Application Express (APEX)
--
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Websheet schema, APEX_BUCH.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,2562619397308603));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'de'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2018.05.24');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_ws_app_id := nvl(wwv_flow_application_install.get_application_id,109);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
 
end;
/

prompt  ...Remove Websheet Application
--application/delete_application
 
begin
 
-- remove internal metadata
wwv_flow_api.remove_ws_app(nvl(wwv_flow_application_install.get_application_id,109));
-- remove websheet metadata
wwv_flow_ws_import_api.remove_ws_components(nvl(wwv_flow_application_install.get_application_id,109));
 
end;
/

prompt  ...Create Websheet Application
--application/create_ws_app
begin
    wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
 
end;
/

begin
wwv_flow_api.create_ws_app(
  p_id    => nvl(wwv_flow_application_install.get_application_id,109),
  p_name  => 'PIT',
  p_owner => nvl(wwv_flow_application_install.get_schema,'APEX_BUCH'),
  p_description => '',
  p_status => 'AVAILABLE',
  p_language => 'de',
  p_territory => 'GERMANY',
  p_home_page_id => 4816873933645415+wwv_flow_api.g_id_offset,
  p_page_style => '0',
  p_auth_id => 4816964125645415+wwv_flow_api.g_id_offset,
  p_acl_type => 'DEFAULT',
  p_login_url => '',
  p_logout_url => '',
  p_allow_sql_yn => 'N',
  p_show_reset_passwd_yn => 'Y',
  p_allow_public_access_yn => 'Y',
  p_logo_type => 'TEXT',
  p_logo_text => 'PIT',
  p_varchar2_table => wwv_flow_api.g_varchar2_table,
  p_email_from => '');
----------------
 
end;
/

----------------
--package app map
--
prompt  ...Create Access Control List
prompt  ...Create Application Authentication Set Up
declare
  sf varchar2(32767) := null;
  vf varchar2(32767) := null;
  pre_ap varchar2(32767) := null;
  af varchar2(32767) := null;
  post_ap varchar2(32767) := null;
begin
af:=af||'-BUILTIN-';

wwv_flow_api.create_ws_auth_setup(
  p_id => 4816964125645415+wwv_flow_api.g_id_offset,
  p_websheet_application_id => wwv_flow.g_ws_app_id,
  p_name => 'Apex Authentication',
  p_invalid_session_url => 'f?p=4900:101:&SESSION.::NO::WS_APP_ID,P900_ID:&WS_APP_ID.,&P900_ID.&p_lang=&APP_SESSION_LANG.&p_territory=&APP_SESSION_TERRITORY.',
  p_auth_function => af,
  p_use_secure_cookie_yn => 'N',
  p_logout_url => 'ws?p='||wwv_flow.g_ws_app_id||':home'
  );
 
end;
/

prompt  ...Create Data Grid
prompt  ...Create Report
 
--application/pages/page_4816873933645415
prompt  ...PAGE 4816873933645415: Starseite
--
begin
wwv_flow_api.create_ws_page (
    p_id => 4816873933645415+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => null+wwv_flow_api.g_id_offset,
    p_name => 'Starseite',
    p_upper_name => 'STARSEITE',
    p_page_alias => 'MAIN',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Mit Websheet-Anwendungen k&ouml;nnen Endbenutzer strukturierte und nicht strukturierte Daten ohne Unterst&uuml;tzung durch den Entwickler verwalten. Mit Websheets k&ouml;nnen Benutzer:</p>'||chr(10)||
''||chr(10)||
'<ul>'||chr(10)||
'	<li>Content &uuml;ber das Web mit einem Webbrowser erstellen und gemeinsam verwenden</li>'||chr(10)||
'	<li>Seiten in einer Hierarchie organisieren und Seiten verkn&uuml;pfen (mithilfe der [[ Seitenname ]]-Syntax).';

c:=c||'</li>'||chr(10)||
'	<li>Tabellarische Daten mithilfe eingebetteter Features, den so genannten Daten-Grids, erstellen und verwalten</li>'||chr(10)||
'	<li>Interaktive Berichte mit SQL auf vorhandenen Datenstrukturen in der Datenbank erstellen.</li>'||chr(10)||
'	<li>Daten-Grid- und Berichtsdaten in Seiten als Diagramm oder Bericht ver&ouml;ffentlichen.</li>'||chr(10)||
'	<li>Seiten mit Anmerkungen in Form von Dateien, Tags und Hinweisen versehen. Zu';

c:=c||'geh&ouml;rige Images k&ouml;nnen inline im Seitencontent angezeigt werden (mithilfe der [[Image: Dateiname]]-Syntax).</li>'||chr(10)||
'	<li>Seitencontent durchsuchen (mit der integrierten Suchfunktion).</li>'||chr(10)||
'	<li>Verwalten, wer sich anmelden darf, und nach der Anmeldung kontrollieren, wer in der Anwendung lesen, schreiben oder sie verwalten darf (Authentifizierung und Autorisierung).</li>'||chr(10)||
'</ul>'||chr(10)||
''||chr(10)||
'<p>Klicken Si';

c:=c||'e auf &quot;Hilfe&quot; f&uuml;r weitere Informationen.</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 42871772548952123964258188480486033887+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 4816873933645415+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Starsteite der PIT-Verwaltungsanwendung',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

prompt  ...Create Page
prompt  ...Create Annotations
begin
--application/end_environment
commit;
end;
/

begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/

set verify on
set feedback on
prompt  ...done
