create or replace view pit_ui_admin_param_main as
select par.rowid row_id, par_id, pgr_id, pgr_description, par_description, pat_description, 
       dbms_lob.substr(par_string_value, 4000, 1) par_string_value,
       dbms_lob.substr(par.par_xml_value.getClobVal(), 4000, 1) par_xml_value,
       par_integer_value, par_float_value, par_date_value, par_timestamp_value,
       case par_boolean_value when 'Y' then '<i class="fa fa-times"/>' when 'N' then '<i class="fa fa-check"/>' end par_boolean_value,
       case par_is_modifiable when 'Y' then '<i class="fa fa-times"/>' else '<i class="fa fa-check"/>' end par_is_modifiable,
       par_validation_string
  from dl_parameter_tab par
  join dl_parameter_group pgr on par.par_pgr_id = pgr.pgr_id
  left join dl_parameter_type pat on par.par_pat_id = pat.pat_id;