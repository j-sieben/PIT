-- Checks a named constraint and dispatches an explicit script.
-- Parameters:
--   1 table name
--   2 constraint name
--   3 script to run when the constraint exists
--   4 script to run when the constraint is missing
column script new_value SCRIPT
column msg new_value MSG

set termout off
with has_constraint as (
       select count(*) amt
         from user_constraints
        where table_name = upper('&1.')
          and constraint_name = upper('&2.'))
select case when amt > 0 then '&3.' else '&4.' end script,
       case when amt > 0
            then '&s1.Constraint ' || upper('&2.') || ' exists'
            else '&s1.Constraint ' || upper('&2.') || ' does not exist'
        end msg
  from has_constraint;

set termout on
prompt &msg.
@&script.
