prompt &h2.Checking owner user &1.
declare
  l_user_exists pls_integer;
  l_user_has_tablespace pls_integer;
  l_password varchar2(20 byte);
  C_PASSWORD_LENGTH constant pls_integer := 12;
begin

  select count(username)
    into l_user_exists
    from all_users
   where user = upper('&1.');
   
  if l_user_exists = 0 then
    -- create a new random password for the user
    with password_chars as(
           -- random char, first character must be a char, not a digit or special sign
           select level idx, trunc(dbms_random.value(1, case level when 1 then 52 else 65 end)) position
             from dual
          connect by level <= C_PASSWORD_LENGTH)
    select listagg(
             substr('ABZDEFGHIJKLMNOPQRSTUVWXYZabzdefghijklmnopqrstuvwxyz0123456789#_@', trunc(position), 1), '') within group (order by idx) pwd
      into l_password
      from password_chars;
     
    execute immediate 'create user &1. identified by ' || l_password || ' default tablespace &DEFAULT_TABLESPACE. quota unlimited on &DEFAULT_TABLESPACE.';
    dbms_output.put_line('&s1.User &1. created.');
    dbms_output.put_line('&s1.ATTENTION: PASSWORD CREATED IS ' || l_password || '. Please note this or change it to a password of your liking.');
  else
    -- Make sure that the user has access
    select count(*)
      into l_user_has_tablespace
      from dba_ts_quotas
     where username = upper('&1.');
    
    if l_user_has_quota = 0 then
      execute immediate 'alter user &1. quota unlimited on &DEFAULT_TABLESPACE.';
      dbms_output.put_line('&s1.User &1. exists, but without tablespace quota. Granted quota unlimited on &DEFAULT_TABLESPACE..');
    else    
      dbms_output.put_line('&s1.User &1. exists.');
    end if;
  end if;
  
end;
/
