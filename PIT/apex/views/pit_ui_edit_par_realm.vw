create or replace view pit_ui_edit_par_realm as
  with params as(
       select utl_apex.get_value('P7_PAR_ID') p_par_id,
              utl_apex.get_value('P7_PAR_PGR_ID') p_pgr_id
         from dual)
select /*+ no_merge (params */
       pre_id, pre_par_id, pre_pgr_id, 
       pre_string_value, pre_integer_Value, pre_float_value,
       pre_date_value, pre_timestamp_value, pre_boolean_value
  from parameter_realm_vw
  join params
    on pre_pgr_id = p_pgr_id
   and pre_par_id = p_par_id;
   
comment on table pit_ui_edit_par_realm is 'UI view to display realm overwrites for a given parameter';