create or replace view pit_ui_edit_par as
select p.rowid row_id,
       par_id,
       par_pgr_id,
       par_description,
       par_string_value,
       p.par_xml_value.getClobVal() par_xml_value,
       par_integer_value,
       par_float_value,
       par_date_value,
       par_timestamp_value,
       par_boolean_value,
       par_is_modifiable,
       pgr_is_modifiable,
       par_pat_id,
       par_validation_string,
       par_validation_message
  from parameter_tab p
  join parameter_group g
    on par_pgr_id = pgr_id;