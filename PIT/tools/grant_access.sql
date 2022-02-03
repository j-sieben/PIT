
begin
  if '&PIT_USER.' != '&REMOTE_USER.' then
    dbms_output.put_line('&s1.Granting &1. on &2. to &REMOTE_USER.');
    execute immediate 'grant &1. on &2. to &REMOTE_USER.';
  end if;
exception
  when others then
    dbms_output.put_line('&s1.Grant on &2. unsuccesful: ' || substr(sqlerrm, 12));
end;
/