
declare
  cursor priv_cur is
    select privilege
      from user_sys_privs
     where privilege = 'CREATE ANY DIRECTORY';
  l_priv_missing boolean := false;
begin
  for priv in priv_cur loop
    l_priv_missing := true;
    dbms_output.put_line('&s1.Missing privilege ' || priv.privilege || '. Output module requires a directory to write to. Contact your ADMIN');
  end loop;
end;
/
