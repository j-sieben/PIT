create or replace view pit_ui_edit_module as
with session_state as(
       select v('P11_PIT_MODULE') || '%' pit_module,
              'PIT' pgr_id
         from dual)
select /*+ no_merge(s) */
       par_id,
       par_pgr_id,
       par_description,
       par_string_value,
       par_integer_value,
       par_float_value,
       par_date_value,
       par_timestamp_value,
       par_boolean_value,
       case when pal_id is not null then 'fa-check' else 'fa-times' end par_is_local,
       case when pal_id is not null then 'UD' else 'U' end allowed_actions
  from parameter_vw
  join session_state s
    on par_pgr_id = s.pgr_id
   and par_id like s.pit_module
  left join parameter_local
    on pal_pgr_id = par_pgr_id
   and pal_id = par_id;