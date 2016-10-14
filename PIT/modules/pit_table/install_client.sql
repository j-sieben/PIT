
declare
  cursor object_cur is
    select 'PIT_LOG' obj_name, 'TABLE' object_type from dual;
  cursor synonym_cur is
      with synonyms as(
           select 'PIT_LOG' synonym_name from dual)
    select s.synonym_name,
           case when a.synonym_name is not null then 'Y' end delete_flag
      from synonyms s
      left join
           (select synonym_name
              from all_synonyms 
             where owner = '&REMOTE_USER.') a 
        on s.synonym_name = a.synonym_name;
begin
  dbms_output.put_line('&h3.Grant execute on PIT_TABLE module to &REMOTE_USER.');
  for obj in object_cur loop
    if obj.object_type = 'TABLE' then
      execute immediate 'grant select on &INSTALL_USER..' || obj.obj_name || ' to &REMOTE_USER.';
    else
      execute immediate 'grant execute on &INSTALL_USER..' || obj.obj_name || ' to &REMOTE_USER.';
    end if;
    dbms_output.put_line('&s1.Execute on &INSTALL_USER..' || obj.obj_name || ' granted.');
  end loop;
  
  dbms_output.put_line('&h3.Maintain synonyms for PIT_TABLE module at &REMOTE_USER.');
  if '&INSTALL_USER.' != '&REMOTE_USER.' then
    for syn in synonym_cur loop
      begin
        if syn.delete_flag = 'Y' then
          execute immediate 'drop synonym &REMOTE_USER..' || syn.synonym_name;
          dbms_output.put_line('&s1.Synonym &INSTALL_USER..' || syn.synonym_name || ' dropped.');
        end if; 
        execute immediate 'create synonym &REMOTE_USER..' || syn.synonym_name || ' for &INSTALL_USER..' || syn.synonym_name;
        dbms_output.put_line('&s1.Synonym &INSTALL_USER..' || syn.synonym_name || ' created.');
      exception
        when others then 
          dbms_output.put_line('Error at ' || syn.synonym_name || ': ' || sqlerrm);
      end;
    end loop;
  else
    dbms_output.put_line('&s1.No synoyms required, owner = user');
  end if;
end;
/