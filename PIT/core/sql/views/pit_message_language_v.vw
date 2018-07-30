create or replace view pit_message_language_v as
select pml_name, pml_default_order
  from pit_message_language
 where case when pml_default_order > 0 then pml_default_order end > 0
union all
select substr(sys_context('USERENV', 'LANGUAGE'), 1, instr(sys_context('USERENV', 'LANGUAGE'), '_') -1), 100
  from dual;