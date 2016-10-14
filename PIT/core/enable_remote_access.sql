
declare
  cursor synonym_cur is
      with synonyms as(
           select 'PIT' synonym_name 
             from dual 
           union all
           select 'MSG' from dual union all
           select 'MSG_ARGS' from dual union all
           select 'MSG_PARAM' from dual union all
           select 'MSG_PARAMS' from dual)
    select s.synonym_name,
           case when a.synonym_name is not null then 'Y' end delete_flag
      from synonyms s
      left join all_synonyms  a 
        on s.synonym_name = a.synonym_name
     where a.owner = upper('&REMOTE_USER.');
begin
  if '&INSTALL_USER.' != '&REMOTE_USER.' then
    dbms_output.put_line('&h3.Grant execute on pit packages to &REMOTE_USER. and maintain synonyms');
    for syn in synonym_cur loop
      execute immediate 'grant execute on &INSTALL_USER..' || obj.obj_name || ' to &REMOTE_USER.';
      dbms_output.put_line('&s1.Execute on &INSTALL_USER..' || obj.obj_name || ' granted.');
      if syn.delete_flag = 'Y' then
        execute immediate 'drop synonym &REMOTE_USER..' || syn.synonym_name;
        dbms_output.put_line('&s1.Synonym &INSTALL_USER..' || syn.synonym_name || ' dropped.');
      end if; 
      execute immediate 'create synonym &REMOTE_USER..' || syn.synonym_name || ' for &INSTALL_USER..' || syn.synonym_name;
      dbms_output.put_line('&s1.Synonym &INSTALL_USER..' || syn.synonym_name || ' created.');
    end loop;
  else
    dbms_output.put_line('&s1.No synoyms required, owner = user');
  end if;
end;
/
