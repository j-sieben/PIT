create or replace view parameter_v as
select par_id,
       par_pgr_id,
       par_pre_id,
       par_description,
       par_string_value,
       par_raw_value,
       par_xml_value,
       par_integer_value,
       par_float_value,
       par_date_value,
       par_timestamp_value,
       par_boolean_value,
       par_is_modifiable,
       par_pat_id,
       par_validation_string,
       par_validation_message,
       par_is_local
  from parameter_core_v;
 
comment on table parameter_v is 'View to combine default, realm and local parameters. Local parameters take precedence over default parameters';
 