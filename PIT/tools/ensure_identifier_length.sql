-- Parameters: table name, column name (installer-owned identifiers only).
-- Do not hide missing columns or unexpected DDL errors.
declare
  l_data_type user_tab_columns.data_type%type;
  l_data_length user_tab_columns.data_length%type;
  l_char_used user_tab_columns.char_used%type;
  l_table_name varchar2(128 byte) := upper('&1.');
  l_column_name varchar2(128 byte) := upper('&2.');
begin
  select data_type, data_length, char_used
    into l_data_type, l_data_length, l_char_used
    from user_tab_columns
   where table_name = l_table_name
     and column_name = l_column_name;

  if l_data_type != 'VARCHAR2' then
    raise_application_error(-20000,
      'Expected VARCHAR2 identifier: ' || l_table_name || '.' || l_column_name);
  end if;

  if l_data_length != 128 or l_char_used != 'B' then
    -- Oracle validates existing data; never truncate identifiers to fit.
    execute immediate 'alter table ' || dbms_assert.simple_sql_name(l_table_name) ||
      ' modify (' || dbms_assert.simple_sql_name(l_column_name) ||
      ' varchar2(128 byte))';
  end if;
end;
/
