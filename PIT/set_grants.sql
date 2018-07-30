
prompt &h3.Grant SYSTEM privileges
prompt &s1.create session, create procedure, create table, create type to &INSTALL_USER.
@check_has_system_privilege "create session"
@check_has_system_privilege "create procedure"
@check_has_system_privilege "create table"
@check_has_system_privilege "create type"

prompt &h3.Grant OBJECT privileges
prompt &s1.Select on sys.dba_context
@check_has_object_privilege select dba_context

begin
  $IF dbms_db_version.ver_le_11 $THEN
  null;
  $ELSE
  dbms_output.put_line('&s1.&SYS_USER. granted inherit privileges to &INSTALL_USER.');
  execute immediate 'grant inherit privileges on user &SYS_USER. to &INSTALL_USER.';
  $END
end;
/
