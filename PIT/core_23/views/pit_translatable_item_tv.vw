create or replace view pit_translatable_item_tv as
select pti_pmg_name, pti_id, pti_pml_name, pti_name, pti_display_name, pti_description
  from pit_translatable_item_mv;

comment on table pit_translatable_item_tv is
  'Provides translatable items for all effective runtime languages, including their language identifier.';
