
prompt &h3.Grant SYSTEM privileges

prompt &h3.Grant OBJECT privileges
prompt &s1.Select on PIT tables and views

declare
  cursor object_cur is
    select object_name, case object_type when 'PACKAGE' then 'execute' else 'select' end object_grant
      from all_objects
     where owner = '&INSTALL_USER.'
       and object_type in ('TABLE', 'VIEW', 'PACKAGE')
       and '&INSTALL_USER.' != '&REMOTE_USER.';
begin
  for obj in object_cur loop
    execute immediate 'grant ' || obj.object_grant || ' on &INSTALL_USER..' || obj.object_name || ' to &REMOTE_USER.';
    dbms_output.put_line('&s1.' || obj.object_grant || ' on &INSTALL_USER..' || obj.object_name || 'granted');
   end loop;
 end;
 /

begin
  $IF dbms_db_version.ver_le_11 $THEN
  null;
  $ELSE
  dbms_output.put_line('&s1.SYS granted inherit privileges to &INSTALL_USER.');
  execute immediate 'grant inherit privileges on user sys to &INSTALL_USER.';
  $END
end;
/
