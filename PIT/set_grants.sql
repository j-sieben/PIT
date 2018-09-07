
prompt &h3.Grant SYSTEM privileges
@tools/check_has_system_privilege.sql "create session"
@tools/check_has_system_privilege.sql "create procedure"
@tools/check_has_system_privilege.sql "create table"
@tools/check_has_system_privilege.sql "create type"

prompt &h3.Grant OBJECT privileges
@tools/check_has_object_privilege.sql select dba_context

begin
  $IF dbms_db_version.ver_le_11 $THEN
  null;
  $ELSE
  dbms_output.put_line('&s1.&SYS_USER. granted inherit privileges to &INSTALL_USER.');
  execute immediate 'grant inherit privileges on user &SYS_USER. to &INSTALL_USER.';
  $END
end;
/
