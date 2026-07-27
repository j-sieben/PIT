create or replace view pit_message_v as
select m.*
  from pit_message_language l
  join pit_message_mv m
    on m.pms_pml_name = l.pml_effective_name
 where l.pml_name = substr(
         sys_context('USERENV', 'LANGUAGE'),
         1,
         instr(sys_context('USERENV', 'LANGUAGE'), '_') - 1);
    
comment on table pit_message_v is 'Published PIT messages in the effective language of the current session.';
