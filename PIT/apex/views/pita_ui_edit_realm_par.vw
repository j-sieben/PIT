CREATE OR REPLACE VIEW pita_ui_edit_realm_par
AS
  select prp_par_id, prp_pre_id, prp_pgr_id, 
         prp_string_value, prp_integer_value, prp_float_value, 
         prp_date_value, prp_timestamp_value, prp_boolean_value
    from table(pit_app_api.get_parameter_realm_view)
;

comment on table pita_ui_edit_realm_par is 'UI-View for APEX page EDIT_REALM_PAR';