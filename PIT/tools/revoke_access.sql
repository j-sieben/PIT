declare
  l_stmt varchar2(200);
begin
  l_stmt := 'revoke &1. on &2. from &REMOTE_USER.';
  execute immediate l_stmt;
  dbms_output.put_line('&s1.Grant &1. on &2. revoked from &REMOTE_USER.');
exception
  when others then 
    null; -- grant does not exist, silently ignore
end;
/
