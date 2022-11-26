create or replace force view pita_ui_edit_par_realm as
with params as(
       select /*+ no_merge */
              utl_apex.get_value('P7_PAR_ID') p_par_id,
              utl_apex.get_value('P7_PAR_PGR_ID') p_pgr_id
         from dual)
select prp_pre_id, prp_par_id, prp_pgr_id, 
       prp_string_value, prp_integer_Value, prp_float_value,
       prp_date_value, prp_timestamp_value, prp_boolean_value
  from table(pit_app_api.get_parameter_realm_view)
  join params
    on prp_pgr_id = p_pgr_id
   and prp_par_id = p_par_id;
   
comment on table pita_ui_edit_par_realm is 'UI view to display realm overwrites for a given parameter';