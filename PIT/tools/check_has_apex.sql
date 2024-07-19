
prompt
prompt &section.
prompt &h1.Module PIT_APEX

column script new_value SCRIPT
column msg new_value MSG
       
set termout off
with has_apex as (
       select count(*) amt
         from all_users
        where username like 'APEX\______' escape '\')
select case amt when 0 then 'tools/null.sql' else '&1..sql' end script,
       case amt when 0 then '&h2.Installation skipped, APEX is not installed' end msg
  from has_apex;
  
set termout on
prompt &msg.
@&script.