create or replace force view pita_ui_edit_realm as
select pre_id, pre_description, pre_is_active
  from table(pit_app_api.get_parameter_realm_table);
    
comment on table pita_ui_edit_realm is 'UI-View for APEX page EDIT_REALM';
