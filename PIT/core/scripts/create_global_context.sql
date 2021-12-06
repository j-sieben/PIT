
declare
   l_use_context number;
   l_context_exists number;
   C_CTX constant varchar2(128 byte) := 'PIT_CTX_' || user;
begin
  select count(*)
    into l_use_context
    from user_objects
   where object_type = 'PACKAGE'
     and object_name = 'UTL_CONTEXT';
     
  if l_use_context = 1 then
    select count(*)
      into l_context_exists
      from dual
     where exists(
           select null
             from dba_context
            where namespace = upper(C_CTX));
    
    if l_context_exists = 0 then
       execute immediate 'create context ' || C_CTX || ' using ' || user || '.utl_context accessed globally';
       dbms_output.put_line('&s1.Global context ' || C_CTX || ' created');
    else
       dbms_output.put_line('&s1.Context ' || C_CTX || ' already exists');
    end if;
  else
    dbms_output.put_line('&s1.Skipping context creation, UTL_CONTEXT not present.');
  end if;
end;
/

