
create or replace function get_install_script
return varchar2
as
  l_is_installed pls_integer;
  l_script varchar2(2000 byte) := 'tools/null.sql|';
begin
  
  select count(*)
    into l_is_installed
	  from user_objects
   where object_type = 'PACKAGE'
	   and object_name in ('PARAM_ADMIN');
     
  if l_is_installed = 0 then
    raise_application_error(-20000, 'Install Parameter handling before installing PIT.');
  end if;  
  
  select count(*)
    into l_is_installed
    from all_objects
   where object_type = 'CONTEXT'
     and object_name = 'PIT_CTX_' || user;
   
  if l_is_installed = 0 then
    dbms_output.put_line('&s1.Globally accessible context not present, trying to create it');
  end if;
     
  select count(*)
    into l_is_installed
    from user_sys_privs
   where privilege = 'CREATE ANY CONTEXT';
   
  if l_is_installed = 0 then
    l_script := l_script || 'Privilege to create a globally accsessible context is missing, skipping installation';
  else
    l_script := 'context/install.sql|Grants exist, installing CONTEXT framework';
  end if; 
  
  return l_script;
end;
/
set termout off
column script new_value SCRIPT
column msg new_value MSG
column with_context new_value WITH_CONTEXT

with data as(
       select get_install_script script
         from dual)
select substr(script, 1, instr(script, '|') - 1) SCRIPT,
       substr(script, instr(script, '|') + 1) MSG,
       case when script like 'tools/null.sql%' then 'false' else 'true' end WITH_CONTEXT
  from data;
  
drop function get_install_script;
  
set termout on
prompt &s1.&MSG.
@&SCRIPT.