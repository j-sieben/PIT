column script new_value SCRIPT
column msg new_value MSG

set termout off
with type_state as (
       select case when exists (
                     select null
                       from user_types
                      where type_name = upper('&1.'))
                   then 1 else 0 end type_exists,
              case when exists (
                     select null
                       from user_tab_columns
                      where data_type = upper('&1.')
                        and coalesce(data_type_owner, user) = user)
                   then 1 else 0 end type_is_used
         from dual)
select case type_is_used
         when 1 then 'tools/null.sql'
         else '&type_dir.&1..tps'
       end script,
       case
         when type_is_used = 1
           then '&s1.Type specification ' || upper('&1.') ||
                ' is used by a table and is kept unchanged'
         when type_exists = 1
           then '&s1.Replace type specification ' || upper('&1.')
         else '&s1.Create type specification ' || upper('&1.')
       end msg
  from type_state;

set termout on
prompt &msg.
@&script.
