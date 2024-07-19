column script new_value SCRIPT
column msg new_value MSG
       
set termout off
with has_table as (
       select count(*) amt
         from user_tab_columns
        where data_type = upper('&1.'))
select case amt when 0 then '&2.' else 'tools/null.sql' end script,
       case amt when 0 then 'Create type &1.' else '&s1.Type ' || upper('&1.') || ' is in use and can''t be replaced' end msg
  from has_table;
  
set termout on
prompt &msg.
@&script.
