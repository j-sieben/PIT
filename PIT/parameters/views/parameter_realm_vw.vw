create or replace view parameter_realm_vw as
select pal_id pre_par_id, pal_pgr_id pre_pgr_id, pal_pre_id pre_id,
       pal_string_value pre_string_value, pal_integer_value pre_integer_value, pal_float_value pre_float_value,
       pal_date_value pre_date_value, pal_timestamp_value pre_timestamp_value, pal_boolean_value pre_boolean_value
  from parameter_local;
 
comment on table parameter_realm_vw is 'Provides access to realm overwrites for existing parameters';