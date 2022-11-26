create or replace force view pita_ui_admin_pit_context as
with params as (
       select par_id,
              substr(par_id, 9) context_name,
              par_description context_description,
              to_number(regexp_substr(par_string_value, '[^|]+', 1, 1)) pse_id,
              to_number(regexp_substr(par_string_value, '[^|]+', 1, 2)) ptl_id,
              (select pti_display_name
                 from pit_translatable_item_v
                where pti_id = 'BOOLEAN_' || regexp_substr(to_char(par_string_value), '[^|]+', 1, 3)
                  and pti_pmg_name = 'PIT') timing_on,
              replace(regexp_substr(par_string_value, '[^|]+', 1, 4), ':', ', ') output_modules
         from table(pit_app_api.get_parameter_table)
        where par_pgr_id = 'PIT'
          and par_id like 'CONTEXT%')
select p.par_id, p.context_name, p.context_description, 
       'Debug: ' || pse.pse_display_name || '<br>' ||
       'Trace: ' || ptl.ptl_display_name || '<br>' ||
       'Timing: ' || p.timing_on || '<br>' ||
       'Module: ' || p.output_modules || '<br>' context_setting
  from params p
  join table(pit_app_api.get_pit_message_severity_table) pse on p.pse_id = pse.pse_id
  join table(pit_app_api.get_pit_trace_level_table) ptl on p.ptl_id = ptl.ptl_id;
  
comment on table pita_ui_admin_pit_context is ' View to prepare the context setting data for the UI';