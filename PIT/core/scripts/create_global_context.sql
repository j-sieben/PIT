
declare
   l_context_exists number;
   C_CTX constant varchar2(128 byte) := 'PIT_CTX_&INSTALL_USER.';
begin
   select count(*)
     into l_context_exists
     from dual
    where exists(
          select null
            from dba_context
           where namespace = upper(C_CTX));
   
   if l_context_exists = 0 then
      execute immediate 'create context ' || C_CTX || ' using &INSTALL_USER..utl_context accessed globally';
      dbms_output.put_line('... Global context ' || C_CTX || ' created');
   else
      dbms_output.put_line('... Context ' || C_CTX || ' already exists');
   end if;
end;
/

