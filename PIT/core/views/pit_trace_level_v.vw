create or replace view pit_trace_level_v as
select ptl_id, ptl_name, pti_display_name ptl_display_name, pti_description ptl_description
  from pit_trace_level
  join pit_translatable_item_v
    on ptl_pti_id = pti_id;