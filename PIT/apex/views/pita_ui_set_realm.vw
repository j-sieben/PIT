create or replace force view pita_ui_set_realm as
select par_id, par_pgr_id, par_string_value
  from table(pit_app_api.get_parameter_table)
 where par_id = 'REALM'
   and par_pgr_id = 'PIT';
    
comment on table pita_ui_set_realm is 'UI-View for APEX page SET_REALM';