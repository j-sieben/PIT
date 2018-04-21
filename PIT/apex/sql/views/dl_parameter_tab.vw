create or replace view &APP_USER..dl_parameter_tab as
select par_id, par_pgr_id, par_description, par_string_value, par_raw_value, par_xml_value, par_integer_value,
       par_float_value, par_date_value, par_timestamp_value, par_boolean_value, par_is_modifiable, 
       par_pat_id, par_validation_string, par_validation_message
  from &INSTALL_USER..parameter_tab;
