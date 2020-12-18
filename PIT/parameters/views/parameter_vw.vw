create or replace view parameter_vw as
 select par_id, par_pgr_id, par_description, par_pre_id,
       coalesce(pal_string_value, par_string_value) par_string_value,
       coalesce(pal_raw_value, par_raw_value) par_raw_value,
       coalesce(pal_xml_value, par_xml_value) par_xml_value,
       coalesce(pal_integer_value, par_integer_value) par_integer_value,
       coalesce(pal_float_value, par_float_value) par_float_value,
       coalesce(pal_date_value, par_date_value) par_date_value,
       coalesce(pal_timestamp_value, par_timestamp_value) par_timestamp_value,
       coalesce(pal_boolean_value, par_boolean_value) par_boolean_value,
       par_is_modifiable,
       par_pat_id,
       par_validation_string,
       par_validation_message
  from parameter_core_vw
  full join parameter_local
    on par_id = pal_id
   and par_pgr_id = pal_pgr_id;
 
comment on table parameter_vw is 'Client View to combine default and local parameters. Local parameters take precedence over default parameters';