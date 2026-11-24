create or replace view pit_effective_language_v as
select pml_effective_name
  from pit_message_language
 where pml_name = substr(sys_context('USERENV', 'LANGUAGE'), 1,
         instr(sys_context('USERENV', 'LANGUAGE'), '_') - 1);
