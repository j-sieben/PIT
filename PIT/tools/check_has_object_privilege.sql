prompt &h2.Check whether &INSTALL_USER. has privilege &1. on &2.

declare
  l_has_priv pls_integer;
begin
  select count(*)
    into l_has_priv
    from dba_tab_privs
   where grantee = '&INSTALL_USER.'
     and privilege = upper('&1.')
     and table_name = upper('&2.');
     
  if l_has_priv = 0 then
    execute immediate 'grant &1. on &2. to &INSTALL_USER.';
    dbms_output.put_line('&s1.Object privilege &1. on &2. granted.');
  else
    dbms_output.put_line('&s1.Object privilege &1. on &2. is already granted.');
  end if;
end;
/