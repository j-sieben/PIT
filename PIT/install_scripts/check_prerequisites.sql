
create or replace type foo_char_table as table of varchar2(128 byte);
/

declare
  l_required_privs foo_char_table;
  cursor priv_cur(p_required_privs in foo_char_table) is
    select column_value
      from table(p_required_privs)
    minus
    select privilege
      from user_sys_privs;
  l_priv_missing boolean := false;
begin
  l_required_privs := foo_char_table('CREATE TABLE', 'CREATE VIEW', 'CREATE PROCEDURE', 'CREATE TYPE', 'CREATE SEQUENCE');
  
  for priv in priv_cur(l_required_privs) loop
    l_priv_missing := true;
    dbms_output.put_line('&s1.Missing privilege ' || priv.column_value);
  end loop;

  if l_priv_missing then
    raise_application_error(-20000, 'Privileges missing, cannot continue.');
  end if;
end;
/

drop type foo_char_table force;