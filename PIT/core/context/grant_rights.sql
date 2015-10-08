
prompt &s1.Grant execute on utl_context to &REMOTE_USER.
grant execute on utl_context to &REMOTE_USER.;

prompt &s1.Change current schema to &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;

prompt &s1.Create local synonym, if install and remote users differ
begin
  execute immediate 'drop synonym UTL_CONTEXT';
exception
  when others then
	null;
end;
/
begin
  if '&INSTALL_USER.' != '&REMOTE_USER.' then
    execute immediate 'create synonym utl_context for &INSTALL_USER..utl_context';
    dbms_output.put_line('&s1.Synonym UTL_CONTEXT for &INSTALL_USER..utl_context created.');
  end if;
end;
/

prompt &s1.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;