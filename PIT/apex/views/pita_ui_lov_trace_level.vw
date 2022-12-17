create or replace force view pita_ui_lov_trace_level as
select ptl_display_name d, ptl_id r
  from table(pit_app_api.get_pit_trace_level_table)
 order by ptl_id;
