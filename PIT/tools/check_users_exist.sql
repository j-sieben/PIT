prompt &h2.Checking owner user &1.
declare
  l_user_exists pls_integer;
  l_user_has_quota pls_integer;
  l_password varchar2(20 byte);
  -- password function
  function create_password(
    p_char_amount in integer default 5,
    p_numeric_amount in integer default 2,
    p_special_amount in integer default 1)
    return varchar2
  as
    c_chars constant varchar2(60) := 'abcdefhijkmnoprstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
    c_numbers constant varchar2(60) := '23456789';
    c_special_chars constant varchar2(60) := '!$%/\()[]{}?+#-@:,'; -- @see https://docs.oracle.com/cd/E11223_01/doc.910/e11197/app_special_char.htm#MCMAD416
    
    c_char_group constant varchar2(1 byte) := 'c';
    c_num_group constant varchar2(1 byte) := 'n';
    c_special_group constant varchar2(1 byte) := 's';
    
    l_password varchar2(60) := '';
    l_pattern varchar2(60) := '';
  begin
    
    -- create a selector with the respective amount of occurences for the different groups
    l_pattern := rpad(c_char_group, p_char_amount, c_char_group)
              || rpad(c_num_group, p_numeric_amount, c_num_group)
              || rpad(c_special_group, p_special_amount, c_special_group);
    
    -- generate a password that conforms to the given pattern
    with template as (
            select substr(l_pattern, level, 1) char_group
              from dual
           connect by level <= length(l_pattern)
             order by dbms_random.value)
    select listagg(
             case char_group
             when c_char_group then substr(c_chars, dbms_random.value(1, length(c_chars)), 1)
             when c_num_group then substr(c_numbers, dbms_random.value(1, length(c_numbers)), 1)
             when c_special_group then substr(c_special_chars, dbms_random.value(1, length(c_special_chars)), 1)
             end, '')
           within group (order by rownum)
      into l_password
      from template;
  
    return l_password;
  end create_password;
begin

  select count(username)
    into l_user_exists
    from all_users
   where username = upper('&1.');
   
  if l_user_exists = 0 then
    -- create a new random password for the user
    l_password := create_password(12, 3, 3);
     
    execute immediate 'create user &1. identified by "' || l_password || '" default tablespace &DEFAULT_TABLESPACE. quota unlimited on &DEFAULT_TABLESPACE.';
    dbms_output.put_line('&s1.User &1. created.');
    dbms_output.put_line('&s1.ATTENTION: PASSWORD CREATED IS ' || l_password || '. Please note this or change it to a password of your liking.');
  else
    -- Make sure that the user has access
    select count(*)
      into l_user_has_quota
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
