declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2282);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor delete_object_cur is
          select object_name name, object_type type
            from all_objects
           where object_name in (
                 '', -- Typen
                 'PIT_UI_PKG', -- Packages
                 'DL_PARAMETER_GROUP', 'DL_PARAMETER_TAB', 'DL_PARAMETER_TYPE',
                 'DL_PIT_MESSAGE', 'DL_PIT_MESSAGE_LANGUAGE', 'DL_PIT_MESSAGE_SEVERITY',
                 'DL_PIT_TRACE_LEVEL',
                 'PIT_UI_ADMIN_MESSAGE_MAIN', 'PIT_UI_ADMIN_PARAM_MAIN', 'PIT_UI_ADMIN_PIT_CONTEXT', 
                 'PIT_UI_ADMIN_PIT_MODULE', 'PIT_UI_ADMIN_PIT_TOGGLE', 'PIT_UI_ADMIN_PIT_MODULE', 
                 'PIT_UI_EDIT_CONTEXT', 'PIT_UI_EDIT_MESSAGE_TRANS', 'PIT_UI_EDIT_TOGGLE', 
                 'PIT_UI_LANG_SETTINGS_DEFAULT', 'PIT_UI_LIST_ACTIVE_FOR_PAGE', 'PIT_UI_LOV_AVAILABLE_PACKAGES', 
                 'PIT_UI_LOV_CONTEXT', 'PIT_UI_LOV_MESSAGE_LANGUAGE', 'PIT_UI_LOV_MESSAGE_SEVERITY', 
                 'PIT_UI_LOV_OUTPUT_MODULES', 'PIT_UI_LOV_PARAMETER_GROUP', 'PIT_UI_LOV_PARAMETER_TYPE',
                 'PIT_UI_LOV_TRACE_LEVEL', -- Views
                 '',  -- Tabellen
                 'PARAM_ADMIN', 'PIT_ADMIN',  -- Synonyme
                 '' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper('&APP_USER.')
           order by object_type, object_name;
         
begin
  for obj in delete_object_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' ' || obj.name ||
                        case obj.type 
                        when 'TYPE' then ' force' 
                        when 'TABLE' then ' cascade constraints' 
                        end;
     dbms_output.put_line('&s1.' || initcap(obj.type) || ' ' || obj.name || ' deleted.');
    
    exception
      when object_does_not_exist or table_does_not_exist or sequence_does_not_exist or synonym_does_not_exist then
        dbms_output.put_line('&s1.' || obj.type || ' ' || obj.name || ' does not exist.');
      when others then
        raise;
    end;
  end loop;
end;
/

prompt &s1.Deinstall PIT-Client
define REMOTE_USER=&APP_USER.
prompt &h1.Revoking Grants to &APP_USER.
alter session set current_schema=&INSTALL_USER.;
@core/revoke_client_rights.sql

prompt
prompt &h1.Uninstalling PIT objects in schema &APP_USER.
alter session set current_schema=&APP_USER.;
@core/clean_up_client.sql

prompt
prompt &h1.Uninstalling PARAM objects in schema &APP_USER.
alter session set current_schema=&APP_USER.;
@core/parameters/clean_up_client.sql

prompt &h1.Purge recycle bin
purge recyclebin;

prompt
prompt &h1.PIT client successfully deinstalled


prompt &s1.Deinstall APEX-Application
@apex/apex/prepare_apex_import.sql

begin
  wwv_flow_api.import_begin (
     p_version_yyyy_mm_dd=>'2016.08.24'
    ,p_release=>'5.1.0.00.45'
    ,p_default_workspace_id=>7313152013503540
    ,p_default_application_id=>124
    ,p_default_owner=>'DOAG'
  );
  wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
  wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
  commit;
end;
/