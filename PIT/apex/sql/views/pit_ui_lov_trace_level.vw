create or replace view ui_lov_pit_trace_level as
select ptl_display_name d, ptl_id r
  from pit_trace_level
 order by ptl_id;
