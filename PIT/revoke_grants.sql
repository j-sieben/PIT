begin
  $IF dbms_db_version.ver_le_11 $THEN
  null;
  $ELSE
  dbms_output.put_line('&s1.INHERIT PRIVILEGES from SYS to &INSTALL_USER. revoked');
  execute immediate 'revoke inherit privileges on user sys from &INSTALL_USER.';
  $END
end;
/
