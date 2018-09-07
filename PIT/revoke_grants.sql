begin
  $IF dbms_db_version.ver_le_11 $THEN
  null;
  $ELSE
  begin
    execute immediate 'revoke inherit privileges on user &SYS_USER. from &INSTALL_USER.';
    dbms_output.put_line('&s1.INHERIT PRIVILEGES from &SYS_USER. to &INSTALL_USER. revoked');
  exception
    when others then null;
  end;
  if '&REMOTE_USER.' is not null then
    begin
      execute immediate 'revoke inherit privileges on user &SYS_USER. from &REMOTE_USER.';
      dbms_output.put_line('&s1.INHERIT PRIVILEGES from &SYS_USER. to &REMOTE_USER. revoked');
    exception
      when others then null;
    end;
  end if;
  $END
end;
/
