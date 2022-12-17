create or replace force view pita_ui_edit_context as
select par_id,
       par_pgr_id,
       par_description,
       par_string_value,
       to_number(regexp_substr(par_string_value, '[^|]+', 1, 1)) pse_id,
       to_number(regexp_substr(par_string_value, '[^|]+', 1, 2)) ptl_id,
       regexp_substr(to_char(par_string_value), '[^|]+', 1, 3) ctx_timing,
       regexp_substr(par_string_value, '[^|]+', 1, 4) ctx_output_modules
  from table(pit_app_api.get_parameter_table)
 where par_pgr_id = 'PIT'
   and par_id like 'CONTEXT%';

