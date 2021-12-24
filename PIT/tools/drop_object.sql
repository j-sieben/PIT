declare
  l_object_name varchar2(128 byte);
  l_object_type varchar2(128 byte);
begin
  if '&PIT_USER.' != user then  
    select object_name, object_type
      into l_object_name, l_object_type
      from user_objects
     where object_name = upper('&1.')
       and object_type not like '%BODY';
       
     execute immediate 'drop ' || l_object_type || ' ' || l_object_name ||
                      case l_object_type 
                      when 'TYPE' then ' force' 
                      when 'TABLE' then ' cascade constraints' 
                      end;
     dbms_output.put_line('&s1.' || initcap(l_object_type) || ' ' || l_object_name || ' deleted.');
  end if;
exception
  when no_data_found then
    null;
end;
/
