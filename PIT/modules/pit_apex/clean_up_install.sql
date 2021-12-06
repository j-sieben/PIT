declare
  cursor delete_object_cur is
          select object_name name, object_type type
            from all_objects
           where object_name in (
                 'PIT_APEX', 'PIT_APEX_ADAPTER', -- Typen
                 'PIT_APEX_PKG', -- Packages
                 '', -- Tabellen
                 '' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper(user)
           order by object_type, object_name;
begin
  for obj in delete_object_cur loop
    execute immediate 'drop ' || obj.type || ' ' || obj.name ||
                      case obj.type 
                      when 'TYPE' then ' force' 
                      when 'TABLE' then ' cascade constraints purge' 
                      end;
    dbms_output.put_line('&s1.' || initcap(obj.type) || ' ' || obj.name || ' deleted.');
  end loop;
  
  pit_admin.delete_message_group('PIT_APEX');
end;
/