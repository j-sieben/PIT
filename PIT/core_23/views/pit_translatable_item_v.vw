create or replace view pit_translatable_item_v as
select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description
  from pit_message_language l
  join pit_translatable_item i
    on i.pti_pml_name = l.pml_effective_name
 where l.pml_name = substr(
         sys_context('USERENV', 'LANGUAGE'),
         1,
         instr(sys_context('USERENV', 'LANGUAGE'), '_') - 1);
 
comment on table pit_translatable_item_v is 'Provides translatable items in the effective language of the current session.';
