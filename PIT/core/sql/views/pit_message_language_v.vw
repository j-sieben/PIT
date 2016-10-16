create or replace view pit_message_language_v as
select pml_name, pml_default_order
  from pit_message_language
 where pml_default_order > 0
union all
select value, 100
  from v$nls_parameters
 where parameter = 'NLS_LANGUAGE';
