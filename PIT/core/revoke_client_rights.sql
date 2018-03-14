alter session set current_schema=&INSTALL_USER.;
declare
  cursor privs_cur is
    select table_name, type
      from user_tab_privs
     where grantee = '&REMOTE_USER.';
begin
  for priv in privs_cur loop
    dbms_output.put_line('&s1.Revoking rights from ' || lower(priv.type) || ' ' || priv.table_name);
    execute immediate 'revoke all from ' || priv.table_name || ' from &REMOTE_USER.';
  end loop;
end;
/