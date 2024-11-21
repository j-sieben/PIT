
column script new_value SCRIPT
column msg new_value MSG
       
set termout off
with has_column as (
       select count(*) amt
         from user_tab_columns
        where table_name = upper('&1.')
          and column_name = upper('&2.'))
select case amt when 0 then '&table_dir.change_&1..sql' else 'tools/null.sql' end script,
       case amt when 0 then '&s1.Create column ' || upper('&2.') else '&s1.Column ' || upper('&2.') || ' already exists' end msg
  from has_column;
  
set termout on
prompt &msg.
@&script.