begin
  if '&INSTALL_USER.' != '&REMOTE_USER.' then
    execute immediate 'create synonym param for &INSTALL_USER..param';
    dbms_output.put_line('&s1.Synonym PARAM for &INSTALL_USER..PARAM created.');
    execute immediate 'create synonym param_admin for &INSTALL_USER..param_admin';
    dbms_output.put_line('&s1.Synonym PARAM_ADMIN for &INSTALL_USER..PARAM_ADMIN created.');
  end if;
end;
/
