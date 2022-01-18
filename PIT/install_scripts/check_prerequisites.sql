
create or replace type foo_char_table as table of varchar2(128 byte);
/

declare
  l_required_privs foo_char_table;
  l_priv_missing boolean := false;
  
  cursor priv_cur(p_required_privs in foo_char_table) is
    select column_value
      from table(p_required_privs)
    minus
      (select privilege
         from user_sys_privs
       union 
       select privilege
         from user_role_privs r
         join role_sys_privs p
           on granted_role = role);
  
  cursor direct_priv_cur(p_required_privs in foo_char_table) is    
    select column_value
      from table(p_required_privs)
    minus
      select privilege
        from user_sys_privs;
begin
  dbms_output.put_line('&1.Checking privileges');
  l_required_privs := foo_char_table('CREATE TABLE', 'CREATE VIEW', 'CREATE TYPE', 'CREATE SEQUENCE', 'ALTER SESSION');
  
  for priv in priv_cur(l_required_privs) loop
    l_priv_missing := true;
    dbms_output.put_line('&s1.Missing (role) privilege ' || priv.column_value);
  end loop;
  
  dbms_output.put_line('&1.Checking required directly granted privileges');
  l_required_privs := foo_char_table('CREATE PROCEDURE');
  
  for priv in direct_priv_cur(l_required_privs) loop
    l_priv_missing := true;
    dbms_output.put_line('&s1.Missing directly granted privilege ' || priv.column_value);
  end loop;

  if l_priv_missing then
    raise_application_error(-20000, 'Privileges missing, cannot continue.');
  end if;
end;
/

drop type foo_char_table force;