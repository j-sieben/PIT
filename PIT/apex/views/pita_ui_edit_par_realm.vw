create or replace force view pita_ui_edit_par_realm as
with params as(
       select /*+ no_merge */
              utl_apex.get_value('P7_PAR_ID') p_par_id,
              utl_apex.get_value('P7_PAR_PGR_ID') p_pgr_id
         from dual)
select pre_id, pre_par_id, pre_pgr_id, 
       pre_string_value, pre_integer_Value, pre_float_value,
       pre_date_value, pre_timestamp_value, pre_boolean_value
  from table(pit_app_api.get_parameter_realm_view)
  join params
    on pre_pgr_id = p_pgr_id
   and pre_par_id = p_par_id;
   
comment on table pita_ui_edit_par_realm is 'UI view to display realm overwrites for a given parameter';