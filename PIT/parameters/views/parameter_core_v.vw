create or replace view parameter_core_v as
select par_id, par_pgr_id, par_description, r.pal_pre_id par_pre_id,
       coalesce(l.pal_string_value, r.pal_string_value, par_string_value) par_string_value,
       coalesce(l.pal_raw_value, r.pal_raw_value, par_raw_value) par_raw_value,
       coalesce(l.pal_xml_value, r.pal_xml_value, par_xml_value) par_xml_value,
       coalesce(l.pal_integer_value, r.pal_integer_value, par_integer_value) par_integer_value,
       coalesce(l.pal_float_value, r.pal_float_value, par_float_value) par_float_value,
       coalesce(l.pal_date_value, r.pal_date_value, par_date_value) par_date_value,
       coalesce(l.pal_timestamp_value, r.pal_timestamp_value, par_timestamp_value) par_timestamp_value,
       coalesce(l.pal_boolean_value, r.pal_boolean_value, par_boolean_value) par_boolean_value,
       par_is_modifiable,
       par_pat_id,
       par_validation_string,
       par_validation_message,
       case when l.pal_id is not null then &C_TRUE. else &C_FALSE. end par_is_local
  from parameter_tab
  left join (
       -- REALM parameters
       select l.*
         from parameter_local l
         join parameter_tab
           on pal_pre_id = to_char(par_string_value)
        where par_id = 'REALM'
          and par_pgr_id = 'PIT') r
    on par_id = r.pal_id
   and par_pgr_id = r.pal_pgr_id
  left join (
       -- Other local parameters
       select *
         from parameter_local
        where pal_pre_id is null) l
    on par_id = l.pal_id
   and par_pgr_id = l.pal_pgr_id;
 
comment on table parameter_core_v is 'View to combine default, realm and local parameters. Published to allow a client to read realm parameters';

