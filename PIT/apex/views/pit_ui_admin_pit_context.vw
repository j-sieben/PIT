create or replace force view pit_ui_admin_pit_context as
  with params as (
       select rowid row_id,
              par_id,
              substr(par_id, 9) context_name,
              par_description context_description,
              to_number(regexp_substr(par_string_value, '[^|]+', 1, 1)) pse_id,
              to_number(regexp_substr(par_string_value, '[^|]+', 1, 2)) ptl_id,
              case regexp_substr(to_char(par_string_value), '[^|]+', 1, 3) when 'Y' then 'Ja' else 'Nein' end timing_on,
              replace(regexp_substr(par_string_value, '[^|]+', 1, 4), ':', ', ') output_modules
         from parameter_tab
        where par_pgr_id = 'PIT'
          and par_id like 'CONTEXT%')
select p.row_id, p.par_id, p.context_name, p.context_description, 
       'Debug: ' || pse.pse_display_name || '<br>' ||
       'Trace: ' || ptl.ptl_display_name || '<br>' ||
       'Timing: ' || p.timing_on || '<br>' ||
       'Module: ' || p.output_modules || '<br>' context_setting
  from params p
  join pit_message_severity pse on p.pse_id = pse.pse_id
  join pit_trace_level ptl on p.ptl_id = ptl.ptl_id;