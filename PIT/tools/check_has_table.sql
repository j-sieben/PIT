column script new_value SCRIPT
column msg new_value MSG
       
set termout off
with has_table as (
       select count(*) amt
         from all_tables
        where table_name = upper('&1.')
          and owner = sys_context('USERENV', 'CURRENT_SCHEMA'))
select case amt when 0 then '&table_dir.&1..tbl' else 'tools/null.sql' end script,
       case amt when 0 then '&s1.Create table ' || upper('&1.') else '&s1.Table ' || upper('&1.') || ' already exists' end msg
  from has_table;
  
set termout on
prompt &msg.
@&script.