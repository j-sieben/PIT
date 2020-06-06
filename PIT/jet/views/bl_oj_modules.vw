create or replace view bl_oj_modules as
select ojmo_id, ojmo_ojmg_id, ojmo_ojro_id, pti_name ojmo_name, ojmo_css
  from oj_modules
  join pit_translatable_item_v
    on ojmo_pti_id = pti_id
   and ojmo_pti_pmg_name = pti_pmg_name;