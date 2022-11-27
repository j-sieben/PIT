create or replace force view pit_ui_admin_pit_active_context as
with params as (
       select c.ctx.log_level debug_level, 
              c.ctx.trace_level trace_level, 
              c.ctx.trace_timing trace_timing, 
              pit_util.table_to_string(c.ctx.log_modules, ', ') log_modules
         from (select pit.get_active_context ctx
                 from dual) c),
     trace_settings as(
       select ptl_display_name
         from pit_trace_level_v
         join params
           on ptl_id = trace_level),
     trace_timing as(
       select pti_display_name
         from pit_translatable_item_v
         join params
           on pti_pmg_name = 'PIT'
          and pti_id = 'BOOLEAN_' || trace_timing),
     debug_settings as(
       select pse_display_name
         from pit_message_severity_v
         join params
           on pse_id = debug_level)
select pse_display_name debug_level, ptl_display_name trace_level, pti_display_name trace_timing, log_modules
  from params
 cross join trace_settings
 cross join debug_settings
 cross join trace_timing;