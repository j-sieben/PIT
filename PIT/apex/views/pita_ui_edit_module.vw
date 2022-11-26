create or replace force view pita_ui_edit_module as
with session_state as(
       select /*+ no_merge */
              utl_apex.get_string('P11_PIT_MODULE') || '%' pit_module,
              pit_util.C_TRUE C_TRUE,
              'PIT' pgr_id
         from dual)
select par_id,
       par_pgr_id,
       par_description,
       par_string_value,
       par_integer_value,
       par_float_value,
       par_date_value,
       par_timestamp_value,
       par_boolean_value,
       case par_is_local when C_TRUE then 'fa-check' else 'fa-times' end par_is_local,
       case par_is_local when C_TRUE then 'UD' else 'U' end allowed_actions
  from table(pit_app_api.get_parameter_table)
  join session_state s
    on par_pgr_id = s.pgr_id
   and par_id like s.pit_module;