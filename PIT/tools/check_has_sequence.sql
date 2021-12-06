column script new_value SCRIPT
column msg new_value MSG
       
set termout off
with has_table as (
       select count(*) amt
         from user_sequences
        where sequence_name = upper('&1.'))
select case amt when 0 then '&seq_dir.&1..seq' else 'tools/null.sql' end script,
       case amt when 0 then '&s1.Create sequence ' || upper('&1.') else '&s1.Sequence ' || upper('&1.') || ' already exists' end msg
  from has_table;
  
set termout on
prompt &msg.
@&script.