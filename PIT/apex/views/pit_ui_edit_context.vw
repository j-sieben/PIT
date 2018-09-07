create or replace force view pit_ui_edit_context as
select rowid row_id, 
       par_id,
       par_pgr_id,
       par_description,
       par_string_value,
       to_number(regexp_substr(par_string_value, '[^|]+', 1, 1)) pse_id,
       to_number(regexp_substr(par_string_value, '[^|]+', 1, 2)) ptl_id,
       regexp_substr(to_char(par_string_value), '[^|]+', 1, 3) ctx_timing,
       regexp_substr(par_string_value, '[^|]+', 1, 4) ctx_output_modules
  from parameter_tab
 where par_pgr_id = 'PIT'
   and par_id like 'CONTEXT%';

