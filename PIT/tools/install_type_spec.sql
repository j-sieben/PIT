column script new_value SCRIPT
column msg new_value MSG
       
set termout off
with has_table as (
       select count(*) amt
         from user_dependencies
        where referenced_type = 'TABLE'
          and type = 'TYPE'
          and name = upper('&1.'))
select case amt when 0 then '&type_dir.&1..tps' else 'tools/null.sql' end script,
       case amt when 0 then '&s1.Create type specification ' || upper('&1.') else '&s1.Type specification ' || upper('&1.') || ' already exists' end msg
  from has_table;
  
set termout on
prompt &msg.
@&script.