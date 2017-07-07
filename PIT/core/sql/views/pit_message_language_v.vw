create or replace view pit_message_language_v as
select pml_name, pml_default_order
  from pit_message_language
 where pml_default_order > 0
union all
select utl_i18n.map_from_short_language(sys_context('USERENV', 'LANG')), 100
  from dual;
