
begin
  if '&INSTALL_USER.' != '&REMOTE_USER.' then
    dbms_output.put_line('&s1.Granting &1. on &2. to &REMOTE_USER.');
    execute immediate 'grant &1. on &INSTALL_USER..&2. to &REMOTE_USER.';
  end if;
exception
  when others then
    dbms_output.put_line('&s1.Object &2. does not exist.');
end;
/

alter session set current_schema=&REMOTE_USER.;

begin
  if '&INSTALL_USER.' != '&REMOTE_USER.' then
    dbms_output.put_line('&s1.Create synonym &2. for &INSTALL_USER..&2. at &REMOTE_USER.');
    execute immediate 'create or replace synonym &2. for &INSTALL_USER..&2.';
  end if;
end;
/

alter session set current_schema=&INSTALL_USER.;