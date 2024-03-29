create or replace force view pita_ui_admin_par as
with session_state as(
       select /*+ no_merge */
              utl_apex.get_string('P6_PGR_ID') pgr_id,
              'fa-times' flg_false,
              'fa-check' flg_true,
              utl_apex.get_default_date_format date_format,
              utl_apex.get_default_timestamp_format timestamp_format,
              utl_apex.c_true c_true
         from dual)
select par.par_id, pgr.pgr_id, pgr.pgr_description, par.par_description, pat.pat_description,
       ltrim (
         decode(to_char(dbms_lob.substr(par.par_string_value, 100, 1)), null, null, 'String: ' || to_char(dbms_lob.substr(par.par_string_value, 100, 1))) ||
         decode(to_char(dbms_lob.substr(par.par_xml_value.getClobVal(), 100, 1)), null, null, ', XML: ' || to_char(dbms_lob.substr(par.par_xml_value.getClobVal(), 100, 1))) ||
         decode(par.par_integer_value, null, null, ', Integer: ' || to_char(par.par_integer_value)) ||
         decode(par.par_float_value, null, null, ', Float: ' || to_char(par.par_float_value, 'fm999G999G999G990D99999999')) ||
         decode(par.par_date_value, null, null, ', Date: ' || to_char(par.par_date_value, s.date_format)) ||
         decode(par.par_timestamp_value, null, null, ', Timestamp: ' || to_char(par.par_timestamp_value, s.timestamp_format)) ||
         decode(par.par_boolean_value, null, null, ', Boolean: ' || case par.par_boolean_value when s.c_true then 'true' else 'false' end),
         ', ') par_value,
       case coalesce(par.par_is_modifiable, pgr.pgr_is_modifiable) when s.c_true then s.flg_true else flg_false end par_is_modifiable,
       par.par_validation_string
  from table(pit_app_api.get_parameter_table) par
  join table(pit_app_api.get_parameter_group_table) pgr
    on par.par_pgr_id = pgr.pgr_id
  join session_state s
    on pgr.pgr_id = s.pgr_id
  left join table(pit_app_api.get_parameter_type_table) pat
    on par.par_pat_id = pat.pat_id
       -- exclude REALM parameter to allow for separate maintenance
 where not(par_id = 'REALM' and par_pgr_id = 'PIT');
 
 
comment on table pita_ui_admin_par is 'View to prepare the data for page ADMIN_PAR(arameter)';