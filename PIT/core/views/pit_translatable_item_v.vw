create or replace view pit_translatable_item_v as
select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description
  from pit_translatable_item
  join pit_pmg_language_v
    on pti_pmg_name = pgl_name
   and pti_pml_name = pgl_pml_name;
 
comment on table pit_translatable_item_v is 'Provides access to translatable items in the actual session language if possible and to the default language otherwise';
