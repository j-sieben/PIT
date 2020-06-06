create or replace force view pit_ui_admin_par as
with session_state as(
       select v('P6_PGR_ID') pgr_id,
              'fa-times' flg_false,
              'fa-check' flg_true,
              utl_apex.get_default_date_format date_format,
              utl_apex.get_default_timestamp_format timestamp_format,
              utl_apex.get_true is_true
         from dual)
select /*+ no_merge (s)*/
       par.rowid row_id, par.par_id, pgr.pgr_id, pgr.pgr_description, par.par_description, pat.pat_description,
       ltrim (
         decode(to_char(dbms_lob.substr(par.par_string_value, 100, 1)), null, null, 'String: ' || to_char(dbms_lob.substr(par.par_string_value, 100, 1))) ||
         decode(to_char(dbms_lob.substr(par.par_xml_value.getClobVal(), 100, 1)), null, null, ', XML: ' || to_char(dbms_lob.substr(par.par_xml_value.getClobVal(), 100, 1))) ||
         decode(par.par_integer_value, null, null, ', Integer: ' || to_char(par.par_integer_value)) ||
         decode(par.par_float_value, null, null, ', Float: ' || to_char(par.par_float_value, 'fm999G999G999G990D99999999')) ||
         decode(par.par_date_value, null, null, ', Date: ' || to_char(par.par_date_value, s.date_format)) ||
         decode(par.par_timestamp_value, null, null, ', Timestamp: ' || to_char(par.par_timestamp_value, s.timestamp_format)) ||
         decode(par.par_boolean_value, null, null, ', Boolean: ' || case par.par_boolean_value when s.is_true then 'true' else 'false' end),
         ', ') par_value,
       case coalesce(par.par_is_modifiable, pgr.pgr_is_modifiable) when 'Y' then s.flg_true else flg_false end par_is_modifiable,
       par.par_validation_string
  from parameter_tab par
  join parameter_group pgr
    on par.par_pgr_id = pgr.pgr_id
  join session_state s
    on pgr.pgr_id = s.pgr_id
  left join parameter_type pat
    on par.par_pat_id = pat.pat_id;