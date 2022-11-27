create or replace view pit_ui_set_realm as
select par_id, par_pgr_id, par_string_value
  from parameter_vw
 where par_id = 'REALM'
   and par_pgr_id = 'PIT';
    
comment on table pit_ui_set_realm is 'UI-View for APEX page SET_REALM';