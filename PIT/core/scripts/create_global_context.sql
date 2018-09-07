
declare
   l_context_exists number;
begin
   select count(*)
     into l_context_exists
     from dba_context
    where namespace = upper('PIT_CTX_&INSTALL_USER.');
   
   if l_context_exists = 0 then
      execute immediate 'create context pit_ctx_&INSTALL_USER. using &INSTALL_USER..utl_context accessed globally';
      dbms_output.put_line('... Global context PIT_CTX_&INSTALL_USER. created');
   else
      dbms_output.put_line('... Context PIT_CTX_&INSTALL_USER. already exists');
   end if;
end;
/
