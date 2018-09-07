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
                 'PIT_MESSAGE', 'PIT_MESSAGE_GROUP', 'PIT_MESSAGE_LANGUAGE', 'PIT_MESSAGE_SEVERITY', 'PIT_TRACE_LEVEL', -- Data Layer
                 'PIT_UI_ADMIN_MESSAGE_MAIN', 'PIT_UI_ADMIN_PARAM_MAIN', 'PIT_UI_ADMIN_PIT_CONTEXT', 
                 'PIT_UI_ADMIN_PIT_MODULE', 'PIT_UI_ADMIN_PIT_TOGGLE', 'PIT_UI_EDIT_CONTEXT', 'PIT_UI_EDIT_MESSAGE_TRANS', 
                 'PIT_UI_EDIT_TOGGLE', 'PIT_UI_LANG_SETTINGS_DEFAULT', 'PIT_UI_LIST_ACTIVE_FOR_PAGE', 
                 'PIT_UI_LOV_AVAILABLE_PACKAGES', 'PIT_UI_LOV_CONTEXT', 'PIT_UI_LOV_MESSAGE_GROUP', 
                 'PIT_UI_LOV_MESSAGE_LANGUAGE', 'PIT_UI_LOV_MESSAGE_SEVERITY', 'PIT_UI_LOV_OUTPUT_MODULES',
                 'PIT_UI_LOV_PARAMETER_GROUP', 'PIT_UI_LOV_PARAMETER_TYPE', 'PIT_UI_LOV_TRACE_LEVEL', -- Views
                 '',   -- Tabellen
                 '',  -- Synonyme
                 '' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper('&REMOTE_USER.')
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

prompt &h3.Revoke OBJECT privileges and drop synonyms if necessary

-- Packages
@tools/revoke_access.sql execute MAIL
@tools/revoke_access.sql execute PIT_APEX_PKG
@tools/revoke_access.sql execute PIT_CONSOLE_PKG
@tools/revoke_access.sql execute PIT_FILE_PKG
@tools/revoke_access.sql execute PIT_MAIL_PKG
@tools/revoke_access.sql execute PIT_PKG
@tools/revoke_access.sql execute PIT_TABLE_PKG

-- Tables and Views
@tools/revoke_access.sql select PIT_MESSAGE
@tools/revoke_access.sql select PIT_MESSAGE_GROUP
@tools/revoke_access.sql select PIT_MESSAGE_LANGUAGE
@tools/revoke_access.sql select PIT_MESSAGE_SEVERITY
@tools/revoke_access.sql select PIT_TRACE_LEVEL
@tools/revoke_access.sql select PARAMETER_VW
@tools/revoke_access.sql select PIT_MESSAGE_LANGUAGE_V
@tools/revoke_access.sql select PIT_MESSAGE_V

prompt &h3.Checking whether app exists.

declare
  l_app_id number;
  l_ws number;
  c_app_alias constant varchar2(30 byte) := '&APEX_ALIAS.';  
begin
  select application_id, workspace_id
    into l_app_id, l_ws
    from apex_applications
   where alias = c_app_alias
     and owner = '&INSTALL_USER.';
   
  dbms_output.put_line('&s1.Remove application ' || c_app_alias);
  wwv_flow_api.set_security_group_id(l_ws);
  wwv_flow_api.remove_flow(l_app_id);
exception
  when others then
    dbms_output.put_line('&s1.Application ' || c_app_alias || ' does not exist');
end;
 /