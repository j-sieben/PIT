create or replace view pit_translatable_item_v as
select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description
  from pit_translatable_item
 where pti_pml_name = '&DEFAULT_LANGUAGE.';
 
comment on table pit_translatable_item_v is 'Provides access to translatable items in the default language';
