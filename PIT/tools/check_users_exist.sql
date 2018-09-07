prompt &h2.Checking owner user &1.
declare
  user_exists exception;
  pragma exception_init(user_exists, -1920);
begin
  execute immediate 'create user &1. identified by &1. default tablespace users quota unlimited on users';
  dbms_output.put_line('&s1.User &1. created.');
exception
  when user_exists then 
    execute immediate 'alter user &1. quota unlimited on users';
    dbms_output.put_line('&s1.User &1. exists.');
end;
/
