
declare
   l_context_exists number;
begin
   select count(*)
     into l_context_exists
     from dba_context
    where namespace = 'PIT_CTX';
   
   if l_context_exists = 0 then
      execute immediate 'create context pit_ctx using &INSTALL_USER..utl_context accessed globally';
      dbms_output.put_line('... Globaler Kontext PIT_CTX angelegt');
   else
      dbms_output.put_line('... Kontext PIT_CTX existiert bereits');
   end if;
end;
/
