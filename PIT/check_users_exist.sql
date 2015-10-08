prompt &h2.Checking user &INSTALL_USER.
declare
  user_exists exception;
  pragma exception_init(user_exists, -1920);
begin
  execute immediate 'create user &INSTALL_USER. identified by &INSTALL_USER. default tablespace users quota unlimited on users';
  dbms_output.put_line('&s1.User &INSTALL_USER. created.');
exception
  when user_exists then 
    execute immediate 'alter user &INSTALL_USER. quota unlimited on users';
    dbms_output.put_line('&s1.User &INSTALL_USER. exists.');
end;
/

prompt &h2.Checking user &REMOTE_USER.
declare
  user_exists exception;
  pragma exception_init(user_exists, -1920);
begin
  execute immediate 'create user &REMOTE_USER. identified by &INSTALL_USER. default tablespace users quota unlimited on users';
  dbms_output.put_line('&s1.User &REMOTE_USER. created.');
exception
  when user_exists then 
    execute immediate 'alter user &REMOTE_USER. quota unlimited on users';
    dbms_output.put_line('&s1.User &REMOTE_USER. exists.');
end;
/
