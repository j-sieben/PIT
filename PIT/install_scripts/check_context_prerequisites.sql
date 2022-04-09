
set termout off
create or replace function get_install_script
return varchar2
as
  l_is_installed pls_integer := 0;
  l_has_context_grant pls_integer := 0;
  l_has_grant_on_dba_context pls_integer := 0;
  l_script varchar2(2000 byte) := 'tools/null.sql|';
begin
  
  -- in any case you need access to DBA_CONTEXT to check for the context
  begin
    execute immediate 'select null from dba_context';
    l_has_grant_on_dba_context := 1;
  exception
    when others then
      null;
  end;
  
  -- Try to find the context (dynamic SQL to avoid compilation problems if no grant exists)
  begin
    execute immediate q'^select count(*) from dba_context where namespace = 'PIT_CTX_' || user^'
      into l_is_installed;
  exception
    when others then
      l_is_installed := 0;
  end;
   
  if l_is_installed = 0 then
    dbms_output.put_line('&s1.Globally accessible context not present, trying to create it');
    -- If the context is not present, you will need the CREATE ANY CONTERXT grant to create it
    select count(*)
      into l_has_context_grant
      from user_sys_privs
     where privilege = 'CREATE ANY CONTEXT';
  end if;
       
  case when l_has_grant_on_dba_context = 0 then
    l_script := l_script || 'Privilege to read DBA_CONTEXT is missing, skipping installation';
  when l_is_installed = 0 and l_has_context_grant = 0 then
    l_script := l_script || 'Privilege to create a globally accsessible context is required but missing, skipping installation';
  else
    l_script := 'context/install.sql|Grants or globally accessible context exist, installing CONTEXT framework';
  end case; 
  
  return l_script;
end;
/
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