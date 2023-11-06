column script new_value SCRIPT
column msg new_value MSG
       
set termout off
with data as (
       select count(*) has_boolean
         from dual
        where exists (
              select *
                from all_tab_columns
               where data_type = 'BOOLEAN'))
select case has_boolean when 1 then '&1.' else '&2.' end SCRIPT, 
       case has_boolean when 1 then 'Booelan data type exists.' else'No boolean data type found' end MSG
  from data;
  
set termout on
prompt &msg.
@&script.