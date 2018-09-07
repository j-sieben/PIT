prompt &h2.Check whether &INSTALL_USER. has privilege &1.

declare
  l_has_priv pls_integer;
begin
  select count(*)
    into l_has_priv
    from dba_sys_privs
   where grantee = '&INSTALL_USER.'
     and privilege = upper('&1.');
     
  if l_has_priv = 0 then
    execute immediate 'grant &1. to &INSTALL_USER.';
    dbms_output.put_line('&s1.System privilege &1. granted.');
  else
    dbms_output.put_line('&s1.System privilege &1. is already granted.');
  end if;
end;
/